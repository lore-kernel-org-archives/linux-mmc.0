Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5113DDA8;
	Thu, 11 Jul 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691253; cv=fail; b=Q8hofzWlJvN72G9G2OsVGCPqyXsoLx8V1Y7WBw0uLajGjBbv6WujPIuPHOtJgYFZ/VswYAYSuw1SRIy3dywkYp6M40/WsLn/iiaB997+3ULLcpaWc4r1WJgrH3fM4NUDCuPmr0ViHToLDRDB34vWQEGrmzBDNn3HWFtf9QNQPq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691253; c=relaxed/simple;
	bh=ysi9dwo1Tp3Wu+yQsrmKerqy1WWWJVIIeVoZWzmv6vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlFQo58HOnWvdQipL70Dlyzp9OG72P0AYrXnPiux6JVj+u4vhQBWrV9RjM9l+u6w9NwYLnjkbljIRQRiKoezBXi6ctYURkyMu0gL6RSi3zos3ilReTo0TYKoHQuiyzLYhBXEOx/EUmDjGc+9xv1uwsEKaGRmgXb2ZamTXiGrsGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z50Xa34r; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z50Xa34r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHGGebM4XH5i2fTp37+ka/WzTFGb9BmBd71o7NnVDv9O8PZy9o+tICUcJH+nioGWKEioVXBXsswWEob+Q4YS55sq2UtzCqL9pIpVzScBQywhH4mGkqDhIdYpBS0wFfqvJepnC61vsN0UXTVinCW1Sm6uK5GYb+iTEzie2PUMZGQIx1MT1IhU4G4LgkJF4Ng4B4eJOLKaKHE2/vSLWs3o/7fy0IwOK48usDjldrFN1JMyKCjst0Znzqavkm78o7IAsh0c8WoTf45dCrfX7zd0OG2rKEgq7DN6UMjHIHzwAPB/wExOwIqPR7kI4We11nmA9KNlqQCizfvzhf8gZeMj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBJU1PVlntxnwI34vEwy2LUhc+gFLPUvmcKj8+EFB94=;
 b=cdfWUpNtyjmCsEGKlHyouLIdgVCtw1SlrI/Kwq5RkX61y2Ui6OeLu+nmil5YcONIKUYKLjWgcyMSaHv6iUyDWISYheWdjLJpBKBwaQYh+a6eMIRMhDKg2pMCS/g/vE8u7YIKM636clzxxAysXkmTfeogI9H3VubCl/OetzCZ8PoSStF6HzLeacO3lA3/fMkeTYn0SBKo+UkVrBGRwwkegviOTLSLwU90uN7WZegVdHLDAZVdNnyZCUytqr9rMSUBIBABgOObZGzTRQwPtCUiTZ/zqom5pPOgYl5WZLP8Nc5NF8yTF9+zRChTGLZA0de7LJTHNAJUWyKU4cSdEFvVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBJU1PVlntxnwI34vEwy2LUhc+gFLPUvmcKj8+EFB94=;
 b=Z50Xa34rhPs4n44YuDFzCGVgCMXuR5YBdCJw/Ud+qfhX6xmLomMJrrPUe3HZ3KqGn8xeM7AaSQrSEFd4ge5PRs3YM2zFZiQ+Um85iQxjFSizduNUo/0RFstyuZJC9QPJVEvzhwzkdDcfvPQv+EVKagb1HJE1aKnb8plLlz88pD/GH4kTx31iLwbPpH9naZU+Omb5VsayWhJ6LFEJmUfg1gPFGF7VBvYYi2ByvHF+1m0P3E62Zz1w+v3SyTPu1ZmG+uIiwSCeU0gW05vODJaSA9xg+pMu6AnjW53KEY0Kbj9wOxAGA3potblDwXgsTMVUE2k5fKKMGiITb3zRG2moxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 09:47:28 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 09:47:27 +0000
