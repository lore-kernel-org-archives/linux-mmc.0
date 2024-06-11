Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDE57CAE;
	Tue, 11 Jun 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121763; cv=fail; b=Bo2ACg15Mw5d/kv8vuGGTsx193z4+mqXNY4WNyowTZ83VCAl1e+oPxRErRznPL/zrsz8QgwH3W2HO73aMWoCOGLMmSoRP8qvFSEFtMd3rWp0a4bKG1jnQK1hHbW9/eyN/fFuf2PATCdV0ushOdTZ1fKemuc8uepRIskAh1joDqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121763; c=relaxed/simple;
	bh=uGCRkS+SHUUH2Knw/jJHfQ6zqvLTI+HgNMKxGUFS1Y0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qTNGzhF/2cMdoYI5k8qnVWZ5/nYSJURLvR3+EsgcB++OCbsWVSyhqNoIIwOF3aODTYI7oopc43kQXgjMBnE5dh/n43sO7BW2hdVtGxVrFqpdGZQDrgANFBPdYeHZ5hytln5OWGe1QjoO7LEO33ZCv9j9JZJNdnte+PPV3AZ+EQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=shKwBXqD; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="shKwBXqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyiWcoEig7y5606aUjvRwrq3mc8bqg4eJKE/3qKXPrwtBnQ8alk5Z9gD5K61U3xP/VCEVQXxmgMZjJ21vsWWfJmBBEY87Rx4CGJbZ71Lu+y1RNg4ociABYSoePkM4gFfHm5nhhgGudESHfnQ+sJesH1TJaJ8XCKWBg2x3yv6zDx3+3u114R6LclPrmaDmHAr4vy5xk0ciSrd0NPDTPLHx5NlvpRPC+o3BFvpLaUhbcsFmy4RyKPgiXptpd8MCex16Qlxxah1ULnd5gXmIVcd3ApHFw1qMxFTvQ1uAY2JmCJ8OxSIEuGHfaoXZepVQe4epQSjYCX9cHzcnXnqzrfSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phoMF08SRyuqmtQh4fu0nqsBU/fpHZqwDlTJJ1JOT5A=;
 b=HNr2rIsBUdwcCv6x6Br5LBseQiBFPPSRF1soixLm3yqapeKhBil9JuNOEVkitBpH/Y5pnEZ0TmGmkWuYifzI8TVKISpQwYloCuGhtufce0zXL9rXshETa2EQXe0Qh5D6BUfwr33XkEsTGfCIJ0ImZvpXJzjg0R8n7MTp/tUwjCtIv23NI3eEHqAExV3jgTO5LJ3Wkc2Qf1W4tpNi2PtlzyD3eUc8w7ZkjVsD6by0qQwOw4WS10AT8wRE+Y+M5vk8kxduoiSCMMgXD/Szp8+dM7TGaU2K01/W2FefX0EN9mDsb/Ce4JIkCnPsEKMHXjZmONnsjobOTx4VneONRzqotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phoMF08SRyuqmtQh4fu0nqsBU/fpHZqwDlTJJ1JOT5A=;
 b=shKwBXqDo/UH2Cb//KhG0ZTEyQi3yPTxErI9j8M0t7GkPcerwvM1xObDS0XwytvfDs6zg8+mHLtMpa6zB5dkG2oHPAQcN8hC/lZ7DJgfH6a7SZoAwU5y0xZF7vr6bFTXIDi3MJilh5EZsVoa3XezcdnmkEU8DX9q+8Aa0qtPeCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:51 -0400
