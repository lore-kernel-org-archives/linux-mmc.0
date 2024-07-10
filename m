Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED21E4AF;
	Wed, 10 Jul 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615858; cv=fail; b=UPry2GbWKc+un/XBzXE0W0g/ijiZ6ZCw3EuPI9WFp1NZPljC6B6fX4eKjss9vbPh8joS8COEbdikKLSfK+7J314F/42O42BKT6epn8Z8sx6rrWxDKupcxJD9Y6SjK4vScCBJFofR2qZLqXosUTV66PDh3FvxZwnSziw3AUbBMU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615858; c=relaxed/simple;
	bh=o/AT49k0nLmpJ/nz0QYNzdoA/chAC0ia6v6VNBOPleE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dOrXsnuGiPu5jUxsdDsq/WDwVFOqRJZ3Zwb/BGrz9quXH+9cthbr5p512sT0r+DJI5hxSaq/9IDYQNQHYr5HjSLsXb+CG5hTReuZLY7UzAnjvJdjFlfLGWdaBljOCsCHebYTdgsGdJUcK6sMUQNPQUnl6/G5qi6kweHxNNLyhbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QxVxsOln; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QxVxsOln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFWFY0qGYuzpGAo+YwWEteYv27mviw16NieXTzeNfnTjIyP/d9stLDVTzybP6VR9maLXkLOsCyE9vMMnJWUmkaxKe1ol6HIzi3nTDGncKYk9YeO9fHklUcFVF4iIf7bPp0FghSwlQg7xZEH+JlneU5LMqIyS9dMoGssyZwLG8HlejWQlwJ0uzsnMOzgV3Ig4WcduPFPeW/W66nLQrKubf16BxF1i/T+GGK42o32Z9i/RtwcZ2NQWngZ28o9baBQUxjl++TUSjGIM9po1xKozWgFM+nJ324WMdY16vChopRHleghG2BddGDkoYV4z65OfE5hN40oiFk9Zx6IZeWISxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc1BO1nhstJQ0IarDV32ZxYalnNUaSERnhh4yuq4lLU=;
 b=O+sIwQAaKBiWcs47q9AWub+d575fwwUQma7lqTOE+RqARBj7o7aK/dpxwuTXSX9uTPwxf9tcptohxB4U2lMt/e1kCTLVE820XeLhczoChhYMY+WZJz1ONpbac7g9TWl5dIBmKwZ2vtmEp7ikhAsm82Ll4hWJguhpe97zHkaxTBGkS1F3qqOOGqy8IhdQNDNu+CjWI/UMMfQb1sSidFygEOKqUDDIdw0oYGcfoDFDQNX57t+Q0HWMxqOt1AsubRhq0XaBmFT2KFrmv3lSEhiMun1mOqNowKYsRnxsdYyLBfj2VGuhUKFmyr1gcP3j6uiZCvUzsS50ca/O83V+ygwOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc1BO1nhstJQ0IarDV32ZxYalnNUaSERnhh4yuq4lLU=;
 b=QxVxsOlnaQ4QqZ8pHAr/B6YHk3Z/WycNj/Fft81WS1rwpqBi7GzXxdds57IcaWLVIe89RZEcmeKSc67pB/mVFKTFvCUEEiefUNnu+p3fgkUBRCdNuLu8fju7rVNsCWTQw1/hWk+qk8KC+ncHZAcw4+ctwR8Pjmu6u5xy6MJ0/h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA4PR04MB9390.eurprd04.prod.outlook.com (2603:10a6:102:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 12:50:51 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 12:50:51 +0000
Message-ID: <7d851eb6-ef8e-480a-9b5a-8cb67d6adf8b@oss.nxp.com>
Date: Wed, 10 Jul 2024 15:50:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate
 after its enablement
To: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-3-ciprianmarian.costea@oss.nxp.com>
 <dbd73f2b-54ab-4832-9610-a4bc70e3b9f2@intel.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <dbd73f2b-54ab-4832-9610-a4bc70e3b9f2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA4PR04MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: cce48951-d8e3-41f7-238b-08dca0deeda7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1ZXSVVFYzV1b3hqWWl0TEVtdTBjQ1RQQm53cG4veE1XZjNNVjV3VnJOS1JD?=
 =?utf-8?B?aU9pWHBqTU4vVGlCOU1kMXdoSWoxVUlSRGdGaEN4dGU0Znp4OEo3ZVpaTEs0?=
 =?utf-8?B?YU9WbFJ3a1hEMEd3RHA4WkFIRzM5WXZFZUdaL2J5RndyNCtPbXQxU25iMnI0?=
 =?utf-8?B?OUJRVzc4RW1ZVEZWeEJoSjJvSmx3VFgrU0xFQ0pzZlp2UVZrYnFzZzg4ZkVp?=
 =?utf-8?B?dWVVbzZOcXQ0dWxIMTVLckZTb2dBdTRubGhJSHBsTTc5ZmlUT0hESDgzakh4?=
 =?utf-8?B?K2FZbVR1Y21zYzRsOGhZNFIxUkNWdzlOWnNjQkNwQ2lsVEtUMWZxc2VjNThq?=
 =?utf-8?B?ckM1RXVIYUpBRXVBeWpHanBjbFN2VGY4NFNobmt5SlFjZ091dmZ1aEc3MS94?=
 =?utf-8?B?clprSVJOeDdrZlJWdGhIdVVjc3h1am0wWUtnWWNwQmlFVmFOb2pIU3BTNHVL?=
 =?utf-8?B?aEpiWFNWQURPSXNZUXFmZ0grNjR2cExrUThydUZhakFLZzFkOHI0S3FHdlc0?=
 =?utf-8?B?aFY5Nkk4OTNNNFFXY2tJbjJ3OXJhMysyUm53V0hiQkxmdnZQbVE1M0VrRW1H?=
 =?utf-8?B?SXNLaXdzM000SXBhTENyR3N0QmlmTlJueEErZWhwRWFBbTN0SWg1VlFvQ29Z?=
 =?utf-8?B?L25zbmVqV0tKMHNLRFlVL3c3TW01WlVZZ1VHYzlkU2wyOVlpNy9MYTVsQ3hH?=
 =?utf-8?B?K2RDNHptQWRrN2UxSTVyYjk5WXljTHBQcFk0K0hxQ3ZTNzdnMHVwZUxGSTJQ?=
 =?utf-8?B?Ni92Q3d4Qm9GbGdmZUtXUUtqYUVCWUVFUWRHNUR2THFXWHcxQk1WbGlUYjBV?=
 =?utf-8?B?Tzl4WWJteVdsTlg2aStPMmVJVTBuUWVLS3VPVEMwdWVPT0RaczIzbkRudW8w?=
 =?utf-8?B?Zlo1UTFaUklrV2NyTm9lV2cwdGdPS1RwRW1DanVYNnNiSW01TEl2QzZocVU4?=
 =?utf-8?B?bkUvK0NjcURtWlJRMVU4YlhxK0RiV3JBeHg1dU5RT3BsVnFSRlltZkxKRDdD?=
 =?utf-8?B?Smw0RDlxMk1IbHYzTU9sSTZJZ09aRmw4bGJzRHJmTXZUU3FQQkZBQjMxVDhG?=
 =?utf-8?B?UVVTM0piZUVwbDNXV3hHNWQzTENzSVZBTjY0V3haOFV1Zmc2dnI2S3FNQWN1?=
 =?utf-8?B?U3RYNFp0MXZiS2U1cWNlZmd3MmxuZDR4bTRwVzJNYnp3bTJ1c1NZU0tWR0d2?=
 =?utf-8?B?akcxZlI5Vk1pVkNKTGtyY084dEtsWEdVYjVkZmx1aHRFaVZ2WlMyczdnWXpS?=
 =?utf-8?B?RWp1cGszR2xzQ2tSWEh4U282T29QVk9pYWNqMlFjQ3QxQ01sUFMzV1g0MHRN?=
 =?utf-8?B?cVg2Y1pwYXJGbWQ2NDh0MERQQjBrcjBzV2hYNEZYUDd0OFRqU1R5RUhsQ2tI?=
 =?utf-8?B?ZitiYVBpTFBlbkxSL2dtcW9HTFFhcm0ySUpqZE9CaUtiMDlzV1RPRE04V0JW?=
 =?utf-8?B?U3hLYVBLVlMyTm80RUNoUUE3U0tBVkd1aVhoUS9xcGh2K2Q0cmlObkJGb0k5?=
 =?utf-8?B?cStPQis0OUxQWEJ4WksxS3h6RUFodDBSeit6T0lnOUN0YStQb2tpS1gzOUty?=
 =?utf-8?B?SWo5VXJFVEF0RnZSUWtLY0ZIK0pHT1l6Y2g2WXA1ZXZ3RzZ0ZTl5Tzg0YzJ1?=
 =?utf-8?B?YWI3T0pySC9BQkM0ZVlKdzl3aU9NbUZtdnNObUxJbDFRYWN5Z3NQbXFJVUpt?=
 =?utf-8?B?RWdrWHdkaGRXVGp1ZWFiOUZsOUdRRnF4WHhITHNZUjQweHZFMzVhWU5PMHNs?=
 =?utf-8?Q?8Q95xN0PU0+tf4ptqU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU43ZE5Mams2ZGZCWFhPQ0g2RGhEeEZvY1hKN2Zvd1Y3ZHNzUVNJa2ZvWEZU?=
 =?utf-8?B?ckYzWWQrRnhIa1liR0x1L210eGZKWlJpdHJxVWlLRHl0NWtqS2hES2RmRjJ6?=
 =?utf-8?B?YitreU94Z3d0eElHQmt6UWpUZE1TVDY4Q2VydlJzTDRIZ3A2QzF2ZFo0Nnhr?=
 =?utf-8?B?U2hzWCtJRDBnOUE0blhQL21lZVl2NDJtNld4em9ZemNHQ0xFamloRDRQZ2xZ?=
 =?utf-8?B?aENWbVRTbWM2YjZuQUNjaTR4WHBoS2ZCWUxuYVNGV1BjZFlMZ0ZJT1ByU215?=
 =?utf-8?B?SE1nQlh6Y1hMM0VQaXREVHZtc3V3SStaUFRBcmJCMDlYWGptSlJUUVl3cThk?=
 =?utf-8?B?amU3dkdGWFR1RSszWTJiQmtvUFF0ekJHZ1ZaSFp3eTlHTzJkUWRYY0x5ZWtT?=
 =?utf-8?B?YmQxSURsc3dkbnJXRmkzYW4xNktBSDFqR2VycVVLRXVjdVowVVUvRGJRQzRL?=
 =?utf-8?B?Rm8zcXJ2cFFFOWRwdVhWUkNIRit2elBIUHhBNEcrZlhVRTFrZkE4eHVIWnN3?=
 =?utf-8?B?aVkyUzhKd1NrbmkySjFpK0hwQm5ValNGUmZtUEhZanlFSzdjVnRWZDhzemtI?=
 =?utf-8?B?YWlWdkpnWHRjSFMzZVlMc2NnUlFpUEpyeHh2Rmt4bThQcU81YnVwL3owc1pB?=
 =?utf-8?B?dVVmRFozQVIvdWdTUGo0QWtjYllMMnFCNTB5ODUzZ0kvMG1TdzIrTGs4UmJk?=
 =?utf-8?B?elE3M05SSGJvYnJhQWRaNnF6aDNvQ0J2cDA0RHU5VzhwUDVNS2ErVEpGaG5z?=
 =?utf-8?B?TCtRRTY4OVFmcStnQXFNeXJyTkxJRkFNVnZvcHgvU2dldGtieVVYd1pVVXRW?=
 =?utf-8?B?N2N3UnVYS0xQTXVocFZjWnowb21pSnAvOXZPSnV6WFRZM3NNRnlaNTZFVHYw?=
 =?utf-8?B?TjZtRGZ6Wm1nRkZVMGQrNm13NG9qRkNjR0dUZFdhS2NQS2dvNm1WK3VuTy8w?=
 =?utf-8?B?R3RxRFhPZlZrOGtaVDJmMGNxQmNrTGJGemovYWwyUXRNZ2o0eTBjbUdBZ2g2?=
 =?utf-8?B?U1JFdEFuUFhPV1BMYU5VREVNN3JpSGxiVjJ6VEFza3BNbFU0eVMyVmp1WDVJ?=
 =?utf-8?B?Q1RtWXZkWmVMMUdNQWV0MEdUcEhUUkVCTGhmREdmdUlubEd5dk5GSEVsMjBk?=
 =?utf-8?B?dVlDRUtxZ09VeVVZKy84T1NHOXVEaGFYRWVmOVEwcDIzeHozSFFjQkFXc3pT?=
 =?utf-8?B?MUoxc3ZDMk5WMno2ck9VWjNFL00rdHIrNzFNektkamNEK21qTVJkeE1DR1Rp?=
 =?utf-8?B?QlN0N3I1SDFwY3hxSzRXUTY0VjVBREN1NDhQaHFjR1VoWFNvWDh0bERTQnVw?=
 =?utf-8?B?Zm05WHVTOFVKaVpOSmdqSWpkR2VDNnpUQzZNekxBRzNOSEVzU2xvZ3lKUG9o?=
 =?utf-8?B?SU5saHVRWWp0R0pXQmJSTkNZSEpYYTFvYU56UFVDR0d4dnNQZGlVaXlSTEx3?=
 =?utf-8?B?K2hHNHRRUndpZ1BoN0VyUWRsQ1RQV0FBQnpwSVU0RmoxeUtGQ2JSQTBSS3pr?=
 =?utf-8?B?eVJRQ1pRYmhKMkRJK3NSMWFoN0ZLUlZHUmpReCtxZGpRdE82dDB4NnF4Y1Z5?=
 =?utf-8?B?NEUzYmNnWWJxZnZkbEJ1OXVUOXVjQ2NOK3d6aVRwdW5XNlZEVjQxQXFCYWVh?=
 =?utf-8?B?WisvSW5EeFR5cDBBby9aUDBIN0NPdXFWQklOWDV5L1hheEdQR2wvbldHYTh6?=
 =?utf-8?B?SDZMR3pid1g4MzZ4ZTNzTE1NUldXenBaZ1RBc0wvakpsL1U5T0Y4a3JjTVhm?=
 =?utf-8?B?aityeUhPdzVqNmI1RnZsOWlEL2VlcUt4eisxdHN2SW1XWVV5RFBOVmNHdzFB?=
 =?utf-8?B?T2VMYnJIei96bmd2SU9ZdlhMVzZOYmsrdjc3YUJTQmRlbjk3Y0xWR0ljaWZn?=
 =?utf-8?B?dkdETDRLd1JkVUxURXJGYW1EazUwbUhySVRnUWExTDl6WXJlR0tjY29LZFV1?=
 =?utf-8?B?N1hDMnppQU1peHQ2bWx2eGFDcW5JTEpiRVZjc3hJNndjSHdJa0NFSnFGdjlB?=
 =?utf-8?B?Z2o2bTlVbFVUK1lYU0hEbnkrYUx5TjcvQjFxblBLYksrSEVhaXZVa21mNkRo?=
 =?utf-8?B?ODQxQWczRDMvbWhueGtVL1E1UC8yZXJuSE1KYmdhelBSeHI5KzVvN3BxL2lx?=
 =?utf-8?B?ZWQ3UzRjaHZ5TzVqL0lKTEV1VmZOdERKQ3hHM0pJYzM4ZEpBRER1NUZ5Um5z?=
 =?utf-8?Q?uWgf8UE7bIsTs5CtzhtEqL8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce48951-d8e3-41f7-238b-08dca0deeda7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 12:50:51.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ7bmpSDPVhxKkg0ANuJMHDlczIzz4kuzDrOPIvm+Dna51hgjW0ej9CrAPQEHCq4+5g573d6C9ZROnJtEz6MouotAs/OtYdFRe+rxlG0ilE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9390

On 7/10/2024 3:33 PM, Adrian Hunter wrote:
> On 8/07/24 15:10, Ciprian Costea wrote:
>> The I.MX SDHCI driver assumes that the frequency of the 'per' clock
>> can be obtained even on disabled clocks, which is not always the case.
>>
>> According to 'clk_get_rate' documentation, it is only valid
>> once the clock source has been enabled.
> 
> The kerneldoc comment for clk_get_rate() says
> 
> 	Can be called regardless of the clock enabledness
> 
> which sounds like the opposite.  Please clarify.
>

Hello Adrian,

My observation was based on the following [1] 'clk_get_rate()' 
documentation.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/clk.h#n720

Best Regards,
Ciprian

>>
>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 21d984a77be8..8f0bc6dca2b0 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1709,7 +1709,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	pltfm_host->clk = imx_data->clk_per;
>> -	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
>>   	err = clk_prepare_enable(imx_data->clk_per);
>>   	if (err)
>>   		goto free_sdhci;
>> @@ -1720,6 +1719,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>   	if (err)
>>   		goto disable_ipg_clk;
>>   
>> +	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
>> +	if (!pltfm_host->clock) {
>> +		dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
>> +		err = -EINVAL;
>> +		goto disable_ahb_clk;
>> +	}
>> +
>>   	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>>   	if (IS_ERR(imx_data->pinctrl))
>>   		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
> 

