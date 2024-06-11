Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577B42A9E;
	Tue, 11 Jun 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121757; cv=fail; b=KqlzL6AjbfvEomNlPsE8W3x6qiMjPJWVUWAiLrmE6x5ovP3san/uFlv5tDrShdwWjdZCDOoWsTcjWlrtzXHTxgK15wFUJb00umtD6YD+LGl3oSfzzuEpEOCKeCYEsWZRmh87uDhM3FbQ1scLGyqQM29OmgLQs+LK/1K6vlFA7Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121757; c=relaxed/simple;
	bh=FnLzzgxAXRojw2heewDje3Y95jdEVLb0QW59HYzqjeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e79tivRFECKAn4NzsWEhKTG+BjXzZEwyp8e8gzyorVds0Wrhx8PAFgxCszXqr+vZPjvqWdtRl/VU3oLazvWHtV/bosimjGOrjWFATBBImTbLP1qbJ0MczTkHL8XOKx0+DEmEpbYr738+cnJo80iui/V2vWxSH3c3lBR+5d2iu3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MHqdwwN7; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MHqdwwN7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkXlnsKcfAm1wzMD5K1but0HVKdH+9ff7DKOFzH6EG5aOSHqHQze19xrkdckDkE/8XjKSBnhAe4KNE6fTR9ftq+XMr2EJMgH8iJfaMq02QpnX1+e7yB+7VO7b9zIlHVdexnCFZmBC/W/qQIz7v/BNbsiO36y8wR2Ifn4LF6njjZBgYrrO2+zIs32ROxZpD9ZUxTdDYFoJl9qpDyPOqsvZvoaHVykvR7i39dd3hq1NhmSuZnVahL1UgkkLIbR/U8q1w/BUtS1lANXiNHeqrRV7GdjAgvnHTKk1VmKhALlTwT80ItDiEJVSEDemzoJoxbIG+Lkh+TvLiec5Wm9jfJhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpKuxDYFOkqUNJCjEWRgf3SbpmJIVAmw1j43hEGJn1E=;
 b=iGkp7GS6UH57HIalMMXtg5ong70Nx34EZ1TyBtbv00frjEp9CTxqODgEHYYTln3XfP7DAaalYBp/pJIXkTQGfRTvPf6OyVa96BAz/0rfslt0AZaNzwm9e/m33WORvhoBMDqrCrGh+i5U4KMm13qV1+ZcqnmIdiXokB/cSHrMtA9of0jgpMcF16/UjJrpcr5jXMVnD+I3fVydjkgj+aPf2V7SBugSeKaa7jqRowgJcIwTkhtaICzK42N/pDApDz+RhJNNzXGGq43F9JX6XefP8ALyCwKbyBTsXaGg5MFyIOgmpNniEIbFjQRg3oAUrHkAACGqYgDLOm1S6qK3wTrp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpKuxDYFOkqUNJCjEWRgf3SbpmJIVAmw1j43hEGJn1E=;
 b=MHqdwwN7QTGcVOeVPAIiMBiE8pSbRQtuCA6re15+f36cHZEpwCkN+xQxxu1fTJiwJw9xupO5dR4x9Qqion/Xf27DR8IG46Rn8Y32xOoanYUY+btAg+dVONTvpexRzmZeNfA9ooKq7PiOugOnXW67d0LqpCPRJydLD5OWKGeuH5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:49 -0400
