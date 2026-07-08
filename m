Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0013CBE69;
	Wed,  8 Jul 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492704; cv=fail; b=qsL9PRt8374Ay8ovOIrFAnFncyEQCrGfDLHFH5cHRukcSyIM2ZyAUNQ/Xv6dCqDavxO9Ky0l5MoW+wGKf8jtVwWipJj+E1g0IhZ138rV4R8H0oYBp+No25Z3Ale5cSj2cdpNLgxmKi7MPR0BCXf0hlkbNNmgCtEAVSfH3vWClZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492704; c=relaxed/simple;
	bh=rTKxA9N59nt4Z+3ndHkhZkfti+wOR22HFENx1HjjU9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJaa3ZhyVSh4Lc19Nvy6ohYJOtJkWJ5nC4iPx70LEObk8LgHaPTcA9E96UdN3HwUrs/5Fb20m61v+5MktMQgEOYC+UqHWKxs3kBCGx0M1kq6VN6Hb7P6S98+LyTTi8tzj+tPTpMcYt8kQ3dbvNHiVHsb7SjEoqVHCtYFBeaIFJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lEB6c3hD; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lEB6c3hD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQT82Q5MAP1VTo6EjQfhnK10F6yYTo4ykzhRXEmwwNJZtTxhRHfH0hVqRRGi4fX4E2OWoXN1xfu9sDzx6n5TwDZNWAfAZBDwJBQDowQnZ56fwsBUdmnoCN4zCq0F9J6rViUvJz3lzJtWQy/s60HcliOxDRxtIC2UlmATCaXerpmgJ1nE2jbZhrNguovM3qt/T7pIzVnjt2bhPObrowLLfaYsRKuNe25Wy5l0CwnKNaUCEh7FkKUNjEo7Fh8QzdAoCRpe8eMMk1p898CL6Xt7q93LS+Arf8zeacwj8cKxnkh420hfrdSHQB6d33wFWAwezTOqA/WCHC8lcmraVO/yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfi2I+7+9MUtsLjquSYysMJTL2x83JAkX+WfNxMAzcw=;
 b=oOJTwmwwGYariSDdP5XESk7HVuC21dakA8WPfrp3TRkPCF4lQSmaBYOChYcCDijtGZVypafEMEXuA521g/HBJfKpuVWuUsGEZqxcGyyaJ02EKalxvqEBr29gu6hOFjTDjpp04dt2A9TBAr4R5gkQ7kJpfwVlsP1odIZPfkto+0ku+eR2+KzDo6V62SfFVJkLaQVu0pGu5rKxfU993iVubDbEJIWfAtY22TfUdncMlDGZRvqkMG9B2x3CDCjzZBhvrVMndf3QtFSacSYlAGZjXkaUJqnR2f2ZXwjU5HW+4u1XONlTdjlUfHc22yo2+5vFwYbqOcGWVQwo+p93UdQxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfi2I+7+9MUtsLjquSYysMJTL2x83JAkX+WfNxMAzcw=;
 b=lEB6c3hDi+24o1SXheNS1miq0lIfdAoxFKfFw64QEFTqwyiXDnxUezZTqPh5z7FBuzB9aj3zRWtsWkTrxKngjcF6r1OpA+Jeb11BRhwcnoKz1yZ/3nDDDrXs5nhq6ZKRrzF8g9/Uex31yqd/MwwmBKmacPv9voHrdn8zVQtuRgwGaoj90av28yfGBszZNux48H8NnEBDVO+nhS+XGGHCqvE2J9+8xIHTRzoAXSf4MKDQoOOpyQjeM0Mmpa0htMsIR/p/07hIAlXQip/4BXidINzwUXIAxepRbFRG69CpJpNbnsT8JrxvvBa/PbM5aK60hAw3wg828QSzF6FPhTGZKA==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by AS8PR04MB8357.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 06:38:17 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:38:17 +0000
From: "Luke Wang (OSS)" <ziniu.wang_1@oss.nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Luke Wang (OSS)"
	<ziniu.wang_1@oss.nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulfh@kernel.org"
	<ulfh@kernel.org>, Bough Chen <haibo.chen@nxp.com>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate()
 to allow default state restore
