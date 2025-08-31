Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5725101DE
	for <linux-mmc@vger.kernel.org>; Sun, 31 Aug 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756672525; cv=fail; b=I8HjFQ3XcS2ObRyQKX4rV809O/+U7k0WnFthtA5UIZM2YfguncgeFoTNkoO+Z8iy7TkPLvBUHX0hmvXeR8T0xzBIgfoLN2zQgV7w1JK166UlTzgWYF/j2PxyJPpWCWYJQt0e06FtfFnfrTJLWk5wOLcHQDEZ8ZnWzcjXJ6c0Zvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756672525; c=relaxed/simple;
	bh=a5xR1YmZHSnVpmR/CfSp7PAPwPkmdrtYilPMIfsmyqU=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=HJQsLgPAmCvnmsKOeaaXiG1vPfNtL02qIKg8UBLzKcn1xeM0MWwfoTfvJ1kFla4uG0+QhnyOu3ZJEVqyADrKMeG9uf/6IFyWTmzs/j9vJzV4UwFzd+zh5+bHJLz9wvmaof4eg/cFIGCptq3Rn86zDzHDtZdIJXJvKWFDdQHpZOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iZIh4Afe; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iZIh4Afe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZY9qI3Ga2LR2LRvKsJ56FPWywi3RgxWafC3d9dNnmCu0oo5GughpGkbMP6ep3SX+FNX2Pp51IB1yYpdHsdHXOftjKxAhiFjtjAcpKYrq3P1qJ6klvDpIhCOoC7TXSlwvzwjOIdQMrzVaohqDHwXm1wYDb+i4owZU1N9qe6mbGDkhbR2XDDExeEp2ktk7sjL1VQWJmsaOnEJx+tEwQSKqj7w6XHXwvyQSD3hgEY/eqDxIjAI2Xe2++kDkrK/RH75wL1E+gK1Cd0IDYIbVRrcYY7ob0uQ9sqaAGNNP7qiWk4MzBdu9xSDX2ytzjRz0ua3BB2F6lGVDdvs3FABmkWu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDrYUhIaTdyui6+AOxilONry3ciSoGk2b+VUYEenuDw=;
 b=q8CNVcRb3MHCuTgT8YiW0FqUaA7YknIYEIiT22Yw7gZOqJ+dVQrJWrMVN3+DbJ4u+ujBrTaWuzraiYCGvOj1/HR8XSB4wPPa/aVyoje5+wUVsLgNUD4pMob26dR1hHgvw7KSTF9Qgsp9rTx3+DnL14IZGq7PoGhKcnorFOC5n3yH/c62Cbps/XnAmVaCfHjDTA5iuemRDROrMeqOYVqKIy9AFZ0bhp3F/9KR5FmPlgPdg7jHZ8B82r7XzFt50KYYV6EzAFkFkSttzYurO7n3yduPwbeuliOejmQEk62xTUH76Vzr8Jp+tz1ccGlwmW2dWHz4usnybyPfMAJlECMsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDrYUhIaTdyui6+AOxilONry3ciSoGk2b+VUYEenuDw=;
 b=iZIh4AfeVtwzdw/e8LqRLyPFERaruWKsp66626Rv6pY3EKxHDQkQVwZX1tc0KJallpeSWIioDYUEooAYn5LhkmlR0GfnqdpM4mzx0UoORKGkvLA0Y8ahD2Aw/HA8rxVxTalW2fch1CmhwVfEyV2Wu+utI8iX9+TIb2YFsH20vt6ApsepZDBLOB5z7wRvfoAxTZQza1t1542G/VqLC3sCzej4zJClBzz7sOunns+nQr+NmjCR5YtEXDao8MTRcQafhpfnUUfHpNKwkU8gyBZjcidXsLti6JVabz6qPryJDfn/cs28JwFebG4ya3UwStHIBPNk07V0D+Lrysxxo4vSxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 20:35:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 20:35:17 +0000
