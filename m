Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68D3FBA4;
	Tue, 11 Jun 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121755; cv=fail; b=KJQlN6HuK5SGpfvtJgx8JJpVRc9HquQySqvMTNoo4983eUrzNvVi6/M1bzGJPML9kTNWffASp14oGoBfANp/YFwtKulwApJ+jkDsnWj4NAAPJgMFQcRHXsvnOHQ0OOUBDc6qeIG8r2oX5/0chwRFFq9ECwU9bYTGQ6AMg20NDDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121755; c=relaxed/simple;
	bh=/fCmcbr+BjSaSyDjYlgwEEMrtlx/F5xeg961tSf5sbA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Dov/Sw63tYqt6KPVutdhQyRryRqhqrBdOlG+lGq6PjjhhjRUhawIbzRzuHMpD4pym7iZDPocTYZrSp5DYwaJq5MGYslPSLCPkkAIr0xWOVXOFNQrJz8LoPHiLezqkNwj33QQopta6ZBhSNaPMqA6WcjVkTT61J8Z+SYhqN8fWz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XkPNl2Nk; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkPNl2Nk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY1ZdMB2wHlKgfDRagX6kB+bRUrfF6lh9oXyHuQaDPQ/uqMZAMNrrznaqx3/f+aIDTJj7unhsSF0IZzX+6iTuGgAn09UZToTep1fAbNVWk0RQT2JHf1UM3NDjE/k73AVNFtbqBE8Grl9gJsrH6H31WPnzC9DtU/pTHC3XcrpGHexltnCwfE+6CKmzHhMiPZR1oBlgKR6bVhRL7Hq/5THdN51783sF85tE5mnCv/fUBBAwPRhfpcEugJpRc/5pNXyMw6E7T/obiMGpu1vYS1zOf88hvrYc8ExFKE495y2XaOGRsPN6gV9NqhUhX8m8LoM5sK0Gth83ZRl4zhMDZYpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIUny4AR6pTgzAZNLysWaKzbSNDVdKLGimNusW/DDEc=;
 b=aDtUj/dZrE0H0sIyIYpBYxg4aiiA+PQm3r9pQhzVoqRn8Huao5kYLKVoKSHEnzDYAx5vQQ2Q7d0lnR16M2bzp1JtVug6lUT8j7t6kzC1qFBbmJnJjXfh5uMI9Q9paOwj26xAhaXEc2CnibT6ff1UfvY5cXinlJncHs4+kjOYd7Jk7NplGHDbnH5IAdrCPR66FKoXmOL913spEdHxRzbdDHgwPXJQffNY/MuS4Mgbbl1YirepUQf8qn9iygDxz6h13vSaKsSeZ1N2a6IfCG/QAQ7DNC46gLLnx8TQr4UHUKQIRkSJGd3ETIkeOQkz6a4OFCuXLeoYb4aiuS3970uJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIUny4AR6pTgzAZNLysWaKzbSNDVdKLGimNusW/DDEc=;
 b=XkPNl2Nk6EK4OMLzj4q3SBObMssi+ZALpmenzStK3h8UP/QOwScNSIjAS8yTiKnwJ4lCRq8ZmFSXkUdI2HHnMh/NI4YRKu0yP7CtTPtZsmWZuEZM6ZmQErmJGdE8S7P+EUQKfDTt8ybYztkV1mfT4SJ7EDDkZbb5uR4IvujlPgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:48 -0400