Thread-Topic: [PATCH v5 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate()
 to allow default state restore
Thread-Index: AQHdDqRc6cdYDyNt0UGtnZbPmS8dYQ==
Date: Wed, 8 Jul 2026 06:38:17 +0000
Message-ID:
 <AM7PR04MB6870BB87AA247B3D6E8DA29DEDFF2@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
 <20260707110303.3779799-4-ziniu.wang_1@oss.nxp.com>
 <ak1NMS43Yrfsh7CS@SMW015318>
In-Reply-To: <ak1NMS43Yrfsh7CS@SMW015318>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|AS8PR04MB8357:EE_
x-ms-office365-filtering-correlation-id: df665b8d-94a8-499c-f7a0-08dedcbb7ec2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006|5023799004|38070700021;
x-microsoft-antispam-message-info:
 sZqOJ9lTH9dy8hlGfd3Z9hbg8aCid6TKhA8xZQxydoS5uZEpJH1W4WCm4YaTZNcMbjR+476FHWO9CWpTuSOZASvCgqBlsBPyGsBhkxIfmmH3bGvau8SW5hgv0WrH49HNZMjglbU9CK/tkdGr9ynxRm013DWK6qtZqom8Af+jK4Op5dhuRIH+6ZYv9KHZ8gl17UCa6mMQwDq0yU4UGQKR8ml3ZjHCucxIUHWxw4R+p83xYQyEMjFPPZ05UXxRNpxPYkprr2JzRDBXeiC7u3cngDqcDwX6OER8NfT+32MtrqxfIZQbw8iuHPW+BsR1jZ1+LEcKBtH1WbmV1QW3Q/3lvVe2bcKapq1PkhdhnqckaxyMBjfOe97OoKNcz6mGjY3o6Wepzce3D81JzDQZ3qWJDhScOjro3wsI3kP8ex9auD1oakBoX0NDQo26GifOaxg7v8m7Pz2hZLsZUaxgPDgs1yHlydu5BLiAVK9uGKZ1QvYMiVhHlhLnfK5VGX+dVLxEo5TnKEV8izcnXyrREN4nFTL+eaq/TW0mky7NC1ngFVwHGgNzu5FZ8V1OfwHJFDb3qXbgsr8DvbYGEYsVQdxAYCSQAzaTT/xzO1tqsmuOOMN+pvJBtsiXYOpH247PrJpfss0ncSTqJHZfW0mp8sUtaY9MSBoja+qJ4q/QLGboJ1UhiB9AG+SRy7ap5ZX/VeSQMzBw+e0ITMo9e7yxy4Zo4WC99fVCkOXn/m54IZBE4Jk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UTpR3GTtpvYVdvJsQ+Ru5D4Sy7Lq25xFqICZOsCqETZNvadfxBIj6QmPinph?=
 =?us-ascii?Q?UDiYmIxfdEa4VIQsH1ZrLFfpSb0yvrGazGexkOHggBWmJjoa875pFK4hxT/q?=
 =?us-ascii?Q?va0MAzSGwuRHaxhJxt3Xk7ZnCQNchj0hKt870sehY22HruGfk0TLVvnZCGYb?=
 =?us-ascii?Q?nbpJ21r2pT2//got9xubbh+krxidaHRUbsH21vNbI5OWNCTaAebnMlko352z?=
 =?us-ascii?Q?rzpbbTyJHjLEBw68oBbbtHR7Jh1d6OvlsRng366MbLMXpX2J2KbJ2n+pkmLj?=
 =?us-ascii?Q?9d/DCpzga0kIE+PXwG1felat21dC8k7E3VrajexU7j9Qsh11yJarDmmHWx7V?=
 =?us-ascii?Q?9z2XKtnKx6serpqA0KFQsEM3+WtSR90U3VH57JUh9VVc1jdFGQdzUKRQoVyh?=
 =?us-ascii?Q?hGm7NUaYGLndTkS70Uc9NP31Syv3OvL6hdzZL6QbpvWIQiMPyPIPYV+g1Q4/?=
 =?us-ascii?Q?WhRCSbd3u15KaE68cyvckv8/K8kOrqPgzu9TQR3jaWsAPjZtmxsTaGNtsnbd?=
 =?us-ascii?Q?DzVhJKSdDo9Rz7NpKJk68c57ikG3zAYjg5OKVzOIV0mckQsvwOYdcSA1J2Ej?=
 =?us-ascii?Q?KaXxcUXaaV+Y0LxJRxiquxb3H0lQT1kLOHIkjJ9qzoV4667YrceT5ay0Nzhm?=
 =?us-ascii?Q?UeV7VLThoaygySx8BdVSZ1CyMniViLz7fKG1OASVzfmgk3+9hTIT6UNbYAbl?=
 =?us-ascii?Q?iFh/wCgk0DpGYl6S9M6avHvlYfrSiRhxW3X6UXoF9Ntqu8O3Tylxw1Sb2mBS?=
 =?us-ascii?Q?kqCTD5jjLUjpOvp4+n/6YJ4cuwAQW6h5QOSxOVaHNNb0hxVMxFfr0bQu7tiL?=
 =?us-ascii?Q?FfSFqqcNZzwXSrAAGyUN6LLsopk5//Sq3yKH95ytyjf3mZBRPN2HAwDqLDwJ?=
 =?us-ascii?Q?wwOQmnRjFC0kVeaZgsF6GllpQ2t+BUtdQ8RCV9zeUrbHvw8uiSDtIo3a/8jm?=
 =?us-ascii?Q?k828qw4J8FC55EPHpOPuk1Ku7Z2xX8kJhATxgyFvgwL0YrT07vNizG4qxFoE?=
 =?us-ascii?Q?0TQqhdLRtgcAX3Fvwx226eJBtLhmcIUudvysTYRv587IOAaWS4Pwshj6oIMX?=
 =?us-ascii?Q?JdGu748QWuIPVCJxG11W6KYsnO1mgR9cr3zmEXHgovfMg4k4kseychF1To0n?=
 =?us-ascii?Q?01JptOsD3gHLzdYNBdcHr2hYB3FNgJcwUfO3iMW1r8hiK7lfLWanwEE0A5n5?=
 =?us-ascii?Q?6To2os+TqI1nE6FCy3+JjIWTPTkOrg02DMr52fS86z32HaYwun+ufpReZ8WT?=
 =?us-ascii?Q?ifT3B5PhGu53xlewLGUEAs53nQ+ibNh2sI/+Im+mazPSCXBEjIlnF5ooL+P5?=
 =?us-ascii?Q?uq4ZnQmPBSaJPrx8JnrE+kVKma1Qtc8AebrE5EAUU28LeIQcV4r6GktLmZOs?=
 =?us-ascii?Q?pYu8I1BIjQEq3pEDZcMIfrmvSSSVGBdudN3GVbp+PlOCurbSFqff7FuWSvjd?=
 =?us-ascii?Q?vjON8jUfgmUIqe8fQvwcgvh+MC03HRweJxNGpqzdBBFHQV4cSTklLz90giv/?=
 =?us-ascii?Q?++YdneTTliYYcWxFIMcIj65GsxwORjfugKb/QVU9OtIC+0Vh5C4hKH/PKOhS?=
 =?us-ascii?Q?aIYRviqU5y81wV2YO8wXUcFKPuxj77QgKRh9CK5ajtd9sXvSgjdDuVG9/Mm1?=
 =?us-ascii?Q?JG+KYYh9WrHrCCpHgUuWQSqlqpYO3n/fv6bWX/LQ1Jq+vwtUIDOVHmbId1uS?=
 =?us-ascii?Q?b14W2fdba1ATI5jOfdHNBptmSU1ti+7VazvhJRjoF/PuxPrZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6870.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df665b8d-94a8-499c-f7a0-08dedcbb7ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 06:38:17.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AfKuTCFCFmDp9guw9pHq5mV1TFUDaPdyMD2x8OE1vtOZkXDiVVS0TOSIcGp/pftTn0U3BV8XjDC2vtX8cXupw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8357



> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Wednesday, July 8, 2026 3:02 AM
> To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/8] mmc: sdhci-esdhc-imx: fix
> esdhc_change_pinstate() to allow default state restore
>=20
> On Tue, Jul 07, 2026 at 07:02:58PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > esdhc_change_pinstate() checks for pins_100mhz and pins_200mhz at the
> > top of the function and returns -EINVAL if either is not defined. This
> > prevents the default case from ever being reached, which means devices
> > with a sleep pinctrl state but without high-speed pin states (100mhz/
> > 200mhz) can never restore their default pin configuration.
> >
> > Move the IS_ERR checks for pins_100mhz and pins_200mhz into their
> > respective switch cases.
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index 7230d70e02ae..ead4685d621a 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1326,19 +1326,21 @@ static int esdhc_change_pinstate(struct
> sdhci_host *host,
> >
> >  	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n",
> uhs);
> >
> > -	if (IS_ERR(imx_data->pinctrl) ||
> > -		IS_ERR(imx_data->pins_100mhz) ||
> > -		IS_ERR(imx_data->pins_200mhz))
> > +	if (IS_ERR(imx_data->pinctrl))
> >  		return -EINVAL;
>=20
> Maybe off topic,  I suggest set pins_100mhz and pins_200mhz to
> default pinctrl if not exist.
>=20
> Currently driver use pinctrl_200mhz/100mhz judge if support SDR50 and
> HS200.
> Actually it is hidden ABI.
>=20
> You can save max support speed to variable after check pinctrl_200mhz
> and pinctl_100mhz. then make these two variable to fallback to low
> frequency
> one.
>=20
> So you can reduce these check in code.
>=20
> Is it simpler?

Good point - using the presence of the 100MHz/200MHz pinctrl states to gate
the UHS/HS200 caps is a hidden ABI, and making it explicit would be cleaner=
.

I'd prefer to keep this out of the current series, though - these eight are
suspend/resume fixes. I'll send it as a separate patch on top once this
series lands.

Thanks,
Luke

>=20
> Frank
>=20
> >
> >  	switch (uhs) {
> >  	case MMC_TIMING_UHS_SDR50:
> >  	case MMC_TIMING_UHS_DDR50:
> > +		if (IS_ERR(imx_data->pins_100mhz))
> > +			return -EINVAL;
> >  		pinctrl =3D imx_data->pins_100mhz;
> >  		break;
> >  	case MMC_TIMING_UHS_SDR104:
> >  	case MMC_TIMING_MMC_HS200:
> >  	case MMC_TIMING_MMC_HS400:
> > +		if (IS_ERR(imx_data->pins_200mhz))
> > +			return -EINVAL;
> >  		pinctrl =3D imx_data->pins_200mhz;
> >  		break;
> >  	default:
> > --
> > 2.34.1
> >
> >
