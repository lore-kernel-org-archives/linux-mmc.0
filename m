Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED3377553;
	Tue, 14 Jul 2026 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998100; cv=fail; b=ETHrz665g/EvQiYV8AfjhQNh2i3VEfZ7g2Xu5MOxXdHMWEGj5HfalF/+UxQ8Fg8IksCWJxLkEr0HKVGYA6Bpgrs20UcLf4dqZaDQ+LKQL3wfHBb4Eash6OafdrXColb0oik7inglTSjDLaz6tNAvyMyPznSp+en7fpwiiwvWuUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998100; c=relaxed/simple;
	bh=4EipjCeXIBdvovgb/by++O0Xh9gJ1Nx45qxozA4q6dU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYoiMUUs4Uw6gc2fYJ6pAVHE1IR68H2qBuSB+f/qk15bOjjBmjQCNxBr2sVfl4akb1TDKEHoNeMYhQWKrkfYQxfKH2RbYiMsKrv5dycCWZZ3cEYzNLd5XRqSm3lGW7XszneWo1MPIqhwl2fVLpHrw8YqGCkOiJ/d2YOnwi9aL4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=r8Nec3bn; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r8Nec3bn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6Uh9r3HUB2ANDmhlf5KGX1YVbwUiXVZcIcoqYctR7ZqONIYlOwmR7/u3RrDcYOkieCkwlQ/CEycyisC0MhVpfzsJtwSMJV61AUxpktr1eAaT3yTdvbEQ/TXfr5UL4dO5ciizwiRH2uEIaBbJOD2vM4a5AxzzaHOUynoeK20uw793DTNDnLKuxdBJFNa3FX3vLjeIr0L76I3rkCRWiMJuaSwznmlHxT9rncSKT/r67zVlbI3BAFeUwgcIQSSonHAed0ErJfoVpe76y3dDWuRr0HfNxiYeIK2NPe+NAnf+DU8HfGoaeSfsNI3TrFX70QsNnKsr0KNNiIpFGF+OHOTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMvGjzLxioBTWtoxtMxJK+WrgiQ0PwK+S3MARSsxwEM=;
 b=LDUT6+mgxt0qM19C3oZHoSHo2SjlFuy4VyA07N+Z46+KZ8j19bXEMYc508gQIjaLazDiJPAxL5rEi5nWq7EPuuLYh1wMvxjZkagcJ6oOODDGwHGAhiiuKVTs6g0FOmobiCHRrNUv9KBg+Z3heVYi0zGNDkCNle+eujSeAJiG7QP4E+Hdd9FCq51W25FSVxPKQB4JWH0l9zxD3TpswTQegEBY61YxsCJCM85hfAmdTP8cgRBy/FtnPYy/GombFpD0VWAfEKOZ3lwJg/Z01cM58PCSJ8YEYL9YwsGCOKQzvSgffMj86uZy8sl8t5QQDVNvQQGHfxuR3Gx48/Jflmb/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMvGjzLxioBTWtoxtMxJK+WrgiQ0PwK+S3MARSsxwEM=;
 b=r8Nec3bnSM1ii1F+/mADwNfCyPgzCKv6AQIuTucFlDIYwlKbKuh0ac4GZq0hyvsLaxIAbt2cmIoY3j4YL6OPbs0a4ErJlp+ZT+gJKpGclJoZgOg7LQgMwAx7A5criCKvHIGOGWMeOfXiLYr/iJUdqbsQ9mOoncMhkPCi+geo0NVx+5xDSmgjNpESXdJlx0p5S+70NkVBRQjq334OOtc3teaZtELulXd7g/QC3TWE8q6/VOJDFxfVDhlu8nb7FYGuHI509jKMjGYr/3PwCiL9cOErIcWdQ2P5WotYtCmsEa7X3bBfFen9WR7kqEtB9OyBrhkghJPxZN0W3cKSbA7q7g==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by DUYPR04MB12690.eurprd04.prod.outlook.com (2603:10a6:10:65f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 03:01:29 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 03:01:29 +0000
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
Subject: RE: [PATCH v6 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors
 non-blocking in suspend
Thread-Topic: [PATCH v6 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors
 non-blocking in suspend
Thread-Index: AQHdEz0Ru+YGPTxDsUq+TRTpUlH2FA==
Date: Tue, 14 Jul 2026 03:01:29 +0000
Message-ID:
 <AM7PR04MB6870C0F56CDC053C82820543EDF92@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
 <20260713043904.4144172-8-ziniu.wang_1@oss.nxp.com>
 <alT7u_qNf8JqoXUX@SMW015318>
In-Reply-To: <alT7u_qNf8JqoXUX@SMW015318>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|DUYPR04MB12690:EE_
x-ms-office365-filtering-correlation-id: e7037926-9773-40c8-2246-08dee15433ad
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|38070700021|22082099003|11062099010|18002099003|7136999003|6133799003|4143699003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 WKsx2HE0cb4BRI+rBWqF0Er23F+icbjFMATjv2ATnYR5meNABIOrPBeiTBn0u3Jhg8pCpW5QllcCJBSbSZr3ltBK0nJs3EdYE8QOfudAu7Wd3lUGudetTqViFpR87LGIkob9Q3693NpqJb7jpArcE2pJ3okOgpOxGqFlOP0h7EZpz2cpKl/vkMHWrqRhYPzIZmIFe5GUc2eVZ+ikj+2DPeK7VJjlJgiexrsJmN6rMCIIZlUE8Ut8r4GNXBAjEvPV0RDR/nTfSmkpoUTn35do7FN3PCBZ8P07a6KrIlziF1TI2N31+s3J59fcjbK/pcGGvy/98JR0z4DeeiUi/Qw7IMkFOPfRj0N2sGocQ0c2s9fmSQoXufyg24VytTQAkvPC7WBGa/B1mhiFhxBtO8nhBnhHwIwM0ZB8OlBqVdfj/BrypCOSMBzvJjAdkiR+tmFWDqSs79m/Aoo2lCHjKI1TrTt86v2YdIBGIT8mUGex3lYXD6QwGXnLHQzBUXCDczRUWde8Wo09/4dvQvuGX2KfmXknC8MeFzc3jREt5zj7qfduEY0W1AJ+fY7YpvBkCL0wZXbKR8Qg9MLElVT0oNYQssPyfZBVO9O0uGSYRMjPQxB4Xz8WwT4qJAZWSszLfW28MqtD3ip0sqb6CEuzh2w3Tb94bC7DrmeJncvsiFDqv1eqDCIoYtppyjYKW1xMpp0yinyx5qg6T+pTVgMndA6jquMicTlhEq0AHo/mUlsmbMQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(38070700021)(22082099003)(11062099010)(18002099003)(7136999003)(6133799003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UHwC6YpyQIdjNvMx9tuyokAeKs+snBvvEzaba82EOQhEPGhPMoeUOhRsFIUA?=
 =?us-ascii?Q?LjXlSfXVAwQXVACPaKdnyWod3AGST9ssB580ETWsNd418PdCmGs88THrmACA?=
 =?us-ascii?Q?r9T4wxdY9rvzmm53CG3W3WIsMpI9uXb/FxsyDhCtF9UaJ3qJnJpOWI2gOwJp?=
 =?us-ascii?Q?HaosgVArj5/pwyYrtfUtqeyUf1rjM3EtAnBcikvz2yjQQf/iaVMsZv/X6Sar?=
 =?us-ascii?Q?kOjRJt/RsZQU+w5ks8p23NscCRL3yX3kCalaVDp4CfQANnoXZ2nhG3sHeZdm?=
 =?us-ascii?Q?WloMSNNrw2xZJEZQKzuMK03N2vFbaor1/eJZnTAtaZkcIvGlJfHjAranVkWG?=
 =?us-ascii?Q?v2UgwN8LlfJApbup55NTqzrHVhXAM/cPSKcwbIAvEQNNReV5OesHfebO3YWu?=
 =?us-ascii?Q?RmjrX+Mnrv+Mtx8dMuhXuin1gBwy6vZ5rI5imdjifi0MbsLIXgNxjq8Xpp1l?=
 =?us-ascii?Q?fT/jI8/gEYK4wTZnvwi/CKjiI5G2fqD9hD9vYgy8U1MRZWU7IVg6ZaZX+hKE?=
 =?us-ascii?Q?KfLFodIEA+gvAoV0wNps+sE0nCZhBq+jP4x7vNXdPfyQGHB9GhJwEm4fl0qd?=
 =?us-ascii?Q?cwoAq5iuIb8iJ+3NE1hd7xrkpzFQqGYHu3WSUVcmDYq3nr8vchFBtpivQIhy?=
 =?us-ascii?Q?qMkJxM0l/OI4Ngivm6Gs+v+ELUISe2RaZ9tUhEVypPysLFPGSi7rjU7ENAlc?=
 =?us-ascii?Q?yWZAELQWN0jOi+4ysaR7jkR87I9xqGJuF+2T5OBdaWZA/IUjxXoOzOG6lnKI?=
 =?us-ascii?Q?2/f6LlrXYlkqUheUWT0ApGi9a9Ork2wxoPZxxi1WsSitgPUipXEjJvHvyUrP?=
 =?us-ascii?Q?FXUF91WLW+0af7itIqS4FaRAkhT8D9nGFX4YsFOJ4k/UXY6U23p8rb4QPZ3+?=
 =?us-ascii?Q?CjJjdmhChvVREeJRgCEIHqDxlfwoyYzuAYMJ+rBFftB2NFfpkZOAZGUUvk3Z?=
 =?us-ascii?Q?IjrzDay3GPWNcL8qH/BUv/5dRK/yScsN/3obKd4TeivBGyEcUedAPlksbcxa?=
 =?us-ascii?Q?5zMi1oThN1BYpTKoAwJ6kA7EcfpVXltgkZCoZC4Fd+/lrLGkvDML8vC5rYQO?=
 =?us-ascii?Q?vWWBFtYJxPgnUfoOsJFE1D0huoECQ0OmrJir0rOYIvxZx4sOIW2FC3tMfurk?=
 =?us-ascii?Q?VqDMq+6o3H4zhxFZPwekGX11oHRmDOj8OyqHxi2VZIs82nGQZky3OSXZ+dK7?=
 =?us-ascii?Q?x1rYtnYRtuXQ2hr2oh1g2kENlhnLQaqcEf7zwIvbXKbbrJxUZDTZycaIZLru?=
 =?us-ascii?Q?SX+SrWiY3iy5qmTggJumPlRlaD1Dmo0xniujWwldaR9QBiKfxUYAOXdjio3M?=
 =?us-ascii?Q?hN4tblD3QPG+vwadIUnFhl6VwqKsgL9vfsVZFl72hy1ClW/CePusneM4StGY?=
 =?us-ascii?Q?kxWLx6J0QgekdI6WwCb1BTmepRmhHSsyx3ClnGWCUk7xE4jj2E2Yyj0TmuGW?=
 =?us-ascii?Q?BpJYDZ6G83FV2LwG6j5EnAP0LJSNblkAtYWezpz4uQEPiQhnQaTl3owf8o4x?=
 =?us-ascii?Q?JYrwRN2qmN1DMTWuz7vypP+x4agABcamDGWcE8nU+AsXQzAqSOQzCCo9OVeI?=
 =?us-ascii?Q?izll7ErBYJMxLhSNDf3HfkLZvINvptBORG1hpEf75GyEqq2cLORWJBWg7z8r?=
 =?us-ascii?Q?FkNiDOehqNm7NNxQjOuJPsUrUIZABaXK0+Qg9tPQVRKR3qquucVhF1tGU4Ly?=
 =?us-ascii?Q?otuF7DXjstEo/VUOkLjig/tvz6pUkWl5adDZy7oXwdV9Ub6T1vPy4G8CGNgS?=
 =?us-ascii?Q?1m+ugQY5tA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7037926-9773-40c8-2246-08dee15433ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 03:01:29.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os0dKhwuSwcpKkYQMuJnHvnYlidqQvLjkAnJXkCl5jGdCD3WQ5t953ldri44p3ibmdtZ+4m545YSAXd5YNVIbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12690



> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Monday, July 13, 2026 10:53 PM
> To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors n=
on-
> blocking in suspend
>=20
> On Mon, Jul 13, 2026 at 12:39:03PM +0800, ziniu.wang_1@oss.nxp.com wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake() failure=
s
> > non-fatal in the suspend path. These failures only mean slightly higher
> > power consumption or missing CD wakeup capability, but should not block
> > system suspend.
> >
> > Also change the function to always return 0 on the success path instead
> > of propagating non-fatal warning return values.
> >
> > Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system P=
M
> logic")
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index 7818f351a58a..6cb84690fde4 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -2097,10 +2097,12 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  		 */
> >  		ret =3D pinctrl_pm_select_sleep_state(dev);
> >  		if (ret)
> > -			return ret;
> > +			dev_warn(dev, "Failed to select sleep pinctrl state\n");
> >  	}
> >
> >  	ret =3D mmc_gpio_set_cd_wake(host->mmc, true);
> > +	if (ret)
> > +		dev_warn(dev, "Failed to enable cd wake\n");
> >
> >  	/*
> >  	 * Make sure invoke runtime_suspend to gate off clock.
> > @@ -2108,7 +2110,7 @@ static int sdhci_esdhc_suspend(struct device *dev=
)
> >  	 */
> >  	pm_runtime_force_suspend(dev);
> >
> > -	return ret;
> > +	return 0;
>=20
> if other error path set ret as not zero, the real error may missed, I sug=
gest
> don't set it let
>=20
> 	if (pinctrl_pm_select_sleep_state(dev))
> 		dev_warn(...)
>=20
> 	still leave ret here.

Thanks for the review.

The fatal error path (pm_runtime_resume_and_get()) already returns
early, so by the time we reach the end of the function, ret can only
hold a non-fatal (warn-only) value. Keeping "return ret" would turn
these intentionally non-fatal errors back into fatal ones and block
system suspend, which is exactly what this patch tries to avoid.

To address your concern about ret being polluted, I'll drop the
assignment for the non-fatal calls so they no longer touch ret:

	if (!sdhci_enable_irq_wakeups(host))
		dev_warn(dev, "Failed to enable irq wakeup\n");

	if (pinctrl_pm_select_sleep_state(dev))
		dev_warn(dev, "Failed to select sleep pinctrl state\n");

	if (mmc_gpio_set_cd_wake(host->mmc, true))
		dev_warn(dev, "Failed to enable cd wake\n");

	pm_runtime_force_suspend(dev);
	return 0;

This keeps the semantics clear. Will send v7 patch.

Thanks,=20
Luke

>=20
> Frank
>=20
> >  }
> >
> >  static int sdhci_esdhc_resume(struct device *dev)
> > --
> > 2.34.1
> >
> >