Message-ID: <ffbc49d0-8f4c-4c76-8caa-21203076a592@nvidia.com>
Date: Thu, 11 Jul 2024 10:47:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE
To: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20240710180737.142504-1-adrian.hunter@intel.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240710180737.142504-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e702352-cc35-4118-3a75-08dca18e797f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVBtRk9xbkZwYk14bDl2bUcwSnNRM3l6Vi9MVHhIYVlwOXJPM1Q4dG9jVUZn?=
 =?utf-8?B?QTdZVWw0andSQkY0TFFmcFRVUXphMFBHVjRDTTM2QVdLNzZGRi9OQVBBQ2RO?=
 =?utf-8?B?Yk1IOXhqT0pINzJLclN1RzVaVGRVR2hyYlpDUmZteFNTcXg4a2pULytjUTFX?=
 =?utf-8?B?T2RjRnlKQm1Fa1lCZmROTVNmcWUzbzd5eEZWUkwwMXZtSlZYVTNyT2lCckMy?=
 =?utf-8?B?UWxpNTVBWmNzWFZuVitOak1LSmxnN3JrQ3g4OTBwSGR1aVcraEViTS83N3pF?=
 =?utf-8?B?OXc0TjNPSW9aWFNkYnRtbi9rNG5vSzB6bTFEM3NLcUFFOUVkSHgwV2Zuckpt?=
 =?utf-8?B?RENvNmQ4L3pBZ3hDRG1ZWkJNZkRIcHVvK2RJd2t1TXorMTdrTzdqakxGamlk?=
 =?utf-8?B?OHJQNWJWQ3F0dVY5YzI3V0VBSGg5ZkVWU2RKbkR3cEVqcmorWkZWejcyajJJ?=
 =?utf-8?B?eXc0NkFEVGlIWm5DMlpUTU9RalJJNHVMYjJ0ZzJDdHpJZUY5WklENS81Zzla?=
 =?utf-8?B?bFNEV1ZxeEEvZXkzUFRuMXZQbkorbkU4cFpNR2puQm05T251ekIvalFlVlBv?=
 =?utf-8?B?VFVDUElTNEVFOENVbzd4Ty9HU2dzUjJuVWY2UDl4aEhSWVl0NThYTm4yRW9a?=
 =?utf-8?B?aSszRVd6eEpvQndtelQ1N05QL2UvRDJBbUxiSWl6bVNrYWlrVzJtUDdzU0Iy?=
 =?utf-8?B?eWdnQVBaOC9kYnBlU0Rtc2trb0RsSGxJc1ZiTGxraGdkOEV5Snc0bS9yc3B0?=
 =?utf-8?B?QTB4aHRFRWtnYXFyZzVFY0ZJY3ZoQlgyLzhWYWpxSzdCTFFVZ1BjbkZJVnhP?=
 =?utf-8?B?NUs2WWxqTi9ncDhENHRMeG5iRUNzZ3JOUm85WURRcXZhWnNFYjRPejJsdkhi?=
 =?utf-8?B?TGVRQTF2L2FzMG5CVjJqc0FFckYzMGgxTWVYRnpNbEF6MlNUV2FXVFh2NlI3?=
 =?utf-8?B?cStNUDlwcXVPNVJrVER3eUhOOFRpd1ltZHQrbmhJdDlXdVRFa1hBcTRoaHI5?=
 =?utf-8?B?ZmEvU3FOTDVwZ20rTWN1UXFza0tBMCt5N0pJcEpUWGJkV2JwV2V6ODRSSFVL?=
 =?utf-8?B?d1dZQlpwSnFIK1N4QjQ3c1J1OVhWWXY1VWZ0WVZvWGovblc2N0VRZXFWbGZB?=
 =?utf-8?B?NHlFdVNNNHJ3eENuNXBsbkxoRUEwendNYk1NWGw3Y3VTVm5iMFA1YmVXbG1a?=
 =?utf-8?B?akRQWXA4MDllSTBCZGlPdDI5dlp4S0sxZ0pvUG1FZjdWQW8yYU9ycVpFQUw5?=
 =?utf-8?B?TVorQmx1UnpKdmp1aVpkY1k3TVFUVC82MVZwdFFsN0RReGhwYTNudldpbnVS?=
 =?utf-8?B?aGpNOUcyTi9ZOE12a2JuM2h0RXFrYXBVSlJpZG51QW9KNS9qSStLWlZxNWxX?=
 =?utf-8?B?UzFUc3pOdFdXLzB1K3kvRlhXVWY2SGF6RzloVFE5cnJUZnVFRkV4dlpBbFhG?=
 =?utf-8?B?M2prUytMN1BtVDloOS9xQzdvVFgrblR6cXR0amVDZjNCeTBQN3JGbnFNaytY?=
 =?utf-8?B?OGhoNWRFSStYU0ZZd0VVWlBNZktlQnFOdGdiNWNNbUk1U09aK3k5QjBsT3dj?=
 =?utf-8?B?LzBHaWRGaHZIZDRiL05TdVVhSnBNOVpCV3h3cFF1WXhuZUgxY3ZKTWRMaTJz?=
 =?utf-8?B?R0ErWEs3NHVFdGZKVUREMjJSWkJQcjNkNnhyaVhoYUhOVlhLalVOa3pNenEv?=
 =?utf-8?B?elRnS0tlcVpRcTJrQU5aRVY1N0hOdVVDVFFSNzRPY3QxektKU1FWVTRzbVAx?=
 =?utf-8?B?S1UwQ3BMNXl2WkVUaTNETEh1THhCcEtLNytyRzhhODdlUnNSV0xmMTJBTkZK?=
 =?utf-8?B?SVFrZmtHdzZkSkc0TUlZZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUljRmlncnBkTit5SXQ3L0JiZ2IwcFBzS0RJMDEyT0FIMVMzdWFVTXBkazFk?=
 =?utf-8?B?NmNYWmRuYzVFa3RXZ3VubXI3dmVOQWZNbk9LUGYyc3dJSDlOMG1GU2FTK0J4?=
 =?utf-8?B?Smw5UFZ3TTRPa3pSdmNqeDQzdTdnajdtVjdicldmSEtCQ1M1VkFjazVRVklC?=
 =?utf-8?B?OTllbUtJS2thclZRMjF0ak5rdVlRVk9UZFlBUVk2V1MzeW51RlJmZ1ZFMXU3?=
 =?utf-8?B?VE9jZU14eTljRmpIdWR2SHVnVGF0TWZBMXNhN1JSbWZ4U0w5ZUN5YnlLZzNK?=
 =?utf-8?B?RERoNUN3U1pBUVRHTUtzeVE0Q0REUVViTkRUNktJcXR1cHlad1JkN0FjSzd4?=
 =?utf-8?B?Wkk3UStZQlljT1hmNHFRbVBIblF1c1k0M0p2YzJCakd3T0crSHA0NFdrR1RC?=
 =?utf-8?B?bUtIQXpYanpGOUdXME1pa0tuZW9PQkNkUnZRVGt4TkhaRFF2TnQ4WVY2UzU3?=
 =?utf-8?B?M0hWVEI2bko1ejIxYjhJVEt5TjNudDlJbGg2cXpwbzd1UkplU1BNRzhPbTJz?=
 =?utf-8?B?UThsV1FiRUlYajJFMElOa0RxeUc1dlJnMmlLZ29sZUIxMjB1VUFsK3VsK1Nz?=
 =?utf-8?B?ZEp5bVU4VTlxVVQxc1B1bHBHT24rQ2lBMVQ3d0VPandXL09JV2tFeUZDOWdo?=
 =?utf-8?B?dS9CTkpudk4yRmJwdEFvSDI3ZkNRNlU2cjN1UkVGWWxaNTZ5TkZJdWNKSnVO?=
 =?utf-8?B?Slk4Zlo4bG4xL2tvUGVnaHMwNVViTE9RaHFWc3BvOFo3aEYwZUduMGhJT0Yv?=
 =?utf-8?B?YXZQOXBxODR4MkplN2paTXZHaFFkcHp6cStiTnpUVThwV29sVUM2NVRqSXd2?=
 =?utf-8?B?aWMveHdqekRFUUFlQXZBTWk5N2xzaisxQjJVVVpiMTkrSUdjK3NXQ1RqVEhX?=
 =?utf-8?B?NnlaZ3hvcmd1UTFJMXFnSTYycDNtbXdrMnlSM0JFRWFlSUdJeVRDcWZGRmhp?=
 =?utf-8?B?U2RJWGFqRUZRMG5XM0VTT1ptbWZjTnNUdE0yM1d4OXVqYjhmVEhZaEN5QkVV?=
 =?utf-8?B?enNMNk1HU0xkOHVvVFlwR2JqVXBiVytWRnN2VjhzQTBWYlpRaklaeGZSbkIr?=
 =?utf-8?B?dTlEL1A0TWlXN0VzZklQKzZBSHRqWTlCZXJHa043TGFsMmE1akxQeGREYysv?=
 =?utf-8?B?dGJ0N3pxaU1CZ0I1Q1p0Mk0vOE1WMkNDekRWSnJ3OHdtVkNnRHNna2dPYlFh?=
 =?utf-8?B?S3VkVDJnSTl1U1c2aFh0Y2RJdDVseHpPb1JLcm1mbEhKcVJyUTFBY0pwTWV4?=
 =?utf-8?B?TnRNdDBpN1BZUVJaeFpDMW13TmpFbGpla1d2RjV2R1FDQURoenVZZis4cDI2?=
 =?utf-8?B?K25RcGdNYTd2U3F2Ui9uc2hoM1lsU1JDeHUxOW42UWM3S2ZoS3BFTmVuNjIx?=
 =?utf-8?B?MktEN0lGSmptamFSbkRWVlNCOThKVlp6NGg2cVRlb0N1U01SQU43aEFsVTZH?=
 =?utf-8?B?V0ZVeWJBVDY1cGFKRmpSaUlqbmFYMlg1WE1RcE10YmdxMzk3bS9EWktnTGFK?=
 =?utf-8?B?cEJMbXJzNTFhQXpZdnVjTU9PZFZ0T09IWGM0cFZ6SGVqRjVKQ0FpWlRoN3Zo?=
 =?utf-8?B?WnU5TkFQYWF0RVRucVFRb01tTUQ2TkJ1N0JQZ3RuNWJhbmNSVzhLdEY1dG5N?=
 =?utf-8?B?aFRGWll0WElQWEcyRjFuRDQvNkZJN0tyaS8zOXZWY3JqbldOczBzMDB6WWkx?=
 =?utf-8?B?QUtLWVViblFRVkh2QUpOS1gxamRXWDZJaHNva20zcUcrb2xndEd2QjBnZlNl?=
 =?utf-8?B?Z1A5MTdjT1gxdWkvZy9OUEZXZHM3c1Eva00wSm1CZklGZ2p6TWpwQzFUWWxw?=
 =?utf-8?B?V05mWHNWT01IMjBMT08xbStJMnFKMDVhaU4vd3dLSFhkTTZmSUM2ZHJKSXNl?=
 =?utf-8?B?SUFROE82TnlCanhURm5tMkg4MkNNbzgvSUtiOVdOSXVSSmxxMHlTelRBaHhP?=
 =?utf-8?B?UjlaYkR2OG41ZXh2VVFzOS96bjVvbDZONFlBdHZRVFJrTGpaVlAyTUZLdkc0?=
 =?utf-8?B?OGZxMWx0RE1KUHMxY1ZHcGhQSVBzT01OZTNVT0FlWjdJMThPTllBbm9uMVU5?=
 =?utf-8?B?QWo5empJcTd1NVdkVnVkemhRcm9vUk5RSDlGaWJ0a1N1N0NPS1pZMnZ6MjJy?=
 =?utf-8?Q?KcGyWx/9WprU9DNCg4Br6uW24?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e702352-cc35-4118-3a75-08dca18e797f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 09:47:27.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYPsU4L//mqy9S8eIXae43mDd4DOJMDL6yWWs0HgIkhR4RoSOPUyE0Bxi6X0LCFQ5lIg45nG+yKHa8m5Y6Vzfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317


