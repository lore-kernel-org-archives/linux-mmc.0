Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C930F523
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718776; cv=fail; b=IxQTZhy30MgtRmUWwNaNbx72sxoA6WxOJziHZT3Lm9LHJf5OgmqOjZnzBOQcU5WpO3OT2VaHyW6/ec7H/y4i/EKpvqZlB4zRI9PM/vIvD5u6KHugosexJ9Ix89ItAVE+cyMkgkmK0HQSvCLDUGipqpx7PxdKwV/NXDhly3kMPnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718776; c=relaxed/simple;
	bh=hPflKntlkc76Sh8H1AH2lNnukj5RWodhugTHTG85zb4=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=cf/lCnbWT9/bxC/FNtlvwL+T/TXliPiHlxG0+5WCVxIT+Mg/e84rYpfJVDaspILLevxaJ7jO6JhcOxm7W1ASjbnTEavijBScbqMAJ4TFIFPtxDpXKk0wOwZ1A539QMFyKiXX1z4hJFiT5//0jc3qdLOhcBmXPQJzOw+a1DGOy6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HTKuVoXd; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HTKuVoXd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkjd373OepyEpPCEMM78LsG2MHq8SU4hAHRHabp1ddIDHYqGGTaNao1HSxigpNfkifJk7o8XpwXMF5arSniGdgwIHW5w9EEFPss1Pu7l78SnorVLtLXkwL98zo8vAHzUCmMEVt6JR4pScgpwwLTtAhEwHP4zGMUlN/YU1z3W4NiQ+7CBh8nZttZPA+d+JslGpgeY/UuBs7bsTWba2XqM7u4e9mocqxqb283whhcap+JhjtUtfarQquzmaMwAwHLxi/Jh1x2HaPHUZWCcfKhPw0HhMb88mMvPZEclcxn6TFX1HuI2IAoAhjxyxbNrzRtlwAbM4Hih+v1HzUMzQtGggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvnSG8Yvl6PRlan7N794A7NXZc5hS9vTJAf40lxRSPw=;
 b=Dj5gubE6jHQHG3kX2M/AP54hLLjd13p258N+EEdtQZVIHRpDEANI/mTDkiEmFynGTkyJeC8Pmt/8ScO8Tni4PGsugWUjL+9xhi2nzD4u1hnGZ+/2A+19nt18R9Ml+oKh8MFKbwFC4LuG+F60/Qjqk7/5N3/zQwEPbRRtHXsQVYU2Smk6aigC4TypFwnLkwS3m2t9amH3eiUxIYgWtMQPoX6+DaEfjgFnqRzpnewAp95ag0uIriqvIYuDeUOx5N8cNNvjEGLvpH8X6QgzWrzfDbEt/JZbSH5yngNLDFbZkYskF5ByoCzZ2SuC8A4EYUU8nAMlEttEY8sGeU1OOQdWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvnSG8Yvl6PRlan7N794A7NXZc5hS9vTJAf40lxRSPw=;
 b=HTKuVoXdzfasWpen8B3Vdr7oiwk5KTL82GKOmDeQBtXZqad+26kVU2sJPUk8Wbo71tPdmnJurXkyjRcozcRPHdqmgYVlT12AlNfHqdvpvKJG8hhreHBodFAj2+F+hgB1gjUrloaxKgbjYl8uOYEgqoZylGFISGM7yc3+o0dx9R3yq4jIc5ADU2ALylLMccWGK+yNSP2YB+tj5xjP6iD+coW+2PXGYqqMBAI5KkKD9LCffIBbXmvZKqbB6aN9L4YmQwLdp4w+/QqD8dM5UzVvLLLKgFemm2QsDk2V5Q39Zo9tD4BAsvtkJ4w2ND1WAky2ggOxJ+QUavge+cyntDzJkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 1 Sep
 2025 09:26:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:26:10 +0000
