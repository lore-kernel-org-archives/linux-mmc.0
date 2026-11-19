Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795081546;
	b=NWtbamifLaZB0pJ5sPHBON22sUdIvViskcIKtJ1xrL8qTXiLBcy9lVaBs8/KUEB65zza
	 lSFoWdprFeZ04mgyBXFvcur1+JuAbqnX4I4y2oe8zA+o1RwxWLmDtVxJXANumv4IgMP57
	 nX4pxcdnROPYB0BVODIrnf1xiwuMfqr0EsTBAySHBSXNGQsNC3bi58kwVNryPq3bkfo4a
	 +XlJZPM7+q7QLiK2+RRHNovDOyyNa49pA53Du0ilyAWamhsZNtaVF5buutA7VluRAVXCv
	 9vRL9U8Jfd7U1ziNh//h2gkZvQNEDNFHz/7A9kG4TdZZ85bwAEsLwAe2iXWJS7JAKvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081546;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:Content-Type:X-Change-ID:X-Mailer:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PW+RCger9HVlQ185NQVmEbRf1KV5iNIkp9uj474YG2A=;
	b=u0FjfXUEZvriKeSoQj1HHOnDyWqh7oL9eT5MCXqtzA6R+1/Jt7Ie/F1n0WPyvUnGCnSN
	 9Xo10tkPDIH7VTgs2mpXu9VZ0IUxoLKor3zURLksUeNQSx03jBLsKhwYSDgVD4yvKvaaR
	 QY2pMqx/VxhhgbBi9oQiiJqDJ5i0YrL/u4IrO9Y5VSbSFjzNZwV9lvYEMtXs/sdVw8nqa
	 FNj+vyKjMFmF/XLoAH0AUsVW3Fl4RnEI9LmuPdtiNfUL2/0M9+XfeZlk5GrzFpSoB/VFj
	 b5F0YGbh1XurBCrFDSYdn8jgl5qRnlUj5FySSqraG8PQfvwqZHdnPIuRFoCbs5YrNZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=prGd3Xl2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.23
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC55606A320;
	Thu, 19 Nov 2026 09:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC55606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=prGd3Xl2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEEB96sewZmr/Os0cfMofnb1pd/4DmzprvHH/aaIbhx8YnuC3L7D1pBIHxc3bjxAwxU5qkqMlgEKtZ14R66UlRhHe7NFD+nTy3Dw6eieakx5KM9mhuvRx88oHgVEQufiae2dGgWMHWhJAaiUKunA6lHM+aRqbW7wXTtTRCTia/dEBY85yq3vG3Fo43l6/3TPstnQx/WzAAlNX/0chhr8U22457gF7vIV/U605Dx/oG1+M+eHByXd7/D/tL2scUPVUaGLcMDQ6mr3NLOJlQIZCHlpXlZwyLJd95V5nksgcTYvninTb81bxhN8AMvvVY0gkQeQoecgpPc78n7WFQdaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW+RCger9HVlQ185NQVmEbRf1KV5iNIkp9uj474YG2A=;
 b=b7jYnPJ+M8xeR4MQfooBKKXw2/E/eZzTmjq3Cs0DQSIARsZX9GVNB/PzMpRYGJekfT5FnZrJeQcOTdXmPeOSPjwSvRRWyBu1z6nd/2mnBNj4+yB7YNfSmoleHcKKxD2/Q1Y6K0h4aVU0CJEU6lOO1amwLZY1UmL6g3KJKtI1Yyo3oU9QMw3Rexg1GnMEAmE6ks8RcQm+73QYetUZaJe+Dt4Ayhy76QBLWnz/0PK1oTPyUASxnXRQLgZFns5xssKdqskxEyICt3y2iDT3Po3p3Jjv3D1yBCg7XEgrnkGS/zilMIcUd45bf9u42vTwWsALoFpqPpcVymUW4VDsAOuAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW+RCger9HVlQ185NQVmEbRf1KV5iNIkp9uj474YG2A=;
 b=prGd3Xl2gcOvLRLWt7Sfg0zvmHM3i3o7jIhKyKR/btYqQC5qjSrSV44d+D1Hx9UDQMeP1HGtS2FOsvasikAh1S8fBDXq0ZBLMdfPwWc7Y37MPCRsIF4FXgWLiXMSP7gaIqkd0gcnCqngqv0kUR5xds0bByD7Dqs1UPcY4EQW95M/g+Z1jllgmhrm7JeXWn7iz2PV3t9/ZYvolc7kERFj/2ZnCzQ7QwRd3s8OizHZxTvFw2f/Y4D3ZtJLh1Aa79CljmIOkhrEKXTcvLHgbvPX6LaCDU5IXQ0AUZE6cwAmPWY0P2w/pnq5lNC3K3odOCMtikAKnbzeuQVxUdKVf/t+eQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6987.namprd03.prod.outlook.com (2603:10b6:a03:43b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 09:45:41 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 09:45:41 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v4 0/3] mmc: sdhci-cadence: SD6HC DDR50/DDR52 read-path tuning and fixes
