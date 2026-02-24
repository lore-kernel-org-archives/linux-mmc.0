Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016437BE98;
	Tue, 24 Feb 2026 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931750; cv=fail; b=e6PMLt9z4n9GQoh6pgrzuarMdOPBR+g4g4DuGsJqXN94Qta3y/BUivrHaMAQrv2mHFz88rPX/k3WV8OqhA1TKWiVgkJIX24T0zsWvcn4UCNpMzxBrxHtz3s6Y0uQJgbezCp9YHso3yvDhFVLk6+h/zp5sTugFT931htlFzsBiso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931750; c=relaxed/simple;
	bh=gDt6U78OmWUdw4rQT9akUuhDQKA+pdPqHI6ZGpKG+kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJjPNUTNS/Oshw/QQbMycOHh5W25DqRUknHZmzUmlHFq1eqsn96hE0fLWV9g3oIwEGIoABAr8YeQkQ6ue+NSdIuXNOPctr1ldSbsWQCxeUFCxfqAiYmyzIj6NRCf7bwYYMd+ap7Tm/kQJuMJyj8Yf1Fco8925clk1e0AkAqhQpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gWG47fh3; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gWG47fh3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YY2+sZPoqnuUXuz/UD2a472DRXk4p949OkgaQBIY4J0/+w52LydwMYjLkNp7RTVqDZSpX6Q0cKIjY9dJ2+T/DxWKMX/2tJjmxiFg84oeTWivJH3OeySIAtZ3St4CqzEFJQfDKH86ZgfeWnA+nogTxvbaBI67S9s4leyU1qg8h+qhybIjdiMPOgeawT6dVPqV77jSHlNAR6YKwitSUCJwADKMSf8PibU8ckthywbYJYh9ElEVKDtheVMJt2bC6bumcYwDRwkChW0OqRfsIdSh/ZNcDI8G999hfSVmf9vOj1GNkO3yyGlyTDJmu67h1FE2N4z8fSHhJejPOfr2jPzwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HnxGAbp2yndzQJZkGpfpC3TDryEVoVJW+Ppm2RN9II=;
 b=rXzFJQbCjsOEOwd2iKJn4miUtHGHOn27pd5BskE9DSAevXOI6PGLLTWcfZAqbvzgxIIZfCJoqKI8Ay89LZP6hAQq2KTm1D5I/SjSkwy03ZvcM/44AA0qYbe+BOwD9FurrsrapmPkyqLsC//IAx3j9RnT4IBObpW7oBx8hfRrztEphE1EUwyUR/ifbaYLvKgzHfXIQS5RgnnbCGI8N+bwpvIwz6SQL71Gdgy5Anzblh78jBH1EuYiPeyx7RdSv9ZusuJ2yVEn5YtIZI2w1eWMLLllYHNBRNZeePDWZSvXSmLCK+Vl8NWre4AjKZy14P2vb0IRKxt0d9KbRh0LhsrwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HnxGAbp2yndzQJZkGpfpC3TDryEVoVJW+Ppm2RN9II=;
 b=gWG47fh3QtucfR+VQHRo8mZO5jKgMSE9L14iavMZlGlvIRyz6gesswT442VH48mf58xWc65T4yT9Uj/97sbTv6GSqLkZ0IW467+WYa5M+58Ri9noXzn7fIMUgwP8JDH6sOASIFmtwMP1+LYRVPQaB/yquYxBLn0OSceLpyzoZaJdMm4jVDmoKVziPnPt0XuF4GCk13pgVeYfKBhXnAgUIevlbDngI9yScRXqvpp4IsMZm/Xu80wfz2Chvy9vqFp+/aUAs/HckW64ASdrBtFMlV1ohnLiEhVEqzwBcHKzEAZhonWVaEpIvj+CV884gWAjsWASzauqa76RNG2+xjJlzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB12114.eurprd04.prod.outlook.com (2603:10a6:800:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:15:44 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:15:44 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 2/4] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
