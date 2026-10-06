import pg from 'pg'
import {loadConfig} from './config.js'
const {Pool}=pg;const config=loadConfig();export const db=new Pool({connectionString:config.databaseUrl,max:10,idleTimeoutMillis:30000,connectionTimeoutMillis:5000});
export async function health(){const r=await db.query('select 1 as ok');return r.rows[0].ok===1}