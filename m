Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1028EF;
	Mon, 28 Oct 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085343; cv=fail; b=HTttyoH2mGJk1tRVjTHb4SpG6SoWmfe5Wlb4Tcrvufw2YlhKDA23qxQFUtLhnO7fyCHTKr+1va/4pAbwqM65l2OxL/aG2p4lfowljlBRzlpF0C0FziS4cpYs3hFjJuvroU8JKAUn/pdv7qCpRV2cP68vbHA9wat4LxjjC5eLzrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085343; c=relaxed/simple;
	bh=7r+JhS+3jKWUhGcZCPfAjpK1dxyicKdhg485ly68WP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJ44uwGH4JKYhJ9iwE3YPVkNFGHS85PF80N53XoASum1pKXXsbeWTPjeQV7jnptYSOdl/5iUcUVCe4u0BxTIoPQJa3KR9wrYK89PJGfsGxThkt/iRpTMyj1PSkelYK9e13U0/Ov7K2UzgQjS9tW0toB54nBuojV38pbbQWaUtIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hvlbrItw; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvlbrItw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boiUPI8fn9G5ulHZevD/h25awJ9l1wGHr5UA3ta9H8qWEdhaJD+N0HVTREbKR9I5CDBgr424UGixUfQ9aJVivI+U7o1jwPSu4/dliXoLJfZiL8FN9NePuBSMUS1C67KbRnDEh2K61fBmefVwTzQaNTJu2ODw8smDYeUhRf5YvRZoHzweg5G27u6w/+jxwgRmNr7skAp7KW0Jm16IzDzwFZarWrLoVsqAwU/spZukpNj5l35AA9qzNNNK4yLFW6G9omMvkkQ6bf6WlP8bjtHnqKxosz3w09J60ZffhkWjbVmraBYX2L9kLYtSiDWml07Zbf8wlwkXkuwXiVgUvECW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r+JhS+3jKWUhGcZCPfAjpK1dxyicKdhg485ly68WP0=;
 b=tPc6s0/FxoG1o/iLL6Q8PcK+mqh+PLWrsw38qdz/RhDH3YYlVutHuos0/SJyYtbPMdSa7paALtsAz/+C1+7v8nGCgog/p0i9Fu+d2pjql9ONSIpH34YRZgyp+iCCqCZEblSfO1EzBlHBWWcrWH8aIucSGCfSJWtGhyzJ3EAlN8TjietIBISuqXRA84HJQgJb3uEBfYVQCg7KerYbHUDg2hFkMOdBPgdSm5jvDW4eQfNmzrvIpbig2tGZszXnhPS9/Z5ZL4WBGY4mxe4w1y25EynmC2stONUBFO7ypKMJ8odgd7T9iZEVF/Z7iV24cWKFFXTy2IxPF+7Ndc7Q10bCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r+JhS+3jKWUhGcZCPfAjpK1dxyicKdhg485ly68WP0=;
 b=hvlbrItwfxfo434OK0ip33LrpPDgKcF6GbUSkQ9Lf4w7M0dLr5uBn+4HODCL2FIF6WrmmVkJAGJSGfpVbe1c9Lk1OQ1xbiXTNUQqApQrFq2AAw5WhJzZptT6tqPORisezhcKKwStw2l/cfvbM67iGR9/a4MDn+PRNkSZhyxqDKNX6dkmOHhpMi9xFvENXFwfRiDbJzn/LqMbN4KMaBMhyzKQkQ+V952bj1W4vOfVSzidhnmXn7AmV6A2OevZd128/rzi4fW35YwKL2W4odMxo/1s/gz0L+tbOIevPnjgepYXWSBwK7uYuayFFlDWGD2XXL9J4E9ptM+bgjqIsnnYjw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS5PR04MB9756.eurprd04.prod.outlook.com (2603:10a6:20b:677::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 03:15:37 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 03:15:36 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Josua Mayer <josua@solid-run.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: yazan.shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
Thread-Topic: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Thread-Index: AQHbKH5LcX/pcU7hiEe46rC2ml7debKba/0AgAAN+EA=
Date: Mon, 28 Oct 2024 03:15:36 +0000
Message-ID:
 <DU0PR04MB9496769805197714F198EC0F904A2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
 <PAXPR04MB84591664B7A4455E6F0BD19E884A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB84591664B7A4455E6F0BD19E884A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS5PR04MB9756:EE_
x-ms-office365-filtering-correlation-id: c2603eb2-c498-4361-78b7-08dcf6fecae3
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmVXN0tKZmp3Z0ZYdmt2V3FqT0tlcWtiUnZ2cXlhM25TWURHdTFTUjQwUm1S?=
 =?utf-8?B?Kys3Tk1MaDNORTZxd3RMazNOYmZFbmFZNWxYLzBoTUdIWVZFQThMR1FqL3lT?=
 =?utf-8?B?dmorcHlFbmsyQnNVZ0pZUm85eE5hdXNhZjAvbFhPelFUZThmTy93KzdtczVw?=
 =?utf-8?B?azJhdWFuc0Vya3FEZXhaSjJldWRKQVg0RXhKMnJIZzFWTmZmUmk3OWpTZUll?=
 =?utf-8?B?RXZ0c3E3V29CLzYxOERlRzBGZEt1eDhDOE1Ic09NWGszTkpLWFZkeHRTR3pa?=
 =?utf-8?B?S200UXlWRlljeFdEMU9Od1JkTUJQWFU2NTRoS1NCeTY1cStjOHB6SkJTTWRk?=
 =?utf-8?B?VU0va3VPRS9WZ3BSVDZ3MkxQYWpiU01wVHQvbWtGaVo0WVc1b1dlbTVRcVE2?=
 =?utf-8?B?M3VnQ2JqZ2JVdVZHVXpNK3ZYU2xONnVIZ1lWL3QwQzlFMkNPWlludFU5WXVt?=
 =?utf-8?B?N29Cbi8xR3hKY2Z4anp4Tkh0emZTYXNpMlJYYy9XQVVCUno4cllmN1psc1NO?=
 =?utf-8?B?aS9Da2wzbUZlZlVwaFhIRHkrc1FjWEVwQnVCdnVISzNWeGZMRWg5UDcrMVpZ?=
 =?utf-8?B?YytudGVHVzl2WE5KTTRNQVZRTWFmd3cxYUMwYkdEN2Zvbk1SakgwQVpaaW9R?=
 =?utf-8?B?d1huTTdTTEpHVXFpeWptN0w3ZnNkVTI5RVFLSzY3Z2JDMlV3SmZOa25lQzdt?=
 =?utf-8?B?aUNleC9zYTZFd1RmQ3g2cU9YaEdkMk9pVGdyMVdpRmg0cXAzRmdsZzRINlBq?=
 =?utf-8?B?V3NldFU3MWRTV2hZMUhEYVM1MnlwamhTaFZJQi9vSk9YV2FtNTZEV043bmJB?=
 =?utf-8?B?V1VnRTZLNUJ5dkZVVUhnNE5yVDNWNFg2QXFtUkMraHhNbllxSTdkZEh6ak5M?=
 =?utf-8?B?bjhxQ0N1Q3NCdUN4MVVkRUFUMjk3bnd2cEdMdUpnUzcxQXU4N1hlMzF2aXRy?=
 =?utf-8?B?MzFEYk9zQldSbTZPR3lweE5MSjNZR0h0SHpsb2xmWUZBYm96TWtYazhsSjdO?=
 =?utf-8?B?MWpzVHY1VkpsbjBsMnlYL3JPSmZCK25UZHhOOWpIdjgxZEtDQVZ0RXF2MW5H?=
 =?utf-8?B?cFBYL1R5aUZhcU05ekJoTzdvQVlQMVpPanBLZ2JENFlyVEpkdUV4NXZZRVNP?=
 =?utf-8?B?dFBTRFUzMWJWQVRLUFlNeWtPK0dZMzE1VVVXeGVyR1NBM21RNHltUE9CVm50?=
 =?utf-8?B?K0s5cE1vN08waENhZXBoVGRoNTB3T2ZLbGRaSS8rTlRQZ1VjekRra1NkbVAr?=
 =?utf-8?B?eEFRRTRubFUvNDdRQm5sZWExUVFBQVM5dXJZR3dpWTM3WFp5cVBGakZVcXor?=
 =?utf-8?B?ekNzTEt4R0FVdXZHTlhYSTB6aXhoSXRHZU9RRWRiUmt1dzNZK3IyVW80emFw?=
 =?utf-8?B?ZmxrMlRrSk5RaWNHNWFDUW9sNmFQOG02cS8rZ0ZDUkpFWEZMa3hlYXpVR1Jz?=
 =?utf-8?B?dlNvR0VYVDEwSEtOcDloenhsNFpBTlJzT2NSWW85Vm5jTGhoNlVYMXZiTHMw?=
 =?utf-8?B?VUY0SE1TUWJ3RER1QzN3ZXZhRTBrSFBqUmlFUXVxQ3JoUFNPOXpyMXdIVkJJ?=
 =?utf-8?B?OExNcEZXQjVuSjNqdy9McDJ4TlFNb0ZkOStFSmttc0EyRWhReEU3dlkwdGVn?=
 =?utf-8?B?NHFOZnEzQmF1b3RVRXJ4VE5YNGcxWGF0UTk3T0VrOHFxQkNnYnMzblRVZndx?=
 =?utf-8?B?emN1TDJTNm0xSTZaeEJKSmcveTV4Uy9jQU1WYlYwMmxFSVMrcThMc0FrbEVx?=
 =?utf-8?B?eG9BdzJ4UE1uYmkvLzFuK2xRajRmVFNtbld1UEFNd0dHTUFqWlVzR0FCaWI2?=
 =?utf-8?Q?EtTDOe/GZuWKyEEJufqS3yyrnaqT0RKYxTrxg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1JhbEcrMUlJOWRQSW1uaHYxQ3Y2WFpocU4xL1lXRmxQQ2kyM1RHN01NQzBP?=
 =?utf-8?B?Ti9NTnRqRllTbzF5NFVYTUsvNWdQM3o2alpFNTNiWEJGeTg0b1htUEpwMUl6?=
 =?utf-8?B?UTI5cXkzV2p3WmtDS1J0M1FObnNpQTEvQVVWejhnYWlFTG1Xb3kwMU5ud0cz?=
 =?utf-8?B?VXdPNHNmdWJGMnI3SzRDekx2ZFpOSnRyR0JQelc0SXB3akw1U1hURnhTb1V6?=
 =?utf-8?B?RklQQ0FXMTZISGlyWGlteFFuL0RlRFBnUTJCYUE4ZDFzaURyQ1BJdCtITms2?=
 =?utf-8?B?YjAweGQzYXEzejZMcnM1bDFnUmIvVS9qWGRpNVhKZEl0Tmx4WDk0NmszeFli?=
 =?utf-8?B?QzZTZ0FBTDFmQi9hejZNamc3WGhiNFZrejdYMkdZKytSWXFpTHJJS0ZMWWhI?=
 =?utf-8?B?SDNjODJHU1RsZ1lrRFMzTmplM1doMlpneUt1QVFCRVI4dlNGcXFQZWJLeXBF?=
 =?utf-8?B?ckYvdHJVUmhsblF2Q0VPSDNKRnFGdDlseU9rMWZ1TUhoSUlhQ3VCN1AvS2ts?=
 =?utf-8?B?WHBhdFRSdWpEeXpDdHRqY2wzTWpvdmt0dTByRlpUZTZpMGIzalRXakZhSmtH?=
 =?utf-8?B?aGlOS0JqVXZrb3phcERIMnZSTXEweGVGS1M0anBKa3dUNGJIQTYyMStycFR1?=
 =?utf-8?B?NFNvT2xwRFNBZmM2TjkwcHlobkl3NncyZ0N6bW9NM1RZYUY5VFBNZkZHOXha?=
 =?utf-8?B?RnpQejh2VXQyRlI2amxnbmhsZVlGTXRSdGhVZlJZbFVHZEEzWFFYb2pRWmhK?=
 =?utf-8?B?VWxuazByZWhkZ2tGRUdaTmRWQktxUWV3UThvL0ttb2hwbzQ2RTUrOUdxYlpa?=
 =?utf-8?B?UlByRE9LYTBlUS92aUtidE1zUUxSYUhZNDNuTG0wdkxXNGluZ09lZ1crWWYw?=
 =?utf-8?B?R21raWJpUVFPbGtjMlhpa3FqNjlHek9qMGhCb0xYY1FHNGxMN3AzcHBTSmt3?=
 =?utf-8?B?NEcyclhSNVpwNVRhRGxBS0FNcjVxMmt3TktZU2J2dkh2cHI2SDRVeUgwOGdD?=
 =?utf-8?B?OUpFb2ljWld5RUczZThpOGRvYXU0RkFhTDQ0NmdLS0ozRndZbXBiR3Rtd3Vz?=
 =?utf-8?B?YmlPWm5UNUpXdnVhRjgwUGRmZFIzaXdhSkMxNXpjVms1NDAvb3YvY2lxR1NU?=
 =?utf-8?B?WlJCR212aE5YQXNpNmRDai9WYkZ0YS9iWkZrWi8vMWhtYS9HUEdIOTdZM3VO?=
 =?utf-8?B?K2R5c2xhVlNzNFNGT2FXaEJ4UkFzMG9MbTZlMi93RFdSWDBPd25PS29RSnR4?=
 =?utf-8?B?SE9Db2pQMWlPQjZyYWZvV2lvOThEODNMUGtkcUo0Tk5TemkrQ1RkMlY4Q2x5?=
 =?utf-8?B?UGVlUUFyeVdNcWhlejEyWWtKaEZCWXZkdk5iMDFETXR3eHIwK2plR0FscG9u?=
 =?utf-8?B?Z2UxaEZXT3BXMktTSGZQNG83WU9iL3krejN0cHdlZE5JL3pMbGxncGx3TUZo?=
 =?utf-8?B?VmhKNWFKcEZ1cWVKUFBTakpPenQyK0tCdHJHR0tOOWhzeFN6aWdleDJtWVVq?=
 =?utf-8?B?cElvd3d3YzF4Skh1SWhFMmswK083QnJrbVhzZTBWK1BDenB0RWhzYWo0RS9R?=
 =?utf-8?B?Y2FzTUpqSWJaSUZhZjBHd1JwZWFFbVBxTkR2SmVSaWFjdUw5ai9YbWQrVjUz?=
 =?utf-8?B?RUxYdkhxMHoyWDZiSDA3N3MxVDFEZEZESU8xM040czVqYVIxRm9ZNWFqVVUv?=
 =?utf-8?B?VUNwclpqQm9OcFVrd2lUNGlXeVZFRktDVWV1dzJPL0dzRndxalVsbjVCZnpC?=
 =?utf-8?B?ZVU2Ykx1RFVnTWFmMjgvYW0ycXVlSFhieFZQb2dRSlZ5RXU5Y2FjTlNvZzZ2?=
 =?utf-8?B?Ky94WWRCTnMraW05MVZMYkk3TTliNk5yVnh1a1VlME80ZGV3c3NwWkZibitj?=
 =?utf-8?B?emhYbHRGalNkV1NwYUphSWw2Q21TVXZoVzh6V0Nsa1QzT2x2Y2RUV3RhOGpa?=
 =?utf-8?B?dzdpRlN6aWdQYXNMdG81bE53Z1pNV3Bqa29XQ0ZjRVZmUUUrNHYyeUx0emFo?=
 =?utf-8?B?ZTBPUEo5bnRWY05UQVZOa0U0RmFyS2FJVkNnRk56S2NDbmp5czdnTVUwaUVP?=
 =?utf-8?B?T3cySVIyaE8xY2dCaC9ET0RhNERYTVJVcW5TK3NuelRLb0wxc0VaVW9lMEFD?=
 =?utf-8?Q?O/Kg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2603eb2-c498-4361-78b7-08dcf6fecae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 03:15:36.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRjZTuL6KMQjiChr7wb+TiIXtjNEsFb2WVtL5UjwQXXf8YMQtf+GljC9wYv8zHqtiHEaa98BMY6oYyup1J9gfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9756

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMjjml6UgMTA6MTANCj4gVG86IEpvc3VhIE1h
eWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFuLmh1bnRl
ckBpbnRlbC5jb20+OyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBVbGYgSGFuc3Nv
bg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJv
bml4IEtlcm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiB5YXphbi5zaGhhZHkgPHlhemFuLnNoaGFkeUBz
b2xpZC1ydW4uY29tPjsgUmFiZWVoIEtob3VyeQ0KPiA8cmFiZWVoQHNvbGlkLXJ1bi5jb20+OyBp
bXhAbGlzdHMubGludXguZGV2OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPiBkbC1TMzIg
PFMzMkBueHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIG1tYzog
aG9zdDogc2RoY2ktZXNkaGMtaW14OiBpbXBsZW1lbnQgZW1tYyBoYXJkd2FyZQ0KPiByZXNldA0K
PiANCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIG1tYzogaG9zdDogc2RoY2ktZXNkaGMtaW14OiBpbXBs
ZW1lbnQgZW1tYyBoYXJkd2FyZQ0KPiA+IHJlc2V0DQo+ID4NCj4gPiBOWFAgRVNESEMgc3VwcG9y
dHMgY29udHJvbCBvZiBuYXRpdmUgZW1tYyByZXNldCBzaWduYWwgd2hlbiBwaW5tdXggaXMNCj4g
PiBzZXQgYWNjb3JkaW5nbHksIHVzaW5nIHVTREhDeF9TWVNfQ1RSTCByZWdpc3RlciBJUFBfUlNU
X04gYml0Lg0KPiA+IERvY3VtZW50YXRpb24gaXMgYXZhaWxhYmxlIGluIE5YUCBpLk1YNlEgUmVm
ZXJlbmNlIE1hbnVhbC4NCj4gDQo+IEJ1dCB0aGlzIHJlbGllcyBvbiB0aGUgUEFEIGJlZW4gY29u
ZmlndXJlZCBhcyBSRVNFVCwgc2hvdWxkIHRoaXMgZmxvdyBiZWluZw0KPiBkZWZhdWx0IGVuYWJs
ZWQgd2hldGhlciB0aGUgUEFEIGlzIGNvbmZpZ3VyZWQgYXMgUkVTRVQgb3Igbm90Pw0KDQpObywg
ZnJvbSBteSB1bmRlcnN0YW5kaW5nLCBldmVuIHRoZSBQQUQgaXMgY29uZmlndXJlZCBhcyBSRVNF
VCwgc3RpbGwgbmVlZCBTVyB0byBjb25maWcgSVBQX1JTVF9OIHRvIGNvbnRyb2wgdGhlIG91dHB1
dCBvZiB0aGlzIHBhZC4NCkpvc3VhLCB5b3UgY2FuIGRvdWJsZSBjb25maXJtIHRoaXMgb24geW91
ciBib2FyZC4gQnkgdGhlIHdheSwgSSBjaGVjayB0aGUgY29kZSwgd2hlbiB5b3UgZG8gdGhlIHRl
c3QgdG8gc3VwcG9ydCB0aGlzIHJlc2V0IG9wZXJhdGlvbiBvbiBlTU1DLCBkaWQgeW91IGFkZCAg
ImNhcC1tbWMtaHctcmVzZXQiIGluIGR0cz8NCkZyb20gY3VycmVudCBjb2RlIGxvZ2ljLCB0aGUg
Y2FsbGJhY2sgeW91IGFkZCBoZXJlIHNlZW1zIG9ubHkgY2FuIGJlIGNhbGxlZCBieSBlTU1DIGRl
dmljZSwgc28gd2lsbCBiZSBzYWZlIGZvciBzZCBhbmQgc2RpbyBkZXZpY2UuIEFuZCBpZiB5b3Vy
IGFuc3dlciBmb3IgbXkgcXVlc3Rpb24gaXMgInllcyIsIHRoZW4geW91ciBjaGFuZ2Ugd2lsbCBh
bHNvIGJlIHNhZmUgZm9yIGVNTUMgZGV2aWNlIHdoaWNoIGRvIG5vdCB1c2UgdGhpcyByZXNldCBm
dW5jdGlvbiBiZWZvcmUuDQoNCg0KPiANCj4gPg0KPiA+IEltcGxlbWVudCB0aGUgaHdfcmVzZXQg
ZnVuY3Rpb24gaW4gc2RoY2lfb3BzIGFzc2VydGluZyByZXNldCBmb3IgYXQNCj4gPiBsZWFzdCAx
MHVzIGFuZCB3YWl0aW5nIGFuIGV4dHJhIDMwMHVzIGFmdGVyIGRlYXNzZXJ0aW9uLg0KPiA+IFRo
ZXNlIHBhcnRpY3VsYXIgZGVsYXlzIHdlcmUgaW5zcGlyZWQgYnkgc3VueGktbW1jIGh3X3Jlc2V0
IGZ1bmN0aW9uLg0KPiA+DQo+ID4gVGVzdGVkIG9uIFNvbGlkUnVuIGkuTVg4RFhMIFNvTSB3aXRo
IGEgc2NvcGUsIGFuZCBjb25maXJtZWQgdGhhdCBlTU1DDQo+ID4gaXMgc3RpbGwgYWNjZXNzaWJs
ZSBhZnRlciBib290LiBlTU1DIGV4dGNzZCBoYXMgUlNUX05fRlVOQ1RJT049MHgwMSwNCj4gPiBp
LmUuDQo+ID4gcmVzZXQgaW5wdXQgZW5hYmxlZCwgTGludXggdjUuMTUuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDEyICsrKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBpbmRleA0KPiA+IDhmMGJjNmRjYTJiMDQwMmZk
MmEwNjk1OTAzY2YyNjFhNWI0ZTE5ZGMuLmViY2ZhNDI3Y2NhNmNjMjc5MQ0KPiA+IGExNzAxYTM1
MTVlZjY1MTU3NzlhYTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMN
Cj4gPiBAQCAtMzMsNiArMzMsOCBAQA0KPiA+ICAjZGVmaW5lIEVTREhDX1NZU19DVFJMX0RUT0NW
X01BU0sJMHgwZg0KPiA+ICAjZGVmaW5lCUVTREhDX0NUUkxfRDNDRAkJCTB4MDgNCj4gPiAgI2Rl
ZmluZSBFU0RIQ19CVVJTVF9MRU5fRU5fSU5DUgkJKDEgPDwgMjcpDQo+ID4gKyNkZWZpbmUgRVNE
SENfU1lTX0NUUkwJCQkweDJjDQo+ID4gKyNkZWZpbmUgRVNESENfU1lTX0NUUkxfSVBQX1JTVF9O
CUJJVCgyMykNCj4gPiAgLyogVkVORE9SIFNQRUMgcmVnaXN0ZXIgKi8NCj4gPiAgI2RlZmluZSBF
U0RIQ19WRU5ET1JfU1BFQwkJMHhjMA0KPiA+ICAjZGVmaW5lICBFU0RIQ19WRU5ET1JfU1BFQ19T
RElPX1FVSVJLCSgxIDw8IDEpDQo+ID4gQEAgLTE0MDIsNiArMTQwNCwxNSBAQCBzdGF0aWMgdTMy
IGVzZGhjX2NxaGNpX2lycShzdHJ1Y3Qgc2RoY2lfaG9zdA0KPiA+ICpob3N0LCB1MzIgaW50bWFz
aykNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgZXNkaGNf
aHdfcmVzZXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpIHsNCj4gPiArCWVzZGhjX2NscnNldF9s
ZShob3N0LCBFU0RIQ19TWVNfQ1RSTF9JUFBfUlNUX04sIDAsDQo+ID4gRVNESENfU1lTX0NUUkwp
Ow0KPiA+ICsJdWRlbGF5KDEwKTsNCj4gPiArCWVzZGhjX2NscnNldF9sZShob3N0LCBFU0RIQ19T
WVNfQ1RSTF9JUFBfUlNUX04sDQo+ID4gKwkJCUVTREhDX1NZU19DVFJMX0lQUF9SU1RfTiwNCj4g
PiBFU0RIQ19TWVNfQ1RSTCk7DQo+ID4gKwl1ZGVsYXkoMzAwKTsNCj4gDQo+IFBsZWFzZSBhZGQg
YSBjb21tZW50IG9uIHdoeSAxMHVzIG9yIDMwMHVzPyBUaGlzIGlzIGJvYXJkIHJlbGF0ZWQgb3Ig
c29jDQo+IHJlbGF0ZWQgb3IgY2FyZCByZWxhdGVkPw0KDQpBZ3JlZSwgcGxlYXNlIGFkZCBjb21t
ZW50IGFuZCBleHBsYWluLg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBUaGFua3MsDQo+
IFBlbmcuDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBz
ZGhjaV9lc2RoY19vcHMgPSB7DQo+ID4gIAkucmVhZF9sID0gZXNkaGNfcmVhZGxfbGUsDQo+ID4g
IAkucmVhZF93ID0gZXNkaGNfcmVhZHdfbGUsDQo+ID4gQEAgLTE0MjAsNiArMTQzMSw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX2VzZGhjX29wcyA9IHsNCj4gPiAgCS5yZXNldCA9
IGVzZGhjX3Jlc2V0LA0KPiA+ICAJLmlycSA9IGVzZGhjX2NxaGNpX2lycSwNCj4gPiAgCS5kdW1w
X3ZlbmRvcl9yZWdzID0gZXNkaGNfZHVtcF9kZWJ1Z19yZWdzLA0KPiA+ICsJLmh3X3Jlc2V0ID0g
ZXNkaGNfaHdfcmVzZXQsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBz
ZGhjaV9wbHRmbV9kYXRhIHNkaGNpX2VzZGhjX2lteF9wZGF0YSA9IHsNCj4gPg0KPiA+IC0tLQ0K
PiA+IGJhc2UtY29tbWl0OiA5ODUyZDg1ZWM5ZDQ5MmViZWY1NmRjNWYyMjk0MTZjOTI1NzU4ZWRj
DQo+ID4gY2hhbmdlLWlkOiAyMDI0MTAyNy1pbXgtZW1tYy1yZXNldC03MTI3ZDMxMTE3NGMNCj4g
Pg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiAtLQ0KPiA+IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xp
ZC1ydW4uY29tPg0KPiA+DQoNCg==
