Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592513C8EA;
	Mon, 15 Dec 2025 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765764356; cv=fail; b=NH7jGnHZkXgYIVIlwmAXnlSUiupKECWpAAJ7+08XYKUiBd9tOswyCVVG5s4y60hA2l0JcE8aYrFG9VNDvBC421nzIks93AjqjNChWSVjTZaAcwknPBk77CmDYvo/9Sf6RQCzT9PYslYdzJlIrk+NyxwdpoAAUhA9arRc1tFa51I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765764356; c=relaxed/simple;
	bh=TFe+SsfqrHcTUzW6My3ZbJJ+/v1qmr8o2Az1mFeXSXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFR9J2eRnpRvhBNAsw8cK3gC5F9JmjBTJcxFW0WvnWuJjdK2hSb5bCJyANNyT9SI4cUnVScSJviT11AY6bNsGSGYdN/bDTakaWdE3iEAWByUYlY4B6AepdMAVg/FoaZH/QKzR3gMBNXPKbvg0lRPNst5n3D58gD4tm/2nNwiv9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y6u1ee7g; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y6u1ee7g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUOELZHRSkzJcRkS6Hmpp7huEq9i5mmKLY/AVSCHQAM/rHMOe50nfGcds1eqLl89XKCsXGf0hEaII/CG/oRjHHESw/f04Iz3SYZLFDS8Adb9ISrEcoRu7ZSbqVczdeKZfl4c4cuDCCRyhSQEJPWjQ1Y/6vyhEq9nqsnSox4vvUcETr1qY7t/s8fgOoIEbYC1NM0Rm0dso3q1/hcVXiIcQRtKcY1zTdEYWubzb1281HvPj5PzsV8QsJ6dRNRXAY/QAdBWowlP9wPJHfhFgxEqt4eOEbxwda8YDrkOC1WABu3QHSGAM+Jco46M4MGicAS9rtcgcMwmcWPK/trf6qh2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFe+SsfqrHcTUzW6My3ZbJJ+/v1qmr8o2Az1mFeXSXY=;
 b=JiQ0tuL8TKC0LlolV/MCCS0GqNfEykqnj6YW+MURPP0x4rdezLcmuJ2PznSqqnj6zTitvl75ho1JqBGiFLG2aZ9m1wAeTAEgCer4I58lbIbqet+sj7ZgC42OaTBLIedjcO5nelnXM1prxzCAY32zq91X840/ScxVEICDHMHMWMhTL6fKrRnoYGXblVF1uvEg30qb9INCXh8Z9EnrJH8CaoLvPagHf+ydf8+xuJWBzSiE4jxzSkQfX3MII7yMOr+3ZP1SpfDzJXsE9S1gHnTCqDLNnm1/Pq7XxK5iwFLYMJ52zjiP8Wm8KYz9nGU4TcKPijmlBhwP2Ab223npt6MUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFe+SsfqrHcTUzW6My3ZbJJ+/v1qmr8o2Az1mFeXSXY=;
 b=Y6u1ee7ga3s7b9fBx351rpx40eCBokzCeiHiVS3DwapA9Wn4+rUoxkrF8no23VdkLLwJyQquIIuAZOJtI5tft9T9YQiygPhxJz908/WE2F4FZ3aDKfaqVTPF43dyGDsbZ4kNcAQ94ye86J1nfB9m3V90XmqefduzLwbl1kxz9BTl6HXaar/UY1AvgvwRj5ycFV5PLWNqGXBRGu6Q1dibWy/3Z3zXEb1p91thfjIaYV4BBlXoPXkrGxgaS4YBkmhK0OSyCC/HRURwK4MMRO13c2U12Hiia8A6F0cfl+vFhQtMeSHdNaszdheYajHfN7h5izMAbt3iPRcSj7cQWDR/Ug==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB9812.eurprd04.prod.outlook.com (2603:10a6:800:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 02:05:50 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 02:05:49 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jared Kangas <jkangas@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Chester Lin
	<chester62515@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency
 to Kconfig
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency
 to Kconfig
Thread-Index: AQHca3iR9OtOLtq9I0K4V7MIlKwwkLUh939Q
Date: Mon, 15 Dec 2025 02:05:49 +0000
Message-ID:
 <DU0PR04MB94963E37EF077E5A3FF7359D90ADA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251212-s32g-sdhci-kconfig-v1-1-8e278c8d7f78@redhat.com>
In-Reply-To: <20251212-s32g-sdhci-kconfig-v1-1-8e278c8d7f78@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB9812:EE_
x-ms-office365-filtering-correlation-id: ef6e55c1-e1a7-4fe3-3ea4-08de3b7e77f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?WjlVWkV1WHU5N0hOa3Rjd0hESlRweTZVR2JqSVBZckdCeDRYV0Q3TnZodFhh?=
 =?gb2312?B?Z1NVQ2toQlJ3U0hrZUo4TzhJakFnZXhMUjQ5Ky95ZGhXQUFxb0ZXejRZTmNG?=
 =?gb2312?B?UDljVjRNRlZnbk9QNnkzRVJ2ektXSHBVaTdKVWk3bTIzMHU3Sko0dmNQWU9C?=
 =?gb2312?B?UXVaMWpzNU5zbDUxYUtsbFRNRXNhdUF6NE1GcEEwcnl5bjAxRkpoQnBBeG5F?=
 =?gb2312?B?R1F5cnRzTkhhd015WFV6dmVwdExrRWlVUU85WVlNZlZLcVJnNXUrdGczR09o?=
 =?gb2312?B?UmNkUmoxcFRCcFJtUWsxanlDYUNOaEJXcXM3ZUhrWHY0WVpidFdPdnVKZHNH?=
 =?gb2312?B?RUZMQVE5QXo2MTZSSEdRU2RNUEFoQ0JlbkNnNFNXNFd6QW4zNWxaMC9WOWV2?=
 =?gb2312?B?UmFVL3gySm5qd2VybFI0M3dxL0wxd3UrR1k5bE9GaFU1TEI5Z0Zoamh1L2Jo?=
 =?gb2312?B?WFNtMEVWQTQ0RGxHckFvNkxBdmVQQ3Z0dVNYeGlDYi9FczhzaE5jVWl1b3BF?=
 =?gb2312?B?TE5NOWhnZDlWNlA4KzBhNVdJZzZhOHR1YUorN0o1MHpDZlNkU01jNkg5VHVm?=
 =?gb2312?B?cHB2alJPMnA3cEhmc25NZ2dkQmh0alRKLzRWeUp3MnZLc0p4cmxhY0s0SU82?=
 =?gb2312?B?ZldLN0ZrZUFBY3lLRlhQZzFXNnZkb0tNck1OMTBpa0FXMXVlQ3B2d3VEZzNr?=
 =?gb2312?B?MVRoV0ZzaHdVbHQxYWxXNVdSU2NMdTRxQWg4eTE3UzBSaTFvYU5melZSdzhu?=
 =?gb2312?B?T0RxUm90MEJkTWMrbFFaMUNWU1QvU2QrR29kQWFjNHBOVFVzZi9uRzRIbXVl?=
 =?gb2312?B?aDJrUXBtbkQ2QlJmSFgzRmlPQXgxVUtyeGxISHFBNkVSbS9lZnV5NjBKeURY?=
 =?gb2312?B?VEd6c3JXQ2ZSR091Uml1Wk1lOGNNb1FUaHVXQW5DV2MwV2tpK2tBaDVnWFNN?=
 =?gb2312?B?bTE5UXVwSlFxMDdhK2liVEZ0MkRKaXNMT1lucWRORHFVVGRKeWhXSThTb0Nt?=
 =?gb2312?B?aEFqNjJWQmhRQW5QQXFvR050VlQvZVFEMlBKY3plMVhTUXBlWG55bmZjZGpp?=
 =?gb2312?B?VWtJQ3A2N1RSMXBCcU5rNlhTS1dHa0NhZnduekRFbUJVU2xwOXFLTU4rby9a?=
 =?gb2312?B?enBoV0h4US9GSnkzaUFzbVBBRmdsYVg3clp4d1BwYjlDRGNhZk85bnYweURQ?=
 =?gb2312?B?U3g1Z2lXVXdJckIvQ1I3bklOalgxdFkxTCtWNU0wT2dTZHdGaWxpZnNzblBx?=
 =?gb2312?B?aXdtWXIrRytKalJsYjVBRGxoN1JoeUlEVnJkZ1pHOU9aUnpLY2IwcUlLRHEz?=
 =?gb2312?B?azBkWXdYTzEvY2k1Mkp4bjJKWjI4d2dyd3dUUXk0b3lLaThLdG5vdHpMaHZp?=
 =?gb2312?B?d0xvTzlabm5VYmZMOVZCSzNQYm5YOUVwcmdOT0hmWFlsVjkzSEZOWDF3L1dt?=
 =?gb2312?B?aGFBVnV3TlduM0owQ21TN1F3OGhYdVZuank0VFNCR0MyeS9JMjlXMFgzdnRs?=
 =?gb2312?B?aWZoTzJkbXFBeTM1VVdqdlhjamNUUzY5T0RVN3U5MjdCeDJwNkFxWkJMYlM1?=
 =?gb2312?B?bUtQQy9oYVAySWUzSGxIUEhKdlNkMk1oMVc4bmphdUg0NVJqTnh3WWZiY3hB?=
 =?gb2312?B?Ym1RdXNxQ01YeWVhUDFNZVBhNDFJTU9GRnFOQm5memo4d2hBYjF2RUp5MWpT?=
 =?gb2312?B?c084R0t1QkppMVl1OWxQbU5sN1B2SFpKZ0t0M0FVSmNQa1MxNkFRdlZmVTdk?=
 =?gb2312?B?MlJudlRBYnh4Vy93VllwaXV2d2VBNVM1QjlUcVBtc1p2RXlVU2tsMmdXcmlW?=
 =?gb2312?B?VVhwM3JuTWVzQ0pnR05MOWluMksrT015TnV5UUVaYWhaMG9JQnErZGlOU3FO?=
 =?gb2312?B?bDZWRjlVQm8xallvNURGVi8vNTZ2a1JNVHNWOUN5MEl6OTFOenlWVlVGQ3VE?=
 =?gb2312?B?clpWY3lLc0lsdmxlSGVuVW1RVFBXMTJRaFZZUDVzbDBsYjN6WEJUNHdYN0No?=
 =?gb2312?B?TnJsV2VnNjlCNjBnd0FKeElDU3JDY29tOVdDek12dE5maVV6OEtYQjZUSmpN?=
 =?gb2312?Q?gvInMO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bE1qZHJHaWE1bE9jOUNtbHg1MDc0VjBBNTJpL2cxZkdBSlBSMzNINW1RSTk2?=
 =?gb2312?B?Rk4xcUtkcXozOTI5NlFzWWQ0QmNSblhvS3VHSlVhY0VqRVJZVDZkWDNDeXhF?=
 =?gb2312?B?cVN2S1BYRCtLNDk5RGg5TWFVUEFHNHY2eGY4TjQyOHhQbG5IQXdMSUZ0MGdl?=
 =?gb2312?B?OVVRVVdVa29YcTFSYThSQldZRVUxSlFTNEZMVSs2bnZZNk5HaHZhcm5sTEw1?=
 =?gb2312?B?YWJyRUhEMDM0TFg3bDZWYzVtcUh1ZkxsWXAyUTJWblg2QzBiRjVWN0tyYVdy?=
 =?gb2312?B?eUNYUFVJYnlXRytzUG1WTkZHYlU4NGlZMmZqUG4wV21HQy9ld1ROaDhmREx6?=
 =?gb2312?B?UnliZkU1b1Axc2ZTOG9ScDdZV2h5bkdjV3dYKzl5c0N3MDR0Ujk1QllxcFpv?=
 =?gb2312?B?ZEljeExrNXVQNXpqcHNMZXpySFFqRkpGUkNnckpWRTZGYlBMWXFVY3FrL3JX?=
 =?gb2312?B?RFNOVDhrdFZUSlZYYjI5bXlNaEpodGRJanBIM0tRNEtMczdGNnd2Q0JuVm5S?=
 =?gb2312?B?cWdVNkhlbjhENGN4bXFTTzYzV09HMk9BMkV3SzhzTkdSS1dEdG5xcFV2OFQ2?=
 =?gb2312?B?Rm8rSlorMFJnNmVtOVc0UTllN1pVUVhGMWErUnlpT0Nyam9mdGl6ODF2T1kx?=
 =?gb2312?B?V05GcnVSUDUxeFUxRWlXbFZpOWhqNHF4YW43OHptNnVuWlM2TkE4ajFNdWpT?=
 =?gb2312?B?TlYzSmw1RDY3am5ERytxaVArajdWNlV6aWZkTTFIcnRndEVvZDhwU0Qra0kr?=
 =?gb2312?B?ZU1UZ0VMNUtmRzRlTXlPcWRIZGJjQXRkT2VnVFltWkhrQjk4UnZudit3amx4?=
 =?gb2312?B?b1lhT0JTQlJZZzRhOFJzcEJLSFMveXBROTRBeXJ2OXpQSDdBQ25jOGUzRHBv?=
 =?gb2312?B?K052c3dUWG5oNVhaMHZVWVNYNzNheURxWi9yNDhQNCtFNFFWSWtUazd0R2Zm?=
 =?gb2312?B?RjY0bzV1aVRGY2xJRzZHdzBFTVBGa01rU1MxdHVXd01Hb1oxWGJpY09lVGti?=
 =?gb2312?B?a21KRk9VblBvUTRlTmFlWldCazVJUndzVGNWVzBYazBDemgxMjNCejNaSzlY?=
 =?gb2312?B?Qnhib3BwZWpEbFR2OUxRbUVZZytYWjIxY3M3Z29MVkk3UWY5anBaclhWQjhy?=
 =?gb2312?B?R1BQZXFTTU5Xak9sZkxDOE5UditNQjlXd2dGTE93a3p0TjZwTXl1N2tMNTdX?=
 =?gb2312?B?akM2SWFHalBvWmtCa1IzYXVSd2tLcHFQNjNwUG5KeUJrbEZSNHg0OUg2Z2M5?=
 =?gb2312?B?Yk9EVXlVNi9Kc1RoVHJRM21mcTgyTmlZY0tuanVTcDNDd2dzL0VTUTN1cHN0?=
 =?gb2312?B?aFBNMktiMmhycHl4Nzl3SHlPS09GOHlKYjJyZUZDZ01rZG0zUklDeTZvK1NX?=
 =?gb2312?B?MVFCaWxmK3BkbDF6ZU9ONVQxZitsdWNXR0dqR0xaRitndkdGRHF1VjlQa3F5?=
 =?gb2312?B?MS83aG81MVVjanN3aWhJMHJBU3hVK0dOSUd4eHpKZlJ2SHVHK3EyMk9IYnVM?=
 =?gb2312?B?bm1jWko4cjNueFpBeHdHTks1WnBIanNnU0R6VU1PTnQ1RVU0VDNNOHNkb01w?=
 =?gb2312?B?OE1DeU45WDZWMTJXcldwamdMeCtBdzJ2NmpJTlZ0NTFWRXU0ZWR6emZhaWN6?=
 =?gb2312?B?cHVsRXJ5eFpvRkoyTDFHanR3OHdFOHc0VWpsRDhQZkR0OGRFRE9nTDhYeHI1?=
 =?gb2312?B?Z21WdVpNMVlvSjdRU3BQZWxNdFZ5VUZOSjBJcHc4dTQ4NHR6SVZoOGhVMjUy?=
 =?gb2312?B?cFlaUXN4T3Y5M3AzM0dqOFVsSEdPOHhXZEo3elk5Q2tpYVplbUtQcTRnNGhZ?=
 =?gb2312?B?RDlTZ3EwT1dzcG5TK0VkVkZqNUllOXRqVFA2TTZiSE1HbDhzK3FyY1F6dGVp?=
 =?gb2312?B?ZTA5cG8yTFR2R1BBK211UmZkUFJKVWg1anJoWWcvdmlBYUZUd1pBMzRVM2hY?=
 =?gb2312?B?MjV2OWY3SUdJSE1lbnRqQy82aWNvajhkN3E1RytTcFoxTXYvVkVBTFByNlJr?=
 =?gb2312?B?YnM1bHJrL21HSkZBa0FRT1g1eG9OQkNRK3ZCeXNsYWRJamJ6UzA5c3E4eXQ0?=
 =?gb2312?B?S1dHUE4yTktOeVA5Y21EWUpOb043N1MxRVJXVG5kd0U5U0JGUTh6NHdITE85?=
 =?gb2312?Q?ubUc=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6e55c1-e1a7-4fe3-3ea4-08de3b7e77f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 02:05:49.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxumTHnAgBzW2CK5+P+D3zXzL1QIX2q6ClGM2zrHid2FsBG4UOoo96grADafW0HkGzFzex+XHvzyua+voyn8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9812

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXJlZCBLYW5nYXMgPGprYW5n
YXNAcmVkaGF0LmNvbT4NCj4gU2VudDogMjAyNcTqMTLUwjEyyNUgMjM6MDMNCj4gVG86IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPjsNCj4gQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBTaGF3
biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgQ2hlc3RlciBM
aW4gPGNoZXN0ZXI2MjUxNUBnbWFpbC5jb20+DQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2
OyBkbC1TMzIgPFMzMkBueHAuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBKYXJlZCBLYW5nYXMgPGprYW5nYXNAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogW1BB
VENIXSBtbWM6IHNkaGNpLWVzZGhjLWlteDogYWRkIGFsdGVybmF0ZSBBUkNIX1MzMiBkZXBlbmRl
bmN5IHRvDQo+IEtjb25maWcNCj4gDQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20g
amthbmdhc0ByZWRoYXQuY29tLiBMZWFybiB3aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0
cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IE1NQ19T
REhDSV9FU0RIQ19JTVggcmVxdWlyZXMgQVJDSF9NWEMgZGVzcGl0ZSBhbHNvIGJlaW5nIHVzZWQg
b24NCj4gQVJDSF9TMzIsIHdoaWNoIHJlc3VsdHMgaW4gdW5tZXQgZGVwZW5kZW5jaWVzIHdoZW4g
Y29tcGlsaW5nIHN0cmljdGx5IGZvcg0KPiBBUkNIX1MzMi4gUmVzb2x2ZSB0aGlzIGJ5IGFkZGlu
ZyBBUkNIX1MzMiBhcyBhbiBhbHRlcm5hdGl2ZSB0byBBUkNIX01YQyBpbg0KPiB0aGUgZHJpdmVy
J3MgZGVwZW5kZW5jaWVzLg0KDQpSZXZpZXdlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KDQpUaGFua3MNCkhhaWJvDQo+IA0KPiBGaXhlczogNWM0ZjAwNjI3YzlhICgibW1j
OiBzZGhjaS1lc2RoYy1pbXg6IGFkZCBOWFAgUzMyRzIgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEphcmVkIEthbmdhcyA8amthbmdhc0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bW1jL2hvc3QvS2NvbmZpZyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0
L0tjb25maWcgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcgaW5kZXgNCj4gMTBkMGVmNThlZjQ5
MzEwMmQzNTg2ZDdhMzFkNzU1NTQzMjk3OTk5YS4uYzk0YWU0Nzk0NTQ1ZGUxYzgxOGFkNTBiDQo+
IGU3ZjkxMzMxODYyYjZhY2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZp
Zw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcNCj4gQEAgLTMxNSwxNCArMzE1LDE0
IEBAIGNvbmZpZyBNTUNfU0RIQ0lfRVNESENfTUNGDQo+IA0KPiAgY29uZmlnIE1NQ19TREhDSV9F
U0RIQ19JTVgNCj4gICAgICAgICB0cmlzdGF0ZSAiU0RIQ0kgc3VwcG9ydCBmb3IgdGhlIEZyZWVz
Y2FsZSBlU0RIQy91U0RIQyBpLk1YDQo+IGNvbnRyb2xsZXIiDQo+IC0gICAgICAgZGVwZW5kcyBv
biBBUkNIX01YQyB8fCBDT01QSUxFX1RFU1QNCj4gKyAgICAgICBkZXBlbmRzIG9uIEFSQ0hfTVhD
IHx8IEFSQ0hfUzMyIHx8IENPTVBJTEVfVEVTVA0KPiAgICAgICAgIGRlcGVuZHMgb24gTU1DX1NE
SENJX1BMVEZNDQo+ICAgICAgICAgZGVwZW5kcyBvbiBPRg0KPiAgICAgICAgIHNlbGVjdCBNTUNf
U0RIQ0lfSU9fQUNDRVNTT1JTDQo+ICAgICAgICAgc2VsZWN0IE1NQ19DUUhDSQ0KPiAgICAgICAg
IGhlbHANCj4gICAgICAgICAgIFRoaXMgc2VsZWN0cyB0aGUgRnJlZXNjYWxlIGVTREhDL3VTREhD
IGNvbnRyb2xsZXIgc3VwcG9ydA0KPiAtICAgICAgICAgZm91bmQgb24gaS5NWDI1LCBpLk1YMzUg
aS5NWDV4IGFuZCBpLk1YNnguDQo+ICsgICAgICAgICBmb3VuZCBvbiBpLk1YMjUsIGkuTVgzNSwg
aS5NWDV4LCBpLk1YNngsIGFuZCBTMzJHLg0KPiANCj4gICAgICAgICAgIElmIHlvdSBoYXZlIGEg
Y29udHJvbGxlciB3aXRoIHRoaXMgaW50ZXJmYWNlLCBzYXkgWSBvciBNIGhlcmUuDQo+IA0KPiAN
Cj4gLS0tDQo+IGJhc2UtY29tbWl0OiA3ZDBhNjZlNGJiOTA4MWQ3NWM4MmVjNDk1N2M1MDAzNGNi
MGVhNDQ5DQo+IGNoYW5nZS1pZDogMjAyNTEyMTEtczMyZy1zZGhjaS1rY29uZmlnLTU4NWI2OTA5
ZjdiNA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBKYXJlZCBLYW5nYXMgPGprYW5nYXNA
cmVkaGF0LmNvbT4NCg0K
