Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03B291C12;
	Tue, 29 Jul 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792362; cv=fail; b=IY4nTEzdy63MaF9xBJERY6iPRyA3SbWIkmGIaK4KpXmtXou0SEzhQAyOriF1Cwobcf8/8Z8Z7spmM6Wfr++ElIcTh1510OHgHqj8jiEAosplzyhKzukLe9nB3MbXsiET4xcFfC21LfXQv1hZv2GoulNDy1rueqVECPavixpn8zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792362; c=relaxed/simple;
	bh=oAbj14QcHdL0u7bIVHGL/PkNmiqI2/hPiUBuM5qfjgo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iL3yVG2LkKrj0SWrpgnfaT3MxUaSn+0z6QRzkxzCbuQckGQjsYNU9/9mDNlws/8dACZMY3grrst4ndcL8DgMdn0dZvwAYL9mHIAuUwBYlA47wkUiQa2VJudieApvomG/dPQq3lrlFHRrlzQpRIdKzC07L+2xDXFgp+b9SBRUYhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=id172x+1; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="id172x+1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIUUQbWDKWkPslcz5Hm6bp8BhJqDfQSGuHqD+AXyae6wE9CDhduXf9sRx9ugXjARO3z6pNan7BcOfIoNhw1Aj8otBS50lAtu5ovr6oIRS3S8G4fI6IP2KdCt5Hq5pSqb0bzgpDCsV3nx8wwigjMucvuh9CrjKPSB1Jm/GY6r7hFBnkZA9PO8HQIXZWElqocYg6F3WdSYKqa2B0azQEyQgB+1OGpuqxgXDvc8p9zqbigxs9IEzVNYn5cxMUCUiOIojOriKSF9VpAU43vQb0jt6HvGI+wlVQnPITH+8Z1pMEdbEXPKpGwT/G23S7oaRbtdbyjUsmQhNPeuss02EzN7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq2ZV1/4818n/zeelX7mMp6KqG41q7cH4kJtHlbDlZo=;
 b=Zg9Zm87j3AZ8QVii9aYQr/HUWLU0Vb4ctvpLPDgkgHHhHAu1CZYgvf+oFxKuFWCryY/pDUGzQ3wwrrZtkgckt0J2H0emFNvRHnUGLHNMaPXt3EvXF40elAxmQ+7ti2NcUeGUTulZB0SvwnKPLjS7pHjSHcNt5niyUfK9S/PmIeXfcCp7r25Uzw3sDJxNN2AzKUfanzAJ4erM2WfsNJmlP9MjVUP4Zq7oNuj/WQbGwqW8Hl2WRowQqfoVve15JBMAmQPKvA4w2IdH8LjKWChuOU4BM1Wtfr767EAe+jrDzqD8CKFAehqcpTyVwaozg1RwUvRKwrPRQyyOrnBWXPq13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq2ZV1/4818n/zeelX7mMp6KqG41q7cH4kJtHlbDlZo=;
 b=id172x+1uTA6ng0INtK9CdqxO6a1J3nTV6mkcM13jBSJBgG+T7/26JbAOw9fBEJeuf1ZBFzea73s2qXzpq3Sl8aaM/YJ4o27v51EH98llBEjXL+p/xS1tyb6B1l7I3sAqylr/AckDNzO79+f4iQpnfl3+OlnC93Lwfpf9Rig+N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 12:32:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:32:30 +0000
