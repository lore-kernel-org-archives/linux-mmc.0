Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200017573;
	Tue, 11 Jun 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121747; cv=fail; b=k8yUyP9VfY/qX0s0mdy81TDjHVsOQLEwu7JTDN7dAh3X8KHIvUFSuwuS2k5LKpmM/QwJksIg43T0vXkUa9VsaQXcSJgfzMH5gUG5VK6up0sTKavlFziEbEDFTPX93RB3cXRQuBS2lbWVCEWrvJEyB8h420Y+btblmcbtVyTNzmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121747; c=relaxed/simple;
	bh=5dX6n2/7tQD1IvcrjFPR/z7msGkfgduYI8XE2ZgayOk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IbesQNze2Bhoe34c8oU5icsMfVEXJ1IbsEy+VC9YBlSqiMcg3K7VMzFG0UHI5tJuR3nj92amO/g0xdkX6o2RA4Hq7ubIfISIozbOkZwbPRrf1VkDns37ZbH/YIE5EUv+92yKITGUJVMgi5tzNsmUeTM43QfBJyTmDNkLMxO8LcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F+bW43IZ; arc=fail smtp.client-ip=40.107.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F+bW43IZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwG2xkKU0osu/UeJiF5K9twrPoG/DOkZW62BUjtLMAaKbb3fySYz95KlVVKRCOBcHRznJT49bNbYpyQ/igHNONRYT7uTfkmD0L0yVjMX8cGvEmS6FyNyKEWuSHemVvRGvUV012ZONUsUOAVvS9FEi5LG651meZ8H6ikK4UAmBK+Wrmd6f/1/FK+fzdV2w6I4Ruw9A/tk/CUi3JQTN9jBxKHXSwX7JJ/ofJxbou8nMh24+3QuecdqtgbvfIQU6Bcfe5bAjpsFHyUoiVSj7HkLajm8zrPPeNeJATMgo8hO3Ne94fP7EwMyFvsArrYPgpQUB9VOajXq53HQ3UjR8yMI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz9NhjNbXXabUEF0wPX41oKciy7IIyz/I4hN1/9Gruc=;
 b=dnKSnCa0sHRGuRkNpOKNCRQgmA9Qiv3VDLReWcFMbMsuGDCez1NuDojhXgshzKMyJeIUv9vapp0HJJugEd/A00MQAybUIQadmFygUqFBSZUFje2okNbeyoCWcLkd7IAXBGkDinBlhLhmsPpdx8dk9QsmPv4qBXpi3LWaKmVVCey73/bmCgM4StxmEoYBS61i3WSb6L1jYTnQ+hNLbZ40cV7V6b50Nqu68pQ1H8TuDfOaHf/tmsl6gGdiRZPVa98h/KH21iM3NC6rXZgDD7fTii+z68JiNUT6STrOoP8bhpPYN+lCVRqVzFObbG4OIeeT0Y+CKlxX/DD1sAznWC1Hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz9NhjNbXXabUEF0wPX41oKciy7IIyz/I4hN1/9Gruc=;
 b=F+bW43IZppXqag+145RfR9um5O3JLZDLx/xgxz2m6FTbLpT4eWqtSFfD2EaEN160K/pie/4WqKkVo3ZAnTT/HO3vR3t/vhlcV2E2MERtt7bgcMG3O620Fz0QwPinBx7+aRFuBAUlqbnHQLLYjeboKta2ffq3bIrEOrQDyGM6mL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10287.eurprd04.prod.outlook.com (2603:10a6:800:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/8] arm64: dts: convert fsl,esdhc.txt to yaml and fix
 layerscape dts warning
