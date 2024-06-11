Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133923A29C;
	Tue, 11 Jun 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121751; cv=fail; b=nVW2lEvvSJoSGhZ4DE66+yXJVQkaaBAVD2FC2oWpHBSiIOUdld9ufFz9KkIDH606ySaoMH+Qxg9QUeRzM3jFNMIt/Z7WPbVJkuS5vrkCELxVT3AbNaaLlAp1GL0gdn8HY5ayQwBO+CI//bxC2P0JJ/EMnBVVHkqfHwgJekJrLvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121751; c=relaxed/simple;
	bh=LKlyJXTL1wk9fiWDehxW2c7+JJzS3ilJP9FoltVBtQo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KVwtySbvLoZelqZjMzOmaTYnAp3LCWFgEQDzF4ro/QwC+PT/N05HDpaLJKpVYZEWlxe/GUe+5GilNbESDak4vyQrXUtJtatx7gFh42uvctavkualhmUi/SQl3IFTGue2SPEV2gv0PWB3ebGrbqDAkhKfYJypGwCRBzSHR3vCaO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U1tDYV4f; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U1tDYV4f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqPRwYMozXz9NYLEvXCfSgqCL3je2+YWhFSqI2yM3pxlBNklgjcqhlo0Kpx8CgTvQmzeQ034B4eVwWVq2i5h0lY7qc2yIkHYEDqD0oOiZedhZUqA+0df0tppKLnvcvW6Q47CePsjJifvZPl5oCmnqTgN5ND4BvvW/R2u5+2Vi9ezJ9yt23gNkS5dkyJM1IxKtrK9gKTu1N1asBBuw8BIVgUE1V2G7BFvts1v/z66UiHeZwzaMQBBQoByGGXx6NfppA7kw2+JHqHwOIGQ2dWhgNccBiAhza5T+G67nMjLRiYuWjEzvdV0LdFVyKfTxlO9i/kKgNe0kYIbHBsMaC3N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRigU/HJWru8YfX/7aohN9dmxVgr27FaA++EasCOa3Y=;
 b=nabmFLw2cMB+rV5KVpY2xE/m/SmfpP03Oad9kMlzwJurgBAVkpNWElsBvwNYHNIu3LHqn+7gvCRlBA/d1BwP83CXFhxN9hoCarKMPyyX28js/jDqAZ4ekdSR9pMLus+5o3MpWJXP6vgIDaUhW976nRRVfJ5O2whayS2LgrRFVQ3GK5s+FkUnD7TVcXw3+0MZ1Goqu8pLEEFGaM5fFPc2xnLx452T9EdX9rvZ0H/rZ592RrAZk06+10dcXBXBkVDe4i7tVLaT4Gx+i/n+iCQVZ869d36d9THAHif6p5YqvUiiILKbOpxo8DUkJAtaGlSSpqKO0aaqStfHqoBI5kXDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRigU/HJWru8YfX/7aohN9dmxVgr27FaA++EasCOa3Y=;
 b=U1tDYV4fSLe3/9WTunOiFmsY0ujvPgJTBog9m7ZvelONVXisnJyKgwsQ8sgyFrk7Mc6lg5ouqDgnXvxrgQpMQlPQfqO2bRUOY2dvSrw/iNwHdt3wISBgABsyKE6eH86DV++UbdFMkQmZMHkJV5qhUfXc0s7SubNxMYUw7pYq6AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:46 -0400