Message-ID: <07748607-e13e-4cb6-a620-5d170c6cf208@amd.com>
Date: Tue, 29 Jul 2025 14:32:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com, saikrishna12468@gmail.com
References: <20250729064528.1426093-1-sai.krishna.potthuri@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250729064528.1426093-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 31260cc8-247b-4de5-77a8-08ddce9bfc65
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zll3b0QrcTVPRFRaVkowMTJFRXBTL1NmUFdTNkRwMElWaTFjZGFnRS9lQnRy?=
 =?utf-8?B?ZGVvZTI3eWFEdHIxNmxBcStnYVJCSGRpMWVhUytFWGs2aVRNWWxZR2lrd2Zx?=
 =?utf-8?B?Ymp1UEhOWGwrdmN1dGVmdEtpNklFa0RZQUV0RFNRVjYzcjVwbzhBWEJ2a01k?=
 =?utf-8?B?TXRvZ0t1Q3Z5VTlpOG91WEVjMzVGUUJsb1NmWXZjRFlGMnJSdStzSkMyRWFp?=
 =?utf-8?B?Y0xBMlZzNlA0ZzBuQ0ZyMHBBbUEwWWMrUnMwb2J4VHArZkxtaW9uVTAwTjVw?=
 =?utf-8?B?ZTBhbEp2blZ5eWNtRFl4ZExBV2hTWEJ5bi91Uk9mVmdXRWFJdG9zOXR6aFZQ?=
 =?utf-8?B?WWRYS3lZV2tUMnJuUTl4UXJvU3BYQkZFSnJsQlVHMTFaek9MM25YREllWW8x?=
 =?utf-8?B?Q0lEc3hGTDQ3cVIrYWFqT0VUcnBzNCtGS0N2MlhzY0E0WHBod0w4eVVSSFpr?=
 =?utf-8?B?N1Q0QVE0ZGlBd1FsRjdVN3N4QmNyRmdCZ0NYT1N4aFR4N1huZW9jKytUbk01?=
 =?utf-8?B?WUZ0V2doRlhON2RIQnpZZGdoaTRhSlVCNndnMGdIKzZRMUVWbkxCeEg2VjVw?=
 =?utf-8?B?dTJUWjROMmQwaDJ2WEVjak4vVFlzRk5GRkxTTXNVa09qWWMwdUJOWmJ0c1lj?=
 =?utf-8?B?TnhuSkJNWXY1UG5SZnNOS0FWSjZwa1ZTL0xUY3pvUFQ0RWJaeEdRR2ZlVThV?=
 =?utf-8?B?SC9EYTJwa25VN1dVZUFVN29oUzMyOTFUK2dIOEk2SStVN0NKa2ovUEh1bEFz?=
 =?utf-8?B?OUJFaDVyRnBPbFlyd3NYNFN1WGt1OEt1Z3ZmTnFCRTVSSlNtemVwRUxFQk1U?=
 =?utf-8?B?UVUxUjJoTU5odlYzMXRhT0xnVkY3aFJRSnRjdEpTaXZsUG95THBZVlBUb3lP?=
 =?utf-8?B?emU2MUgzQWdRblp6VEJ0ZFMxd0dsM09wY01vYUF5Nm5QNWVqd01TRzA5dS9O?=
 =?utf-8?B?Q0lpWldac2szQnd3QW0vL1BBdWhnbS9qSzlDb1RsbjNtR0lrZDVsajlDU0dU?=
 =?utf-8?B?YXhYZTZNMEZ2bGRUZWFsNGpUbE1ubFVXVnJvd3ZTYVJOekxZZTZBK2Y4YVFn?=
 =?utf-8?B?ZTRzaXBWa0NiUkRDUUhOQytteEdua3hSeG9VVWc3aC9MNVpodU13WEp3N3Nz?=
 =?utf-8?B?azZsdC9CUytZQVBvM3NQZ0g1ZXhzckhXVGtqSy9WR0FVNUdQZVNYc1dXNTZa?=
 =?utf-8?B?MHRlNUUvUWplVzJ1ekdWaE1TcVJSM3NEdnk1TVRqQjNEMS9renRnN1F3alk5?=
 =?utf-8?B?Ukd1RFhlOXpXTjhaSHpnN3hiNlBsTms0ajJPVnorOGQxUW9jWFJiQ3lRR3hi?=
 =?utf-8?B?L2lvMWgxaHN4TjdwUWxQL0xTbDJJMThxeUI5T2FldDhmRFJwQ2tYbDRxVXNu?=
 =?utf-8?B?Q2lyeHV2TlkwZ20xY0FDNXRBbEdXMm5rby96UXFmamRCb25FbVFxSmlMaWJv?=
 =?utf-8?B?dWt2b2N2RzdTQ1U4ZVg0bFNjQlJ0WjkyNzVpWDF3RUFGNDFNalBUZVdnVGVq?=
 =?utf-8?B?YUpYQTZ0ZHE4aW5KQVhCTE1jSzh1cVBWVmhUL25mNmQ1OFIyeDIxYWV6OXRo?=
 =?utf-8?B?eWhYd3hiSzByRXc3aEwwaFdJNkdrSkFqL2lucUYxN0Y1UXBIc2lYSkZjMXha?=
 =?utf-8?B?ZkR0d0UxNmEvQ0dsS1ZseGoyQ21BYmdSbWpNWVVrWktoMVVHR3FLbGpwSENF?=
 =?utf-8?B?V2VGc2xnanBRYVNoUGJOcXBUYmxURDkvTVVoVjYvZm5Sd0N2U3drUjRzVmhZ?=
 =?utf-8?B?ZndkSVkzMTB3S3dsZUhwOGx2UUZIdkpWOUJ5NWUzbmVTcUZMSGhLYVhGbjNa?=
 =?utf-8?B?NjZBUW9qZmoxdzE2dWhvODdPWmJBUk9UZmQ1U3NMQS95dWkraG9yWC9yTVBZ?=
 =?utf-8?B?N1R3eFRHRDBSczZyWmtSczlJSjZEcTJyVVdSNTZ4T1ZSMndMWXRiN0Vka2hm?=
 =?utf-8?Q?rB4dqXq4xL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjBlVVhMNHhPNUQvWXc0U1U0MFhJNnVRSVFvS0ljSWpvS2JCT3dlN2l6T2pH?=
 =?utf-8?B?dGs3emVEZmFJNVY2WDRqUVlZY3lyRDB6VGx6akpvUkdKUGxOVE93S2VpdEwr?=
 =?utf-8?B?SlhrZDMzcUgyRXhVdlRGSHl6cWpVZkNXLzJtRDY5RzU0MW81aFk5QmpPUnp1?=
 =?utf-8?B?eVlmTGFqRlpTTDk2NXptWUs0b2QwNnR1Zy9MR2RIY2VWMEJibkN1OSthWDRC?=
 =?utf-8?B?MzJYRnBNbHNZM3FreHh5blhQNlFEWndFUmNwNjVKbjZBNmYwQUhWTlVxditZ?=
 =?utf-8?B?ZFFVaCtTekViVjdCeU1xRk5xeTJYZXRieGJoNWxyRkRYU2kxSExjSzdmWDZP?=
 =?utf-8?B?S3VOVEp3YzZ4VzdNWXY0K1kxa1VhRnBQcW8rSkNLUkNBN1pkbm9mekVaanhE?=
 =?utf-8?B?bEhwVll5QmNDbHVRcnI3TEJRYi8wSmJ1SFFOTXc4MjVITjYvRmxrV01sRDdS?=
 =?utf-8?B?VnNCN25SbEt3R29hdUZaNDRxUXpaelVBaG0vMTd2RVlHZGVDNHZocDd3aGtr?=
 =?utf-8?B?RFJBRUlXVEFCMStRZmdtV1llOHY0M0tqYzZqb0JYeS9lSjRQN3VSaE1pNWZo?=
 =?utf-8?B?cFVHa1BZaWVZclNJeTBhQjZYTjd6TExKanRObFUyc1RPMm42S1MrQ0h6TnFU?=
 =?utf-8?B?Z0FJK2pvTm5JVEFjb3hUUi81QWFmOXRWc2FLeUJqTGRsM2lBbVVBQktSRlBY?=
 =?utf-8?B?RndvbENneVRMTmU5Q1dsOUtyVmZnTWxSWUlJM1Q0UEIzbW9rS0JWVU9iTmFR?=
 =?utf-8?B?alBUTkF4M05XY0c2K3VyUmk3cXpndGtackhQeEZkQlJPNHZUOHNOL3ZMdUo1?=
 =?utf-8?B?a0lRc2xnckUycFRTTmxkRDNmWnhudDgvQVRFZHEreFNabUVWL0lxYlNMYTZT?=
 =?utf-8?B?NUU1Zm00QlljcGc0djNmRFpjYVRqc1pPeHN0ZHcrZGxFTVAyNnVub25jaURV?=
 =?utf-8?B?NVg2bDZYVm0rMEx0SzZ1aWsvWTQzNVEweXNQbG12c3c2QUZzL29mR2E2aDk1?=
 =?utf-8?B?MExSWFo5eHBRM3dGVEVVVUxzWStLOEIxaGhtY1M3VFV0d2hxbWNFV0doZXlL?=
 =?utf-8?B?NHMwOVlaSklSZFM0WjRyOHRXWThheFVyYkxzd2d3TFp2eG9iK25Pb0tOdkxJ?=
 =?utf-8?B?aTlxQ1Z4RVBUSWxDcnd3UWJkQW9TTjhDSVVDZ2Rja2VTczZmbHREL3R1WEo0?=
 =?utf-8?B?bURqNHFLcjZNR0owWlFWRWZhMFdlRlRaVDhKN2FyTEZJQy96R09JVGpYQlBL?=
 =?utf-8?B?bjhrZHRhc1F5WEc5eFhEREZlc0pheFpQSEs0a3MzbU5tbjlQNC9qU0RScXNM?=
 =?utf-8?B?RG9WUndOOENBZEk3NEhBR3BjMFNKL21xdE96TkhiSGZROGxMYzg5eDVpUXJ2?=
 =?utf-8?B?NWdSQ0UreENTMC9tOXN0Q0ozY3k0MDd4dXFiY2dQM1p4TWZDUUI0WlZDNEpT?=
 =?utf-8?B?c1VSU1g3ck8vSjBPNGwvNDkzVGVlTXBRTE9pV05BRW0reFhXVnNJeFBxanIx?=
 =?utf-8?B?SVBGWmpqVFNBUXZoWGxlcndlOFZoeGgrZzFFNFJRRkVyZnJadWJwZXpDWU10?=
 =?utf-8?B?V1Y2U3IzUWZhU0lVZHJPWDhMRE9nNDlzTDBwZXZQRFcwUGg5WU0xbExsdEdW?=
 =?utf-8?B?WkxWTTNkZy9HYTFPVGxYY2pkRGlNQ1VBT2lpZkJtMEtzN1NwRUlvMms4d0t6?=
 =?utf-8?B?UStHbVE5N1hRWkxPU215L2czenMzVkdlS1AxVU04dkk3Mlc3akZ3bVJkYWF4?=
 =?utf-8?B?QW9NS29CdnpBTlVvN1hlUXFOQTYvNkk5RTAvek1FanJrQlVwVmZHMDJrQ0Va?=
 =?utf-8?B?K0s1TnN5ZnVZMVJkWmZQbE5QWW5zRjkrdnBnVTZxeStuRGU1ZHRYeko5dDhH?=
 =?utf-8?B?VEtOenlzYjRxSmUyS0NtNmtENjNMY28wbkhHYXVhUU5DbWlXaWJZbjBUaldM?=
 =?utf-8?B?eVVUaXpSWjFicEg5OVZpb0FJSUQxTWxDVGpSaVBPWVZjNmo2T2hmYUJvbnh6?=
 =?utf-8?B?Tm9Camx0T3czd3dvTG9BcEJ5b3k5NjdON1Q3SGVHL2g4U1dIRUJXdTQ1YUl0?=
 =?utf-8?B?WmcxNG1PSGtpTjVvS0xERDNnS2lyazdrckk3V09uQ21EbndrTDJ2VjYzTmJi?=
 =?utf-8?Q?YIbMWMxAU1g+EMYD0ueKGZ28V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31260cc8-247b-4de5-77a8-08ddce9bfc65
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:32:30.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ks5ZIuHZwk57dUIetJB3Ofv/NNVd972D5ALbX21yRTOmjHSZkO4NbfcdjYxfa2xR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559



