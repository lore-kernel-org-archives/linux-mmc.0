Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB9140E29;
	Mon,  8 Jul 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440629; cv=fail; b=OKd2QAOGyWq390YDzrTVENw4eZGMjB/1VfIwRuVSJ0QLJPjVfLI77oAiRTahZBHR49lJzBI5FRVbG62zxQHQ24zWU0KB/vhTqOQPvzyfUYZbQZeg1XDYeFSGDinu0noUK3DFGZaLUynUZNXXlEp35Ks2hKcuDT4wuSiFTX25YYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440629; c=relaxed/simple;
	bh=AQH127nXs0NBQpDhrIenMYtSEPKcPviNRrVrst7c3EY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qEU2IVQ39QCvywOO/Uhl/pnNWzNwBFPCgmvfryRBkEWLTrk2DdbQKgF51KOj7+AQzBGwBRgf3TNeEd/Mp8DdNCXR5JterJkasz+QVjz8thh0+YhHv3LZYzNjPBDdDNJz+kt6Lq1zWmraNXnJreTHrMzXkfTko09MG2J76XZWlr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z41vwS8C; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z41vwS8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0d5FU3UPU+5a9eMN33Nirz7mHujIxEqfujRUmlwHf1mdOilhi2EO8phsc+dNYUgOHb9+SBQGWwg81zD+DcE8Wf1CyfWtzOcZytz+UOqmcjtfExVqLeQoEv2GdTzOJJiE4igy4P2+0g6h5QLlY/X3NBhvGOeybcvtVkc7Hk3XJAZRNbb0l+1OQ1HB0C0pXfCNXSX4uewcgWVkEUEfszb//PgecQoXtY+CbDYSJsL8YWZyfuTEknXm4lXoIZFDf+t3ZjmLY3HpryAPZrNrZee6kFPXUVzTgn9zWlnbIN4Y7hmy240xmz3UDofks9aQ4uX+ERzyX/RTUz+4lSIIoB3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALAXGEdIxJJcDfoxtYGEY98v8Un5fU5EAFyBJf+Z7UE=;
 b=IG/gLV2u5eb3BVrmQl1Jmv56pLCmgU7GzaOXEKlloGVwW/jVI0J4mi4oYHqLcmk5gYXtJHgK7VDTIN4Y5TLQoOBVXLhaosJLx3pHbMx5IFkufRHeMhIX7f1PBL4pty62hssdEcMElDDnjzl/8G1+OvHNJSvzx152qyIF+P6jH+4Efyp/IrAxTpqrSQvsWKqFUG70RsTqmWlsypaHREt0UGkRc1yDl2aAb51L6mYcbvtfVsjLJ/TrRdQWPwRX0wikCxIo8/nOgiC0uv4c6wEYhHcH4TDCXGTqoPrOThON7OGKbMRmUsZVm0fRdLzrGn5WSX0krSFTgDf3+hoyJKlgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALAXGEdIxJJcDfoxtYGEY98v8Un5fU5EAFyBJf+Z7UE=;
 b=Z41vwS8CmQQWY7bYR7CMjPRtI6UIX8wFaFK2L5mSUToljUPF91ydg44YF5b1gG4ytkseItfoK84wlvu91A6NGyU1IKQ56LQfZXHDBqUPj+aVVhEwgEQpPF1Z9BohwUNywL6syXvk9+ztNq7C6CjCQ1Hi011rhqgp0nxNFirsvoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10614.eurprd04.prod.outlook.com (2603:10a6:800:260::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:10:22 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:10:22 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 0/3] address S32G2/S32G3 SoC based boards particularities