Subject: [PATCH v4 1/8] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-1-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121738; l=6845;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LKlyJXTL1wk9fiWDehxW2c7+JJzS3ilJP9FoltVBtQo=;
 b=IyXRqzfPQIva/eWVERwh6+e84Th1qiACcFNBOrWcSRnEfYrqVKNxkVrGXWutW4PcuVfli1u/V
 YvrpytHAojaAj/CCv3+iFxdL0TJqeuObOqGW4EGdwAMsXEQGgctpVhI
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
X-MS-Office365-Filtering-Correlation-Id: a7313f2d-4ac8-4a63-705b-08dc8a2fe27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW56UG5uQjV2WXhTc0h2dnNlQkhoeVlNSk5HK3dacTRBNHZ2aGYrNS9RWUZM?=
 =?utf-8?B?QkVxZEhmQjlWL0VPOXB5TDFXRS9HZmd6cHhTVTdycGU5eTN5SzBzOFVkbXhF?=
 =?utf-8?B?WkpkU1ZzQUJGNHdSTzFvK1pHSXJXRzFaa1h6ZHc3aHUrdm56KzhKcmJTNmxB?=
 =?utf-8?B?ZkRQcmxsVnU2ZjRvL2x0NWllUGlNeWdlM1VXRER2QTl3dnR0V0t6T2Vnb2JE?=
 =?utf-8?B?SmY4QkQyZG9OaXA5OTRLSlVuYUpQQS9RWlVVRHVjdm5nQ1ZCQzB3NEs3WWJO?=
 =?utf-8?B?cXczUGpYOU9RcFhxbzlDKzRHSjBTQmdCRTd6ZnFNbUk3WXdLTGtPOGN3dUdo?=
 =?utf-8?B?Zk5DbCtZYmxweG4zY2hLcFp5ZjlRWkFMdnJCanBSZmdWTVdzeDJFbW4yd1Bl?=
 =?utf-8?B?ay9VTXlHV0F6UlFrc2VKL2hibHQrY0pya3AyUVFVOVc0SmFzYktFUml6NEpK?=
 =?utf-8?B?dGVQVjhMZ1pPQmplZ1dYL2ZKMnF4cW9mcWF3VnJtY2lJS3RKc1Q3Wlk1Wi9s?=
 =?utf-8?B?QVByalZ5dnZhOU53SC9OVVd1UUdPbjVpVlFnQVhlemtHT0x5UU81cTErcStw?=
 =?utf-8?B?NHk5bjRIb0kxYVI1N3lnSUIzZ0dVekFHMWpNSmdXZ2Jrc2p3T2w2bm0rUnpy?=
 =?utf-8?B?L1FoSzl3aWR2NkdiQnpGcm5BUTYvM3ZVcTNPMHJtVENBU1NzNlFERkdOdzd6?=
 =?utf-8?B?bDFOcm1TZGR3MnJFVnRib1FYRmRkMTZuWVVKckRCOWF2TXFuVXBiUnJwY04r?=
 =?utf-8?B?Z3pQODZIeU8rQWcxWEJWZTdqRzBHZUp6eVBkQ1lxSzJObDhPN09kVlM4TVkr?=
 =?utf-8?B?U1VFRXBWdGpjVklBbHJmTTdrOTdYZlpIWFVOV210MmlIR3gyaFJEY2Z5ZzM0?=
 =?utf-8?B?NzljdXFvRTBRUzJqN3NKUmROZGpOeVNzdHhraUxmUmY4SlIzR09oblNVM0Vo?=
 =?utf-8?B?eFB1a04xQlpyaFpkeVQ3bXdMLys4ZGxpRjYyRG42K3hHTitZM3JvYStFMFcr?=
 =?utf-8?B?UThCVEdUMitzTVQvWldmRTdrMnFiVFVZc25FQi9jcWtTREdKSkJVM2dmZjg3?=
 =?utf-8?B?SVZvdGR1SVJvTXJFS2Y0c0RMOW9sYzNES0pBUDJVL3JEQTZWQWtaVlpFTDkr?=
 =?utf-8?B?TUM2RzBabVdMRjBBQW1UT3NrMUgyQXJiRlRRczQ1RXpIUndWdVBSUjU5ODRL?=
 =?utf-8?B?bUFLL3ZqVzQxVk5YNld2Ri9KSTlMa1FEbFcyRXU1d1VQWGFDWlZPQlpFeitK?=
 =?utf-8?B?VGVZMXdmRC9DT0VaSlpSN0NXdkxIMEFjTi9ybWk3VC9Pc1FLY3RVbnFvZklJ?=
 =?utf-8?B?QWorazNndnlMSHRNRG1Mby80T1pRQ3dNZ05GN2tRbzJPeTgwSVJJK1pXQmpW?=
 =?utf-8?B?SFpjNWxvNlRuOXpsbS85bGVpTk9uMDBRTkQ1LzZJVDZYek8xd28yQ25xUjlV?=
 =?utf-8?B?U2JISHNoQ21tWnY3ZlNFQ3F2UUl0ZVV2TFUwTVlZNCtybGFkR1d2QlJBL1Mv?=
 =?utf-8?B?eWxzQ0FaMVpiK3p6NDdRYTFON1ppNFRkalRYWXZaRFNvWnZzcEh4MHVxK0hB?=
 =?utf-8?B?Y3FOUlc5TlZUUUV4bmd5alJWaVlYOGRrTEZhZ3NhWTh5QUxiVnpDdjZQRmRS?=
 =?utf-8?B?TGkxcWQ3OVlPdjRveWNPRytBYmpuYkFDT290SlAxVUxSN3d5ZlhidWtVR3kw?=
 =?utf-8?B?OVVWVk8wZ0VrSmdpVjFWdXJ3NWQzWS9yeHh0c0JPK1hudWw3UTJVL1hXcUo2?=
 =?utf-8?Q?u4DhaJepUMlnvSX90n0dMtjBAvBsRb8ODaLGFhl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlVUc0I0MTRmeWV0S1VjOGNzd05RNGdxTnU1YWtLNk55di9CYThUaWJlMHJy?=
 =?utf-8?B?S2F5YXdVeXpVdnMrd2N3SWRWVFI3anB3OFRZR2UwQnFBY1RKVFdERE02RGV1?=
 =?utf-8?B?SFE0ZVhYQ1NpVTNzV21ySldQVXJMY2RJR3dVNllTMjdha3drMEFEUmFGdlVN?=
 =?utf-8?B?MjBaN0NIVWtsbE1zWFRJZUxMRm41bkdHSFdNblNUWGUweGNLekVMd09qblc4?=
 =?utf-8?B?YmFEY1djSnBDcTMwQXRqdW5aejd4ZEpMSTB5aVdhejBmbzl0U3Fwd2djejNS?=
 =?utf-8?B?VEVrKzh2cG5MZ0laeXB6UVV5NG5JRmdEZVpFV2czczFJTTA3cjNweG4yT04z?=
 =?utf-8?B?b0tJZkkrNzlGRVYrRHh4TW9pdTJKVDNBZmdjeDdrbkMzckFDdHBseWE5UXc1?=
 =?utf-8?B?SDQ5ajFVd3YzTkthVm13dHFnSHdDanhQcGRSQUt1SHowL3BURElZdG16dmM4?=
 =?utf-8?B?b2NsUlZUbHFGc0xNZGFpc0NQUW8wWk1GTEUzcjFZdXpSZCtpWXAvOUtWNmhO?=
 =?utf-8?B?Y3lrL1BwNTZrbHRodkdlcmZtTVNYNXdlekg5WkJnOHNoSG9xa1VTRWIzRWRG?=
 =?utf-8?B?WWU0eGozOE02RE1ZTDZ1Mm9tUnovdXdMRHRZTEFBc0Rwa2NvVVBSQ0VxKzV2?=
 =?utf-8?B?RFY5aWMvRnY2dHRnS2JHaWNpamZPRGgxOVJxRFVxY1h4RFVnbkxRSEF2eDVo?=
 =?utf-8?B?VXVLdXZhdVdLQzkxcjhuL2hTTEpuZXVTTTloaHZhOUdJdmpSSDVjbmJnQ3li?=
 =?utf-8?B?TUFzTkxOOWMrTU5wN2hPR1ZFemxHRk1KYTZqUXJJK1NaWFI5czQ1aUx0WlpF?=
 =?utf-8?B?Wk9IREdsbkJOMWdKYTI2R1pjKzNWUGJJOTFETTQ1VXc2dnhPZjZtL2toSVdo?=
 =?utf-8?B?VHY1ekFubXQvaVVVbWZMcW1hdGltazZ5aVVrOWZla2FiYVRuS3JESElNRVBm?=
 =?utf-8?B?SkdQbWhFK2czZm9HcGpuVmFCZERzSkNFYXpmYzBHanBlTUZOaUN2aUFLeStM?=
 =?utf-8?B?dnVYeUJsWjY1d0pZcW90QUdlRWFMOURGQkEyRjRCSnFKemNZU1RjNGRRM0Iz?=
 =?utf-8?B?L3FRalVDTHUxN3ZjZ2pZNXptUy9jZHNkUkpjM1UzeEtVL0pReGJKcFBDR2Rp?=
 =?utf-8?B?cm5QSG1MTHdSN0ZLUmxWa0ZOTzZPNkNQVHlia0JKQ0gxRHY3YU5mSERsZ2Ix?=
 =?utf-8?B?MlRiSERFWE9Tb01CMHFkVldhS3oxUjhTd21pM0tIb2llNmd3U1VUUVFwQUxE?=
 =?utf-8?B?MjRIa3NSRnRmdkVDOHd6dlN0TFNDeDU0dHhneFFiTWFlVWZTS1hCeDBNL09R?=
 =?utf-8?B?SjhsdFlFVEYxaWpKdFJHU25lUWx3elRWTTVvaE44eWhUbGFtZUJBWDJYVVN5?=
 =?utf-8?B?K2F2d2pvUWI3TFdCdGZkT3dWMjhiNWN3cVNwSlNsQ2xtdFJkRGk3eG5hQjdD?=
 =?utf-8?B?NGIzQzFzTWUzRmJwZ3FHU0RHT3FhcHpjR2FBRFdhMS9nci9UdytvYk9sZWds?=
 =?utf-8?B?WUhDNzJxZWUzNVlDR2I3TW5JUUNESUtGaGpORjlseU5oSEpxRzlvK1p2UFN3?=
 =?utf-8?B?NEJMZVRwaWoyRlFHdmlnSnJ2bXZwZTVZaEZ1bEpIQXhTSHFtdUtmQ2RnZ2to?=
 =?utf-8?B?Z3lJTFhMRGt6YmVNRURMV0VrY216UUYzZTc3U0tHYVRFbW9yYzd2TnVMd21a?=
 =?utf-8?B?aldrWjR6cXljTHN4M0dXN2x2eThVU1h1M0VMdmd1UjBnWDBuUlBObTQxMWpL?=
 =?utf-8?B?SmFXVlcvTnVTODE0WkR1T2dDNzJzQVlRUkVIRjluK3FNUFFwZjNscVhRdEdU?=
 =?utf-8?B?MmdoYzFLUEdlT3NiL1BKalkxbjgwbmd1MzN2VGFWZWoxU0ZDUFlMOXk2bk1a?=
 =?utf-8?B?VkJPcDYzaTFZOWtqc0htdXdMMEV6S0FjUEo5YzRHYU5TcE5WeTdpdk5PL0xm?=
 =?utf-8?B?Q1BoWHMweUN6eWF3OEFHYnUvendWaTFkdnB2N0txNnFzdXNPU05uWHlYMWVh?=
 =?utf-8?B?bUwzUTlrWXVZUzZiZ0ErOFpGakpJWm1OZFF4NU0reFd2citwS0hrTWVpS0tT?=
 =?utf-8?B?SHdGQjlrY25nNkMzb3BNODMrbEZpSlhLa0lNQXFLQVBrd01RemVZc0QzOFRL?=
 =?utf-8?Q?VqUWSrDYy/dU0JtZG2BLD1c+h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7313f2d-4ac8-4a63-705b-08dc8a2fe27d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:24.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbyQUbKNEtVcA0MhE97+TCYN87It9uetuSbq9CLip9un/0O1IaocvBRpZE9TxINYNwQuv+4T7Kqevs0wvDpBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Convert layerscape fsl-esdhc binding doc from txt to yaml format.