Message-ID: <31174fae-a3bf-4415-a8a5-76d252a6fbd4@siemens.com>
Date: Sun, 31 Aug 2025 22:35:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] mmc-utils: Correctly handle write counter overflow status
Content-Language: en-US
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: d463f157-fdee-4b77-63c2-08dde8cde501
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2JWV0t4UE5Fa2xtQjA5Z2M1cDFVUU0vdkdPNXA0UnFrdU1TZ0l6TzNvR3I5?=
 =?utf-8?B?VnRIQy85YVNRMlFvVGRmcXp2OHZWbGdOVks5VXRMS3RuQjVPMTRpa0JqcDZZ?=
 =?utf-8?B?Ykh5QWV2NE9LOFlLczVxTklFQllLdE8rdlQyTUF1anVkQnVmQXEyMkRtTnpq?=
 =?utf-8?B?Q0NaaHBTcm4yZEpVS3B5TENmbHp0M21Da3NLN2gwblVrOHJ3RDRmNEhmMzFk?=
 =?utf-8?B?UWhyVnBwc1c5MjVCN0NwdHA4cUpmN3A4VExpRVArVnc5eWRVSHliMTJxTnhh?=
 =?utf-8?B?Um1tdUU2TUZadlk4Sk85RG9DclBYQjhxbWxhSmx5MDJQdEVNUGUwL1dZOFEr?=
 =?utf-8?B?WFRhN29XS3UzRUVublBtUzJhZGdGVXpVWmQrVnNnZFMvRFdMNkkwa1RuTDE3?=
 =?utf-8?B?YVZJeFBkbXg3K3BkYnJXQTJkRlV0eng2TWdHd1pKL013SVpoejEwbFJKN0hs?=
 =?utf-8?B?VCtYSVVyellHREJBdFp6ZTRxT1ZERm1WRk9GUnl3VGx1a1I4MWNaREhMZXh2?=
 =?utf-8?B?V1NvdWxoMGg1NS9OTlVkc21wU0hnb1A1QzhtRkdPOWxUWmNrYmp3WFdxbThW?=
 =?utf-8?B?SGJHdlVNYi9yNWxpaHZ2Wmo3VTBadDR2M1NZb2xpR29nQk9BY1BISTQ5U0c2?=
 =?utf-8?B?ZXhjY1I1NHRPSHo4eUdMMjlXNGhPY2RHSDRyU2tFWmZvT0ttdE43L05tV3NX?=
 =?utf-8?B?M2tBa3ZITitmKy9EWXVmUEJJTHBpM3d3bmFta2djNWRtTEhjZ0NWRUpRMXlV?=
 =?utf-8?B?TU8rc01lbDZjS0QwK2pXNkYxS0Frek4xdlhITUJISkxkVnV4eCtodWN3MTg3?=
 =?utf-8?B?OWdONGhTbi83MWN5YllHeWFGb0ZqMXdpUFVaMzdmNWp3VDhoWmNOa0UzbkNt?=
 =?utf-8?B?SENDWU9ZUmJGcVNuTVRkUU1icVU5WGR3SElkMFdvUWhvM01CMVpBcGx0Z3NO?=
 =?utf-8?B?Um12QkNPR3FPWktYNjBWNjh5R0pGbUNnMG9QTWJzUG82ZGF5N0VSby9TeFJs?=
 =?utf-8?B?WTR6dmlVZ29MNzVRTzhHVmZxOGFsV1JXWmI1c0ROVlJzdmFXbHkxaUVETTk3?=
 =?utf-8?B?cGVTaVBNV2ZXNXJmZEdDQ3A3MkpjcFp6U0lreUF4SHlCZXA1QkcyZ0IrZ3hO?=
 =?utf-8?B?OTAyN0VqUnhoZ2Y1ZDkxbWtvOTBaUDZhZDhud1hkaDhuNlpHano1ZWN4aXZo?=
 =?utf-8?B?WTk1dWRQTU5FT0cvNnY3WXgwVWFBVmVpUkcrSDl6UGJuenRsUStBNzNsWGJm?=
 =?utf-8?B?eExzOVNLemFjTHJNT2RkcnhYa2loVjBiaTVRbW9zZWlnRnhzZTg0R3BsRVFp?=
 =?utf-8?B?eGhDU0gvSEJMdWc3WWFtM29MWXhtZ2J1Nm85NUJhWWUwRFZzSVR1NVpwSVhq?=
 =?utf-8?B?b1ZLanNaU3h5ZTIwUm9zZWJ2eG5yVFJ6Z0EzbUtQMTVIRjR2aTFheEx2N1lB?=
 =?utf-8?B?YnY0c3h5Y1BBbUxERjRhK2ZSVHlYRnhPeWhWdWdTRTJGcm0wajhDSEdPUEdU?=
 =?utf-8?B?amtENnhpYnF4Nm94YkRwVkZuVURacGt4UVc5bjVJd3hOOVAyd1pQcHpBOHlt?=
 =?utf-8?B?ZlFyNU4vbVoyaDFwS1JZeXNwYVIwWDQ0SmtteUoxclZvbHdoSUNmejNuOFBW?=
 =?utf-8?B?eFZ3Vjdkb0I1eVVqbDVIdVpXQXY2VUVSN0V6bnhwZWZndC9oZkZmWGNXaVBY?=
 =?utf-8?B?K25lZzlhSkZ6TWN5RHlZYTlpWXBLcjJNYVc0VkZ1RnZ4YU8xcVpqcHhIV1hq?=
 =?utf-8?B?dmZTYVZsUy9aWWZ5eVRxblVMUWp3cnlMTXpoYkE4elRTQlRVZmpxVjYxMWI5?=
 =?utf-8?B?T3RIUy9SWGJWMTBUNW1MVlAzY0lrQ2NGYk1kSHJmOE92N3pjaDF2a21KYXEv?=
 =?utf-8?B?UkpmV3d0WmpNbFNFOHRNL1pCNW5aTTEwcnJFYStlVmU0ajhkMHdTR2N1eHpM?=
 =?utf-8?Q?EJ7BOA6oxDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0xvemF4bmlSajZESm95YUFKbWFkNzFzNUttZDRhREd5UGtGNHhaT1JFa2Nr?=
 =?utf-8?B?eGlrSHJlenFsejR3L1pyRnhPMHE5RG8vcC9sQVJuZ0RSeDJIbjZVZzFUcHNj?=
 =?utf-8?B?dWlqZ0NUZlpQd2loV2FBVlhsQUxKSEhFVFZHNG9zMkVNTDB6OFVWMnZYa2s4?=
 =?utf-8?B?YUIyeGNiVGJYbW5wWkNRSSt0SGtTRHR0VTBWS0loL2pDeWJwMHdJcEUwaC9S?=
 =?utf-8?B?dEc0UmZwcU1zcTNBazVqQXc5ZkdYaERUNThPZHZ3N2VTaUxmVWVRRGt3ZEw5?=
 =?utf-8?B?VHZGWkExZlBPY3BJdjFsTnRYUTJnNUdsN1pWOFczai9Sa2d0WFZVbWM5cHhp?=
 =?utf-8?B?U0NTZFpMcnZncHl1WkV2alVDSnBKZEtrWHJtZ1J2U0MyWHh1ZkJzNmxaaHZ3?=
 =?utf-8?B?eUtINGZoOHA2T2RWVXJ0VTFaOGFkTjZ5bDYyUGNseXJIUitwMFlyYnJraG50?=
 =?utf-8?B?Qms5OU11c3NBVmdKNTR4U042MThvdnJsbVpQZy96WkJOOG1LandnYnU0L25C?=
 =?utf-8?B?NHMzYWRMVDVVeGxWTGQ4UEJrazNlREJoaTJ2OXRGQU85c2N6RUJIaktXNTRP?=
 =?utf-8?B?ZlhMTExtQ3pDTGVaV2g1aTdWT0lXQzQ0czVLYnBNUlYvcFNjZFpTQk1Gd1Nm?=
 =?utf-8?B?azNtNGZsN0pPMXJRbThEMFd6a1Y4aE00NnYwUmJYdHpTZzJTbUdIZmk1WFUr?=
 =?utf-8?B?QXdvUjVodHptOHZmOUhxNlpTVmh1b3hvU28ranpsWGlMcU5uNGJPVVRnRjFj?=
 =?utf-8?B?QUhJZVdmalU0VDNQVEZTTXBsazFvT3ZVN2F3VVp1eTFKdk5GUWovakhocFlY?=
 =?utf-8?B?R0RrL0RYUjBJTzNFelJDN2R5QUpUOWVHYVVvUE4vU3d4MjdMYU00QXRwVUVy?=
 =?utf-8?B?Znlwc0pPTWN5S0lhVXM1L2Z2N2NQdzg3a21EbnZlc1N0b3VHMXd1RzdTdzNN?=
 =?utf-8?B?NlBQRFltbUQzK21sbUNvT3ljUnhnQkxZdG1taHRRN2ZhYzRmQ1RJM1ZvSU8v?=
 =?utf-8?B?LzdKL210TUdqQWJJM2xvSitIamY0Tm8vVmpieWYrNldkbWZIbHlJVTRuNmgr?=
 =?utf-8?B?MGtiQm9GYWtCVlBQOHluVWtTdlJOdVIxd1kvcDYzbHRIeXRrdGx2c0RadlFU?=
 =?utf-8?B?dU5NdVE0K3FqL0tKNTlJaDc4L3hIQnNISGNURHp6cXduQkY5aHNkdFh5d3Vp?=
 =?utf-8?B?T1FoV1RHYW1CeHoxWFRuMHRyd1c0d09lZWZyOUxhOTBIQ2t6L1E4QVZlOWRL?=
 =?utf-8?B?T05aQ2NydXNDVHV5YSs1MXgvazAweFBZQmxHL1lHMlhOS0RyWUVFYUdROGZT?=
 =?utf-8?B?ZDFWRFE1MFA1TzNSeWJDRTNYUVIwWUxsR0xENjFhc1lVYmcraG8veGl0NnF1?=
 =?utf-8?B?OHlGWXJjQjd5YmF1Z0VuKzROMmRTbnkrVlpZcUJVQmZadjJBaGV0RDAwcHRN?=
 =?utf-8?B?K1VNbVJWdmF4YS91aDB3dUhaVTIyOW11dzBHazlvL0UwdVRCNENzdDhQL3Z4?=
 =?utf-8?B?VlUweTZIbm1LTElKaTZNM3labTRQYjVrYzlJLzBHN3FoMU1jV2NCUS82MnJZ?=
 =?utf-8?B?WFVJbDZ5d1lFclByM2ZlQmFCbVV3VUpIbGJSbzZWNks2ak1vS1pKRy83ZElK?=
 =?utf-8?B?R2FBWjIrWlI2L3ExMVhUdlFkakRQYlJoN3Z5R014ellYTkpxVldRSW9BV3FP?=
 =?utf-8?B?R2NNdHNiY2JndGx2OWdMbFczMU9IV09LOUZjaEMwamlsZm83TTFtRWZoOGRz?=
 =?utf-8?B?TVh4OHI2R3BjOFdTRWpHNXlmR2l3c2FxTmNpMnE0RVM4SUR2Wi93TFA4cVRE?=
 =?utf-8?B?a3BhTmVXai9tNVhEMEF5cXVQNW5NYTVVZVYraUFvNjk2RXNLakZnVCtkb2Z3?=
 =?utf-8?B?dHRkSURHM29RTGFIaUhqdi9TVTZQYlRoOSttOG0zdDcrYlgyZDRqQmdtRytl?=
 =?utf-8?B?elh2V01kMmFGTWJkUHNMS0xBUmN6c2FkdTFWRnFJS3FrSVdUcTM2eFB6Z3Rw?=
 =?utf-8?B?RVlNVDEzOWNxbGR5Ynd3Z1dqNWpNd0ExRGw1MDNyNjQ0a29vUmFHZVowTVRB?=
 =?utf-8?B?ZnRhaGVSUDA2eDJBNXUwTnF5Y2Q2LzNXWHVFMWtVVUJQQUI3YlZBZlhWQXo2?=
 =?utf-8?Q?wLD4VZw8rQ5VZEU1IKwP7pNC6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d463f157-fdee-4b77-63c2-08dde8cde501
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 20:35:17.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/qcVy7pYGcX3v7ngQKbIxeiU3zs0wqgfEOrjzmUHpXybcOT8i79LZciFCKkDj0wAiPX6tzKLXeKkZvS7gFYZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7304