Date: Mon,  8 Jul 2024 15:10:15 +0300
Message-ID: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB10614:EE_
X-MS-Office365-Filtering-Correlation-Id: 5172033a-e37b-4e64-66e9-08dc9f46f0ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1dXdkkwSXFQTktyLzhIWDhVcUcrbVdYT1ZuclEvOEpPU2dLNUR6djJUY3ZJ?=
 =?utf-8?B?Y2lJZHZGVU9sZEpJUWZOcDFvQjJ3TjBuQUtrelRLVUtHUnhMT3BTL1NneGtN?=
 =?utf-8?B?d0lmSjJtZmE1MDJQNnBiR01XYjg4cFEvaVZpZWVrcGNxMjA4OWZIREFtNkpR?=
 =?utf-8?B?Tm1mNHByVHZTeVBVSHBUdC9ONFUyU1cvd0gxUElxSEZLSUJ1enYzbzBJTTVV?=
 =?utf-8?B?VG96L2J3LzhPVEg3MnltQmdvdDc0QnVudkhkSTJMSHZZMkJ4aFpjN1paNlJS?=
 =?utf-8?B?RDlKcEZxNmIwOGg4RFBBS1NRM1FpTnRMRytUWnZUMG1zREVidVpDNkcrY1R4?=
 =?utf-8?B?WDZRNEgzSFBiZVk1RTBrZ2ZiSTVtSlJFTVJ4SVRqM0NBUTY2SjlXNm9xWU5l?=
 =?utf-8?B?b0c4cVVwRngzMWJWYi9IaEQrVmRzTmRtdVdLd3c2YmhwSnN5K0xKTUJ6WDMz?=
 =?utf-8?B?SnZjdjB0dTU1YldqTUs3Y0xpREJQNTBTLzBUUFBSdGRVa2tjZDI4QTg1TU80?=
 =?utf-8?B?VG9HRmFYZ0p4WmVRaytsekVneGIvaEs2K24vdHEwdGpSRWozMFhma1ExeVJj?=
 =?utf-8?B?K3FieGpQNi8xdWtnTTRCbkFnMml1dVZuWkkvWDNFbnhuV2VLdzVlR3dPVkdn?=
 =?utf-8?B?QjYvU041WHREUzB2MlJGcURhKzArNHAwdDJ3QVo1RnJtcndMaDV4eG9kRUtD?=
 =?utf-8?B?bGZGSTllZ1JDYk1KTW1mdFlFaGlCR2h0R1NaZGNQeUswQXlKT1VTbUZ3cGpX?=
 =?utf-8?B?OEF3NzdNb1BUSHYxL2NyekRFNGhYeGVBeWNvREgxbUlySldybXlFRUpVbWhD?=
 =?utf-8?B?dG1EMjhJa2hINTh2T3p0VUNVdGNZN2d4Z0lueG1JaG4vbTR5RXBFdWluTE5T?=
 =?utf-8?B?S1lhbE1jK3NIUUVkSG9rczhDdVAvcjZoakNHcUpPUlhCU1ZhMGRiQ3lHQ3ZZ?=
 =?utf-8?B?TzRLdDJod1JKbWNBMmpjSDJYb0NsblAyTTFFcUtJMExwdFcyN1hvNEF4ZVRs?=
 =?utf-8?B?Z1Y3MGtMYm5IU0w3VEFicnJVbm1JeldwSFA5VkFrTHNOR1FHZzFGeWZxZTd5?=
 =?utf-8?B?NE1aZ2VRbThQZG16TVJHMmRUSjdxa0JIcW9rTjNldWZDdllsenRadEtxdGpG?=
 =?utf-8?B?UkEwVG9oeDFEWmJKL0hhSy9uRWZ4WE9qSVNkdlMzUzZBRTVSanZwY3l0NjBy?=
 =?utf-8?B?V2d4L204YkoybGdhUVBIaG95MnlGQ3NoSTZsS0pHQlJrN0g3UnRzMmxpbDBW?=
 =?utf-8?B?dHpIaEhhQjdINHpEY0d1WGZvQW1hTWdsai8reFIzeXVNVHNLd2ErOG9vcGpE?=
 =?utf-8?B?NjgwbjdIbmpYeDNjM1hLTnlUT2VsRy83azVuMVlrRHE0K29XdnhBeHZPZndE?=
 =?utf-8?B?RXVJNWdpcTZDSlo5cDBKcTFsRmRFNGpsRitEVGZSRExGK2EwK1I5Q2VNa2lB?=
 =?utf-8?B?U3U4ZWV2RUNxaTNyNEs5WUgwK1kwU2FqcThOZ0lRc3oySXBPMm45R3Z2T2dY?=
 =?utf-8?B?MXFxOGhONFJKTVdSQ01BMVJoY3lTemFLdFZUOFkzb0ZycnAzbExzOFZoVVlC?=
 =?utf-8?B?K0NIeTg5QjZmck9JOG5rYVZVNlZic3J0dUs2S1ZmWHlJeHFCVE83emlxSldo?=
 =?utf-8?B?OGJzV2gwbjE2bUhhVFBTOExhendZYTlWbU0vbno0dWxqTDV2NWhSOGp0TVZs?=
 =?utf-8?B?b0QzRzJLUXNLSXdxRGhXL0h1amV6QXRXcFVsSTNtOHBVMytMbk56c1Y3emZ1?=
 =?utf-8?B?U1k1QzUwR0NxS0haeHdibjdLbjhLSDRHa3QvbGFYOHpvMTJVSERlS29aSmdm?=
 =?utf-8?B?Rmk4QUU3OStrUnFMQnhndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0Z3dHREa3U3dUtxMmFDM1ZTK1hIZks5QUlhSks4ZkNxZUNjaFZNVWcyNzJX?=
 =?utf-8?B?aGtUSnBVSkxlZDVZNGF6UVpqK2tqZTkvQ2NwSnRidCs2OHp2ekdEdjVEelNk?=
 =?utf-8?B?Z3BLaFBSR09oSThGUHJLbVVJdTJqeEplajdSOGMzN3pNNzNoK05VNkQ4LzJx?=
 =?utf-8?B?VTVqa1ZqTjh1WWFsT1pGWTIyemw4SUFKdTVNRVJTY3VkSVBRbXlrR0tsdUh6?=
 =?utf-8?B?VmVEYXZFcTA1QVVDeURyZXllTERkTElRb3F6c0RrQ3h0bXBjUEtNVzQ5Lyt4?=
 =?utf-8?B?bXQ3RXhXeStVV2h6Znp1NW9wSWFIa3I5cmsxQUFGTjNJcFluT3M3S0MrVDY2?=
 =?utf-8?B?VDAvWDVUaG1IeWhwUGsxVWQyMHQwdzcxaVhTWjBFZnFYSlFzM1FqbnRwL3BQ?=
 =?utf-8?B?L1Evc3VYR3VlVU9NM1JMWkM0ZEJYaEhUU0lCdUhFMHE2a2JPTXc5VzNRdE1K?=
 =?utf-8?B?WnVnN255UjBYU3JqQXd2OVViZFFZbE5adWJoVkdiZEx5VFQzd2xGQVJBRTU4?=
 =?utf-8?B?d2h5UkFoN1ZiWjRYek1teXlENmlKVDBHd3BVd05oOVZoeXZLb1BtWTNzMGJh?=
 =?utf-8?B?ajNFN25OdU4xK1BBWEt1UDRIRklvSG9VR0o3RWUvRTlBMHM1MjliNXdGYmNl?=
 =?utf-8?B?UG5OL29sY0VqRm5qc1dFNzd6eHdXdWRGMjhITFZraUtmUTFadUtoY203TENh?=
 =?utf-8?B?SVpOTU9sUnFJdW5tem8zV3RkVitvSFVnbm1nVEVrVG5iUk0vRkszb1RJY0tB?=
 =?utf-8?B?Z3owWDVqSmV5czlFWGlSTVZRa3lyV0J3SjczZmI0b2dEdERYQ2kzbmxCZVhh?=
 =?utf-8?B?N0w4RUpoSlNiOEdzT0kvQTBhUXJVYWM1VHVRQzBGcmNqN0lPL1pwek1BQlZo?=
 =?utf-8?B?MUlBWUlZVEsvOE01RG1GUXd3SzE4cGp2TkJ6MGpxRlEvMFFrZEV6dnpQR2pj?=
 =?utf-8?B?dnJhY2t5eTBqKy9TL0RPUkpxUWpwUnNXaGdrTVgxNzRiZnFLT2JJUzB0SjJy?=
 =?utf-8?B?WHdpQm0rK2dMaWRCangra05aWW9iTXFhaGhpY1N4TE8yT29vY2FRU1JmOGRt?=
 =?utf-8?B?QU01SVpXdnVSZWpUeHZxSTZXS1hNUjJjblJqeGRROU13VGkvTDVDTWpGUGc4?=
 =?utf-8?B?bkhWMlAyNm1QdnhFaTZaMEtqUE40M2haMGZxdEdsVGtFSGpKVklFRUpnWE1U?=
 =?utf-8?B?NDFIZ3hmN3h3K2xwUkZRclFzend2OWZlMkI4YmNTRmlpS09LSWRTajA1SWVr?=
 =?utf-8?B?Q1pGS0E1bFhlaUV2QlhaaE54WXdOL0Jvd3ZFSGVlamgyWDZzcUFlQXR3cW9r?=
 =?utf-8?B?Zk5xNitaQlpKcm8wRTFiS0NvSHRNditNYXNZWTNRamRPTGdpb3pEQ1pRT3Fp?=
 =?utf-8?B?NEFHQ0t3QndscmlqSFBoTVBoWTZIUEtDd2ZZdXBMbW5wSllWWHJaaStLNkdp?=
 =?utf-8?B?NWVXZ0lwekdnK0hNZm1jK1ZxV2RMZHlibXFoVEEvUjd6T2wvMHpONWxiYnhx?=
 =?utf-8?B?TkVtdkE3OGpJbEpsbGRxdzVlZDlqSTEybHBtb2JIVnpEZEVqMFMwMzVJZFVB?=
 =?utf-8?B?S0lKRWxzNDY0Vk13WVIwdkF2NS9wb0JxdlFmbkJMRmlzM3B2NFRNb0FNRnB4?=
 =?utf-8?B?N0lDM1c3R2srTWxxYVgybDE0UUI0cSs0U2p6eXh3MHBzdERjRWkwSmpOUnI0?=
 =?utf-8?B?Ukx2WEI3TEswTnNoamxTajJuM1NFY3FrbFlrSGxUYXZoVUxlSDJRNWlnUWpN?=
 =?utf-8?B?bTRHTlJaVkRUNUxYSzI4K0xKM2dPK3NzdG9jd3NRc1JRVUhZODM4amlPV0Jw?=
 =?utf-8?B?MEduNEZYK21zLzEvRHd3UnRDK2hVdVhGMU5sbkcydHFXNFZnVnhONDloU2lZ?=
 =?utf-8?B?d01xVTA5a0E0a1Y1QkdtbTJKcWQ0b0Jyci9Ma2ZDVFZXZnZtUWFzbER3NWRZ?=
 =?utf-8?B?eWhOSy9jUVFSaXl1QU54RVZXUis5TDFyTENSaWRhQmlaT0hobkRDOWhzZjBX?=
 =?utf-8?B?SEZVQVVBVndVVW5UYWNJelBEOXhvN3VyTmp3MUdnM0pKNUdWSFI1U1FUN1lp?=
 =?utf-8?B?MUp1UmZhc1VwMHRnckNFQnQvUGFOdFBaZlpUbmJjNXRRT3V3bVlxUzBNUVdK?=
 =?utf-8?B?cWxXQ2g0SExhT24xWnY5ZXlPRHR5RXhqMllNK01CRjl0ZU03RWtCNjRXVHpj?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5172033a-e37b-4e64-66e9-08dc9f46f0ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:10:22.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG6YmpPuewuzWwidwy8pNnkEQKU3X31NwB3INj7nZHnDm8zeAWFS5VNE79K/kcCw9lH+d4okPU9HskEZRZ4ESJpfaiosqfs4qFdIuK8ki7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10614

This patchset addresses S32G2/S32G3 SoC based boards
uSDHC controller particularities such as:
- GPIO card detect wake mechanism is not available

It also fixes a clocking usage issue on 'clk_get_rate',
in case of 'per' clock.

Changes in v2:
 - Dropped option to not change pinctrl during PM.
Instead, when S32G2/S32G3 uSDHC pinctrl entries will be
upstream'ed, 'sleep' pinctrl will not be defined.

Ciprian Costea (3):
  mmc: sdhci-esdhc-imx: disable card detect wake for S32G based
    platforms
  mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
  MAINTAINERS: add 's32@nxp.com' as relevant mailing list for
    'sdhci-esdhc-imx' driver

 MAINTAINERS                        |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.45.2