Addtional change during convert:
- Deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
- Add "reg" and "interrupts" property.
- Change example "sdhci@2e000" to "mmc@2e000".
- Compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
most existed dts file.
- Set clock-frequency to 100mhz in example.
- clock-frequency is not required now.
- Allow dma-coherence
- Add clocks

Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Change from v3 to v4
    - Remove clock-frequency from required
    - Add dma-coherence
    - Add clocks
    - Not add Krzysztof Kozlowski review tag because some additional change.

Change from v2 to v3
    - add minItems and maxItems for voltage-ranges

    Change from v1 to v2
    - use filename fsl,esdhc.yaml
    - Add clock-frequency to required
    - change clock-frequency to 100mhz in example

    pass dt_binding_check
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esdhc.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dts
      DTC_CHK Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dtb
---
 .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 +++++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 ----------
 2 files changed, 105 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
new file mode 100644
index 0000000000000..b86ffb53b18b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Secure Digital Host Controller (eSDHC)
+
+description:
+  The Enhanced Secure Digital Host Controller provides an interface
+  for MMC, SD, and SDIO types of memory cards.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8536-esdhc
+          - fsl,mpc8378-esdhc
+          - fsl,p2020-esdhc
+          - fsl,p4080-esdhc
+          - fsl,t1040-esdhc
+          - fsl,t4240-esdhc
+          - fsl,ls1012a-esdhc
+          - fsl,ls1028a-esdhc
+          - fsl,ls1088a-esdhc
+          - fsl,ls1043a-esdhc
+          - fsl,ls1046a-esdhc
+          - fsl,ls2080a-esdhc
+      - const: fsl,esdhc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies eSDHC base clock frequency.
+
+  sdhci,wp-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that eSDHC controller reports
+      inverted write-protect state; New devices should use the generic
+      "wp-inverted" property.
+
+  sdhci,1-bit-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that a controller can only handle
+      1-bit data transfers. New devices should use the generic
+      "bus-width = <1>" property.
+
+  sdhci,auto-cmd12:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      specifies that a controller can only handle auto CMD12.
+
+  voltage-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: specifies minimum slot voltage (mV).
+        - description: specifies maximum slot voltage (mV).
+    minItems: 1
+    maxItems: 8
+
+  dma-coherent: true
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If the host controller is little-endian mode, specify
+      this property. The default endian mode is big-endian.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@2e000 {
+        compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
+        reg = <0x2e000 0x1000>;
+        interrupts = <42 0x8>;
+        interrupt-parent = <&ipic>;
+        /* Filled in by U-Boot */
+        clock-frequency = <100000000>;
+        voltage-ranges = <3300 3300>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
deleted file mode 100644
index edb8cadb95412..0000000000000
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Freescale Enhanced Secure Digital Host Controller (eSDHC)
-
-The Enhanced Secure Digital Host Controller provides an interface
-for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the sdhci-esdhc driver.
-
-Required properties:
-  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
-    Possible compatibles for PowerPC:
-	"fsl,mpc8536-esdhc"
-	"fsl,mpc8378-esdhc"
-	"fsl,p2020-esdhc"
-	"fsl,p4080-esdhc"
-	"fsl,t1040-esdhc"
-	"fsl,t4240-esdhc"
-    Possible compatibles for ARM:
-	"fsl,ls1012a-esdhc"
-	"fsl,ls1028a-esdhc"
-	"fsl,ls1088a-esdhc"
-	"fsl,ls1043a-esdhc"
-	"fsl,ls1046a-esdhc"
-	"fsl,ls2080a-esdhc"
-  - clock-frequency : specifies eSDHC base clock frequency.
-
-Optional properties:
-  - sdhci,wp-inverted : specifies that eSDHC controller reports
-    inverted write-protect state; New devices should use the generic
-    "wp-inverted" property.
-  - sdhci,1-bit-only : specifies that a controller can only handle
-    1-bit data transfers. New devices should use the generic
-    "bus-width = <1>" property.
-  - sdhci,auto-cmd12: specifies that a controller can only handle auto
-    CMD12.
-  - voltage-ranges : two cells are required, first cell specifies minimum
-    slot voltage (mV), second cell specifies maximum slot voltage (mV).
-    Several ranges could be specified.
-  - little-endian : If the host controller is little-endian mode, specify
-    this property. The default endian mode is big-endian.
-
-Example:
-
-sdhci@2e000 {
-	compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
-	reg = <0x2e000 0x1000>;
-	interrupts = <42 0x8>;
-	interrupt-parent = <&ipic>;
-	/* Filled in by U-Boot */
-	clock-frequency = <0>;
-	voltage-ranges = <3300 3300>;
-};

-- 
2.34.1