From: Jan Kiszka <jan.kiszka@siemens.com>

The result field of an RPMB frame will have bit 7 set as soon as the
write counter reached its limit (0xffffffff) - even if the operation was
successful. Handle that correctly to avoid false error reports.

Only the result returned from key programming does not need special
handling as the write counter is still 0 after that step.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Tested against a QEMU RPMB model that was tuned to reach a counter 
expiry quickly.

 mmc_cmds.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 16c6b2e..e91813a 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2103,6 +2103,8 @@ enum rpmb_op_type {
 	MMC_RPMB_READ_RESP = 0x05
 };
 
+#define RPMB_WRITE_COUNTER_EXPIRED	0x80
+
 struct rpmb_frame {
 	u_int8_t  stuff[196];           /* Bytes 511 - 316 */
 	u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
@@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) != 0) {
 		*cnt = 0;
 		return be16toh(frame_out.result);
 	}
@@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out_p[blocks_cnt - 1].result != 0) {
+	if ((be16toh(frame_out_p[blocks_cnt - 1].result) &
+	     ~RPMB_WRITE_COUNTER_EXPIRED) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 			   be16toh(frame_out_p[blocks_cnt - 1].result));
 		exit(1);
@@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 		       be16toh(frame_out.result));
 	}
@@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n", be16toh(frame_out.result));
 		goto out;
 	}
@@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((be16toh(frame_out.result) & ~RPMB_WRITE_COUNTER_EXPIRED) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 			   be16toh(frame_out.result));
 		exit(1);
-- 
2.43.0