Date: Thu, 19 Nov 2026 17:45:32 +0800
Message-ID: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261106-sd_cadence_ddr50_v3-35f970f31364
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: b243ceb2-1920-40cc-65ad-08df4621dfb0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|260925022911599003|261102123227099003|261026121527099003|260925021311599003|260925021911599003|56012099006|11063799006|10067099003|261022105027099003|261022075727099003|261021123027099003|261026140227099003|261028144727099003|261022113327099003|261021121427099003|261009223027099003|6133799003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+oG9qNxdeQn/aYvaQKZWdK/iZdSUxg8uauBx7KqfyJLOWohjvF4K4SqzBxjTLu+jQGL/emFqG8izoSlEmLY0pg5EpG/0GOh0riWbfnOSNZh1Y4cZVg3bj/nrqclvk1yFkoJFQTysFaEgmsvX4PxO9QGicT8G9HfgUgeR3BlMZar1qkvtce1VKiviUR7qyDIleZyS6dWbVRgb56PK5dDh+m5tmBZz0CzBjSUlZ3NN46W6FRyh4bHPhT7DGcDon6y9uGWBDda+3uUKTvWVFeqX8dEu9ibC5WOUCuj1v99UwUfFlIh2FGh60XqaVAqH5hiY0AvDdgKtZDCwc3XDvcr2NxZ/oGeuTZJNayDfJQeanGcmgsbWkseNPqPLTSb5CCMWBUfVgPApyejhOZ1tZ8+8gXdjFzXdDRC+stA553JvF38cWKcTWwnjWEBFk/yqPhpqHMzJvc+Yox/AF89Gz0c3qZ3yaHUTZfjjuAJXbc/CMrv3CZfw4mG4bt0xsJgUWTjHNrc74ds0nxR/ukVBpFS6kWaBwaoDlotbW4rBH2iPyiJzVFYRasrRT0t7f0gA8qHknH5GYPhYvk903V2If/PBvkWlU0XuPZwLs6VZikUBEGy8IU8FC4hRs2151HHJaZIM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(260925022911599003)(261102123227099003)(261026121527099003)(260925021311599003)(260925021911599003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022113327099003)(261021121427099003)(261009223027099003)(6133799003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NiME9BWHJlcWNkUW9YMHZrbmJaa2VCSGtGZkQzQmcvU2RIbHJqM2NtU2lo?=
 =?utf-8?B?S3BLZ3pxbnVHc0JDSi9lU2o2SEZISEx0M0VEM281Nm1oaDZ2c29rdFdnc1hk?=
 =?utf-8?B?Tmp0OUZKWHZVK3ZFN1A1Y1VsaE9tMzBGQzJNSHZBRndLVUNtbi8zMFRUaHRm?=
 =?utf-8?B?SklGbU83Tnd4NzZiVU9ETnkwVzNINndRWFIxZUtXOW4xbkR0WFhKRVNjY1BT?=
 =?utf-8?B?RjYyMmRob2kvcEd2dVJXZTErM2xVd1RlZ1FaSWgvVFVRVmtrVEY1LzR1VXk3?=
 =?utf-8?B?bVp6WnJyQWRRaTBQZGZVWldCYlJITFNkajdMMFVkdXB6dGxyT2QwSW1MN2hq?=
 =?utf-8?B?QXVQMkxMV2JyYXlLSEpQelhpU0x1enQ2U1JzZ08zQjE5RE53bkErZXA0Mk5u?=
 =?utf-8?B?Q3FRTlhybWFTUy9VSDVYU1NrQjdTMHhYUGhTTnBkK0JjR3gwSWpldTBCSEls?=
 =?utf-8?B?bUlkVWZGNHpKQlhiaVdhWnNEbmFUb0hkZy9POFQ1NWtRZWhRaC9ZYldTZnB2?=
 =?utf-8?B?VUdpOEY1bmxFcXpSLzlGU3Q5LzNURmVUS2lsUWsvOEpTazV3VUFxRFpIOE9i?=
 =?utf-8?B?eHNJMGQxUVpGZ0k0ZXRZNHNOaitCMm5odEE5VUY4TDBWVGo0bGdHRzhQOGxq?=
 =?utf-8?B?bmJ3YmQ4WHVJYlZTZVdVeFRmcEJUdlE4WERaVVNaR09FdTBqbnF3UGFLSldI?=
 =?utf-8?B?RTNZK0lGRE8ybVdnb01NalY5SXU5QkdncEljMDJzRVRndTBCWTRVSlVpaHl6?=
 =?utf-8?B?RGtFekw3WW5tTHBvQjR2NWNWOUNTZUhIS0lyVU9pdFd3WXIxdCtmUmE2QXZz?=
 =?utf-8?B?MnpPV3pvN0NVWnNjYUg2UUJHN1RJMmZGUGN4MWpKdVcwY3pPNFRNOTlRRStl?=
 =?utf-8?B?OUprb09LRDQzT1BKNWV2UFdHcm5vM0NVTkpsM042V3pPNklPd3JzMUJ5VDN5?=
 =?utf-8?B?RDZWc29VTmhGeTBtWFJwV3QzeldKRFBMY1hObWJGaTRBUyttUVhEdE5kZ3F2?=
 =?utf-8?B?d2JqbzZrYnV2QlRsOVZXSmFsWVR1TnZIKy9RRG02cUZKdE9BemsxaTFZY0dV?=
 =?utf-8?B?V3c3OTM2RVFuM0hrQm1IREJRTm1hVVRXMDhoZy9DTzM5NHNXSHJtMUtsQWtR?=
 =?utf-8?B?QTBrYjFpUFlaUU1mSHNRM2VqVEtTdzB4U1hlQk1SeFMrOFc5QndScFpScUkv?=
 =?utf-8?B?SDQyWVRrV0RYMDA2Q0pNanBjTjk1bEhDZlV3ZmtiempSNTRrWndOM1RLQzE1?=
 =?utf-8?B?YmVNM3FXRXhCYmRYeE1IS0dKRWdLRFRCQS8zN0NFdUFLS3k0T3hrbDN6M3hM?=
 =?utf-8?B?SFVsNFFjS0lGRVBibDRreWs3VS9MS1RwR3BZMEdkdmk2UUVkUnN2RnowK25n?=
 =?utf-8?B?ZnBzWnlIelpoenBjWDMyNFFGbmNUZHlobGd1b1h6c0pUMDBxUERRRFEwVGcv?=
 =?utf-8?B?VEVGa2dwTDJ3eUQ4amw5TVNBL21zWXhmcGJuTDRxWmZiaFc0OEN0T1QyeVd2?=
 =?utf-8?B?MkxOUjgxb3k3NnhqY2tmRjZaSXJWNklrSnFhVmJMQVNNL0xwUkpwZnd6RjFX?=
 =?utf-8?B?OWUwZ2VhQXp0VndteFlDcTB0b2htT3NBQlh5QVdxUlE0TmNQY2ZVNFBLc2Yy?=
 =?utf-8?B?QStqRUNhcG5KZUZXZ2tqRzBCaVRvaWo5Y3QvOWsvdXUraEIvVnBPZi9CRGd3?=
 =?utf-8?B?QXgyZ0lKQ1ZmYkVKaWd5NGhaVmFiNVlpdENmYVNNY1llZC8xUTVSa251SExj?=
 =?utf-8?B?NFpZRjhuRTQzM3hmRG9KVkpwL3ZGRzJpVXNMQkxtc1BkeThpcTZJelVoNmJD?=
 =?utf-8?B?SU80MWljSjArK1dXeUxmdysxZVNoenVpelJ6WnMvdWdXRXh3MitRZGlFR09N?=
 =?utf-8?B?ZFhodTVJL2tRMWZTMks0VEhJaFFyWHFYLytJQjZxUXNWMHpVZ3ZzNC9Wby9R?=
 =?utf-8?B?QzZMenNnL1FNekF1NVEwdlFkb1p1UzF6NklzV3VDdFltemdTZlBLRWYvQkRy?=
 =?utf-8?B?eEJycWRPSld5ZmkyOHpLZWY1VnI3RHZIVk05ZjVGOFNnWlBSNlIyUHA3S2Q5?=
 =?utf-8?B?Q2FaK3hxeVlBNjlsM1F6RVIxdUtMa21KdkZnZTYyR043N1RwdnVFOTlTSlhW?=
 =?utf-8?B?QUJIUysrZ0lzWTR4Z3ZDb29nT09VSTVzNHdtaEdlUGpBRVE0TTE4U1N2Tld6?=
 =?utf-8?B?SEJKZ0QwRHhIcDdCL3FGM2R4dE9oNldsVXlDSTdtZldrRDV5TldvM2RiQ1Fj?=
 =?utf-8?B?bHg4aDBUZWNHMjJvSmhjUHppZ3YxZFd3ejRzWHZYbkJYR0dScFFMTFVHMEFv?=
 =?utf-8?B?a0JNSUhxYmlMNHAwUlpIenU3dk80MFl2SCtpcFpKampaUHJ5TTV2UT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b243ceb2-1920-40cc-65ad-08df4621dfb0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:45:41.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f024JGe+BRE74+qZTzMRt3MfB2OcT3BH2w4Ehuzs08NP/9JM0mRQ1s6S7cCU7Ew0DsoSs4bOwF5qn6eKNsizvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6987

From: Tze Yee Ng <tze.yee.ng@altera.com>

This series enables the extended-read DDR modes - SD DDR50 and eMMC
DDR52 - on the Cadence SD6HC (SD/eMMC v6) PHY. Neither mode runs a host
tuning sequence (CMD19/CMD21), so the read path must be centred by
static, board/SoC-characterised PHY settings. Bringing it up on Agilex5
also exposed PHY issues affecting the existing tuned modes.

  - Patch 1: abort a failed tuning command on SD6HC. The software tuning
    loop never aborted a command that errored, so after a CMD21 command
    error the eMMC could stay in the Data state and time out the CMD6
    that HS400 selection issues next; mmc_send_abort_tuning() clears it
    (a no-op for SD). Limited to SD6HC since the path is shared with the
    untested SD4HC.
  - Patch 2: document two optional SD6HC read-path properties for the
    extended-read DDR modes (SD DDR50, eMMC DDR52).
  - Patch 3: program PHONY_DQS_TIMING, which was left 0 in all modes; in
    extended-read mode it must be the rebar pulse width in clk_phy
    cycles minus 1, else one DDR beat is duplicated. The width is now
    derived from the SDCLK/sdmclk divider rather than hard-coded. The
    same patch reads the new properties at probe and applies them in
    DDR50 and DDR52, and makes the DQS_TIMING update clear USE_LPBK_DQS
    before reprogramming it so the loopback/phony selection takes
    effect.

The new cdns,ddr-* properties are unused in this series; they will be
consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
device trees, submitted as a separate series.

Tested on Agilex5 SoCDK: SD DDR50, eMMC DDR52 and eMMC HS400.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v4:
- Merged v3 2/4 (PHONY_DQS_TIMING) and v3 4/4 (read DDR tuning from
  device tree) into a single driver patch, now 3/3, and moved it after
  the binding patch. The series is now 3 patches. (Tanmay Kathpalia)
- Patch 1: limited the abort to SD6HC (host->version >= SDHCI_SPEC_420)
  because sdhci_cdns_execute_tuning() is shared with SD4HC, which has
  not been tested; reworded the commit message accordingly. Added Tanmay's
  Reviewed-by.
- Patch 2: dropped the cdns,ddr-phony-dqs-timing property; the phony DQS
  timing is always derived by the driver. (Tanmay Kathpalia)
- Patch 2: dropped Krzysztof's Reviewed-by since property set changed. The
  two remaining properties are unchanged from v3; Krzysztof, happy to 
  carry your tag again if the reduced binding looks fine.
- Patch 3: derive the PHONY_DQS_TIMING rebar pulse width from the
  SDCLK/sdmclk divider (t_sdclk / (2 * t_sdmclk) - 1, clamped to the 6-bit
  field) instead of the hard-coded 2 clk_phy cycles, and apply it in every
  extended-read mode instead of only DDR50/DDR52. Dropped the
  cdns,ddr-phony-dqs-timing override. Stored ddr_read_dqs_delay as u8.
- Patch 3: dropped Adrian's Acked-by from v3 2/4 since the patch was
  merged and substantially reworked; Adrian, please re-review.

Changes in v3:
- Patch 1: replaced the post-tuning PHY settle (v2 1/4) with aborting
  the failed tuning command. Added Suggested-by. (Tanmay Kathpalia)
- Patch 2: unchanged; retains Adrian's Acked-by.
- Patch 3: re-expressed cdns,ddr-read-dqs-delay-ps as
  cdns,ddr-read-dqs-delay - a count of DLL delay elements (0-255, each
  cdns,delay-element-ps wide) that maps 1:1 to the 8-bit PHY field -
  instead of a picosecond value; added $ref uint32 and maximum: 255,
  dropped the redundant minimum: 0, and used plain description: text.
  (Krzysztof Kozlowski)
- Patch 4: read cdns,ddr-read-dqs-delay directly as the delay-element
  count and write it to the 8-bit field, dropping the v2 ps->element
  conversion (divide by cdns,delay-element-ps) and the FIELD_MAX()
  clamp. Hoisted the repeated DDR-mode test to a local, removed the
  probe-time firmware-value warning, and unwrapped lines to 100 cols.
  (Adrian Hunter, Krzysztof Kozlowski)

- Link to v3: https://lore.kernel.org/all/20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com/
- Link to v2: https://lore.kernel.org/all/cover.1791459448.git.tze.yee.ng@altera.com/
- Link to v1: https://lore.kernel.org/all/cover.1790074790.git.tze.yee.ng@altera.com/
---
To: Adrian Hunter <adrian.hunter@intel.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Ulf Hansson <ulfh@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Tze Yee Ng (3):
      mmc: sdhci-cadence: abort failed tuning command on SD6HC
      dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
      mmc: sdhci-cadence6: tune SD6HC DDR50/DDR52 read path

 .../devicetree/bindings/mmc/cdns,sd6hc.yaml        | 19 ++++++++
 drivers/mmc/host/sdhci-cadence-core.c              | 12 ++++-
 drivers/mmc/host/sdhci-cadence-phy-v6.c            | 52 +++++++++++++++++++++-
 3 files changed, 81 insertions(+), 2 deletions(-)
---
base-commit: 2febfc8acbf712439b6d30c99b108641d881fd75
change-id: 20261106-sd_cadence_ddr50_v3-35f970f31364

Best regards,
--  
Tze Yee Ng <tze.yee.ng@altera.com>