Subject: [PATCH v4 6/8] arm64: dts: ls1088a: Chang node name from 'esdhc'
 to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-6-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121739; l=890;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uGCRkS+SHUUH2Knw/jJHfQ6zqvLTI+HgNMKxGUFS1Y0=;
 b=xbF48LxS1siM6pbFFDrUxCRC6lzcz2bD93NVXfzAiIsLXT+xDDhzV/tjB0cfQr01DJ8ufu112
 RPetCAdFCyDApT7cNbTPPqiyH8PQ/wHHD2MhNCUBi5Myr69sTaGMg8i
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
X-MS-Office365-Filtering-Correlation-Id: b5221b26-563d-4449-044b-08dc8a2feba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VllhWUp4RTV3cklyQkdaSFZQcENLYUYra1NHcWNqa2t5RHBEV0szL0dtV1R6?=
 =?utf-8?B?azltTFBUV0pJenlDc1pwaDNZbVRLQlNTbE5rY2xQZFd6MmVlQmlXWlRPSnJJ?=
 =?utf-8?B?Z3JnVEliTzJxQXBGUkxxcW5PdDVBQ2ZSQklVMjVwSHI1WE1PU2VlMitTZDRG?=
 =?utf-8?B?cWxzSk9FbnJobHFpQ3lHMmJ4YTFNRGM3Uk9SR0NLUkRkU21ESWl5NzMya2dl?=
 =?utf-8?B?NjQzMGdPMm52Q2ZYVmNwSHBzY0RMcnNoRkhxNXBWVzZnd2MzTjBvS0txK2Fu?=
 =?utf-8?B?aGYwWmg4S0RwZ256Uy9OSUp5bHV3cjJsdGw1Z0pkdTJsamRSOXVVZTVWbGZk?=
 =?utf-8?B?SmM1VytTN09xYytlYlM5VXJ3UVBwcFJVVFBUT0xiRmxSUUpSamY1NDlCaWkv?=
 =?utf-8?B?ODZJNERvT3BkQTJFWllWM3ZVRHJGbFVjSkY1TnIrbnBLMG9tY0RyODViRUdZ?=
 =?utf-8?B?ZjhOWmJPM3QxdXpFZmhZSzlONldIVmQ0V0U3U0x6TTZ2WENEbytjNDJpU0Fq?=
 =?utf-8?B?RlpRSzIwandkWkR1U1J3WEk5MzJVYW4ybkI1VUNnQWpMTTlBcklnTWQ3T3BI?=
 =?utf-8?B?bDA2aDUraE8wRlU3bUpON3RnTjJieUVUOVRJbDVkaXg2eGN3M3YxZ1A5VVJS?=
 =?utf-8?B?WnZQb25mL3BYZW5nUVF2dG9NU1E1WU04OWFkY1ZqTEx1ZHhmTC9GaExwZW9W?=
 =?utf-8?B?a0VzcTNrWWRDZS90QnNoVGtNaTN2K2ZIT21KOVhZM1RkUFhiT0JmdW0vWHND?=
 =?utf-8?B?MHpMaU9DaTNkeWp0RFJxU0R5WWdoS1NCMFlRb2didFZ4S2tqUjRjMkovWmF4?=
 =?utf-8?B?M1h5R3lTbzJ1d3pNZk02ZkN2SU9MUmZ1ZytWbEdpeTgvTDdvYU85VUdVTHg0?=
 =?utf-8?B?N0o4aFF1a2ZvUHpnN0NCc3ZVNjV3RWd2Y0pjWVZwVHViME9Va1NWOGxvdS9K?=
 =?utf-8?B?dm1hQ0NVL2lRWEJxazVFMFNsNkVWRGFHYmNLbHFlLyt3RFNoYm5Jdi9kVHM3?=
 =?utf-8?B?UWxna1YzeGY0WVdpWVh5T005VDZWN2tRN2JLbk1OVGVIUjNXOG9kUW81ejF0?=
 =?utf-8?B?dXdrWWt1K251M0NjR2hJa3RlNk10a0pDaUUrYWQwMVZWV01iaFowRnFVTzBi?=
 =?utf-8?B?ZnE1OGo5TDVRK2plRFF1ejNrYkkwUDF2azY5ZnZIUjVJVGFqZEZjb0lkbjB6?=
 =?utf-8?B?RzhpK0xPNXZiYnlJTFhZZ05rMlVVUHEvK245ZnVLRFpJMHFUMXRvcHhxVlho?=
 =?utf-8?B?T1ZvNWlFZStmd1V5WS9GM0dUV0h1d25Yck42cmxsenN0MzFuanVROVZuOUIz?=
 =?utf-8?B?MHdFdTlJR0RMUy83d1ZhWTR2Sno4Y0xLNGdvdjR6TXY1dW5oSjNpN0J0VGF5?=
 =?utf-8?B?RGZ6aHl0MUwrT2UxeFVtNEZ1aUxGbm5ML0l5dVlyM3JWZ09maVpJcXZxZ0xX?=
 =?utf-8?B?RWZZS2c1RmoxRU43M05DbVl2UEZWMWJ3ajF5NjBkWUh6bTUvSG1JOXVMWnpN?=
 =?utf-8?B?NUNKcU1JcXdRcmVvS3ltWkhlYi9NaDFHTFQ1ZUk0eVVtYVZVY0VOckJQZDY1?=
 =?utf-8?B?U3lUMWNHb2VHZnRab0Nyank5L2xCenAvQ05kblFzUHExVlJnT3U2TitpbThD?=
 =?utf-8?B?YmdmNjVxWkJ2VkJKRTQvKzIyb0J5RWpPZzNUS0xOQytsNnRGcW81UW1iZjg2?=
 =?utf-8?B?aEhoYXdBQlMvQVMxelQ3NW5EOEdmM2UwUXNIMTFRR3VYbFBBdGdYSXM0aDVJ?=
 =?utf-8?B?cllLaWt3VXlVYWtEK0VFWG5acC90a3E4VTJNNExtWWZvMDVLVG5uWDJjTDcv?=
 =?utf-8?Q?CXSD+jNixbP1OXArw910Dm4JTU/KMLAXebnI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ljb3p3NDRSNzU3M0d0dlNxVEg0M0pZVkxGdnl3MzV5KzNNY292OFdoQ05a?=
 =?utf-8?B?c3VPaDFXTVJENlJrNWptbU9iZ1lYbkxLa2ZHdGd3OHZwVkpMZldNamdYSWUw?=
 =?utf-8?B?OS9NVzhveVFOZmc3QTBwM3lQSnJpYVJab2pTTFFoNnVhWGVSa1dwTVlBZnNW?=
 =?utf-8?B?REVBZEVmOUVEcTZFK3N2ZzZMd1UwdXRiZEZvbnJNNnNnejJSQXQ3NHhOS21y?=
 =?utf-8?B?YWE2YW5YM21GOXhoSWtyeVFqZ2JPYm45akZZR2QvTTk1aENxN2tlRXk1a0h3?=
 =?utf-8?B?SkkwWmNLVWhMZ2NDa2VTS21pcTdvbFo4N0Z1UUJlc3BRbUtsLzN5VHY5aVdB?=
 =?utf-8?B?TXZzTGp0M0VhS3k0TzRKYlR3b2NPMUZ4YUl3NGE3WGF6S3E1c2hiRUtnU1Nu?=
 =?utf-8?B?dHVzZy9MbGViOE5BcTJsQkNWWHUxWWpvajlPWE9iUnd3OTlSWDUwb3A2b3pZ?=
 =?utf-8?B?eS9pTDVMcTdDbHMvbWJZQUNaazAwRkJiMVArcVYyYzhic2xIK1FvRkREajA2?=
 =?utf-8?B?YnFlaDJvT0lDSXhWbkgyMndBNDZKajJId2c3U1hVVmdPN21GS3Q5MWlNejRk?=
 =?utf-8?B?cHBxTGtuZzdaMTNwdzFKWWlnNFJIWCtCaVBCSUNWWi95RlRrWXcxc3Fha09L?=
 =?utf-8?B?K2VKeHdkNXYyU0h2d1RXc29OSFR4ZTIvUG8rdWh5clQwZVBJYUNKTGxhL3l4?=
 =?utf-8?B?M2RyTjEydWFTRkxBOVBqVVFQRWVtSjRHN2ozVm11OW0rVkMrQjl5VDE4YXJt?=
 =?utf-8?B?cDBqdWNKMmRIRE1HTHI0MHh2bjdOallzZXFDelVESkt2YWdsdlAyYWQwbHpF?=
 =?utf-8?B?c28rMmozaHFYZjZZK0xBenNHSlZZU0xKWXZjUGVaYUxEdFFQOWVwNWl4d0VJ?=
 =?utf-8?B?blc5OURkblhrR2JmTUtKZGVQT1pubmFwcTB0elV4b0tUWWJmbFVacDRXQ3BU?=
 =?utf-8?B?VDhPcU9QaG1jN01jcEQ3aTRYeFRqK2VYR3NZZWpkMmU2aUdYOXZzeGxJT0Q5?=
 =?utf-8?B?TnhXM3oveTNzV2dPb1o2a3BFQUlISHpWYUNsRWV4aExnYWxTbDFsRnRRSGRk?=
 =?utf-8?B?RzRTbWRlamxmM0pYdm1FUzFEV3BkUSs1dmcyenpUVXg1VHllVkJWSDlwdjIr?=
 =?utf-8?B?RXVmUmxpZnN1Q3AxR2Q2WVZlVWgxTzRNVjNBYnQ3OTJHQVhNU0ZGZEZDNzk4?=
 =?utf-8?B?UmlqZVBTUDZDbjRvQXl5Z0ErdUFkVUtiVDF4bGo3QVhTaWRwbGl0djYzTW83?=
 =?utf-8?B?NG1jZ2NZNUhuT3c0YmdDSWxVdXNjZlpzaUxyQlBGMmNpN2Q2QkgvemppNlRx?=
 =?utf-8?B?NFFQWExFREhieU94UW53UUN5UHRyQ3NWOVBmdXFOVjhNbVhraStpaUtOL2ZN?=
 =?utf-8?B?a0hmNEs3VXFvT1QzdHZHdmZPVExycndYSEtKSVlLd3Z5VTJXSUIwUmZPVWdB?=
 =?utf-8?B?K2JqNHZHT2VqcUlPakxIVXd3S1lwSDBxZVNiazFGTVhscEY0akVtRURIZ1Vp?=
 =?utf-8?B?UzRUdHdKWEp5blh4RVo5V1FCdlFuTU55T0tKeXREVFU3TUtqVW1Hb3pqRDZB?=
 =?utf-8?B?a09tQkVkajc4bUYrQ3M5RE1hSGRraVVuTUJBYTJHRnVTbjJXcjZhZ3dsV3o1?=
 =?utf-8?B?SE5CazRWTEpVbXZSaDJTSW1zbUNBSlg3V2lCS1orejVYd2s4Q0JlMENTd1JT?=
 =?utf-8?B?dk85TWdIQkpVMisyZjFzV1BtNkhlTUtGZUJPQVlBRnloajNXYXA4MWVaMkFP?=
 =?utf-8?B?bEQ2MHpuRGZZSWhWaFJTR3pZOXllQWJxd1RWN29GSnNiTmU1L25TY0Nld3Iv?=
 =?utf-8?B?U0R3dUtobENaL1ZteVhkT2k3TkdTNC9yeE00MzlZRnlxdFFreEltV0tyeDhQ?=
 =?utf-8?B?Q2cvSTdHU0RPWFovMW9GNzAzN25vVVBuR3BSNGdwZzJza1NnZlBTUTNHcU5z?=
 =?utf-8?B?bS9SSWFwYUVmSXhYeTJGaEtBSzd1UUU3RjY0SXhvNzh0ek01anFJNXgrZWE1?=
 =?utf-8?B?bjQyN3lKcGlTbWdxVXBya0g3NGJpcmdPeGZISVJ0UkptYUlDZ01hRytWek93?=
 =?utf-8?B?bTlMMndybHlmT0txcnBBYjJ4TXFMTEtqbTR4dVQ1a3pKWW50cDV5b2p5U0dG?=
 =?utf-8?Q?B88LMJzpzlbv7SfSXS5wO7NiY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5221b26-563d-4449-044b-08dc8a2feba3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:40.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ilVoFMfvKQ+WjFY7JqGPHYo4eoRCSj6l+wb3IIE+zHJVNB3qC31eFTKYaX4ivwLJdcF6C/aCWDYJVRePChZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Use common node name 'mmc' to fix DTB_CHECK warning.

arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 604bf88d70b3a..20f331dc28f13 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -474,7 +474,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			status = "disabled";
 		};
 
-		esdhc: esdhc@2140000 {
+		esdhc: mmc@2140000 {
 			compatible = "fsl,ls1088a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */

-- 
2.34.1