On 7/29/25 08:45, Sai Krishna Potthuri wrote:
> During SD suspend/resume without a full card rescan (when using
> non-removable SD cards for rootfs), the SD card initialization may fail
> after resume. This occurs because, after a host controller reset, the
> card detect logic may take time to stabilize due to debounce logic.
> Without waiting for stabilization, the host may attempt powering up the
> card prematurely, leading to command timeouts during resume flow.
> Add sdhci_arasan_set_power_and_bus_voltage() to wait for the card detect
> stable bit before power up the card. Since the stabilization time
> is not fixed, a maximum timeout of one second is used to ensure
> sufficient wait time for the card detect signal to stabilize.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
> Changes in v2:
> - Use read_poll_timeout() instead of readl_poll_timeout().
> - Enable the CD stable check using platform specific quirk.
> - Define the quirk for Xilinx/AMD ZynqMP, Versal and Versal NET platforms.
> 
>   drivers/mmc/host/sdhci-of-arasan.c | 32 ++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 42878474e56e..86da766fa480 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -99,6 +99,9 @@
>   #define HIWORD_UPDATE(val, mask, shift) \
>   		((val) << (shift) | (mask) << ((shift) + 16))
>   
> +#define CD_STABLE_TIMEOUT_US		1000000
> +#define CD_STABLE_MAX_SLEEP_US		10
> +
>   /**
>    * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
>    *
> @@ -206,6 +209,8 @@ struct sdhci_arasan_data {
>    * 19MHz instead
>    */
>   #define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
> +/* Enable CD stable check before power-up */
> +#define SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE	BIT(3)
>   };
>   
>   struct sdhci_arasan_of_data {
> @@ -514,6 +519,24 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>   	return -EINVAL;
>   }
>   
> +static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host, unsigned char mode,
> +						   unsigned short vdd)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	/*
> +	 * Ensure that the card detect logic has stabilized before powering up, this is
> +	 * necessary after a host controller reset.
> +	 */
> +	if (mode == MMC_POWER_UP && sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE)
> +		read_poll_timeout(sdhci_readl, reg, reg & SDHCI_CD_STABLE, CD_STABLE_MAX_SLEEP_US,
> +				  CD_STABLE_TIMEOUT_US, false, host, SDHCI_PRESENT_STATE);
> +
> +	sdhci_set_power_and_bus_voltage(host, mode, vdd);
> +}
> +
>   static const struct sdhci_ops sdhci_arasan_ops = {
>   	.set_clock = sdhci_arasan_set_clock,
>   	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -521,7 +544,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
>   	.set_bus_width = sdhci_set_bus_width,
>   	.reset = sdhci_arasan_reset,
>   	.set_uhs_signaling = sdhci_set_uhs_signaling,
> -	.set_power = sdhci_set_power_and_bus_voltage,
> +	.set_power = sdhci_arasan_set_power_and_bus_voltage,
>   	.hw_reset = sdhci_arasan_hw_reset,
>   };
>   
> @@ -570,7 +593,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>   	.set_bus_width = sdhci_set_bus_width,
>   	.reset = sdhci_arasan_reset,
>   	.set_uhs_signaling = sdhci_set_uhs_signaling,
> -	.set_power = sdhci_set_power_and_bus_voltage,
> +	.set_power = sdhci_arasan_set_power_and_bus_voltage,
>   	.irq = sdhci_arasan_cqhci_irq,
>   };
>   
> @@ -1937,6 +1960,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(np, "rockchip,rk3399-sdhci-5.1"))
>   		sdhci_arasan_update_clockmultiplier(host, 0x0);
>   
> +	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a") ||
> +	    of_device_is_compatible(np, "xlnx,versal-8.9a") ||
> +	    of_device_is_compatible(np, "xlnx,versal-net-emmc"))
> +		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE;
> +

don't you want to introduce new quirks field in sdhci_arasan_of_data and just 
assigned them to sdhci_arasan->quirks in probe instead of calling 
of_device_is_compatible(). You already know which device you are running at when 
you are in probe. And it should also speedup boot.

sdhci_arasan->quirks = data->quirks;


Thanks,
Michal
