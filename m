Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013019.outbound.protection.outlook.com [52.101.67.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816471879;
	Mon,  8 Jul 2024 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720406021; cv=fail; b=gdhKVUWdzGt4sDf3i/QxzbYHD5vA8/t7eUlnRnt3zIKqLy7FW7w847Hg4YC0ul0RXOSsRFmMd6wS+znIcGzvmm3AApvGi4Z6mel06dA71ha6KLdUbFWebvxrix9wDPkFUgJIlujQ3l/tRskj/UFOK3NmUpKUSBusUG5+OmPWN50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720406021; c=relaxed/simple;
	bh=IxcE+D9zGVhs4NWecDy2H6QZTkD5xOaXY3VGanucIqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=daTh4+m0bZBVUZAXIQhuq/nL4LkELEE719LZxRxoMBW07btv5yUPwjMB8YzVGHLaUOdr2J4p25zompq8343qFf1z95mIzPlgnMU+Sj3/gUPa3wYwOrK39PfpiE01DQWurFralFk39KExPNBMX6VUgjkQV5RxsHop+PUr7xmzli8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qud4R/6n; arc=fail smtp.client-ip=52.101.67.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qud4R/6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djlqx1c/4voxM58K31zpwha23DP6GXo3o+dQKbUWzSfYFCGjUKn2DGYKlm73Ns5MbG0QBgoSK87rP7u7qqK74jv32urzrOqEnyLuTBnbD3ypr8kjj3zgjb0Jyejra/1qB7OUT2yztnkXZvAb5qG6aWf64DNNh33v1dQ04BdIB2G5mk0OdnZQECZF2suHsMogXHLC3rl5mA7DVnTLJ+9H+Am2lCYnDgpPTMeZo0tSZ9HyGDA716/sas29HCwtzE9vQqx+on0KqAyv26azc8OLR+hV0xGRKIX7XENPo5RNtxKmQkB6Bk16L9rLQnXfjEj9JKOKzgM45A5LkuKRCKfr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxcE+D9zGVhs4NWecDy2H6QZTkD5xOaXY3VGanucIqA=;
 b=PrvcIDwnxRVjQSQ/6MfTURKCZsjLV82c9Gc56oArxu5+ft4O1bJm8B4TaCLQyx/LnDOcJSvuxMPC7I348wQF4hqwTeMxMMEm+GRuuUGwR+MQo2UW2rs4fshY4jP2izlhYWEFO/BHLNHkISXv44EMcWxwy8xzynDYYHGrvMHjlIM4xd4KRqs/TaPcXiNGZ91YYMM+Ov1Zljo8L+7Md9s1kYbiaBxjNtSXR/PB6Q5rRTc19mxusXp091GA7MMblgBTuHHXtEmtV5pmjsGc4mcm9yvmpuGF1KfFWDrOaKROzxyFKkS0SUwA8D/rAIbzBnudlnYLENbWjEpqkRsh+O29kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxcE+D9zGVhs4NWecDy2H6QZTkD5xOaXY3VGanucIqA=;
 b=qud4R/6nIi63bI4iXGcKoQjefEDRLBEreKKXo1ozNjKeGWHzZhp6R6Xn3BO7fkhbY3LF4mrV156I2I/3obAec3Rl8cckhptltAERtWP4gijPrgG2n1ofwij7rMSZeztBkTtl4ojtF6HY0jcmrFYsX0WNtsGFpWj6httfi9k5dPo=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GVXPR04MB10778.eurprd04.prod.outlook.com (2603:10a6:150:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 02:33:34 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:33:34 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
Subject: RE: [PATCH 3/4] mmc: sdhci-esdhc-imx: add option to not change
 pinctrl state in suspend
Thread-Topic: [PATCH 3/4] mmc: sdhci-esdhc-imx: add option to not change
 pinctrl state in suspend
Thread-Index: AQHazuHeni4bupq4EkyAuqwNp9/H57HsH1Gg
Date: Mon, 8 Jul 2024 02:33:34 +0000
Message-ID:
 <DU0PR04MB9496E9EBCF92568D459F3F4290DA2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
 <20240705134647.3524969-4-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240705134647.3524969-4-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|GVXPR04MB10778:EE_
x-ms-office365-filtering-correlation-id: e4608e06-b04b-4a92-8098-08dc9ef65d40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmFTbE02KzZFMWlIT2RBWkg3bm9BUGFJZUMrMk5pVG16SXlqTE5CZ1I2TE5C?=
 =?utf-8?B?YjJ3ZUZsWG1lMmsyUTcxMnRUMGMyTkVuZE1lY0NBd0lmcGR6WGMvTjg0M0NO?=
 =?utf-8?B?OUx5RFpoRFZ3Qmkya0doL3FmZG0zeGt5T3ArZURnVzJkYzg3TWtvSnBsdi81?=
 =?utf-8?B?QlI1N0ZQWExLbWtBUGNydWNLNWZpSEl0Mk9QY3JwQTB1QmRIQWZZZzNHY2hX?=
 =?utf-8?B?VjFEZXFRQTMrZ2g2SzZNTlh3MXh4TmlnWEZ3c1lrWW52WnhsVTZ0RXMvWlFv?=
 =?utf-8?B?b0lwV0NzYjhPd3orQlEwZFljUzFhbU9kNlk4cXdZQnZ2MTBrZThza1BkVE05?=
 =?utf-8?B?c1ZTQ3EzNkR6QVdBb00ydkcxQlpMNmllbDlVMHFqdGM3Zmt1Z1V4NUwzMVo2?=
 =?utf-8?B?Q0tzUTJLNmgxNEt6dEVOY3RqL3NVLzRROWVwVVBQRkJlTXJaN29VRWVwbEJO?=
 =?utf-8?B?SjNEd0N2M3dYUWF1S1VPMy95RHJGNVo5WlFtSHNQVzJRSFZCMzhRZzRqQXEz?=
 =?utf-8?B?VEVmNDBvWm9iTzBzZjgyQk9xT1NtQkFwVnRMNXU4bVQzTXpXcDgrWWY5MUpL?=
 =?utf-8?B?RWxQZHhYVkZyNGlhSFA3bEZsc2xtVWFmY3RQbGxxT284MDVPRmJ4RjYxNldR?=
 =?utf-8?B?WmJ1NGFidnIwV2FQZnU4a1Brd0NDQkhlU0tEK2FZQlpPbDY3aVdlWFgzZU5W?=
 =?utf-8?B?UDZrVU9jVThNSS9veEVnK0l2NXdrRnM3emNPdkFnN2VVMmwzeHM0SThjdEhF?=
 =?utf-8?B?QzFyUmt0NVoxeWk4Q1ZCanMrdHo5Y1FlYnFwVVJhMDJnMVRCa3AvNnJmMzkw?=
 =?utf-8?B?T1RzaXhpWmNPZEpXOWF3bEJvcmJqaWdkRXNMRVJhYkVCMGQ1aVVqRmtHNnF6?=
 =?utf-8?B?UTU1Q1BQWjhXNFlpQmc4OThuMklqMUUwL0pQd2cwOEtreHBTRGQ1aEVRaWha?=
 =?utf-8?B?aDNMeVZ0czZaQmwyTFhwTG83RkErRnpxUmJPMExOQU9NNll6NlhocFZXUk9R?=
 =?utf-8?B?TFZ2eXlkYSszWFRTbzAwOStMZE1UWlEwbDBiQy85Nzl1Wld6UVNOK2RENmlF?=
 =?utf-8?B?R2NaejVrSmU1ZytPeGlucndidXRxWDZlWHh5T2owU2tHS0U3b2l4NUVzUERT?=
 =?utf-8?B?eFJoMFhPMUFIT2Z6U3Z4aWRYU2N1OE5oYnB1MmtQSmZWK0xoVEJYMEdkWWJD?=
 =?utf-8?B?QWdrdTFVUm9FTGxxTXpaNXdnT1dzcm1mc3BLUVRqRDRESmMxZGFOZ1dJRWNw?=
 =?utf-8?B?VnExMWQ2VnI3ZnEwR3M0UTdaM2R1REwvelpnR0l3NDN1dGtKNDUzZndqNmZD?=
 =?utf-8?B?eXJnVGd2RHJsTkVOWER3a3l0V2ZCVjdkYWJjbWxMQWo1bnM2WWJZZ3MyZkVW?=
 =?utf-8?B?SnZ2VFl0Wnd4MTRCcWZlSzltbGVvWXpCdlpFRnVxYTRHR1ZlbkNMbFNBNll5?=
 =?utf-8?B?TWtUZUJIY1RwaVB1OW82NEVTNDZiQ2NXanNNUENLbE9LdXF4S1VQSmU2cU1U?=
 =?utf-8?B?bUF5UmtyWktObHA3Rm1MNm1tMTR6VzRoYzgvWHRuNzJZTUxhL1Mzdlp4V002?=
 =?utf-8?B?OGlQVlo5WlZVUTUwQjdDTXl1WTdVRnJJTFRRRWtYK2NocGsxVVV0VDVPOXdC?=
 =?utf-8?B?OTNLZVloZXdIZkZxMGNOWGlhZ2pQUHh1S3pUcWhIdGxtK29QVU5ZdjFONFky?=
 =?utf-8?B?ZlA4OE8wRm1tNEVxaXpNZnluMDlUMURyRlV0alhtamRWY05PZWExYzd2OEN5?=
 =?utf-8?B?OTN5NDYzMVorV09UbTlzbWJXY1phSG5HazU3bDhRSGlEdnJBNTlYc3liZS9x?=
 =?utf-8?B?UXhhWkdPcm5PajFkaE5JeFVkOWJEa1VQelhGdzNaSm9lVnVLSG5peDhKNkcz?=
 =?utf-8?B?WmM5a2pHK25kOFp2OUhMeEkzUG02dDhVYzU0NkJKTTBvSFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFAyQ21OYnNTM1VSdkdkSGJ1WUNRZTBuejNWUVVYUVo3b3I0QWdMMGhvRCt0?=
 =?utf-8?B?Z3I3THYzNmp5Vk1rNG1YSVFvRVZEZk9HQmtLOFV3MmhwUDQwdEZuQ0FLMHRJ?=
 =?utf-8?B?Y0FiU3JQTGJBdXdnWGZwTkRJbzdwNE5RK2hsZVFQbG5raHEvTnhvTGtwa0Jn?=
 =?utf-8?B?aVcwcnl0aTI2dGtVdWsvS0RYSjZacDdPRWo5MGlRQVp4K3hwWkk4TWxlMEFm?=
 =?utf-8?B?cUl4djd3aSt1TTk3MUYyR1k0Z2tGSnMrMVdqMjV5UUtrQjdFVVBNUTNBNGJl?=
 =?utf-8?B?L0RtR3N0ejNXWG8veWdwd3JTdVpjYTNPK3p1WDdiVGQrVEdacHRYUlZGd3BJ?=
 =?utf-8?B?NlhVS2JsZEdZRzhQdHF2OWdZN1dpZGw5TldNbG50VTlYdE5HN1VFTlV1S1di?=
 =?utf-8?B?cFJOUkhMcGJTdnpHcTkxZGJDREZEbmRON3Zpc05tUjNJejk4RzB6TTdGWUJX?=
 =?utf-8?B?WTFtL3E1Rll0TnBrbXdNNUhVUGErbVZMZElJdzA3eXUwVFRoUHVYa1hhaVEv?=
 =?utf-8?B?Mjg0clZoeTFwcE05OXViL0JDS1JKNjJncVJveUdneG5tV2xLcjhoMEtKL20x?=
 =?utf-8?B?QlVlL3BxdGxBUEZBQlVHOVNWU0h2VmZadHJsb0xuUXNnT2sxT1REQTk5Vkw2?=
 =?utf-8?B?U3FFdWdVTnpYL1BiY3ZickJPeW8zOWFtRCtJNUFEMEJaeWhvejJMYkI0NFU5?=
 =?utf-8?B?c3FMdzdUYmlxVXhiMVh4bTgzNG15T3piZGNzeklQNTA2MEFiVUNpK0NXN0pm?=
 =?utf-8?B?dmpSb0tLeXJjRXUrWVlhdnVIOWJZdnRVbGFjNXdYemJyUk9WdUtEYTZPOHBu?=
 =?utf-8?B?bGtGMW5WMUZSK3laUzNTdnJNZDIxcDJEaXZpRzI5OHJZZUFNdEhScDV0bjlS?=
 =?utf-8?B?OE9ZSXpKekdiN2FBWitkdWM3NTVkMVpqZ1poZVhEaGJKMnFKTkZHcFhOMEhZ?=
 =?utf-8?B?QTBlUzZCS0V1M3VqU2krdUh4bWZBOS9ZS3hRdkhaYVJOWGVZMXgrUHB6WXlv?=
 =?utf-8?B?N2hpZ2loVTAyZWlLTVV5dHNjM3Vvb3N1YVFSdTBvK0xxa05KOUJ1VmpBbnRN?=
 =?utf-8?B?YWFBRkRFYVJQbFI3NFhBdDg5WHEreXlZMFUrK1IvU3lQNXJEaEdSUnVYYU94?=
 =?utf-8?B?a2RyR0tEc3UzNE9SVTBtUzBLMThubXJwcnB4RkFuZWgyeFZJNmI5OTJZeTlV?=
 =?utf-8?B?WUg1YWF1ZnJpdnJXUGUyVXJ3MzRNMHBVT3JOSVl0Y01mOFJQTCtiT2x2eHU2?=
 =?utf-8?B?T1llYm8zUTdROWU4dlptUFBnVXFwSnVBSE8zZkhYVGp3c2k0QjBLeldHL3VG?=
 =?utf-8?B?R0tRWDJtdDRad3UzVjhibFkyWDEvbHBWQW44YzNOUHZoUTUxdlE5UmdlZ1RX?=
 =?utf-8?B?cEtqVmJWWVJaOFpDaUhmM0piZXNINmt3SnkvdUg1M0NHZVkrdEw4eEtQMkhM?=
 =?utf-8?B?a09PeHMyTVIvajQrbWNWZGJRRkhwbDFFUXJscURoL2hsZlNhVk1jSEIxblNF?=
 =?utf-8?B?ZjI2OU5sVW5VamFyRitXYVJycGd5d2Q4Tzl1QzhBU3NRK1dPUEpFMytjcVZO?=
 =?utf-8?B?UTcydXZCZUkwZXhCdUVzR3JSWVlZT0ZQRlhLbmdvYkkva0F4TWRwMk81bEhI?=
 =?utf-8?B?RVFTVUhHZkZEamNPcVg4Q1FPQWpqSkpVeFdaM3h6RUx3QUxQR1RuaUFhcXV0?=
 =?utf-8?B?QTdFMEl0N1luUlpNZjdEcC9jeEVxNCtDTkVIa1YvM3R3azJuRHd3WW1DdERD?=
 =?utf-8?B?ZG5rQ1doY1J4bVM4dEczRlZIU253THpPVzJMS2RzQXIrL1VTMkpXN1FzVkV3?=
 =?utf-8?B?ZE5Wd2pSZXBrZDZ3bU4yOEhXSUc3bVJJOGE5SnVCTmxwY2xUekYzS0hwMGtL?=
 =?utf-8?B?MFFHaDkrVDZQdjJ0ZUlOdTFER2hkS3FuRHhDd1Q1bUhpWnhaZmlJa09Mdk5E?=
 =?utf-8?B?N0dOMTM4SzkwUUlpclY4NVZIN0lKaDZSdTZuUGZsNHVDR0VaV204bTdVTndy?=
 =?utf-8?B?Sk9kWE0zblJVTnFtNTUzd0tpYUZ4RW0yRmJDZ0ZQeDB6TFVJOUEzZWtCSmdP?=
 =?utf-8?B?YU94TmdBMllycXBkVG5WZGJSYTFYWmNhOTQ0VWNJelprVHdNVjZZank5ZytP?=
 =?utf-8?Q?l6IY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4608e06-b04b-4a92-8098-08dc9ef65d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:33:34.3041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AX5cQqhvYqPEX87CGsQa//7//QLoVQP4QuM803Cii0MhoBHsuhUsGRwf5EJid98JmOwulZF6NKuSaaMRPiIl1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10778

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI0
5bm0N+aciDXml6UgMjE6NDcNCj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47
IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25p
eCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1TMzINCj4gPFMzMkBueHAuY29tPjsg
Q2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpDQo+IDxjaXByaWFubWFyaWFuLmNvc3RlYUBvc3Mu
bnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDMvNF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IGFk
ZCBvcHRpb24gdG8gbm90IGNoYW5nZSBwaW5jdHJsDQo+IHN0YXRlIGluIHN1c3BlbmQNCj4gDQo+
IE9uIHNvbWUgYm9hcmRzIHN1Y2ggYXMgUzMyRyBiYXNlZCwgY2hhbmdpbmcgdGhlIHBpbmN0cmwg
c3RhdGUgaW4gc3VzcGVuZA0KPiByb3V0aW5lIG1heSBub3QgYmUgc3VwcG9ydGVkLg0KDQpJZiBz
bywgd2h5IG5vdCBkb3AgdGhlICJzbGVlcCIgcGluY3RybCBpbiBkZXZpY2UgdHJlZSBmaWxlPw0K
DQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IEZvciB0aGlzIHNjZW5hcmlvIHRoZSBu
ZXdseSBpbnRyb2R1Y2VkIGZsYWcgJ0VTREhDX0ZMQUdfU0tJUF9QSU5DVFJMX1NMRUVQJw0KPiBp
cyB1c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2lwcmlhbiBDb3N0ZWEgPGNpcHJpYW5tYXJp
YW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
ZXNkaGMtaW14LmMgfCAxNCArKysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4gaW5kZXggOGYwYmM2ZGNhMmIwLi5jM2ZmN2ZjY2QwNTEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMjA0LDYgKzIwNCw5IEBADQo+ICAvKiBU
aGUgSVAgZG9lcyBub3QgaGF2ZSBHUElPIENEIHdha2UgY2FwYWJpbGl0aWVzICovDQo+ICAjZGVm
aW5lIEVTREhDX0ZMQUdfU0tJUF9DRF9XQUtFCQlCSVQoMTgpDQo+IA0KPiArLyogVGhlIElQIGRv
ZXMgbm90IHN1cHBvcnQgdHJhbnNpdGlvbiB0byBwaW5jdHJsIHNsZWVwIHN0YXRlICovICNkZWZp
bmUNCj4gK0VTREhDX0ZMQUdfU0tJUF9QSU5DVFJMX1NMRUVQICBCSVQoMTkpDQo+ICsNCj4gIGVu
dW0gd3BfdHlwZXMgew0KPiAgCUVTREhDX1dQX05PTkUsCQkvKiBubyBXUCwgbmVpdGhlciBjb250
cm9sbGVyIG5vciBncGlvICovDQo+ICAJRVNESENfV1BfQ09OVFJPTExFUiwJLyogbW1jIGNvbnRy
b2xsZXIgaW50ZXJuYWwgV1AgKi8NCj4gQEAgLTMwMSw3ICszMDQsOCBAQCBzdGF0aWMgc3RydWN0
IGVzZGhjX3NvY19kYXRhIHVzZGhjX3MzMmcyX2RhdGEgPSB7DQo+ICAJLmZsYWdzID0gRVNESENf
RkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiAgCQkJfCBFU0RIQ19GTEFHX0hB
VkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDANCj4gIAkJCXwgRVNESENfRkxBR19IUzQwMCB8IEVT
REhDX0ZMQUdfSFM0MDBfRVMNCj4gLQkJCXwgRVNESENfRkxBR19TS0lQX0VSUjAwNDUzNiB8DQo+
IEVTREhDX0ZMQUdfU0tJUF9DRF9XQUtFLA0KPiArCQkJfCBFU0RIQ19GTEFHX1NLSVBfRVJSMDA0
NTM2IHwNCj4gRVNESENfRkxBR19TS0lQX0NEX1dBS0UNCj4gKwkJCXwgRVNESENfRkxBR19TS0lQ
X1BJTkNUUkxfU0xFRVAsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2Rh
dGEgdXNkaGNfaW14N3VscF9kYXRhID0geyBAQCAtMTg4NCw5ICsxODg4LDExDQo+IEBAIHN0YXRp
YyBpbnQgc2RoY2lfZXNkaGNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJaWYgKHJl
dCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+IC0JcmV0ID0gcGluY3RybF9wbV9zZWxlY3Rfc2xl
ZXBfc3RhdGUoZGV2KTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiArCWlmICgh
KGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfU0tJUF9QSU5DVFJMX1NMRUVQ
KSkgew0KPiArCQlyZXQgPSBwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0ZShkZXYpOw0KPiAr
CQlpZiAocmV0KQ0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwl9DQo+IA0KPiAgCXJldCA9IG1tY19n
cGlvX3NldF9jZF93YWtlKGhvc3QtPm1tYywgdHJ1ZSk7DQo+IA0KPiAtLQ0KPiAyLjQ1LjINCg0K
