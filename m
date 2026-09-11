Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57811328B62;
	Fri, 11 Sep 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112161; cv=fail; b=aCroTJC7sOz8g1in4MMrPir7ywkbcDm11+WUp0vrQdsL33Yey39+rgC7HmvlysXHIZrN4bI9PeKksdFUJovRG4b/sBv2RkVFCUdaJ8boXdqJtY0lgIhSZ5xrlOx1jO59wS998om/YinGMD/9McKgMyEIRyECLDAWujwNHTy4oQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112161; c=relaxed/simple;
	bh=G2UPEbSjcJ6z/s5NTHOH7ZzqsjuE+0nVSywTt/5Sg4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BtOjDJRQxZ6JJ1FMzhVXD/YHxFYJO8w2Zw2pMOcLeKoRfN6zASueGqS7B5VJsBZmZDvThCSmYiG13I8G3XaMp0Oeiep0MQgLEh1gtYcvJQp9P55ax/GJbq5SC0Qg2Tfsu/lgklA2WP7ZLzRkYJ3zljAd5ch0InPiBIS9DcXmtYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YW0F1rj1; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YW0F1rj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5uTuY4bpjK8GNDUsN0S6IPjs1X48STCqmGQqyEChz7eNKObnwO3sZqKvaaTJm/iJwQXDX6ps79V337OhTCE40EVhMBPKOuW8ixB0RxUvuiP7kgklgSyHI6ahFabGXU6fIfo68pEzmfwTpKCfZX9OzxKLKmmqGx79eKd9/i0dRvLWEMKo2Z3D/UaQOCDxZvyFX5Qj05X4SZ0z9o0Hjy/c6ZzBjYg6eDoXESzS6OgCA5f95af+eENMWOqbvxpn/WbqYB8FkcooIGqYpgn1EJBk4q5TwlIHHrZKLJ9znxHSUDCU7+UScbV1LvCRdb0PFCQ3317y5h5FGtDOWuNnUOQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2UPEbSjcJ6z/s5NTHOH7ZzqsjuE+0nVSywTt/5Sg4U=;
 b=JdNcJErD1TqpPDFCN91j4Inn6Qf//N/o5tjODIBmJrmGwmo6FSNOUhIr9mOrOk4ZULI7xIYSTiHEnqgHq2t5PoERKTL6cMvlGlebl/kyqa5IV4LpBL4F/coVCkLDfZnGs2tJSLYPV6zD0AzTFFhTVJ4lE70JDV7qcvSGdfs29HvWN2ky/VbOCxmRSTISOZpk9L3JCUNE6mM7ELRPhVXBwt72bz2FHeAtNVEE4KLZW4/N3aQlZoB9mroq2ROTlvP/TiJ9XFbIm/ela1fLVLnT2TrRbiLDo1EIS2RK0orQuigKBZtFkNwdXSpPlTyJqvuzXVGx2a1vYt+dc0JEU9WiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2UPEbSjcJ6z/s5NTHOH7ZzqsjuE+0nVSywTt/5Sg4U=;
 b=YW0F1rj1fIrsXm6YT5CJvZnGC1LW0LaJ1xcjq08oo8cXV2WbuRHcWpdP7pBIuwUc+19xFifaTAZabUqdE5tLg/jsI9YO62Kbd8AERIv+I4JHXB9hije8BoGEQ8CQx6fHCYCNHmP5LCHZlSU0WvnZWXPoqE63mKCFLNxWQF87SLIK1GVqDSvqpAYcSTSHbbH53haZbaMsNPHV1fIA9SoHghV836CU0XTpusvI8kiETBWH3ZwuWUOWz/MBkhy3n6gEHiGoG2e0xgIOZTAin2NVeO55kektqs8KJV66dQEeStxTDwshlg4wulBEtVdHBivvo/NwrzDTgP4Zk1092GT/NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS7PR03MB8292.namprd03.prod.outlook.com (2603:10b6:8:26b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 07:35:57 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 07:35:57 +0000
Message-ID: <e9559842-8283-457f-97d4-02752f1ed850@altera.com>
Date: Fri, 11 Sep 2026 13:05:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] mmc: sdhci-cadence: add SD6HC support and Agilex5
 enablement
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, adrian.hunter@intel.com, krzk+dt@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
 p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0304.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS7PR03MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 411041c0-81cd-4c06-dc1e-08df0fd75028
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|55112099003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gLohmlVIMEWM33dPsi03UtTEtNqeIZ7vpjrwBLg9bQSK6pLa3rSOkfRwNb6s7vwyaYbrP6hRnMR0ZjlPT/YxV9rl0f9/iTRYTwVXnzPBZdia5e2athI8Osg4CGQ87KYktoioL6lLMdfPnTByOF9jfSBMLVP9+2eFcFULDXWGvuA+WZEsorXybDzpnqlAZaaXTc5ju+GpZ2vxf6dHjsrEhNNVYl4Ki67VBZg/gV67P+l+ddCnlLbdudff1A6ecfEdud+tORm9AsHUlJj+NytXqfDTTLzMWmtIv+eyZwWFSgnW6oUde1679QVRY7w8z84QWZRkQMeMFEJHLfG2Sx/GSZmBqPZdGlxuPE7yJOPS2Q2c4MFPPDWh+lPz3wSNFFWStreW4ZuRdan9Gd1JmbjpXU9CT5KKZZVHqnGs9cdRFhA6mdS0GK161rvkaSNZkyrFrgDJoDfAmsEIbYJu97uvi59AIRxlCHWPfnwzl7gKi3firTwZcpn3NgGR7/VwA7vgccJysDIn+PMsk7Xe7Rv72HGHcmmK9qeN+xJEhV/p3PG0IV37gE9Cw0x/aH2l2ml1OnP8EotqNXUKBoIyZWr9xtYDu8th2WbUyItHO6bWA3V1aGSF7K82+Z5KViwfqjpFJ3+2yZLG8ic/iigmxJnxmLf63P0/6VWLYVuE7DfzBto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlR4OUZCcTROYXhBc3hXQzhaa3hpMm9KWlQvdTFuM0luS1hSSXduY21wQlhG?=
 =?utf-8?B?cmI2UVQ3cVJjZko5REhNRVNVTllDQWRsRzI1YXJhV0ZIUlFKSGh4ZlI4amM4?=
 =?utf-8?B?bFBpcmRFOWZjTUhPUjJOc2dCTXpYRVZjTmd6bFlENkM5VVVHZ2k5UUZBMkhY?=
 =?utf-8?B?b3FFMUtUVmZXa0cxNFBlNWhkK01mZEMrcVN0R3RJWUlqK0IzS0tFaGM5d0hW?=
 =?utf-8?B?VWxscnhiYWxhc2FPRDNTZ2dlaU5DS0E2SEdOZmRldjlHMXduMkpYdCtaR3hZ?=
 =?utf-8?B?NHhJQTVCTXZWOHE1cGorWXFwOXRDL3JPRWJvTGlKVjZEaEZTa1R6L2RBSmJY?=
 =?utf-8?B?V1U0UitoQlFNL0pNTnZkaVFyU2hZYXNaekpESTg3SUVJcHlsOUVqWHZKTVpX?=
 =?utf-8?B?OWJlczlsU0xZNFpSVWlRcFpJVlNJbEJJWU5aMEpmaFlieVdsNU9ESFo5TTUx?=
 =?utf-8?B?dHdEQThZdTlTQlNPQmd1M000RUIzelhoc202RXNPWm9WVmxvL2lleHFCeW9T?=
 =?utf-8?B?aU1OcTBHbE1rTHR2NEQwRVhQeXllVnF0T0pNNmFqKzF0WEI2Vnlaak4vUEhj?=
 =?utf-8?B?anZkMTh1VnR6U0ZtSFpTbW1xYnh4cWFLVWtreDNzREVFNjVJZ05GUlpkTDlx?=
 =?utf-8?B?Qy84RUpIL0FLdnM2QlBBWDNGWDM2TWpWZXExSUtsNm53UVdrbGVLUzRta0hz?=
 =?utf-8?B?YVhHdGpwWEd0ZTZORE5lZ0pCRFY1M3BZQ3VtVmdLZFZpT2krblFnMzUwbExG?=
 =?utf-8?B?YnNQWVVnNjhxQjZpclFtbys5RzFYMUU3UXlpNG8wajhidWl2djJxWWZPMW5D?=
 =?utf-8?B?QUZocGFWVWg3RWdTL3ZMT1phRmpONFA1VnpBUzV2WncweWhzUDA3M01WK2U3?=
 =?utf-8?B?dzl3UmtkcWovb3VuQWNTMEpGWTJNY2hhN2ROamgyWE9vWkJ2L1ZHMVZMSzFU?=
 =?utf-8?B?MzFvTFFSR0RRbmZkNk5XelZaMVZhSUZRUVhISUQ4S3VDSisySnBjb0JYUkdo?=
 =?utf-8?B?MXppQlRBODNZaW8yOUxOeEhCc0NlWFpnakRaK2twSFY2TUQvUXRlYWwvZUl5?=
 =?utf-8?B?dXFPZmZ4TWd3RlVoUDVKa2Q3ajRJSUhkV1J3eTI0RmxvVkpwd2REZnEweFJL?=
 =?utf-8?B?eklKVkI0ck1oTWNaT1hJMWtLY3BNbjRLVmRxUWMyTzlKa05oUCtYbnlES0ZD?=
 =?utf-8?B?b3VhcFk5OFFFamxaMUtYTGpwSUYvbitWbmwrZzBuUGlkRmJ5MXBvUGxHeFg1?=
 =?utf-8?B?ak15Mk9UelZzNGNMWUZKQVdrSVNTL2ltTkpuZElXMGZHMkNsQ0krQkhBRWVy?=
 =?utf-8?B?NFZoRXMxZlNTY3Bpa0VLVTRtclVrMkw5dHJLV0dsMzkyNjkrYTIwUElPeStZ?=
 =?utf-8?B?RWc0QWw5eU04d3hnQ1Y1SjVyWjJza1pKTGFkTHA4cGZiUHlhclpzUktYNmVk?=
 =?utf-8?B?RzlscEFYSC8zK1BsTzJSSEdaTHFlOXRvWmo1RDEyUXpTTC9UNWs4aEZ0bXJu?=
 =?utf-8?B?cXYxaCtPQVJXOFgvMlF4TjhpM1JEUlBxRXZYMFArOEt5N3Ria3dLOGI4WFEr?=
 =?utf-8?B?Q0tIbUJBS0F6QWc1dmFrUXF3dSttRVdEK2V0U1lGMzlPMFArdmNpaVhLTjZD?=
 =?utf-8?B?cXkvUXN6aktJSXd3ai9ubVgzNGtDS0I1ZC9rOCt0OEU0bkJvM3pDOXFPVVVR?=
 =?utf-8?B?eWdGeXdVSXFpMGxjMGVMUXdvdE9ZSUpZalBDdkdQWDl4N0RXd1hQY3hsaTZi?=
 =?utf-8?B?eDRLRnpzS2FQcFo4Yk1WQ0s1RWRDdU5rc3VkZERQbjFkRjkxOXRrSW9GSXNP?=
 =?utf-8?B?YjZJY0VvdzM3bTdXK0V6czhncW9Oc0Z0dDgzZDVqOUwreVFsMldlM0dmVXRI?=
 =?utf-8?B?am42Y3V6Rk42cmppTVpKTzBwMDAwSTdTUEt4aTMwUTB3cDNWcjVuVlN0a2cx?=
 =?utf-8?B?RTJuK1psZ3kzWEZ5dWZtN1VEcWdHTFpqUjJNTjBEZGQ0WDJFcC9zM0JmcFF3?=
 =?utf-8?B?TTdUR1NUbCtuWXBacWxDVHFjdXVSYlI5QzhSQUtLaXFYNzhDMWhVV3VFVVdK?=
 =?utf-8?B?WDZzMDR0NHJqL1F0WDVoNFplRUNOWnh1V2hyZTBnNzFhWHd0b09jS3lHSWZ6?=
 =?utf-8?B?UFR0YmZKWTNzalVXZ2xMaUUwL2lBRThXeXhKTEFmUmxQaWk1VTR4ZitmU29F?=
 =?utf-8?B?WUtnekNBL1hBaHdkZnEzMXhqK0YxaW5qT0F0RzNNTVA2U01vL2Vua2hHSUY2?=
 =?utf-8?B?OStvSTBmWmdWR0hQTlpMc05BOFYvUkFZUmw4Qy9HOFdOR1RHZXAwQ25SR0ZH?=
 =?utf-8?B?QVR1cTdpNUg3YzJxbUdob2YxTnVkb1NmMkk4dGNtMzhUWUtuM2U3ZFRoaVBX?=
 =?utf-8?Q?EvW9uIhhG7dM1RWY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411041c0-81cd-4c06-dc1e-08df0fd75028
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 07:35:57.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7TTkQDop/1ttMaa6SqomsV1vRW8zy8pGRHhax1hTrcfb9caAac4u/eTKcAc8USwXnzupv8iKC08T8deorEicIVkWpaYvtSpYudZKCUPgOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8292

Hi Ulf, Dinh,

A gentle ping on this series.

All comments from the earlier revisions have been addressed. Patch 1
carries a Reviewed-by from Krzysztof Kozlowski, patch 4 an Acked-by
from Conor Dooley, and patches 6-9 an Acked-by from Adrian Hunter.
Thanks to everyone who reviewed it.

Could you please pick up the patches that belong in your trees?

Both dependencies noted in the cover letter are now in mainline:
ab45ecfab540 ("dt-bindings: reset: altr: add COMBOPHY_RESET for
Agilex5") since v7.2-rc4, and 10cf797f3f8a ("arm64: dts: socfpga:
agilex5: Enable the SMMU") since v7.3-rc1. The patches were generated on
mmc/next, which predates both, so those commits need to be merged first
if the DT patches are applied there.

Thanks,
Tanmay

On 9/2/2026 12:18 AM, Tanmay Kathpalia wrote:
> This series adds support for the Cadence SD6HC (sixth-generation) SDHCI
> controller and enables it on Altera Agilex5 SoCs.
>