Subject: [PATCH v4 4/8] arm64: dts: ls1043a: Chang node name from 'esdhc'
 to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-4-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121738; l=937;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FnLzzgxAXRojw2heewDje3Y95jdEVLb0QW59HYzqjeg=;
 b=RFck8s+QADehpQSl4uhAKKqqpV3PMQrvHrFiHBdPsijcJ6Opg7XFQi1pbwg4F+tGi22StFkHa
 SizS9jiqnAVA2iSUOSiEaTglUGQ1cM3opjjpHCrgkV+U0F16VPohHb8
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
X-MS-Office365-Filtering-Correlation-Id: 5a38deba-3681-4cee-dc7d-08dc8a2fe7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0VmdUdJZmUwaWYvSG5vRlhIbEwxK1J6UkdnWVh2ZkJzeGR3WmxjVlJmaXlQ?=
 =?utf-8?B?ZXNOOFFHb3BJZldHN0h2cUxKM2cxZm9VM3RJQjRGb244Q1kwcU1waDRkNUdi?=
 =?utf-8?B?RkVQYkZ5QktLeUEyL2NhVlpzTGNIQlZLaDc0L0RwZ1ZzdVhoTVp5ZlRobWJ0?=
 =?utf-8?B?NlBzYVhJQUJKWjhvZmpOeEx0U2crRXF4bGxPUEJzbHhJWHhYZWlHOW5FNkhs?=
 =?utf-8?B?QnBua3dabGpRc1BjUC9FVWtzRjBLVkZkTkoySS9pZWlKQ2U0cVV4dXhkQ0Nx?=
 =?utf-8?B?NEJkVm9oZnJBQjBsODNPOGhzSWZqREdncFpYbEFnNXBNSW54YkZuK2NQZEQv?=
 =?utf-8?B?MFZsUWYxTVJ2dG0wUEJZSWhlQVpRMTBpMm41aUZnbHkySzBhdmdsdVI2d2p6?=
 =?utf-8?B?QlFpV1BJVHNqN2N3VkZZd0l3U0ViQXdiZi9DNDdodDlya1RjN3dzQ1BiaEdw?=
 =?utf-8?B?TDVxR1ZqYjdaTW9WY1B2QXU4RlNpalVKZXgzUkpneFYzL2xndjNPRFhoMGxG?=
 =?utf-8?B?bTNYaFZHVHhZTkp2VnlNbTlzWk1icnovVU83YmNPYVhWckJYK0R6TGpnai9F?=
 =?utf-8?B?ZTNBN3pJMnlWVEthbEJnWTRONDJDV0R3M25NV3NxUnJSMm5ZR2lZUkRmN2FM?=
 =?utf-8?B?SHYzMml3cWhEb2grMDZGTTRBYno5Z21EVWMwak1vaE5ydGcxNEpzd2tIN2xL?=
 =?utf-8?B?Q2pIRFNmWW9sakFsZ0p1Y1k0YnZNVXowdzhDemc2SVBObzNuaXUzZTJGMklO?=
 =?utf-8?B?aWtOQkY2OXBtUXBEVGZsa3RQY1lERnVDeW01UVg5TGJHanJ3NVhwS1FtV1pr?=
 =?utf-8?B?S1VDQXlUL3BESGczQUhxNlVueHRNN09ERDYwNkFweWllaHI1bnVRMktKcEtN?=
 =?utf-8?B?T0RMbmRvM2E1RTlyakVyMThlRTdiT3NEUGtSSHBBaEFSVm11NzVvYzIwSWg4?=
 =?utf-8?B?b0Q4SktJNVZpeUNjNXlSN3RyN1NBK3VGQUNIbmYzZWlpY2s3NHhWU20rT3RQ?=
 =?utf-8?B?OUNpUkcyVFFwSndIK1VmbTZYS053ckswQjIveU5DbTZGQjRMUFg0NnRqRHBY?=
 =?utf-8?B?Z0Q0MjlCOEExWXZPbW5NS0NFb3dEbmJJSDc0dFZtRk5IV0c2Tm12ZFlUaEp2?=
 =?utf-8?B?STRhZ0pkb0F2bmEwSE9yY2gyUFpaU0ZhV0dTeThQVHRORmZhRWg5aTRKYTVl?=
 =?utf-8?B?KzhqZ3lKZ1VFdG9JMGUzUENMS1B4UkZIdjRUTHpCU2lXR2grUjVtTDArZnlP?=
 =?utf-8?B?ZStkSGlrL0kwQUY1U2h1RGZQTHpCR0Zseml4ZGF3T1BwYVJQbXAvWW9maXN3?=
 =?utf-8?B?dmlEWFpJaVYxUHBKWU5jbnlxS0pYRnZxekc0Tk5MT1FwUyt4NFhlQWg2djdw?=
 =?utf-8?B?ZVN2NGUrM2hGVWhhM1hYcWhTQTllUldRKzlyT1NnYkhnR2VaQnRRUTRBTEpn?=
 =?utf-8?B?OFYzc01RV2lzM1dNVkJpOC9uS3gxeGpvb2FpRDhCVG1kdVk3SG1EWVNSbE4x?=
 =?utf-8?B?SjFvbmdTUkNaSUNnaWxQa1FtSFkwd09SZVgzWHlCNnN0dndnKzY3My9PV0Vp?=
 =?utf-8?B?aHdWbTM3cnRlRi9LZEpuVzJkRytpZGlzeHB3YmdnWGxIVVRXa1BQaVVsajMv?=
 =?utf-8?B?OW43QUE2eVdPL3NqYlIyZUVaaUora0xoeldMUFRMS3Q5dHZKc1dNTkoyS1dr?=
 =?utf-8?B?bzhtWXVVZnh2eWlqTkZ3eDFRRm1nQjFWc0V2S3RlaTV4Si9ReEQxeENPNzlY?=
 =?utf-8?Q?ff0N/O19VESYbGTl34ju7AjFzmI1uinenDqKdFm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHd4NW1hbm1NWXFJd0hsV3ZCckhIcjkwZ0Vua0R3MG81WkZ2TDk0RWFUK1VE?=
 =?utf-8?B?L1JrVndNRVJvSS9RZnRHb1Y1U21OK3ErSS9CdDdqUkRIajNMVVBuSUNVMkVh?=
 =?utf-8?B?eGpMVXB6U3FldVJCTkc2REJ3eUlPakwxLzM2WTI4RndFTGtLQnVRSWtHSXV4?=
 =?utf-8?B?YWNGd3Y3cmM5enQvMzI0cTdwTWtoYnFLOHIvOUQ0QnNsNHJRemlDaExKVjhv?=
 =?utf-8?B?TlZpVERwVGcxY2l0ZytVbzA4QlVtZjNIL2F1T1hoTHA2ZlJtRS9HL1NhN05R?=
 =?utf-8?B?akVXMW9sekRwTVMzRElZc2M3UUtMYmtCR2lOcnFGc2t3R2RLelFxdTJQVS9Q?=
 =?utf-8?B?VnVCM3lJbmtNUHhsa0p5dklHR2hwYTJDMEM0QnA3aFVDcGJFMUhIVkFKMnA4?=
 =?utf-8?B?QXpYVXRzNkEzazBidS83Ry91U3dqQ2xJdm1NQ3VzN1MyVlpyNiszR1NadnNZ?=
 =?utf-8?B?QkorMHRKWTlTSkEyZkZBS2RLWWtvdlRGTFhteTNma2xEb25NRkhtall2aWI2?=
 =?utf-8?B?SGdiWGREckFLdFQwWGxqVTlVQ0dpM2hQV1VDR2E2RjdRVVNkWmdVdUpFY09y?=
 =?utf-8?B?RGJ2ang2dHZaNlcxS0hWZjFuaEZHenFWazRBT0RlRE1vdlBQcXN1b1c3dk0r?=
 =?utf-8?B?aityVjFDeHBwa1VzR1B0N1FzQ0hqTWplZmJROGc2enh2VGZUbU9VczROQ2VB?=
 =?utf-8?B?M0J0L0hDeHdyVWZpRVNXQ0cwZ0FKdjVnQ1ZwKy9XbW5YMGFsTXdiM0ZsRk1r?=
 =?utf-8?B?bi95ODVQV2xWUVNiTlJ0Y2ZBVy9IeVg5ZERqbENldGJNM1QzSEk5VDJJekNH?=
 =?utf-8?B?b3k4VFlkbkg1c3pqMHZGUGhQZzRIUlREcHk4bEJhb3ZQNG1DbGhuODlhOWZo?=
 =?utf-8?B?ZXlzRWpoRlJaWUNxR1VUSjdCQXgvdFRFUGhiSTVzVVM4cWZ1MjQ1a0VvdG9I?=
 =?utf-8?B?OHNiblFYZFF0NGluM1hXR2gyK1NubGh1dU1zK3VkaDdxSTRFbS93NUR0L0VW?=
 =?utf-8?B?ODk5VUEzOTcvaTNaWmhQdnhmb3VQTUxYTEVvUnprNVpVNnYrSll0QVF4c1Nn?=
 =?utf-8?B?RHp4TVRjdEppbWpWa0JyWEJWQUtXeTJTQVN6a0x3NnA4NEJOdFNFTGNUbDNm?=
 =?utf-8?B?Y1pvVmMvYWFsZUZvMGlVSysvUnR0TUNvNXloM3kzeEpzVkNtN2ZnYnY1M29v?=
 =?utf-8?B?aTk1OWYxWlllMktRYm5rWXpnamxONUYrVGIrZkZvU2RBMk9HS3BvU0NZNWN0?=
 =?utf-8?B?d3VNSTJSUUJRa2oweWoyenpqTE53N29Wa1h4Y2FNT2JhM2xrTHJJNUhZZDNM?=
 =?utf-8?B?dkNkdFlMWDhFUUZPc2ZpT2JkeEh6aXVEYTFQT21VYmtiU0ZKV00xUTFSYTJ0?=
 =?utf-8?B?Y3VMaHZxekdsdFJFZTJYRmJiZlY2LzNZVHRPVXlYNlRkejNsanRhU24yVEpw?=
 =?utf-8?B?bDRoaHZyMWlvUElDRkptcER2UzAwS1IxYWoyZXREMmpkZ0UxaWZveWh1cFJs?=
 =?utf-8?B?NUIrN2tDRGhZU2JoVlNpd2ZhSi84U0NnOXBCZExlOUhja2w2eC9pcFZGdkJ3?=
 =?utf-8?B?ck9OWk5hd29OSGJ0T2N5WXJzNEtVS1JCd2VWUWlTOVU4ZzlrZ2xzMzM1REFC?=
 =?utf-8?B?RzhaOWRoeUV2VXJDTStGdWZXOXY3eVpoaGYzb2RzV082OHlORkcwVm9yQzhn?=
 =?utf-8?B?cHp4eStmUDE2STAxdXpnR3NtdVQ5Tk9HVDF4TEtKVTIyZWhXbmpnVWJFVW1R?=
 =?utf-8?B?WUpCdXhwdjk1TTBDZTByUHNSL0pveDV4SFdHeUJpV2p4cXVaNStNL1FGdlN3?=
 =?utf-8?B?QldqSUdkTnVaaVp4dEg0NWE2eWMyajBpQjdWdktTZHlQNzBKVENSUUhLNkxi?=
 =?utf-8?B?TDVWakFJR3luL2E0eUd6SHVQRHFRdFdjWW13UVlwdC9UY1FPU1IrUkdRZTFT?=
 =?utf-8?B?aEN4NnlGazloR0FHdHd6andVdzNLWFlUM3psaEp6UEJidnBTbEMrL3pDS2dK?=
 =?utf-8?B?LzNhRnpNMmNxdnlMQzJNd0drYmVidXUyeG5kbDRTeitSdzNWaHBvRTVDTVgw?=
 =?utf-8?B?a3gwNlhycGdkWjdXd1kxUmlJS0NEWGxCWnUvK1hRbjV0Q3N6S0hmM1dDVDVN?=
 =?utf-8?Q?6Od0WPi1PXXKOwM6v2MdXavmw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a38deba-3681-4cee-dc7d-08dc8a2fe7fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:34.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ42tpMsR8pCg/A06E3W/77bjAfefh8G7wnct6iiMcJxIla7R8fHBydeTXYhHdpeo7bbPe456eT4iPpYUZEl9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Use common node name 'mmc' to fix DTB_CHECK warning.

arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 8ee6d8c0ef619..3eeed7290be9e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -424,7 +424,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 			status = "disabled";
 		};
 
-		esdhc: esdhc@1560000 {
+		esdhc: mmc@1560000 {
 			compatible = "fsl,ls1043a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <0 62 0x4>;

-- 
2.34.1