Date: Tue, 24 Feb 2026 12:15:31 +0100
Message-ID: <20260224111533.3194883-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB12114:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d775ae-22e6-4ce4-d478-08de73960d63
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzkxaUxvcG12aFZwQ1VCdUNBVlp2Q0tlUDV5clVmRmlXNTZncElBelErbVFG?=
 =?utf-8?B?YzVQNVMzaHF3SXJ0RWMyMi80MUpYRzJIMlMyTkZzVzVUT0IrUC93a2ppdDVU?=
 =?utf-8?B?L0cvUnYzck5mbDhzWkRJN2lwOVZKY3FWRHZEVW5sZzc3VU0vOHUvVGRpYmRN?=
 =?utf-8?B?K1l5Uis3MEVwQmhLclZwenE5aXppV3MyeHZZNGo1QjB0MklQRmJmOWNyN3d5?=
 =?utf-8?B?T3dEZCtBNmpPWVF1Ui9mcEV4UGtPeUhZOWVoNTQwcXE5K2NTVjhtNEE2bDAy?=
 =?utf-8?B?YStIOTVCWFJLL0l0ZnZjdVFHWFFxc1BZdVZ5MkJuTmxQQTdXek5HTzZacUZp?=
 =?utf-8?B?K2dDNGErTHB5Tk9ZbUc1UG5XeDIyRmV0WXc0ZDAxRHhQL2tSNjk1anhERGtO?=
 =?utf-8?B?enVQNDZkWkVZQ3NqajZIeTNHUUhhOC9nVkJrdnhuejJnckhOS0hOOWNWOWll?=
 =?utf-8?B?VUNWdi9JdkRWa2VNVzNnM1JBem9OUUlmNkpqaVZ1OW0xMkwzSmFYakNNY3VB?=
 =?utf-8?B?SnFGcW01N0EvZ0dtMzExTml0Tld2Wm9aOXdCNy9PNms3ZStUZHBzcXRpNWVD?=
 =?utf-8?B?eWsxd2F2ZXNlM3RNdTc2NitxdG9NSFhvekp3eUF6cnNPaUU4Zk5sc1A5Q1hz?=
 =?utf-8?B?WUVjMy9XbTArbkZScGtudmhKT0JOZlJzL0NrNUl3cnlqWC9Ma0dCbFF6ek5U?=
 =?utf-8?B?aG1RcFRmWjJXd2JQSm5odGpEUzBEUVlicGRUKzNUOUIxZE5nWmQvNHJSZ0FT?=
 =?utf-8?B?eXRrNkRRYVk0cm51dGxpM3hMUVRPREVzM3BHVE5hWnJSeGVrS3VjbWh4WHJj?=
 =?utf-8?B?RThMc2V4ei9mK1ZoUXZjOWMrWDJJd0NCODhhM1hMbTRiT3I0VDZZZjZ5YXdv?=
 =?utf-8?B?RHZsbTV2NFJ1ajA1MGtTQmF4UUg3YzRib0ptdzZQRVBYNElQNGpYWm1naDF0?=
 =?utf-8?B?ZW5FTTl1ZHlWbU05ZnUrRzhna3JKdGYwL2k1WkdoZkY0Z0NUSkprQUR2NERK?=
 =?utf-8?B?Y2hYZkoxbFl1cWlXL0VNaVRLZ1Y5L29Ybm9uRmZ4MTJ3OUtRV1lFTXM3dWdV?=
 =?utf-8?B?Y1p2bEM0elRQRzByaXl1RUpDQm1RalI2SHpRVlNSUzE4ZFBHclJsMkcycXFn?=
 =?utf-8?B?TG10WEhzeUl3VGV2NWNmWUZkUW9IbE9XVWIwZXFiM0RnUXdHM0MxMGVXMklv?=
 =?utf-8?B?TE80TGY5REhEaVBKOXN3bENha2ZVM2RZQUpNcTl6RWhQaFdlRzJOb3VUUEN6?=
 =?utf-8?B?NEpuRVVGS29KTTVNd2dpNktLa0svaG41OUwvNnV5MjE1eGtUWmxUenBNazJL?=
 =?utf-8?B?Yy8va0wwUXR3d3FKelI0VVFCK3gvS21jbi9JUlo5NDgybFBNR2lyV2M0MWUv?=
 =?utf-8?B?QUlqK0lVNjBxNlRiZ1NEWXoyQTN0bjFrMEdkeXBxMk14OTZ0d0NPOGxTWXc4?=
 =?utf-8?B?WlBMd09vRURsNWJSSkZvYVkrV0VaWjB1WDdHZjE3ZkVjK09JRzRaTnlieitu?=
 =?utf-8?B?bjNLSkFxU2dxNGdFbkVBTXk2QmxvSDRocFUrVG9jdGhZZ3VWT282aVU1RDU5?=
 =?utf-8?B?Y0xGMGpYMDVYS1d0ZUtyZWNQeis4UWhqbmdpOVFqMTRuWlUxNGoxNzlSN1FZ?=
 =?utf-8?B?SE13dnVZY012SXVaUDhqUjJ5NWxiNkFkZGdyZDlOSk9vVmxDT1dnQjlhUWlX?=
 =?utf-8?B?ZHBzZjFERkk5RzlkejljdEt6ck0vM2ZXS1ZoeWJyOWhmRUhlaWZsZDZudjZw?=
 =?utf-8?B?eGpsSTZFcU5zNWtJVzU1d3JuSkdDQjhpWVVjRU9qS3dJWVpOcENJbWFJSnZY?=
 =?utf-8?B?R1gzcFRPdFlUUjNsL0M5NFhOWXhUU2M4S3N2SlZzdE1NL2pXZXR2QmszTlpJ?=
 =?utf-8?B?Rm9vYkh0UytzTjl0eHpzSXYxMUl6ODFSbmFsc045M1FCdUdQcDFzMDdNWWZw?=
 =?utf-8?B?Zk4raldKc0UwVEFKTGdNbzdQY0dKS1cvejlKWk9uVFRmRHhjdXBZemVDOENY?=
 =?utf-8?B?ai9DY3RJLzBSM05SZzE0RVNLSStvRkF1Z0wydXpMRzFrVlE0QUNUZklHY0RR?=
 =?utf-8?B?Mi9SREx6bWpKUytRLzlzeWNQRGR2YkVYblhnMS9BTGpCMjNpMnA3MnNUbmhm?=
 =?utf-8?B?d2k2b1dHNWxjZ0RrMVVMRko1VitndDlLQXRLMWRiZk82NlpUVGJMVFZRTkp6?=
 =?utf-8?B?WUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJCc2tXRXlNYXJzL0ZpTDhMcXkxb3JMRWlYVEdsczFpWG9ZVSszamJURllF?=
 =?utf-8?B?Q1BSd09YckFCVE1OeGFZbkdUOTB6R1FVRWp3L0xFdzdpOVpnVllpOXVRc01V?=
 =?utf-8?B?eEtTVGV0NWFWN2tmWmFuZFArSmpUclY5OUM0ODFyRnVMbDVJU2lSSCtHRmFX?=
 =?utf-8?B?UEMvRnBvM3hYTUlsWXB3UUdzK2hXemF2SS83aFlYNGl2cndyYWFNR1ZRQXQr?=
 =?utf-8?B?UTNWNFJhTFUxY05CSTZzRk5YcEJvTHVMZUFUYm1jSVBsN3BxYUxOZVhrSlk1?=
 =?utf-8?B?R2VoVG4yYTMvdTlsSlNYSXAyemRtNS9EYUJRMkZpRWlYS3BiNlJGSFJWU1lu?=
 =?utf-8?B?dDExUDFwVk1XU2tMZE1xb29hcFlXWXlxNFNDU3Zub2ErOVRPa0VxOFM4NEJx?=
 =?utf-8?B?MkJyTllqNlVKR29FV3o2Q2F2SWg4Y0IxZE5laUxTbDkrM2pWbnl2RVkrYXdR?=
 =?utf-8?B?MDJzaUJ1YVgvSmNHNklrZXF3RDdpWmgyMjFlTWVNdElWanJ0M3ZnT2piY1Rt?=
 =?utf-8?B?R2h1VWdkTUxDYnhWUkxzRjdMbjloZFoxSklpQjJXNzNaTWpkZkhsUE9JekZw?=
 =?utf-8?B?UzFZQ0ZjV3c4cjNQNDNHTkFyc1R1d1ZGcWVsQ09LQU1Gdk1URGw2RHFuajVD?=
 =?utf-8?B?M1RybXlqOFRTT0ExV3U2YzFaOFEzRXBvTGV1N2hpS21nUm9pYUpHQnArYlNF?=
 =?utf-8?B?czFGRXZFVCtiNlZCSWlrNFN1RmV6ckphQWFLMFdTZ1hlZnRrNnhoUDdReEpv?=
 =?utf-8?B?YVJHdnlMRWNISjU3WEtqU3JVWHJpcHVrRlhoUlh6SlFzZlduNDVKYmhERlA0?=
 =?utf-8?B?VFhTS2xVWWtpZVZJYzAxTUlTcW5SRHhmQjNXeHZoQzRIak9ONjhsdDRJcE5l?=
 =?utf-8?B?aXYrVGM5cUNnaUNhNTNyWlVNcWlucjZ1cWRjNy9UL2orSUYydm5EQ0RtVzFG?=
 =?utf-8?B?blgwd05uTktPK2t2Zk1KdTI5bDMzaDJMdDBXc0xsNDBMendTbFpVbWNVREJE?=
 =?utf-8?B?MnllMmlxdVJkU1hNcHdEZ3RWbTRmTTNnaHFzYllkVVVtNXBta3BIVFk3UnhY?=
 =?utf-8?B?b3hmcEx6dDdrSmdXWnlXdXJMQmJqSkp6d21nTnc1WjNEaGdRWGJYS3BUcXRJ?=
 =?utf-8?B?eE1VQU5peEV6Z0I5VmFWUmZmV0xMUFlOcU9GYlN4RU4vdjBBaFFEQUdUTkpt?=
 =?utf-8?B?RnI1ZEJkZXFZaWx2c0dpQlQ0SWh0VGl4LzRVek5JcWlJcjNidUo2RWYyeXJT?=
 =?utf-8?B?L0VldGFzWUMxYzY1ekpTR0NsUGxHcC96L2wwaVE4Z3VlMzE3ZTc3dERDeVRW?=
 =?utf-8?B?NWNFbERGMTZ6M0U3UnRZSi9ENVcvbHZLWnRscHJTREpuQjNGTzA3WDRrSkt0?=
 =?utf-8?B?UHk5WDlBMGhETmk1WDRVcUFlVEYvZHFldUZHbXlnakVKZE43YVk0Z0kxYU1V?=
 =?utf-8?B?Qk52bVJibTdJYW9pTEZYdUFnYUJyZG1oQnlvK2dmRUtVb2V5Q3E5NmNsN3NQ?=
 =?utf-8?B?U2NiaGNZUXpQUzdQM002b242eWpoOFBNZ1Nhdzk3UlRwcUtCWnNiYmxRY2I0?=
 =?utf-8?B?NXMxcURhUUxvVm1iQUgxRUF4ZTZlcHhWY1Zob2NqenJ3b1BrdlVSMENyNi9T?=
 =?utf-8?B?NlJGclZBaUx5MVZDQ2MrNXNBb0tkUWFmWktCZFZUaVF6WGZKczVKUzRNNldU?=
 =?utf-8?B?K0JvVXJtNVNBR2laZ0hCUzk2aTk4YVI2eStLcUYzcGs2ZXJNMnBKdysyaDFt?=
 =?utf-8?B?STFjSFFyV3RpQk1EV2c4blk1NktkQUVkZ2tCN2NKdVNWNGVUcU9FSGJNTFRS?=
 =?utf-8?B?QW82NzdxUEFac0x4Q2Rqd0xhOTFKejh3a2c3ejJOdUg4NTlYdXJxZW11VTM1?=
 =?utf-8?B?Ym8zeXprb0FicG1QRmZNZ2QzalRSV09LQkQvUDM2S1ZNc0ZaZ2owWjV5Vk5p?=
 =?utf-8?B?L2FCZHJtZnE2ZWFFck4wK3FtMlhkSGFBR3dvWmVaa25pTFl4aThlNWQxMkE0?=
 =?utf-8?B?Zkc0T0p2Q0pFa0wwMWFacVpZZWpXdVFDaTByQlFkSVRWRzFnMWhQZ2NCR0Rp?=
 =?utf-8?B?eGtxNWg1eFd0VVJKc3Y2YXI1SCtSYjU0OG8vckZHUWNiR3hTRFdVNlByWHBP?=
 =?utf-8?B?bjZDMkk1SStuYVlzMVlkcmZqSjFPM2dQL012K0I5QmQ4cDVOc2RocGl5QzFo?=
 =?utf-8?B?U0hLUUV5KzExUlRyOXJDTVZhSXp1Z3pleU55c0lYeEJMNWZraVdGZ2lCZllr?=
 =?utf-8?B?N1Mvd0ZLRkZPdENjL3liYVJrdk1Mbm1UYWc1WFJkOUxVc1pvSzFLU3JpMFFE?=
 =?utf-8?B?dHlVVVVBZVdyeDRlUUtaTjArQ1MxQkRicEcwTFdWTS9qaFcreC9aMFFCeGFI?=
 =?utf-8?Q?3xD1S21BXhdhXbTo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d775ae-22e6-4ce4-d478-08de73960d63
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:15:44.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuX045tdfke98g0qpSw045ZzJ09QkBsWCgoKnAKk3mQ+xkLcQXnSAL3VSTCWOqGw7KrX+6MzT24sUmugOwc0dImVZwb3U3NaKZkBuZHARYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12114

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
NXP S32N79 series automotive SoCs.

The controller is compatible with the existing i.MX uSDHC controllers.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index b98a84f93277..014b049baeb6 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -35,6 +35,7 @@ properties:
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+          - nxp,s32n79-usdhc
       - items:
           - const: fsl,imx50-esdhc
           - const: fsl,imx53-esdhc
-- 
2.43.0