Date: Tue, 11 Jun 2024 12:01:45 -0400
Message-Id: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOl0aGYC/x3MQQqAIBBA0avIrBO0rLCrRIjklANh4UAF0d2Tl
 m/x/wOMmZBhEA9kPIlpTwWmEjBHn1aUFIqhVrVRnVZyY3f5TGl1yCHO0ja66XwbQm8NlOrIuND
 9H8fpfT8j7hsvYQAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121738; l=1744;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5dX6n2/7tQD1IvcrjFPR/z7msGkfgduYI8XE2ZgayOk=;
 b=lQZz5kUY55711rRSbUmAOHkubW7xBPpt6ePPO4mm6NHr6oCkSqg/1Eh4HQVFLdXnKS3Vzh3tq
 Vlm+xH02f/xD5XqA2b3swbhw7Nv7n9y1O8LH3zY7Wf6PIPqVQ63LqQN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10287:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f2949d-eebf-449f-1f7d-08dc8a2fe0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajB0dndXK0hEQzRCMkE2UVdjVUVwa1dWR1A1MmhidXkxMXlwbFpSYjloN0FD?=
 =?utf-8?B?c3NDSFNNaWVJL3dpODdxSTljQkwxMXhDQlhQNGZ6ZnJEaGxRWUxJQ1QyYkFh?=
 =?utf-8?B?ZytBUkw1VCtMMUxtbmZHb2tYNzFITDFtT3RIWGhIOEQ4bEJEZWhHLzhtUVAv?=
 =?utf-8?B?TDJpSnk0RlhseURRUzFRYi9DazlGZEw3cVNRUWxOdmRaUWN0bTdMbVJTZEFu?=
 =?utf-8?B?cFZPWUJnN0JsQ3pSdERjMHhQWjR3cXkxQno5ajRRRXNWZEVuZWlVaHJ1UGhE?=
 =?utf-8?B?UUdMdk1kUWNTci9vcVdQbTJGRmdDUzQvZ0J2TjhBSXFObU92TWV4WTh4cXY2?=
 =?utf-8?B?TEZmVWZZL1Z4L3ZLN3R6Z0lTZml4YTcyeFVxQ0pQZFo0MkJJSTZac2theUJL?=
 =?utf-8?B?bDdSWmdtcHZMRmI4TXh5bGs3WGJmMVgvVVBCN1gvSkF1OTVCeXlYYVI2TmtB?=
 =?utf-8?B?NEVsUlBsb2JoSCswY1VhaGhySHhzaW5mRjJUQmtmVm5BMW1ReFJwclJEUnNZ?=
 =?utf-8?B?S0Zma3dueStJc2ZEdFRKYU84QUNzQ1YzQkc4VjlkS0JHQlFFVUxGMGlOVXNw?=
 =?utf-8?B?U0dUZ0xoYityN2I4VjZWalFGVUR0RVlkWXdYbktWcWlOeHpBZUd0dU82T0ds?=
 =?utf-8?B?OFBKQzZiRnRoWjlUTmltOURHbGljaXR0cEwzeXR2aUZnNFV4WmNqQjE5UEpE?=
 =?utf-8?B?Q1IxbVBCd1YxYnNybnN2ZWtJY1VuWXYyWnlzMWdEUlJrNWU4eHJYR1h2WVN5?=
 =?utf-8?B?ZGZkd1pWU1Z6cE9IMkdaM3c4WElwZGIvTUlCVi9aVmF0K0Z4R1BtaTFYZVlB?=
 =?utf-8?B?N2xycWNmblVDTk9RclVWUTVQZU82QUpSekdCbGRoejI4Ry9JRlJlQkYydjls?=
 =?utf-8?B?TkFhZXZmb0FlSko5UUU3STBVN09tSldmSW4yb0tvWEVtcnZQVEN6c0ZNcFpp?=
 =?utf-8?B?a0tBbFpQT3l4d0Z0b3NVR0JVTVd5ZVUyTFRNek5Wc1BuajJQeFBxcS9aeGw3?=
 =?utf-8?B?am1qSHZhZjFpSXdmaUpBWEhjdlhOVXNPM25xYnkySko4bEZUbkNMU0FSeXky?=
 =?utf-8?B?cGNnSlBveGNtT2xRN2IyVk1WcS96c3U3OW5iV2E0d3J4T0JkQ0ZHUjZJUTRp?=
 =?utf-8?B?M2Jhd2pjQjhNc05ub2Zrbk5RUjF1YTcyaVhsWDVPTnBkUGwwb2tmMEJiVGVC?=
 =?utf-8?B?Q01IRUN2bTJyNEltTVhlWGo5U2NpQTRzMGI2eVFQMGZjVWpqcjJNQW9ERGU5?=
 =?utf-8?B?UHJTcHhrNysvU0R2K2g0eEZrOVUrd1krUUxiZU9tTnpBTXEyT0FZYVdFd3Uw?=
 =?utf-8?B?WDNrYWo1OERrUi96Z1pqdzBTczZ3eDYxQjUxT3pyV2FHYjZqSENkRGJHb29a?=
 =?utf-8?B?V3VjQUJUbXZseTNia2txWkEremRaRWVvdXdWN21rTDc3ZWRLa0s3VGVPVENq?=
 =?utf-8?B?amJqcUM1Z3JxLzVaZEp2OUx0bmR5SEpaVXg2aE5oaUlTK1JFZ3VsWlk4N2pM?=
 =?utf-8?B?NDV2MFU2WnBhNWxGNC9YR1Y3dUxQWTVlWmpUWkx3SkdXeFpnTVF1Y2NhUzJK?=
 =?utf-8?B?a0dUTkwzZXNrT3RENnNUN2pPT2JvVWJkbFkxUFN4d3FoaGpVU3ljWE9JSm5W?=
 =?utf-8?B?SStBZFRzYllEY253ZVFhYXRPY2dHUVZLTC9xTkpLclBqVTlScXJNTmIvUU53?=
 =?utf-8?B?YWRxTTNTcE9VTnZPcXQ3WU9RQ2dWMllVVkdaS2pNU1MvT3JIdnI4U2Voc1ls?=
 =?utf-8?B?M2d2YmdOaWx2QXZMbi9ZUFZxQXFvb1lrbUszZTRwcnN1bDlqTVhVekJHSmhE?=
 =?utf-8?Q?pf2YORoVP4c2vAJi15e6yLCs+farihng2bJGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG1NYlBCc0hjRFRZYlZWS0YySXVFT0twakhUMjFOUXpXWFB3NURsWUdJTnFx?=
 =?utf-8?B?dGNacEFKOXpoMGZrOXZVWm5jR2Q1bmo0WkVjai8vVXNVdnZVTHpINm5FUWZ4?=
 =?utf-8?B?NStzT2RPaWtlQkJJaEwrdlRSZlpsbDFPVmx1TVY4M2gzTUhrdGUzWjI1clk4?=
 =?utf-8?B?ZGlYd29lUnB6QjNPajhHNUVMMERCQ25ybHRneFZ6RkZTZ3JIOW1NU2NXem5N?=
 =?utf-8?B?T0JJM3UrcGdxTjJHdkpFaW5LVmI0dHJmYnVScmRaYSt1MWl1Ry9hWkJhRTI2?=
 =?utf-8?B?Ylh4Z0pZbzJCSVA1TXBuMmpaN2ZMWnRvZ0tCb2FqdXFidFZENWRaQysvTFFE?=
 =?utf-8?B?N1RBekppbHpJVDM4Z1NLK2VSeVVLR3lZcUpZKzV2cG1FcGxZK3RrQkkzM2Ju?=
 =?utf-8?B?cE05Ym9FU0FMdmtGYlBiZDg2Z1NFUzZOYTQrMWVNOUg3THFIbVRrNkptRk1i?=
 =?utf-8?B?K1ZnY2Y0NEV6VlZKTHJWMGJ0UldOdi9aL3pKcEtMSm93QS9mYUhVWHA0WGNC?=
 =?utf-8?B?TmZqU0hsYU1MUzE0UzZOM1pzUnZmQmp0d3Q5VmZEaEh0MHA1R1hCaWpKeHFw?=
 =?utf-8?B?UlpXUG5ZZ0FBRW94WllrZVkzaFhJaXQrY2FwR1ZQMHViWEFLczBtOG9NWnZV?=
 =?utf-8?B?U1NRQ3F2bXdwS2pVWlRLWlFiNjJVUk5ieWdmWjFLU2ZSaVl2QzM3M1YyYWZj?=
 =?utf-8?B?bkFpMGhuQVZGKzJKRkVwUlYzZnF5NVNoZS9oRzdNM01VOXRubHRBYmVCdTNE?=
 =?utf-8?B?VGtIblFPWW9kUlNsSnRmdnp6cXFuWElUVmFMR01uL1ZIMEtVbnArcGg1cVcz?=
 =?utf-8?B?RjFmYXQ5TG91aWJzSkhlMWVLV2dRdXNwZndXcTNBMCtKRDFUSy94WEtpVFVh?=
 =?utf-8?B?Qld4dmp6a1FuTDNYSW56YjNCTHVZZEJHelFXblRralRUVUp0cm1vbDNVaW1W?=
 =?utf-8?B?N3J1Y01JMTdoYTV0OVBHUkw1K2hBaDlia3R3MUI5aERPTFYxTHhEd2RjWGt6?=
 =?utf-8?B?K2x4STh2MnZLa0tuR1BoeVAyd0tHMHZNNjBhek1Jbm1NbE15WGJRWTNaS0o3?=
 =?utf-8?B?RlBSUWZ4eDFEaXYremg5OEUrMGlNd0JseHNrc0VhOGRjamk4TXYvNFVhMWls?=
 =?utf-8?B?cFJiRUtxMmFqeUFIVS90YnA3blBHdDlPNk1uNWxta01FL3EyMVlQSXFGZkVs?=
 =?utf-8?B?bzR6UTVDSWdRcVdTazJQS09nM2p0RThxZWVoVHNOOGlaRDArZndOdGlsbHhR?=
 =?utf-8?B?a2hTdGtqampOSUpKTU9JM2RyMFA5RzdOL20zVjNuci9DWlRJOG1XWk9haHFI?=
 =?utf-8?B?UC84L2pmNktoa1diZlhsVFdQK0M1UlArVEp3bkpDdHE5L3FxdDZJejlDV2JP?=
 =?utf-8?B?V1lzZ3QwNTJOVHZPMDVZM09mLzNxbWRaRSs5VlpJQkUrTzFyWFlMSXNCNHpC?=
 =?utf-8?B?Q3NNSDIremJEZEswYmdJcmc1LzlwRFg2NlBZNzRJU1BKWlpEVHJBSW5xQ1Fv?=
 =?utf-8?B?MlpWVFdYM0dNK2JqTE9sSi9xR21Gc0drOHhWZ29LcGk1K0U1Nm5EU3ZWSnJ1?=
 =?utf-8?B?WE02cytiUTExSzZDd3h0TUNIUWYwWXQ2a3BzRHNhaG5oL1VNMWRMTXg4WVVs?=
 =?utf-8?B?c0UxNWlLNjI4K08rSUhkVVJ3ekpFekQ3NnY0UnFmWUNUMEFFRnM5ZnNUSG1t?=
 =?utf-8?B?c1krZFVnZXNtSFRkU2NUS0ZqZElnSnkrSUN0dnZVSHRWMkUzMWdYbHdLeVMv?=
 =?utf-8?B?ZERZM2IxL3NFZE5RU1JVMTRQdk83c1FUbE1UU2VBdVRZQS80TkM4NWwvOVlH?=
 =?utf-8?B?N3IxN2YrbzcwMllXUnlpZDFHbmZmcG9VUjlDNjBVTFM4WWZaSU1sUnNHbDhF?=
 =?utf-8?B?RTRNZEd6UjdJekNhYTFEMldiNFBGbmcwUk9MQXd1SGdDaUZIR0tGY0RLdGtD?=
 =?utf-8?B?aFBWMGQ3TitaczhQRUt0SWMzMHlnVWN6L3ZCbUlBNGtWSDhhYXVZS20ycTFR?=
 =?utf-8?B?OEl5dU1JdHFzRUhXMEdTVEY4dUlORzFYMDkrbWVRQjY0YXpVc2kzclJoaURX?=
 =?utf-8?B?U292T3BXd1VxdnlGdElJb05qb3BZT3dyKysxY043S1hnMG5qbjA5bjFnSG5P?=
 =?utf-8?Q?Gx1WRc8Qu9hVseA6h14z88O/g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f2949d-eebf-449f-1f7d-08dc8a2fe0b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:21.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5KLDeK+qyfuq+TaB6+9kPWQ3UpYktjq0ma8qylj1zWAp3105MJpDo7FF0+dEOSjx2X/tgaeaE9u4sLliQ/Sgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10287

Start from v4 because fsl.esdhc.txt to yaml already sent out as v3.

Change from v3 to v4
- Add dts warning fixes
- Add mmc-spi-slot's voltage range fix, (not sure why it apply to
layserscape's dts file.
- clock-frequency is not required property
- add dma-conherence: true in binding doc

Now only "bit-endian" proptery warning left.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (8):
      dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
      dt-bindings: mmc: mmc-spi-slot: Change voltage-ranges to uint32-matrix
      arm64: dts: ls1012a: Chang node name from 'esdhc' to 'mmc'
      arm64: dts: ls1043a: Chang node name from 'esdhc' to 'mmc'
      arm64: dts: ls1046a: Chang node name from 'esdhc' to 'mmc'
      arm64: dts: ls1088a: Chang node name from 'esdhc' to 'mmc'
      arm64: dts: ls208ax: Chang node name from 'esdhc' to 'mmc'
      arm64: dts: lx2160a: Chang node name from 'esdhc' to 'mmc'

 .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 +++++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 ----------
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |  17 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   8 +-
 9 files changed, 125 insertions(+), 69 deletions(-)
---
base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
change-id: 20240610-ls_waring_esdhc-93136a5dd794

Best regards,
---
Frank Li <Frank.Li@nxp.com>