Subject: [PATCH v4 3/8] arm64: dts: ls1012a: Chang node name from 'esdhc'
 to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-3-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121738; l=1189;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/fCmcbr+BjSaSyDjYlgwEEMrtlx/F5xeg961tSf5sbA=;
 b=IUygTDZCecU9PezKfpUfyhcR9AKmykuGLaiBZvTxtwivrcd26mUc6ew2MLZPy310mIW11RR9v
 MRpDlPBL24jDRY7ZdAWLDEQAxZcNe6B2JOn1atgk/MloTZIZQNWvmaU
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ed83fc-0d53-4feb-29cd-08dc8a2fe63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9vdHdzdzQyc1lqR1d4VHBWMC8ra3R4R2FyUzZBL2tNTkVjVkNsVzZzUUhz?=
 =?utf-8?B?N1lOeWtUdlQrYnArMGxXUlU1ay9iNWVTdkdwdGh6OThyamRBNUxqMElQWnE2?=
 =?utf-8?B?Qmd0cSt0SnJDcjlvVjlQWTY4VkpwUUVCVmhDTUkxcFl6b09LN2VkRWVCNWlx?=
 =?utf-8?B?d0doT0pLWEhGNko5bXdBdEtkTHk1NnpDK3VZRnYzSFFaZnlsdjJRT0NFa0Vx?=
 =?utf-8?B?RDE1L3E1bXFubEVlMmVFUUVTNjc3OU45RHBhMm5kS25kTE43cjR2NmRpUGtk?=
 =?utf-8?B?RFZ6bWxMbTJTeGl5OHhIMk0zZW5GdHQwbXIyRzUzSTBPekhmQUNOUzJQSzFU?=
 =?utf-8?B?Z1NNTUIzMXZKSDl1R2FWSmF3OTVabmVZdUc4K3p3NERnNllMSE84ZWpKK0wr?=
 =?utf-8?B?ZHBTVHBFMkxic0lnV2FadlZ5SHNRNHkxVVFiSC9rNUNJY2s5blBMVzRMaGNj?=
 =?utf-8?B?bndNb3hUWWpIRDlwaVhKUWRCckhTOEg4S0dQQ1NzRnhaWnpJdXRuUlVlVWYv?=
 =?utf-8?B?eWFyVk1rSWdmRENjaVBDQktmdk9xUTE2eTBwZFhoTktVcm9tZzVCTkNCTk16?=
 =?utf-8?B?QmN0cWRqSGEwYnB6RzhBcGVqNUVGb2VnSDNTRW9HdlU1ejRpQnFzODZTWlA4?=
 =?utf-8?B?WXVLSlpFMTZKZUJKRFFTQUlyU29XRFVCc0EvaVI4UkhPSEFIWGVhN0FJSExn?=
 =?utf-8?B?UW5HckZUVUJvWk43ZE1RYVgvNVNRcG85d2svcXQvcmJNNHZYeTBYY3JxT2dW?=
 =?utf-8?B?Z0FGTnVvNzVUc0VyTGd4MjFJa3NRQThrMER5ZmVjaDg3ZVBNL0UvNzlkYUFW?=
 =?utf-8?B?S2JLdjVxUDNEMzR2Y1JPR1hLYUFlNVVwMDlxTzdCTG93NnB5M0dlZE9KbWFk?=
 =?utf-8?B?L3VsQWpVZHhwUEVnb2VEOGNZVUwvWGQ1MTlpK3ZuR1VIa1U4ZUIweGM4RElW?=
 =?utf-8?B?eUxsaWxrZUIzV0tyVG9PNlBmdUphNVY2VjhCdU1vdUMzRzk5d2tCQ2s3S1Aw?=
 =?utf-8?B?UkJpV2I3QVkyVG9pZzdKUStEOVN1VjJLeUhZQXJrWVMvWEVXTFNvZDV0NWdT?=
 =?utf-8?B?YnJLUFcwb25FZ3NZQU1JREpBMmJIQUJRSmRGSXZyYnRISytnU3o4ZEdmODBD?=
 =?utf-8?B?bDFGTnFIUHdGeXBjRXN0cTNFTTRVbCt3VEFwaXhHa0hIMG56c0s3N3JxdXZh?=
 =?utf-8?B?L3FFeXd4RmsyeWl5RDc2YnVLZ1V5WS9wU20xeFRxNWd5Y2srTC9EWGczbDVs?=
 =?utf-8?B?ZDErSVFsU3NSYW5HOTRtUlYyTDNqRHNFTk1SdnVJeGoxWlJZOTJlMmhNcDFm?=
 =?utf-8?B?L0daYWZlLzIraEtTVGdaaGtlakI5Y0hYclk2d05saG00dklWVEUyM1FtUXZ0?=
 =?utf-8?B?Mkp4Q2RVVlFhL1JBNituUyt0WG9UY2JCblhVWDZXSVpEeHpqcytFemdzTUdS?=
 =?utf-8?B?VkpPb2grd09Ncnp1cGs0WmlBZ3owL2NqOGFYRm9PbTNLV0lOTGZmanJhKzg3?=
 =?utf-8?B?bUEvN0dYRWd1N2UvMWQ1UlJtL25selFjT3JVZ2xEYjMzazVtb01XVGFrQlhu?=
 =?utf-8?B?bHppNGFYYnQ4SjFrUjNBeW4ySndoQldBanVsT21XVmlXeExrY2l1amc1dzB2?=
 =?utf-8?B?MlFaUUFnbm5uaEVNQzNQU2djMlBVTERtclM1Nm5mKy9BVFJZSmo3SjIzbmJo?=
 =?utf-8?B?ZlR5bkJHYVQxcnVSWGdtYWlnTExKaG85TEw1R0c3dmhWWWZLWFNXMG92VVZJ?=
 =?utf-8?Q?HGHf1FTuSbD4aIo34gPbVr9+d4QiDZ+4H8eAYGU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzlEd2R0dm1QeXZ0N3BWNG9sOEFqRXdqSXdGTmROUjV1WGc5a04ySHBqMU1T?=
 =?utf-8?B?ZWd4a2xxMWlRWlRoWmZhTlEzL0pvNlVIaUJERHlMMWdXU1NZdW5ZYUM3ejE2?=
 =?utf-8?B?K0NUUHRHUDdhTWl5cG16S0liTGR4SEczZnMvL0ZJU2JLVWhoOU1XTTlPSHI1?=
 =?utf-8?B?RFN2Sjg4VEhiSE9UcjY4eHB2QStnTFpyTmY3dXlTdUFaSHJKdHZ2NUJzUGRL?=
 =?utf-8?B?ZE8zenNST1luUy9Oa2dDMGpIQ0JCRm5tdTV1SzlaSDU5NXNNZTNtUUJFWUpD?=
 =?utf-8?B?MFBUVmM1b1BqeVpaaGRjaGM4VWw4SGlMeHJhbHluUUlTUlBXK2NMb0gwVFFI?=
 =?utf-8?B?VEVnNjUvMWpiQy8wQzR5RDZaMjRjV0pBWDg5WDgreHZsR0xVcWJibEF1WlI0?=
 =?utf-8?B?RjZuWTRqSGs3MlM2YzdRemU1a000RnlLa053Ry9rQkJHNVZGdnprL0JHYmE5?=
 =?utf-8?B?M1N2a29DSGxCY3FvQStvTXhYQm12a2JFVXVoc1JHRmdMRExEYjBydURNRDcx?=
 =?utf-8?B?VDczcGRNcDJrYStlKzc4RUhESkpLZGp5bkVIUld4c2NnOEJBblk5K2orNEZj?=
 =?utf-8?B?VnJoelRXa2xIVFVnY0d5MTcxNmxkeDNHeU5Qdit3aWNHQjBDUkNPdGNYVXg3?=
 =?utf-8?B?cVFreEM1aFlPU0dhcWtxUStjTjF3U3BEeGtCQUovYzJJdGVaRTBYT0pid3pR?=
 =?utf-8?B?V3pYa0p0aDBZRFUzWXM2S1dVZ0xXcUY2aElHeUl6L05wSlJWY3BNVmRlVlI2?=
 =?utf-8?B?VW11UmlBNzN4cUtVOFduZWpxaFhlMWZXaHBBNWc5WktPNkszUXgwTFUzY0Rl?=
 =?utf-8?B?OFNteXo4bkxkVkN1emZKa0RVeVJpVDBVTUhsaUxsRnhkRE5LOFhmWnhITEV4?=
 =?utf-8?B?SHl0QUo1ZkxOZm80NmJuV254QXJReHlIMldKbzM1T2VUa2V4N0Rrc09OSHVo?=
 =?utf-8?B?bUMrRmRNNGRuS2xUcVRXcEJ2ZlFMVGt3NENIU2JoYW14WUVGTWRjcGNRcGZs?=
 =?utf-8?B?WmhOdExWSkpCaE85azNxT2lmbXJaUUJmRldPK0RXMkZiTFhFd3o0WnIwNFZv?=
 =?utf-8?B?S0hZQWoyRUpmVitGdkVqWEsvcjJ3djI3L3NNTlNmL3cyYWQwZDJSb1ZXTldv?=
 =?utf-8?B?WVFTZTlNSFRwYzBUMWxOeUFvU0REaDJHSmF0KzM5a3YxOXAwT1VJYWkvRmlV?=
 =?utf-8?B?eVQ1bkxWWmpKa3lKUFZrVGtLdVZJT05teFhyZ2N0K0FOaUZSSXY4Q0lnalVv?=
 =?utf-8?B?TWZ1TmowRHVvTHRUS2dYRG1PalJYM0lNelc0M1EwT0RIakgwUXRCOFJFTDdX?=
 =?utf-8?B?eXdHNkxkNHE3YmpFcWFWZ3MxeWs2Ujk1UGRMamQ5ZkVuU2VpakloQlB3WlhN?=
 =?utf-8?B?WGt2NmY5WEJNQVNaR0t2TVhxOXJyTUJlZXU4OG9OM2N3djQwTlVEZzBHM0Ev?=
 =?utf-8?B?a2wwM083N3gza3YzcnVEMW1sYmZKVzZodDlUS2xNVTVNZjc3V3VkQ1RPRzV0?=
 =?utf-8?B?UFcxRnpnTTFQandOYTE0RnlMaTVOTWJpM2xIVkNxakw2ZHNmQ0lLS2pYTWYx?=
 =?utf-8?B?WXRqVTA2VVRkREVUS2RXcWE2R1RUeVFIYkhzc1FRUTljVnIvQXBUWndQREMz?=
 =?utf-8?B?TnpNR3BEd29vR2UvRFc2cC9qTitpRGs2QjZXdXBuQ2VqTGFvY0ZTNlZ4WXhp?=
 =?utf-8?B?UC9OZTVxczN6MXhlRmNpNnV0aGt0bzQwZlpMajRQNTBzYXVKTFJaelhzZHNk?=
 =?utf-8?B?U0VHWnBmakJzdyt0MjhhN2VSMWU3U0ErZDgwWVVnZGw1VnJPZnJRR3FOaVhu?=
 =?utf-8?B?NW8vdm02dC9oWVNmT3ltakFPYi95YTNLL1Y2T1dQL0w4ZElyNTQ1Vkg5cHRQ?=
 =?utf-8?B?UTRmcnJ6cUd5b2RKVmVZMGJEZnRDdGc4QzYxMzJ3RWhiYXphOS9rR0RsN1k4?=
 =?utf-8?B?QVlEVDVlUVIvNWR4bWZqSnloNmRzZUVxdGxmWm5GZU5WT1lOTDNTNzhESEli?=
 =?utf-8?B?anE0SitlZGtEbitwRUN5QitRMXN2bjJoSlR4N01sSzVMdXRKaVJicTRvaFhF?=
 =?utf-8?B?c2s4alFTRjNid3lqVVFrVlRZQWc4VlZiNnRCcjUwNzdDMmNPYk5aOFA0ODVN?=
 =?utf-8?Q?VmmKC8a1bttoUouJ4TXcWhLMj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ed83fc-0d53-4feb-29cd-08dc8a2fe63a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:31.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbVKBni+uijUodv0yJ5J0NZcGLLtrFp6s3xYi9fIrdY45XsS0wilhxsijKI/AF8G/oqRq3crgQvcZRUimTRqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Use common node name 'mmc' to fix DTB_CHECK warning.

arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index a0f7bbd691a00..7f8c83670ca86 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -156,7 +156,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 			status = "disabled";
 		};
 
-		esdhc0: esdhc@1560000 {
+		esdhc0: mmc@1560000 {
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <0 62 0x4>;
@@ -175,7 +175,7 @@ scfg: scfg@1570000 {
 			big-endian;
 		};
 
-		esdhc1: esdhc@1580000 {
+		esdhc1: mmc@1580000 {
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1580000 0x0 0x10000>;
 			interrupts = <0 65 0x4>;

-- 
2.34.1