On 10/07/2024 19:07, Adrian Hunter wrote:
> blk_queue_max_segment_size() ensured:
> 
> 	if (max_size < PAGE_SIZE)
> 		max_size = PAGE_SIZE;
> 
> whereas:
> 
> blk_validate_limits() makes it an error:
> 
> 	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> 		return -EINVAL;
> 
> The change from one to the other, exposed sdhci which was setting maximum
> segment size too low in some circumstances.
> 
> Fix the maximum segment size when it is too low.
> 
> Fixes: 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   drivers/mmc/host/sdhci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a20df9383b20..4b91c9e96635 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4708,6 +4708,21 @@ int sdhci_setup_host(struct sdhci_host *host)
>   		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
>   			host->max_adma = 65532; /* 32-bit alignment */
>   			mmc->max_seg_size = 65535;
> +			/*
> +			 * sdhci_adma_table_pre() expects to define 1 DMA
> +			 * descriptor per segment, so the maximum segment size
> +			 * is set accordingly. SDHCI allows up to 64KiB per DMA
> +			 * descriptor (16-bit field), but some controllers do
> +			 * not support "zero means 65536" reducing the maximum
> +			 * for them to 65535. That is a problem if PAGE_SIZE is
> +			 * 64KiB because the block layer does not support
> +			 * max_seg_size < PAGE_SIZE, however
> +			 * sdhci_adma_table_pre() has a workaround to handle
> +			 * that case, and split the descriptor. Refer also
> +			 * comment in sdhci_adma_table_pre().
> +			 */
> +			if (mmc->max_seg_size < PAGE_SIZE)
> +				mmc->max_seg_size = PAGE_SIZE;
>   		} else {
>   			mmc->max_seg_size = 65536;
>   		}

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon
-- 
nvpublic
