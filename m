Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490919CC28;
	Fri,  1 Nov 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461355; cv=fail; b=qpVyTk5fJ/lEmapJYoy1ywvfaQM8MOk2lWcKEeBv4t/G9Dy6/eHApCJD827xqvTfZ4rtZAZiV42uAPLuN1lXFHIamJEL94c3zKSbTqQSzPYVhu0WxCkSvhRSZGpy1gI8PVbeRmRnJ4hxUznLsLnJtjt0MbZ8k/AR5O79yl+sPfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461355; c=relaxed/simple;
	bh=zO9QyWg1HxuSZS9GnPm683YlvKYH/nq9G0g9teQTtrM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rMYxdkDkmfrIzAk61kZWhWp6a/Id5uo9dy6mHonD5AI81S10TXS3qVZfqoZ5iyMZT/a7VtPIScbHfjKtPZUupnz+T7A122HMsMH1GI7/5pvV/fKl+FePINc+prEDZbfOrPCPlWwjOMaC9/bJBzExTnEe7qjb3aeEDhkxe4LcGBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VfAr6WXS; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VfAr6WXS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrZfXUXvIJEwvkf0iQiGKqkXmWBHKnOjFx2AwQhAUIzlvKKR9wvh1raMhuRfvSkhnYvC1MqYLM24OkS26N54/NjYQeRcRLIn/mfIxJ0/5dlTtP9bLpXQhK6UTBss/ikaWN0PNtXbZmVUfQcWnEWEwzenyHW9kWnL/7NeAMSyeZkOL+YbGhjFnB/fQ8MyNJUs02yPb9KrqypbzNyDZ56ZAwQ5bxr00vyBVq7zEtyb6wlBQ3smx8ZzYjbZ/uooxuP1d9uKP5oU84ML4okraFBu9A5vnAkB0/wAMqi2whR+2dwB0n9ZQ1ky1H5Bgjs73M909Xd6gLQDxbwBap2qPD8CtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ssu+82ASPw6IayQqExCdYLnky9EubC2EVJ6pOZJqtFw=;
 b=jEKXHsNeq1dMMwkUrDT6zTFTb+IvFOK1e6x1CoDLXge+q19PPjZEuUkPjPiCM37KnFCnyDeECK8ZDzsXyP8odexkToJzENeAWYBhd08dLnApmZ6Pk8QcAzOPO10LczP1jmIoP12yLxqZY+85uNrTOJHr1xrQXqmkOIW1zBTbF9KDV7ZNwt66c0IgIAQeT0Hkt6GXRRXDY8/tgRZqOTPWaXSteQG1pxHhIEuVbIRds6TG5xUTfXkiCWeOUYlnF+oF9S/p58nQD0PeU/IxFC/CUlW3pMypsBLLbKHUqIGC5i4zuueRcS12LsYSBAH0OigmL2nthNM3klC+DN56YzRI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ssu+82ASPw6IayQqExCdYLnky9EubC2EVJ6pOZJqtFw=;
 b=VfAr6WXSms+wanyp12OEN3qUDRrjKOTKZGrVU3w8+dCyc3xubvxt60wk6NMctwdTi/PpNDzVUhSo7cyBQZb4eAPhU6webfJxkroyAkxQdddhA+dkJPemuD5Nm1ChkiRXoIjVqE/YVaSawegcj9hMbEV/A2FBYpm1Scz09CcFPko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB10519.eurprd04.prod.outlook.com (2603:10a6:150:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 11:42:29 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:42:29 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 01 Nov 2024 12:42:25 +0100
Subject: [PATCH v3 1/2] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-imx-emmc-reset-v3-1-184965eed476@solid-run.com>
References: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
In-Reply-To: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
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
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB10519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7771ca19-1c55-4594-60a6-08dcfa6a43bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXJxWi9udEJGVFp5a0loTk4wUWtxS20xcHJGVzZvY0dsVHozWi9EOWxMbHhx?=
 =?utf-8?B?MjN4S20xSjFpc2psekNDWU5BK1lxYnpmSXQ2TVBpdHU1MmhLQ1FmYW1xSWtr?=
 =?utf-8?B?eHdmN0lheXhYWlpxTnRvYnpITDVpcDRkMmxtVWxRT1V6b1BIbFJtMWg4SG1O?=
 =?utf-8?B?T1RSYXJIWWZ1YzR5K25lOXg4U2xDdXViRmI5bE4yUXZucGk4L0EyMU1HOUln?=
 =?utf-8?B?Nk5FME05S1VTR1VoY2JrV2xXenQrTGdTTlNqNTlOZ0FvUXdKenUrbm1YWTRD?=
 =?utf-8?B?V2Y5d211TGU1TmVYd1ExOGt1S0dPREtkS3RNYzZFanMyOThHaXd5QjlkaGxw?=
 =?utf-8?B?T0NkU1pFVW9pSlJEaGR6U0xkeHRVVk9EQ3pCejRFNEpPdDFJZkdsaXNmSjRk?=
 =?utf-8?B?c2xDaC9rczd0WmxwdTZ4aEZPcktwL1lLRXd2OW1Rc0pCVGNtN3dSeG1hZUlF?=
 =?utf-8?B?WlY0ZmlBVnNkQVl2SW1iWGZUZ21xN1p2eVAwc2dRWnFhcTh2MVhnaWZnU0R6?=
 =?utf-8?B?SktwNGFkcUNxYUpnSjZVbFdOTzhWMlN3MjR1YUZaV1krS0RoMnBpdVo3VzRN?=
 =?utf-8?B?ZnlTWkxoN0dyRDNaZjI3akNpZXAyOWxZbXAzYm56OW41NnVxaCs3bXlKdTZX?=
 =?utf-8?B?bGE5TzVHRzBsZ2RMR01WT0xocXRIc1p0S2l0R1poaC96TDVZVzlDR3oxYjRD?=
 =?utf-8?B?TTM3VWpub29EMnZGZEQ0U1YwVFIvRGhrYXNaSmtiOTNZdXNoTlFKMjgxTWpZ?=
 =?utf-8?B?aWVGN0JKNjlFb0MwQlB5NlN6WVFaWkd1NVZHeXhzekVGbEFYbGswRXBRNWVN?=
 =?utf-8?B?b2g3UU5mT3dPWGFQaWFzSHZCY3dUemlFWUo1OEd4T09IVnZtb29qQTNnNVd0?=
 =?utf-8?B?NGZXY1I4MUd3TE5jYVdWTCtFZDAxWWZPeVdqVzM0SEZWU0p1WHYxdEZuUnEr?=
 =?utf-8?B?b1hFcU9tRWlnNStHRnJ6MXJ2cWhoTWxGNmFRVHd4RTNxR056WTVWZ3E2RURy?=
 =?utf-8?B?R2pTMGUxVzdBaGk5QngvSUZyWEVTMmhRckJMSHVGM3lKOFV1YTkwYlBZQlBQ?=
 =?utf-8?B?Yjdjd1VWRzg0UGxuTkhsWThqdFdsZU9nQTBxK1UzelFhRkFrQXJTZThyRUl4?=
 =?utf-8?B?WnJqc05hSHpIUlhSckJsWEtSVGtzZjFmQjRqYkt1OUlwcFcra0p1eTJFWE42?=
 =?utf-8?B?L3JDWVpnaWtmWWNsV1c2dER5dHFwQlludkJnZlkyUlVnVlBTRGtVK1VzcFVH?=
 =?utf-8?B?N0kxbVZySHNXdXFzN3Vsd2h6Q1dxQ1NrbDV6WXZrT25QQjZCTGRabnNLNmRu?=
 =?utf-8?B?UHNjSkswY1FvOEpvNkxyY0M4UEY3aUxOMzU2bmwxaWFuSENXSWxuZ2VvMmpw?=
 =?utf-8?B?b0liZWJ5ZHduUHdwVCtMbW9rMHhmdFpCTXZBbzlGaWRrUUwvUWxQMlBsMFk1?=
 =?utf-8?B?eXl2Q0tiRlBnOWQzQ2xrcU9yMEZhZFhDRFdPTjBHZVdJVXI5SDIxci9MSHgz?=
 =?utf-8?B?U2VNRk93WWR2ZzYybnRiRjRWK3JtWWl2eExuSHJIMmpFa2RFUXFCekJYZHFG?=
 =?utf-8?B?dTBUYzhweWJYWWxjNWNocHZEaW85WjNhWk1RYVZNNjJIT0JrNExYWHdZZllO?=
 =?utf-8?B?dUMvdlkwemFqOVB0U0tScTVRazIxcmJvUHUyZWhqbUhiVEIrYWNYSmtBRk90?=
 =?utf-8?B?d0NqdFNuZWVNUFdkanc0QzdqY0QxWWNVWjhzMEdJdUJTM2VHcUREaXYzWnVU?=
 =?utf-8?B?Wm52Q3VjUHN0NmdkeTloUGI5WlBBMWJIZWVGR3hMZUNnSWtmY0hwZzgvTnRl?=
 =?utf-8?Q?D80txqtts6ngCs7J7TQOq6NWObz5ilSRy0hNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDJYekFlekhTUTNoTENKVzBBa3A0WldTWUoxMkFWcE1hbHdXejMzVEJvdVVL?=
 =?utf-8?B?U0lST3Boc1BoSGN0VlZXMEtsMnRSWWlhVHJlTTdMSlpEOFhCdkFDQ1FaVG1t?=
 =?utf-8?B?di9wcGMzRTdQd0RPSEtYQ2JnZzErTlZrenlKcGNPSjh6THNIMlBpdy9xZTdE?=
 =?utf-8?B?TzA5SmwwRjBXWmllK040elZlWjBxQXVscDF1eG5YbmsvUFBhQUdNOTZQaGxR?=
 =?utf-8?B?TWw2Zk1VVXVzVnlUTmpLTWRnREh2VUZUQmc1d3lPTTZVcWtKTHJNTTZPOXd1?=
 =?utf-8?B?OVREOGxUdERkakNiZmtNZHphWXNmdytUTmhlUnpMSkF3a2NPcENjWnVtZWEw?=
 =?utf-8?B?dWwzUXBIVkNxSExZcWI2cm9Vdnh6NlNvUm5lY2VLRGU0dWNYZ213bFJybEQv?=
 =?utf-8?B?M2Vxejl2cWY3ZXNmVHREam1sbS83OU5DcTdrVEkxNVBtbThCSkpiSld2bFNE?=
 =?utf-8?B?N0JleHppQXJha2svRThRZUMxVmJwcjhaenhiTDQzUmhtWEVkSGhreEpMMWFp?=
 =?utf-8?B?MnJENy9kV2IxdWxJZHdRK3J1VExqTlJnUlhxYllGM1lLSlBxSTVNbC9PRUhw?=
 =?utf-8?B?MlZDNi9xb3Z2N2FtakJseFVNVERCL3Y2OWtVekZzVXFKTGdmSlBkZGs5Zklj?=
 =?utf-8?B?VzdpZlRJOWgvVW9LdEF3RWs5UUkzeXFRaTZuS3pqNGZ0MFlqYnFCclM5dmVO?=
 =?utf-8?B?YlA2cnB4b0FabG1GbzZyYXNjQ01ldEJ5TlpWV1RMbGZBdzN5cUREODA5cTU4?=
 =?utf-8?B?bm5XTHgrT0l2WXlaRHBaK1YwNnJBS1lMSllWZEh6MHlyMVlzZHJGenFCWEsz?=
 =?utf-8?B?L0I0RVNYbzBMUW1QOTkwZ3VWY3Zhb0IzRHFlTW5IZWpPd2JtTHdtSXRHRE1J?=
 =?utf-8?B?YVhwbTJ4ajRPeFVXdUg1SC9LMUczbVd6YzJQYW9jRHVzU2FWT3pJU0tDWlFl?=
 =?utf-8?B?aCtSVzRObC9JRlNFTTRxcWRHTXZ3YXAydlhtNDJYZTNRU0ZSYmJ4ZThwUTd2?=
 =?utf-8?B?TkYwR0krVXM5NlI5SS9JemlLTkNEamg2WWpjcmFRbjczR2xLUEpiU3l4Y1Ni?=
 =?utf-8?B?ak5Tb3ptZXR1ZXNabTg1VDJDQlMzVFN5ZDhIQVhqaWJzb01oa3JtVXFMWEhx?=
 =?utf-8?B?N1J0TmdIQ2hHSVRQRml6ODhrYlAyQ2IzZjAxSlVFN1UzUXZTYVIrSGRJU3Zw?=
 =?utf-8?B?SE52ZVNpd0dSQWN5S0pPL0xMYU5Ic3dCT3dRaEtTQXNSdzRBNVBsY2ErUG1Z?=
 =?utf-8?B?M2FRaHdJckliQWFmQ1ZVdTM1cVdjZ3VrU0NsY2FtT3BDK3Irb1Y1Q3N3T1B0?=
 =?utf-8?B?TnU0M29rYjc4TkpKWitVM24xVXhYblR3R2xvbTRiWm1ha0ZkSnlSbFlUNDkw?=
 =?utf-8?B?SmdZeFRzYlM3dEMwNHZJaFN0TE1MczJMVjJtZ0xKaTJ0TXVncUtRK010VGoy?=
 =?utf-8?B?YSszS0Y4VDNQb0Q3WTZiZFAwcE5DcVFsM1dPdVhsdEY0NE5EL0ZxUFNTKzhV?=
 =?utf-8?B?NU1SakFvNzFuN2hHcnZpZzRaM1N1VFpvTEhDM3VJWGlRUWVYaFR2STdwUFpU?=
 =?utf-8?B?ZmdkQkZEVmJCRytDNUw5ai9ZNDJuR1pEUHA1c0l0cDhQQktwY1NKcTRhVzlj?=
 =?utf-8?B?dG0xV2xJVkIyZkZVb0JmTFB1ZUZiM1F4K2dMRGx3Qkh6UHRUT3VuY3daQm5K?=
 =?utf-8?B?WjVzeHE3dlRIaE9Zb0orQ0J1dnJMTFJta3FMNzBVY1VHLy9uZjFLczVwdG9x?=
 =?utf-8?B?T2JoR1ZVOTU5QzdzclN2a09LZmpVcUxhcnZnWWdPVm5nN0U5RFNlYnBWMVNy?=
 =?utf-8?B?NlRWQlFVNXp6M29qVGNoNU1hZERRakE4Kzl1bzNzSEwyRWUxV2JOenBISHFj?=
 =?utf-8?B?QXkrekIra1NVcWRiRUxoVmk4QXpwc0JzaUFWeDNuSEljSHYrNDljMEp1TUFM?=
 =?utf-8?B?TkNwYk5URmNvdEJQdU9rdTB2K2JIaU1wT2xoWnpyNXFWNklXMXBweTBnRmVV?=
 =?utf-8?B?czhJd3kyamhITWdNbUJ4RlJrcDFFcUQ0cXVXUEE4eUFzekk1ODBidS95ajlX?=
 =?utf-8?B?Wm1GRVg3RjJ1azdVRUtxbGkrc3ZTM1d6NHNmemIreXlkUU5FdFF4WFMyQTIw?=
 =?utf-8?Q?6KL0Jd+weaCtlziymRanb5Eqo?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7771ca19-1c55-4594-60a6-08dcfa6a43bd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:42:29.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/iSfmaj0yCVt3JDmODgswWZipX98QWa/lrXkDsJNgXDj3F3MANTaW57nL1OxENNNm+wDUCWuuLyd7Kca1Jzmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10519

NXP ESDHC supports control of native emmc reset signal when pinmux is
set accordingly, using uSDHCx_SYS_CTRL register IPP_RST_N bit.
Documentation is available in NXP i.MX6Q Reference Manual.

Implement the hw_reset function in sdhci_ops asserting reset for at
least 1us and waiting at least 200us after deassertion.
Lower bounds are based on:
JEDEC Standard No. 84-B51, 6.15.10 H/W Reset Operation, page 159.
Upper bounds are chosen allowing flexibility to the scheduler.

Tested on SolidRun i.MX8DXL SoM with a scope, and confirmed that eMMC is
still accessible after boot:
- eMMC extcsd has RST_N_FUNCTION=0x01
- sdhc node has cap-mmc-hw-reset
- pinmux set for EMMC0_RESET_B
- Linux v5.15

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0402fd2a0695903cf261a5b4e19dc..f106e291c276d0c8063e9ac59a126acf5e9e239e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,7 @@
 #include "cqhci.h"
 
 #define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
+#define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
 /* VENDOR SPEC register */
@@ -1402,6 +1403,17 @@ static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
+static void esdhc_hw_reset(struct sdhci_host *host)
+{
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N, 0, ESDHC_SYSTEM_CONTROL);
+	/* eMMC spec requires minimum 1us, here delay between 1-10us */
+	usleep_range(1, 10);
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N,
+			ESDHC_SYS_CTRL_IPP_RST_N, ESDHC_SYSTEM_CONTROL);
+	/* eMMC spec requires minimum 200us, here delay between 200-300us */
+	usleep_range(200, 300);
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -1420,6 +1432,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.reset = esdhc_reset,
 	.irq = esdhc_cqhci_irq,
 	.dump_vendor_regs = esdhc_dump_debug_regs,
+	.hw_reset = esdhc_hw_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {

-- 
2.43.0

