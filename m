Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795629752;
	b=GNamNncyjcvt3W25PYd1l+Yfa9EG9uRcY89tcQkbzdhkEY9eXmvJBDyW91yVm1Dk/58x
	 QTw5xD3fVNZKXLRlvLM87MEAf5UVxmOiHNa5acKCdEPhwCwOQxC9RN1V3RU6pZ3KjBKCz
	 NKnxhN3Jc+voWt4QM/P+Bqr0gq+vl0eKEW0vAuh/bnNL3S/m6pclhpF7LxH7+a6A7AgLh
	 VuvkWuwIM8jCePM31z9xfiOtQe254+dwTcBnu7mIY1BgVlkwWBa1dsUbGT5AwxcIcZOzr
	 45obF0lkeLKpyy9xL7mKcp094CzsWFCfYd3Y5z2ycBwstMMC7W7iYOOzLSCu/r4NG9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629752;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GeUjGYJL4PALjYceCyp224ORorBllon9uh1dwU1Ob9g=;
	b=rZ0+6MVk4fJyhlqwJ6lsD8/XLqd8GtJjPhBQjsvu9XNT5aAb2aVIkKj6BXaUuy6vVALb
	 BvVB5jGFjoYeFPSoMXXf3ofWpq2EE3niosq76Bzp1vs5ZK6hRsjwMBWx4wJQPwQ9YDGlQ
	 ASgUypKDdo5B4V0mp1SHikP4bi2i5OnE6fz4ncZuo7UEOEw3dKWNJGWxGQ1BXtER3wGIm
	 mvuofqHbQJf5CCC28mUw8ej0MxXYFEkCV25mJ0hKR502gMP0CT71KX1bWUOL9TwBgwg6a
	 AAppVINt5oDMOwA+LkE0MzG4GaGuv9rQvDe8NPFKFeDv/a1MBi3B70ZOeDH65RFVQhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=R94wr7SI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.12
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010012.outbound.protection.outlook.com [52.101.229.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EA606A323;
	Wed, 25 Nov 2026 18:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 255EA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=R94wr7SI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGjCayexn8PY1xwZznQXOmeKE60BaZ1KOsJ//3p1rsckaLW2DxefkH6eS/59eWsz7WS60BC3fbj+wzq6KCjh9gkgWBVsvBFgZOMPYPUNkePmygkYw3H/9lhkgiukqYfX8cMpTX6OkdQ+BEVeqwiyaqHwm28e61ItU/POEW+wAkWw3euEeFnJsTA60y4DCjKFQUAf5c4aGPZMBh25apSuaFai+fovw2myqnKiXKNIb71Mlkqhu2s954+W0dgSS2Eu5Crzo8Fwn5Y//FongCfa1khEwnIzl98dwKQShsniq8siPy2MieOk0BcJ/epFsyVIgj5zDVL0cgD+FFcBfHWL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeUjGYJL4PALjYceCyp224ORorBllon9uh1dwU1Ob9g=;
 b=C2ImF31fZCQik7OpDQvdLkelLiBB/WsSwOruZAnFeSP3ji1iRCboQE9qn71u9ZlhjslJtBfwNWL1pCXikCf1MtfXSliTVlsJzDep3QkxnVr+dV69/PLU0VdXcumMa3SJ+VSfRprgeCvBmIif9BudwBUoSTA3NJTpglBKkkbhg6vmMIA7DzaAoVNZBc/j34F3NtMSYbiTlinx3tGrv4Hy3ffn/VGAkjtSLf50AOX7vwCazuAXDQemBbsgIphYHViI3ssfA2zpB4H/orHj5iEzH1Mne0P49H2w5Us41CnxYulS0VQS1eXuQXrJdPAPxtu7H0d4CbpkTcPeuOcuOM26Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeUjGYJL4PALjYceCyp224ORorBllon9uh1dwU1Ob9g=;
 b=R94wr7SIWi1wEzSnkDAvN47fF4EczJ47KMARRJrwmtyt6jjB9IcweLH/EA8znapRiX9JUOTUaTowf1w1DwqsonPjfCdV8QTA8Pc9wpgXCf9dPJoS49fOUKvv5q7S0DtE9b5Ol6rntTjBdmMJX8bm1zCdH6vHgzq1WvJ2ZUPgyyM=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYWPR01MB12075.jpnprd01.prod.outlook.com (2603:1096:400:43f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 18:02:26 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:02:26 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>
CC: Lee Jones <lee@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?iso-8859-2?Q?Micha=B3_Miros=B3aw?=
	<mirq-linux@rere.qmqm.pl>, =?iso-8859-2?Q?Niklas_S=F6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>,
	=?iso-8859-2?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Adrian
 Hunter <adrian.hunter@intel.com>, Aidan MacDonald
	<aidanmacdonald.0x0@gmail.com>, Al Cooper <alcooperx@gmail.com>, Alex Dubov
	<oakad@yahoo.com>, Allen Pais <allen.lkml@gmail.com>, Apelete Seketeli
	<apelete@seketeli.net>, Aubin Constans <aubin.constans@microchip.com>, Binbin
 Zhou <zhoubinbin@loongson.cn>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Cavium Inc <support@cavium.com>,
	Christian Loehle <christian.loehle@arm.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Georgi Djakov <djakov@kernel.org>, Guangshuo Li
	<lgs201920130244@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Hiroshi
 DOYU <Hiroshi.DOYU@nokia.com>, Huacai Chen <chenhuacai@kernel.org>, Jaehoon
 Chung <jh80.chung@samsung.com>, Jan Glauber <jan.glauber@gmail.com>, Jarkko
 Lavinen <jarkko.lavinen@nokia.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Josua Mayer <josua@solid-run.com>, Juha Yrjola <juha.yrjola@nokia.com>, Kamal
 Dasu <kamal.dasu@broadcom.com>, Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Lars-Peter Clausen
	<lars@metafoo.de>, "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Phil
 Blundell <pb@handhelds.org>, Pierre Ossman <drzeus@drzeus.cx>, Pramod Gurav
	<pramod.gurav@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>, Robert
 Richter <rric@kernel.org>, Samuel Ortiz <sameo@openedhand.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson
	<ulfh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Thread-Topic: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Thread-Index: AQHde39EmwGk/BJHN0mctvCzIQKx+bc+zFjwgAAaWwCAADAc0A==
Date: Wed, 25 Nov 2026 18:02:25 +0000
Message-ID:
 <TYYPR01MB66030F3A816556D40E658BB986432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261123191703.179283-1-lee@kernel.org>
 <OS3PR01MB65968B3C9FD48C0A7515AA1986432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awb59uLiTOEfLaSm@shikoro>
In-Reply-To: <awb59uLiTOEfLaSm@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYWPR01MB12075:EE_
x-ms-office365-filtering-correlation-id: 35baa816-a6d6-48d2-62e1-08df4b1e4356
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006|261026121527099003|38070700021;
x-microsoft-antispam-message-info:
 rtgwF68RK+AVuhV74y0yc9+6h5WeyzxUJrcdHM4/wtnzg6SonvrcC/sPFobQEyDcirtdHXXgpROILTtCs1aS754wGpGdkuM6R+pg+/b6fzYhjDMnhDI39k9+iUZnE7351iefnVRbXQNCsJN6EZnb7mcxx2hD5IySpHScwLvLhwb02cR07pbRDKjQ//L5DxlDUJJKuoec/unvhc68CeetbIH5ReeV3RqzWHA9/dN+PD0ekSwN+wWtDNCSGBuD7QblJrnV5iVEMOEeir3kmGVjEsPs6abL3IjE8H9b4F4pIqGvpSL3De8HtslYvIbgUovjLRW6Ym+sOZ36aMZ/0NkM1jiU9p6xxPbAH2bbwvP4hcdO+muMv8nvW+I86ooDEzDxGQlNQvJJ7eWCI5EypbSXx8pFSTdizNVc0hbcaRN4O582kOlsdwEaGXIe8ANAcRjkVbBiBN9QvcVQijPA0iY2nc4N/YRkOmz17dzU6/GUnAc+pLXI6a3SIQbguKSi0NTQJOkglmywY5iuaakOYNd1orkvjBH0eYGdZddethWwq1hSi6n552LTNGMdZpzy330vCKlmXUkUQcVfBnMD7L2OfySeNWu6CWU4xbltnNNGuyEP7Hsa/cW9xjQ5nM3POVXYNEnPy4D8KnIlgveO+GY1iNg9XueifaF+5VkbMJrQFkjuKh4sV++fW1Z513a7gbjW6wJetcdAC0+f9GTWvM45k8CE8BiP8/2vjxgUdpgwjpI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Mreph5UG7Qm9M9v7K0UwmMM0YzXGjWgARYLeLRjXaYZ7G9Xm7pbr//vDp2?=
 =?iso-8859-2?Q?9TPx4TORE2jbYdn+FYjU14RxDCVDtgN8k7jXbaAlo3ZS20xAI3WUQBI+Tn?=
 =?iso-8859-2?Q?cgdCWSlEVzM4/aIY2CEznrn4w0oSyA59Udd5SaCG3MIH/mVQcVBSGmt13H?=
 =?iso-8859-2?Q?HGibRDfBXIfytrCiboDe1NnCNmyVzLwbHBoEq6NdBVZ6TreGAYDSkTeeFT?=
 =?iso-8859-2?Q?W6flec9uKLaUkEvLwk8w6Xq1MsMAwVPQiFJGOq24/gV6qcySXe/QQnVvlP?=
 =?iso-8859-2?Q?GS+wWO8wvOATT95N6A8GnEb0esgdgaCz6IfpxpJv5gItIwcub7P+xnGHO5?=
 =?iso-8859-2?Q?VBydLK40esIzFP1HPfTnfzBqTk3p+6xBDiFuQTrh6xc4tZGso3yEBzIDqP?=
 =?iso-8859-2?Q?e8M907QATuUA/f0wiDiXHtu3VjoRz74XNbZ5WjVs7Foo556U2tw9HXy6OQ?=
 =?iso-8859-2?Q?wPzVMm2C1Rf/bGHI0rh3ub+egYGgRGM+AvSJCR3JQ75SDB8iv2SGwsOuhz?=
 =?iso-8859-2?Q?iXZW+AdPFu0DsdNJFOzoJJ5ehOePmo11zZaP24WvZmZz/XMUTrObSluiyr?=
 =?iso-8859-2?Q?g/LBwPbQl9CCSvTV/phNqLBGJSD0mtev7Yf68Ap+mnhBf8nA1SemBdTrI9?=
 =?iso-8859-2?Q?e9+Ogm+2EbHuHumHnDkfTLsK5RAnKYmp/qEWJNX4aooAKzjraNpdAk0R4f?=
 =?iso-8859-2?Q?nXcJaR3hiCH0c7Q/sSy7Ex+zsvUVFpIbObTqKk3xc67rmvQhze4euEDh2p?=
 =?iso-8859-2?Q?tbIzRZ3+H82Yn+I0h6VHDT+RMwYViQlSWQkVbVGPQyiEu64s2kHHb5xNWV?=
 =?iso-8859-2?Q?RvqDJvdaSiD0iEqVY7gu2ii2OKBSnhEx97b/xcPJi9sOfVDx8Da6RwGZha?=
 =?iso-8859-2?Q?ieojSC4Es6orKNttCzTpb9yf2IzGk+NHHMKIFq2jMdlt6TKOir3lU3LjP8?=
 =?iso-8859-2?Q?wNE1IKInvzO8PX2pUC520/6N0Xkqru/g+zVHm1GCPvmFYZy1HLR6dUYHve?=
 =?iso-8859-2?Q?VLZ2Wkyy56fCNUHXk2qOPcZhzwHCtBr+UiIC62qUTI8BGYYwP87eM2Unbx?=
 =?iso-8859-2?Q?ImBtgPhES57FbszgSbrXqDMkRml67RdPmaS/vroNi7IyETAN2H8TgDQ51U?=
 =?iso-8859-2?Q?+eJTTvm90YQGZjBd9LMhgJfmD1saXGWNtbRNfO6fE0U3BaQc+OzcfmTnbZ?=
 =?iso-8859-2?Q?c6KizA9H9PKQz7dSofHpHpwCHUDVwG6T8M4UYCiXmWWD+R9QSn5aeIEETS?=
 =?iso-8859-2?Q?PdXx6ydS4BZY/idm6IFph5FWIfM8VfGH0WEcr+K++x+dNnQlsBSDCrtQgT?=
 =?iso-8859-2?Q?LXr21hYx0Q+kVepf1zQTiQ+SNiyCgzhBy+uYoB+Qoj+6rhnm9CveFCpU0E?=
 =?iso-8859-2?Q?G6uIJxvwvxm5/b6Lx6EzcW7aG7OgbFeLQRFF54+it+4r33td/Q4WEjfg8A?=
 =?iso-8859-2?Q?Yv7I0aJ+wa8HftxWoaz33/2EjVNOee6pYJ6XlkO7zoqvBEZVZi2uBACM3G?=
 =?iso-8859-2?Q?8e/NiyunGCs4YZ6tYmRpdM8vesEoypYYiB9erM8dbPCSrE6mIK9Cema+kf?=
 =?iso-8859-2?Q?mb4NtODhSIRpUkHcHWKljQ287gWklH51bL43vBjJ2N8VgeO4YJxKeRqC50?=
 =?iso-8859-2?Q?FhePVGYqSuLWp4EwWpyEbz4T6B98sfn2uU6FDVns9tPWyUiYYcevl3QDQI?=
 =?iso-8859-2?Q?iM8kDaIa18B0ArnrFUABTCN3DbhsIsO480cO22j5OocHi14eiNkINuWm5d?=
 =?iso-8859-2?Q?/w6gB+fMglN1OjMEMDuVnKIGGSAxDYFcz9MyJsWfcf//iesmf0wu+wx36Q?=
 =?iso-8859-2?Q?n1WyYwk7lQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35baa816-a6d6-48d2-62e1-08df4b1e4356
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 18:02:26.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFgqRNVoAO7pFsZSuXHdlATS9oED7vihFqGkHNkuPnMa8DbOW4gDeOw0fWRjVPHeycBIBVZvxW/845W5Q1R5Ff5e+LLUdq1uIewe2CqifGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12075

Hi Wolfram,

> -----Original Message-----
> From: wsa+renesas <wsa+renesas@sang-engineering.com>
> Sent: 25 November 2026 15:09
> Subject: Re: [PATCH 00/13] mmc: Assorted bug fixes across MMC host driver=
s
>=20
>=20
> > > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> I plan to review the Renesas related changes early next week.

Thanks.

FYI, I just done mmc_test read/write performance on both SD/eMMC
interfaces RZ boards.

I have n't tested SDIO

Cheers,
Biju
