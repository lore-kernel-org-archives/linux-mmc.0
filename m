Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2138.outbound.protection.outlook.com [40.107.104.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA81EBFF7;
	Wed, 30 Oct 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295479; cv=fail; b=aJZ5qAjt38CQBCFRiQc0j4HzwzelLSxQnsK1yE3pELrI/6QhI8ubTqnuc+/wPrlCUOy7EudhBztt2qyOmDChAfSG8VyfZkgkff0xyubHR4SblwzQ4rENwyU44Zyk7RN8Wuf0Hc1YzerfB8t0YN+PtkuSbd5PG2njbMlyF9qAysE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295479; c=relaxed/simple;
	bh=R/R185xnjGDxDDQYHhH52g9GjQICuTSmE2mmrB/4DdQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tpPfedczuE7mShE1ql+lG1Tuu4FuoRIy4Zk/X2pv5Oh+LIqGFNnojaViapMqkiQAhEOLnKzaXsteYMdczP3uKQvMvSRbonbyG1qsSJKy4b/iwR90HzN+Sg6DRTWbWV6YzGZKoeOPpV2YhqDFB5O3gJZdgXCaTst9Nod8NoMj1/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=RDAa6fS7; arc=fail smtp.client-ip=40.107.104.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RDAa6fS7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbSqH2YV/Ck0VJd2RhSe2i/lV4E1Yp9fGL67awahdd+u+UjgEJO9CDRmWxvKyWv6hPynf2Wg3AW/vPNLXXvwyrc8qEgKVzaMe+R2wp+zHwkkc5GNNm73fIg0pI3aDiAO3+FVS/aCBQp1S55MHzsCZv4KorbRLKY1BUVxxWRnRby1zphJru78mGV04peNpj9z+vHzHPdOGU0BnsSBkN6zgc69PltJFaBwEj1jNx83tPj6T4WXFE25y5QyC3swzunQ4lDcTTm0d+n6IFhUxIdWtRnjFAAqCOMK/yPtpBBp58ZxXVdXJ97BOyIUhKMYlar2+h1apZxAP01YUCJSCSKTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CrzKIeNV3LC1Yjtw8TgAbW2jPPZymVcAdYMB9FufyY=;
 b=SdJFcn1ccaUzNjVSKnS2JgMrgrMaoxBidcWa9yyDVbeGla5uphao93YymG32AlkozIbf2R2G9skZUetU9x7TJ5ObmLIS1SddZdquCHW30NAUBb+qN30EruxZmNopaD1ualCAs22tNwp0kZVr+ZzOM16NPqpmbJuneYJgg3/QsAfrG5RSLKEtZ1ORjT1L3nlrYHo1ILYMwTB87Hjmn8F/h5o0eRF0CsKUWCzGkYnOZ3KN3xgffTjzTWKf7zgl2aZpSsBgrFs2U594NwxBd/IWGCmgH9ukZ/uyrtWhF1mYVoNPAcx5mWNDZrP9qTHx2Q76JgaERpZrqcRc6vNL1suE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CrzKIeNV3LC1Yjtw8TgAbW2jPPZymVcAdYMB9FufyY=;
 b=RDAa6fS73cDYJywNWlxw5lqJ+pgYMuh1za+Rh6hO2yqJh6LkXHz6JS63qMWl0zrfEgTK0vtxshw52+2wGknpJN/itRkqeHaIpOEZf9aoJgAv5/Yp48LcsJnjXOroSjy8j1o0JZ6fVgIqXYE28Mg3J60IOLnVG2WuIqTsp6Pdpmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 13:37:50 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 13:37:50 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 30 Oct 2024 14:37:44 +0100
Subject: [PATCH v2 2/2] mmc: host: sdhci-esdhc-imx: update esdhc sysctl
 dtocv bitmask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-imx-emmc-reset-v2-2-b3a823393974@solid-run.com>
References: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
In-Reply-To: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, imx@lists.linux.dev, 
 linux-mmc@vger.kernel.org, s32@nxp.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c4eef2-d44a-4a48-262d-08dcf8e80c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhaV214d3c3Snl1MXBpTGQxQjhNVlVhdURnWEZYSm1ucUU3TnVzMzg3cmpo?=
 =?utf-8?B?d1FSZGllcitaZmM4aUQrblRjV2hvYnZ5STRiOEJtR2trdkhVQ3o4UWtub0Jp?=
 =?utf-8?B?MndCNU55L3NkQ1FrU0FwOER0ekdqMzdqZEdGb3dSdXc4aWljQU9zeFhpZ3VW?=
 =?utf-8?B?ZW1QYS9XdGg0S3dnRWE2ZGpSMm1UMnRDOUN4QXowbUd3TWxNcUlpTi9vK0ZE?=
 =?utf-8?B?OUxzOWxwZzhTREE2OFR6QTZZbjJOVU1NZE9GRW84QkpwcUt0SURITGhOS3hE?=
 =?utf-8?B?dVRuQU4vM0luc2I1YU5leTFaazFtc0pMaEN5TEJYckVoS1U0RUs0S2E1dEZO?=
 =?utf-8?B?emNLM2JpRDFLWlZBSWZHNHVGUFUwM2t2YXFFdElGNjA5ZnNoTnJzREZuNTk4?=
 =?utf-8?B?NERoOGtUZncvbkl6WTBQREJTRzVETmk3OXlka0N0NUZiS2dLQ1pEQ1dLN3pj?=
 =?utf-8?B?aFJ1enZYV1Y0VVJhYllrMGRHbmlFQktNYnlqMGNRc1FXQVE0K1FlYmdCM0Ix?=
 =?utf-8?B?VkpNenVKYUlpclpBdllPU2xmVHFsNWdicjFYdng2dGFYZkRsTlYxU0dXMkl5?=
 =?utf-8?B?aEh1WENMNkhuOGhJdUFOMGRMNzZUVFNSQm5OdTl5aE1DbWsyemI1Kzl6L2Ur?=
 =?utf-8?B?eDRpaUVEempiOXR1ckI1N3hiczJ1aTNlL21vNUliRE1ORXV4a0pMVllWd2FS?=
 =?utf-8?B?SkVxVnB5UVh4Zkd4b0dDendqU2hENmRERWpqTk1Md2poRlBMOUh2YTJEclZz?=
 =?utf-8?B?cE5XNnZ1Yk5hTE9tbE1RdGgwbThjKzJLNXl3VDFQNE9LdVREOU9Va0szM0hW?=
 =?utf-8?B?aUJtS0wvQVA3cVhFeU1ETDhzQnplSUJxQlRQVW5YejhNQjFJZVZ0TlJnVGR4?=
 =?utf-8?B?SUZCdmhDaDdwdVI0T2s3dUtEQmdIOGFMZ2g3bFZRS0RPV1M3V2NnVkJFMVRW?=
 =?utf-8?B?eUliekJPcVF2Z3NMNUZCcktGZml0bmJtMU1CNkZkdHVQSTJrYzg1UW81MERa?=
 =?utf-8?B?UTRXL1F4TkwyTVdReTAvajlqRGxqNzdBaFFsVDB5cFoxajF6UHVUYXFRYXhO?=
 =?utf-8?B?eEtyQzFDM0dCY3MvZkp2RGZ3Ri9lcUlyazQ5UTF5MmllblRyaFlxOTBZTHg2?=
 =?utf-8?B?bGNpRDI1MWJqWHRFcmlmTk5qV0RyMkNGc2Foa1lYWTdkL0U2UGpkZ0s5a0NV?=
 =?utf-8?B?dXJQdE0rem5aYlV4cW9ERnViY1BBclJBNzNXd2NzUFNzKzV3REZYTXA3Zmww?=
 =?utf-8?B?VFk2dlZ0bnJWMmF5QkhhLzNVU29aMHFRaDViQTFHd25jWGpwQXVNU1pjTE5C?=
 =?utf-8?B?ekIwMEJqaUYzd29jWE9GMkV3S25BRFYzVVBYbHZmeDVGUjlhd0s3NHFkOGhu?=
 =?utf-8?B?WjRYYk51MVFZd0RMN2c2dVU5ejhaQTVSb0F2UTdUL01wdWxtakFhRjhROE81?=
 =?utf-8?B?QTJJeDVYbWFpZWdPVXZmNFJBbGU3RENuUitqYVRZenJzeWQxT1VkMnVTaDMy?=
 =?utf-8?B?ODZzTmlaSVdvUW5KOFlZSFlYbHRES3VzWWlacWNUUG1idFZuWTN6STEvSi9R?=
 =?utf-8?B?YzROK29IWXVzTStjUythSVpKVmc1WXpqb1M5MnJvUUt3QlFPMG9KV2k0WEtS?=
 =?utf-8?B?bVRUS3VVZTdIUmFZYUNkMk1mcC9RdXN1R2dZUlIzMGtSaUlDQnRzdU1SNjlD?=
 =?utf-8?B?SmliY1lBb3VyMDZtOWhMTUNxZVV4NXY4NDFqYVJLU0FacWxJVG5RL1lMY0Zz?=
 =?utf-8?B?UmZCckdlNk0rUU9ySmUzekpCNFo3T3U4Y3B1N1lLbFlzc1paZWpGR2YzUnFn?=
 =?utf-8?Q?Yw/nNvcZJuIEHkfmtqM1RucBwuNZNj6J8VdVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllXdzM1ZWh0TXNORDhoMHRLWVBINkdMNy9uM28ycVpJYyszUFNPYkFyRVRJ?=
 =?utf-8?B?Uk1PaUFONENhS3VQOURHaGJocURwYlhoL2RDTGIreEszSURlMlhJYkxuM050?=
 =?utf-8?B?bmJ5dDZhb2w3MEZ5bXYvTzNDWDBCaGJQK1JJcFAxMFNEM2hIL2FrMld0bGZD?=
 =?utf-8?B?Y3U2YmNvOS8wYldpUU1pbThKQkIrb0NjK0ZMN1BvRGMxUlB5NlZUR1JCMnE3?=
 =?utf-8?B?YTkvemV0UmxYQkMwL3RZSExoOUZoa2dMUUJOeTFpaTNuRGNrQ29QUG0vUzVv?=
 =?utf-8?B?M243UVR2Uko1NVh3b25NWG9wNDJJLzNhWldUOTQ0SWxsTHVzYWlnNmxZY1dC?=
 =?utf-8?B?ajYxUWRoN3Y1L2R5Y1FaTEYvNHBJZVdNOUV4VU9udndOWHVsSm5RR3Ewbmhs?=
 =?utf-8?B?WWQ3d0NVbk9SWkJQR1p2TzQzRkg4Tk5hK2tTRGFsWkJ6N2tnUTdrRUNuaXUz?=
 =?utf-8?B?U05YV0xVblY1Q2J2cWlCVm9MSFVXTjY4eVlkK3cyUFphMkx3UFRBN2V4TjdY?=
 =?utf-8?B?T0hKYUE4Tklvb2FZSlVOc3J3YnV4Zi9kSTF2U2pEcVZZaWdYaDN3VUxZQkhE?=
 =?utf-8?B?c09FckgwZ0Zqa3ozS1ZLNzY5YlhHNTRpcTlJc2NKL29WVUtiODJ4T0o0M2xs?=
 =?utf-8?B?bnBPRTFXczNJTk5waTQzK2d6dWlicjNlWnk4MVk1eEVKckRGa3YrVUdScWVP?=
 =?utf-8?B?MGJCR0RMVURpN0hlbEFQS2JiTk5QZ2RyaWlHQUY3b3NrSXhtSDdGUmdiVW5s?=
 =?utf-8?B?a1JaRktQaFlCRFZtVWpld25pcWZEdExmbElCK2NlcitOV1U5RktNZkRsUlZi?=
 =?utf-8?B?TjNlSEV3VHJDUkgvQWhtNnNwMjQ2bG8zVmlSWW53amI0a3FWNHVtc0VreWtt?=
 =?utf-8?B?RCtGMFVlNmt6bEI0L1NVM3RabmxiU3lLQTNtQXhiZkErMkhDQ1AzTktKbi85?=
 =?utf-8?B?dDdudExzWG1qcHZUeU5SdnVBY0MwNTVkVE5Vb0ZWc25PemRPcHhJZFA4NG5m?=
 =?utf-8?B?WHYzV1ZiODh4SkQ3Z1NNcUFWVzN6SUxtODVJbkNSVlpTcFlPYUNGMVFIK1Nw?=
 =?utf-8?B?cnBqSEdDZUNqOWIwVkVGbCtHdjVDRjRIaDhkZVpGdi81SlhMWW1xbUtCQlhk?=
 =?utf-8?B?TDNpNEkxeHNtRVhnNDVWc2lZOWttdjFqUHJIZ0h2WkFNcGNxQk1jR0xWVSts?=
 =?utf-8?B?SldVWlp0cmVxS0VmS2s4MU1PbEEyL0xMK09haWt4VnJKelhGL2h0dXY1UkFp?=
 =?utf-8?B?VEd2dSthMXJadTJlZk9ScTN6b3ZBSVBNL1R0b09IQm9iMFlpbkl0UmN5SGhG?=
 =?utf-8?B?MkRFajdmRExsOUtNRDRyWHVPM3g3NFJJODkwVnBJckRTcnRhTlBBTU1yQUF6?=
 =?utf-8?B?dzVkOVdIYVE4eTRoTVkrU2VsV3c4ZisyRW11cERta2Mxd1NpVEVNb2JrZWNO?=
 =?utf-8?B?c24wSmZZaEZJemhaSEN2SEhHbHVvanR4dW9NaGZDN2FZMG8rdnI3cGtiQlR4?=
 =?utf-8?B?SEF2andIYWRHL3pOM2JOTGZnRHFaYk9UUVAxOVpXcHBhU01kVDYwVGtzbHFJ?=
 =?utf-8?B?aVlQajBkMitLdGk3QW5vQ2l3SlFlRDJnYXZtemlENGFDWHYrR1hXRDlrWFJq?=
 =?utf-8?B?OU02Vm56a0hCVmVENkZsV2lwV2tlKzBYRGRNMkw1eDV5cyt3Vm1hRkdqaFBn?=
 =?utf-8?B?RmRmOFYxVDQvNWlYeEliTUtFMG4zVHhFQzcvbTU1TmxoS2FiL24xUGlqS0M2?=
 =?utf-8?B?R0VUNXhhSWk2eDdDQk5JanBybHViNCs4cUFJeXZVZDFDU1Q2SGFLbkNmWUgy?=
 =?utf-8?B?L1gxdDdHVHNnM3pHZFJXM2JlV3YwT3JraXZJUjA5QWV1Zzd4cExYNE1aUVcz?=
 =?utf-8?B?RDZ2SkZ4RXdxWWFIaFZudFVMbE51ak4wSVM0cFh0cU95OTNla2tvYU82NERn?=
 =?utf-8?B?b2R5SG5XUkgyaUVjeE5NNVMxWHdLbERmb2lFYVdJWVQzVjZTZGNaUUUrU3lH?=
 =?utf-8?B?TDdwUUYrNDJlbUVtczBvNWdVUHJST0Y1V0tlK0pEWlNsWVFyQjM1NDd4NzBv?=
 =?utf-8?B?RjZTbjBFZGxZMUxab1VZaUdzRTRZV1ozNkovU1hMR2huZGVqNnQvSS9oa2F2?=
 =?utf-8?Q?O3Cmd73IrNN1CcCgeF2AO5Vky?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c4eef2-d44a-4a48-262d-08dcf8e80c62
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:37:50.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B49RqsAbTljftugADP3LdAM1CbZ9p09whC5WdKMeJSQmrxrN88wpRZlWSUlWVRpPq9yVnZyOe5L2IX2NA8CZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

NXP ESDHC supports setting data timeout using uSDHCx_SYS_CTRL register
DTOCV bits (bits 16-19).
Currently the driver accesses those bits by 32-bit write using
SDHCI_TIMEOUT_CONTROL (0x2E) defined in drivers/mmc/host/sdhci.h.
This is offset by two bytes relative to uSDHCx_SYS_CTRL (0x2C).
The driver also defines ESDHC_SYS_CTRL_DTOCV_MASK as first 4 bits, which
is correct relative to SDHCI_TIMEOUT_CONTROL but not relative to
uSDHCx_SYS_CTRL. The definition carrying control register in its name is
therefore inconsistent.

Update the bitmask definition for bits 16-19 to be correct relative to
control register base.
Update the esdhc_set_timeout function to set timeout value at control
register base, not timeout offset.

This solves a purely cosmetic problem.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a830d9a9490408d3148b927bf1acc719a13e8975..101feabb24fb41bd10a2e796f4f3f8d4357dc245 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -30,10 +30,10 @@
 #include "sdhci-esdhc.h"
 #include "cqhci.h"
 
-#define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
 #define ESDHC_SYS_CTRL			0x2c
+#define ESDHC_SYS_CTRL_DTOCV_MASK	GENMASK(19, 16)
 #define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
@@ -1387,7 +1387,7 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 
 	/* use maximum timeout counter */
 	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
-			esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
+			esdhc_is_usdhc(imx_data) ? 0x0F0000 : 0x0E0000,
 			SDHCI_TIMEOUT_CONTROL);
 }
 

-- 
2.43.0