Message-ID: <31fb75e1-abf4-4fb2-b838-074edbee5423@siemens.com>
Date: Mon, 1 Sep 2025 11:26:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] mmc-utils: Warn during rpmb read-counter on expiry
Content-Language: en-US
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Avri Altman <Avri.Altman@sandisk.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a91966e-9d53-4716-516f-08dde93994ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjJ6ZUNuUitTZk1CRlNVQVROVVBqcnVXUTFYRWd1M3BwZ0s0VGRmRmYranJx?=
 =?utf-8?B?RHQ3WjhNRld3VWR3eHNTV0hJVlovNjdqN1ZtRWMyWnpzY01LVEYxYTViVXZW?=
 =?utf-8?B?VlJMbm1xaFVGUVdSL3V1VWJ2M1BSUnRvT09nSEMva09OSmdQdHhGQW84UE5G?=
 =?utf-8?B?SXkvS2xJTnp2eUhpSHdXMnBZV2t5U3pMZlNIOWhVNlRnbWpjSyt4NTBoUXdw?=
 =?utf-8?B?cXo4L0g1bktMTjZwUFM5bW14YmhHUldaM1NyUFY1ODlsdnZPRG9OZmxORGVK?=
 =?utf-8?B?OWtUci9BQSt4UUFoSlZ6UllBSk0wZVErdFplbDg3bXp0TFZXMWZKOWlGQXky?=
 =?utf-8?B?RFdSZklOMkxSZVFEZTNBb1VqQzFRcDQ3U1ZOclFxN1JMc1BLTEdWMU56ZnNv?=
 =?utf-8?B?elpiT3RtUjNXanV3eEFxNkoya1dPTEZjYmxsdmtmWDc2UGFDWlFKckQ2N3lC?=
 =?utf-8?B?VEFtbENsUzg0UGpaRWRYNitnK0I2eU5QbS9ueWVyNVF6S2J2SFhYTmtpakMy?=
 =?utf-8?B?RnNKL1pieUYrbGpZOUdEVHZuVSs4VFB0bVhRRm5oLzYraVJtTGNTNUZQQjRR?=
 =?utf-8?B?bTZPbUJxY2VIbVVvZGRoV1hFeExkMElSMklLTmJlZlRleDBRYmNlaDljOXN3?=
 =?utf-8?B?VCtCQ1dPTmVqM1o3LzhabUlYWi8yWm1hMVZjblc4Smw1YTZkaDdUanFKZEhT?=
 =?utf-8?B?QmVjSVBQYmN4S2Z2TXRKdHdhMHlJUm5TMHpmSG1HZFRXVlV1TXVMeHY0bGlJ?=
 =?utf-8?B?cCtJNDREa0k4aDlZUTJvenZsRTVHd1FLT0dRUEZXb0JHSUtTTGtvbFM2VHdN?=
 =?utf-8?B?WVdUSlRkL0QwdUhtd01oREZNQktyenNIK0sxMytwclFyMUFEZFJyOEFJdDly?=
 =?utf-8?B?Tm85Q1Rpbi80Z0Z6ZHJ5QS9TOWhOMmovTXJMeEoyTlJVdENGWXJtS2ZERW9l?=
 =?utf-8?B?L0dQZ2NPNWNtbVZNU24vZGhrWFMwdFlqZSs3Q1NZYjJVcnUyT0ZyR3R0UkNH?=
 =?utf-8?B?WDlkeVJGMVhyNTFlRm91Q0MwTU13TU1wZll0em1JOHhLZVZQWWpKLytRalJG?=
 =?utf-8?B?eU5zeElncnZtMkE2ODVqekd5Wms2RERpcTUveVUxMjcxSXJWS1dSaXFHcVNo?=
 =?utf-8?B?N3hSTFliVHdpZGoyZy9Bb3JwNU8yKzJFbEVReVh1N2c1dkJDbXM2U0xMK3RG?=
 =?utf-8?B?WXlzT3FpeUxodnZ4R0JtRGxHOW00ek9laDZIcUdUR25wYmZFUlNkTHFMZGpS?=
 =?utf-8?B?aktKUkdFeVYra2x0b09DSHRiTnpmVFMrZFJUclRoM3BXbnFaU0huMk1NL2xP?=
 =?utf-8?B?eVNZTEQybW8yVVZQdXVMLzg2dWt3NVBlNVc2UGNTNXhpNDZwV0tMYS9XNGNS?=
 =?utf-8?B?UmtISEI2ZVYxb2hlNlE0MEs3SzV2QlYyUEViWEsvcHF2OFRSWXVqeGxNMlV4?=
 =?utf-8?B?YzhXaTlJRzgvVE81SkR2aVZSb2pRT3lGNElscnFuKzBPb0hnbG9uMnE0YmN3?=
 =?utf-8?B?RjdPWVpod3I1NFNiRjFSSWZoMXc2eVZnK2NGMDNVRno2T0pjQVJCV1JkcnFJ?=
 =?utf-8?B?YnIzaUZOS3RIajBaN2lweWZ3anBGRnRyVVNLSytWKzUwT1J2WUx1QWVtaUI5?=
 =?utf-8?B?WVhsMXl0eldFbi9jRDZqZmZwNFBsYXUzUVdLRk5HMlNGZVFiSFZpY1hJUnVw?=
 =?utf-8?B?M29Nc0owZnFxRFNlMDA3VmF0RkI5YTk2SS9qRU1VNHZ6MWh2akxNQ0FjdUlU?=
 =?utf-8?B?RnpHY29Pc29xdEZmbWhNZWpiWTd1NkJyM1Y0bUp0OVp2QVl4T3JLUGdxR2Qr?=
 =?utf-8?B?NjhSZUR5bFloSnJ6ME5XL2tHamsyOEZNRkdVN0hDUW8wWXdXTnMzbjNPOEJQ?=
 =?utf-8?B?Z1VwTHkzcGJ0QzVxZlI5dXgwUy94SFZpVGY5NkhNVDF1VklUL253N2VLZEtP?=
 =?utf-8?Q?s8TdLDgCKB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNJTSt6SGZ2Sjc2NmFPcFg5MlZDUXFPeXVBazM0N2ZFaytRVkJjcDRTWUtx?=
 =?utf-8?B?UWIydkR5enFTRUFOcWdBQzJyRm1DWUljcVRnZFFVdHRjeEhvUlI4aWp4ekQ3?=
 =?utf-8?B?SXVwcFJlaWU0aXAvb0NpSjg3Wk1walVlM1pGUy9NNmNKMS9pREZUZDlYc01F?=
 =?utf-8?B?R1J1QitNYkFsTjZYZ0tiNlpTbWs5QXljWXRXYXlqVlI4KzFxMWFQTmxITFFw?=
 =?utf-8?B?MCtScTNqYkhLUUlObmtIQ1JYNkUzczZSdzhiUmdFTU5vQXB4Qm8zQTJJbWdW?=
 =?utf-8?B?S21SRTJmeFJhR2hFK2IrWDRqRHFKV3IwaDhuRWlDK1k3VjFHMDJOWWZyekFZ?=
 =?utf-8?B?SW8zRTlmOFdpSmVmeU9kdk9mNEcxbGsrRFh5ZFFIK2plRDBTQ0R0SE9oQnE3?=
 =?utf-8?B?dTZGbkZjd3FGK1dLc2RrWFIrWEkvRStmUHYveGlLRzFSNS9ud3VxYmx0VHd4?=
 =?utf-8?B?L2IzVzh6TFNkS3d2RnA5SEoybDM4bktFemFhT3JJTnNGS3MyaXRtS0NBM2JE?=
 =?utf-8?B?eEdZNVVyRmR1T1ZuTWNFeFFwZXVWK2RmYzhrdVk5UDg0UktITU1XZFlFNkQ1?=
 =?utf-8?B?ZlRhYjlBaUdYZ0NvblhEZG9WMWRYdGpSaUhXRmVZaXFXakFHaE9RbHpKWVNT?=
 =?utf-8?B?azJsaWFta0FIQzVzSGVXMVRBTEkvbENLeXVYSHRJTDkzcXNqUlU2TmZWNWd6?=
 =?utf-8?B?SVhQV0lJN0ppOG5wdm5TbDRIdzBTRUdBNnhQeWkxSkt3ZHBrbDFoQ2VaSWsz?=
 =?utf-8?B?bUxuaEtQVUliV1Y2RjRkMlk2d0RqQ0RrYm5SNEE0Q1pNTzRIb0JqUkxJem5t?=
 =?utf-8?B?VDJMNjg1OCsxK1l2SnA0emJiVnlXRGs0eXI1UGU1VE5BU1l4cDRtMitFK3B5?=
 =?utf-8?B?UlM1bkg1Vi9FNTJoOTF4SCtsK1N4STcrempoUnFUa2N5cXFKSmUxL1JMK1lG?=
 =?utf-8?B?YjFSMWZEK08rZG9rUUtoQUpETE5uTE1WQkQ0TkoraXZJYlpnYkVyV0U1ZTdN?=
 =?utf-8?B?aUJyOUVOelBaV3ZqZHdQRlRCWHNySmt4cVd0MElaWWVZbXQ3SFMzYWtQaTlv?=
 =?utf-8?B?L3l5Wk1yRXFQQk9JM3crZVBmTEFFK3EvU3NEK3pUNEZ6K3c5YURPTzkreHNy?=
 =?utf-8?B?R1ByYWhuaUZIUzVHclZUa1hrTHlGTlE5bU9zVjlMOWptczMxNHdwbXNQZEFs?=
 =?utf-8?B?S3hHcUd6d05ZWnlxVlhRbkNheDc3RVRrbWlhbjNPRHArV05BdWNwd2pXSXJ2?=
 =?utf-8?B?UStGVWxxMmZBbzcvblYvMWZVOW1NcDIyTDlBTEpGYmhsZ0RpaEtDMUNIdTlv?=
 =?utf-8?B?NzBUM25LNW4yMThHTzRqSXFjelBHRlk2akxGU2F3RDZMWlkvaERHK3REempt?=
 =?utf-8?B?VlBzb1V6OTBnalRzaS8rS0dXS0VHVjVmUDFTcWVGQ0hJZXhFL2lrSHNrd00r?=
 =?utf-8?B?bW5nN2JQUmd0NmlUMzZUR2JwSnZiRFdiQUJsODNWSzkrUU9wSHRMcHF4K3lP?=
 =?utf-8?B?bHc0VG8rSmp2RnVHckQ0c0lGbHRNeDRmMVlXcHRvUjFwSy85aWt5elNSQ3ZK?=
 =?utf-8?B?R3VjVldqTTVkaElpSFVpaFF0aW9LVlpCanVDU1VuT3dkS09HK3I2Mk5tZkFW?=
 =?utf-8?B?VTQ3dFNmWnFlZzJWVWFKL1lTTmRRdkJ4WjlGVzN4Q1M0Mmo5SVk3RGVoVlhu?=
 =?utf-8?B?Z1FMV2ZaT3hwZEVQMTloUzF1M1FaWHZrRG9URWd4cTdhNVVaWU16R1ovbzhw?=
 =?utf-8?B?b2pFcHcwN2hSb0ZNRkZ6NE9sRjBLY2wxTjF0ckdUeGFsSkdoNDlyU0Y4UHhj?=
 =?utf-8?B?QWVqbGJDWllQQ1NyNFNmbWNSUVNkYXpRbjZmRVVYaGFhTG13MzNia0ZTcVhZ?=
 =?utf-8?B?aktQNHBPblVjaHNobjM0aVVwNHA3cmVwZHNDWTlhZXFpYlBwb1ZjbkFlb0pX?=
 =?utf-8?B?R2pMK2dJR0xOdGJZdU0zdjgvcXFTWm5JWE9ORmpWUCsxVTJzdm5vYkFzTkZm?=
 =?utf-8?B?eHBIbkxvOHQ5SEdScm9CM1R2OTgzS2FKM2puYThOaUptaGJnUGczZUU3RUVJ?=
 =?utf-8?B?VzhwbDJ1VDRlbGpzUlNDeTJ2bWxmUi9iMHREaUNETDE1c015TzhuVXRoeVJI?=
 =?utf-8?Q?rIAIy30wMS3YUhYwU/l3N/umk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a91966e-9d53-4716-516f-08dde93994ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:26:08.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMVBTbVWh/jVwqCEgV6CZvOuPm6Q3fsOWaX5EWA6cMrP2U8cJKv3F/EcR9EGC/gK4/9IvGhEBn9XcRmS1iOXdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6118

From: Jan Kiszka <jan.kiszka@siemens.com>

When the counter reached its limit, any further write request will be
rejected by the device. Warn the user in that case while showing the
counter value.

Suggested by: Avri Altman <Avri.Altman@sandisk.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 mmc_cmds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 429a9c7..5990502 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2360,6 +2360,8 @@ int do_rpmb_read_counter(int nargs, char **argv)
 	close(dev_fd);
 
 	printf("Counter value: 0x%08x\n", cnt);
+	if (cnt == 0xffffffff)
+		printf("WARNING: Counter expired, no further writes possible\n");
 
 	return ret;
 }
-- 
2.43.0
