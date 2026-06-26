Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459872D6E5C;
	Fri, 26 Jun 2026 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453794; cv=fail; b=N7S54A9a1TEjFAfFHIcT6QVo80+cVpmbsWeVNKY5h9UghRpX1YnEiHtVO0HF+frFsKATJ9Fj7stLljgkfIJsNmuDUCtOkLvX1Pl3RIReX61DK4Ho6sHXR3nQvUqhAlYFfvvWKLnqAG9X5yVh3JMhFtZoM8A1cbqqzG3as5Q7ttM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453794; c=relaxed/simple;
	bh=EwQln6sdTPwOfmF4HbSnva6WuPCPBRPTuzK5fc0ylsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qS9XDa/btGE+OnyakhJIpAZJu0q9L8zL89wFcV3psqsODFh55P1W8rOubSK3EVs+2PX19/ZApfPS516L35QYnKC1JSXBt3vgUyMv7BbHvxStRN/0MvgneqT0HBQl87KKuXEgdt8LlKedd4Y6Sxc9rF8Y4apRd7RDCH8VSrUHvUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=av5Z+FR5; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="av5Z+FR5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccYLWlF4NDmD2YUqyeH3TWTQc4aPyVkk7AV1AqRiTxpmzMYW2uxDh5OxjHHl/nG1z3NMzcdpmxRIv7hp7pwenSRSkm6m8J+DDIP74V6yMK09cENM9B0R0CJoplyDgCnMHrDiDPdFMHcu/3R7nFWEOIwQwlClX5g/6j4lMNpDI4F3NGDEUNb/EizGXaQK/DyAp+EC4Fzl5UCqPVgDwzilQlmeXVDPAedW0P63wIyfVbWg7GWLOkTlk2viPMYiRV9yE6pBNO9HhGbKIwOJIlGuFGKxGKhCdq5TQIfO4v8M3qxsLYRnPy+k/H3BC+zoQAwbG+pSwBbqhnPzuUA712dFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd1jF4q22kV0XzYFqdLSJ27POjKVFYZvfhnIjCMVUeE=;
 b=qQb0KXTdnaVkOVZsyFGyjK1XEaWmpcoIp9Bi4AFjkGfzgDM+z2dB36Ax+pvepxjaYtBUYtPD5OqsIulJDrmXzcJJEr71m1iwUXKT9S0UAqQwAH6P6PgVmbKNI2kkm6TL3IF847W55hiH1ghfDl7CmOU1wHBJS5DTc0KrgHvVgxhxeNBwroV3KhNd6d1ncbCynq2co/7xM6Ns/5xFE+eeoa30kXFmq/chRuQlO79+JTNrgTN05fTfPt7n5pgY01pIrIBCSPenkWMGaNHUKTMBqpFq0gJKvCupE025veEhN642bj4wtq841TFjgye47cVYxqmEUTv5SwW0HppIpCMSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd1jF4q22kV0XzYFqdLSJ27POjKVFYZvfhnIjCMVUeE=;
 b=av5Z+FR5bBgtJG7wjMQ9R/2cm8o4+3JCd9u1E04uDbL/Ol0+XlXQNxKdKP8gPIC3vgOdFowFibPbWU6YsGFuyMOAMHqgEq+idwU7xctUUH8W6+RgQGGg98/S2Yce0o/DLAWv644IwbvQFF8HFQQxk1uvr9Ock3kPU2/RkE71gncH/Rx0vEIboIQZAiApul1/KUpzkOYZm7GCT7CzpF83VoGkTeZUW1kxsiNMQ8Um1kelkD0VHnIwYd6bTb/oA1qJ2VpomB2us/yQf4z30HYwhO4KdTYKhwcO6hCVFMH/v0qaE/HgrQP1jbdEfJMLX2UERES4JmLm2GDxUhrF8Kap0A==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 06:03:05 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:03:05 +0000
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
Subject: RE: [PATCH v2 3/5] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
Thread-Topic: [PATCH v2 3/5] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
Thread-Index: AQHdBTF0cdekhDvyrUOO5+VTZWgUpg==
Date: Fri, 26 Jun 2026 06:03:05 +0000
Message-ID:
 <AM7PR04MB68708D2075BE3EF4BC35204BEDEB2@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-4-ziniu.wang_1@oss.nxp.com>
 <aj1Y1zLgZMzEihZw@SMW015318>
In-Reply-To: <aj1Y1zLgZMzEihZw@SMW015318>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|AM9PR04MB8761:EE_
x-ms-office365-filtering-correlation-id: e4a2bc28-813a-4469-40e1-08ded34896f5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|6133799003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 kMyVCrBWFmt5I9alIVB3RwEzTt1bo4olymEyF98Itv5ijTw8IlzMBWSaFCuhLGDlY4crbwlwwKhlTUjQ21x3RmvLizbE9sKoXsx2590Eikpqe672b6Ih9EJOp05b5B3xSBDQSlLf5VKaFrfRd9lhnkhWt3xM1SoDjhmaGVNoeKew13xRzWg94xgR9/F8dcdOSBzdkaDfpUWM2LvloUeH8dudEVUkn9Vt+Sg/ozPEsrqYPLMZBW2KwLNyCVNf6RI2K3+T11SfRVHGWRr+HFOr+45+w3tqqEw0GSstbeb+sa22xJLeZ9jtbUwX8ERCuyBmwDie+v6NuyR0o55u7mD9XS2bd5oBDH/svE2lE4ODeJJlzsf6hHv6E8x7rSPo78XD0TEvuYVL9cL/QSi84+MBPiUzdKK8wCX16UTYCrH3ZOBLdu6XVj6qFX11wpRD9oOFGQ14vnjekoG6SgYkrvl0GLMZ4op3kKnUg6MsW+Go1TmEW8aM1mNjbY70HkZx2zByS8IivuBYp7wPhum9fHZrsOaiYWJc4OQ+e1EINo0qqRf6DFLSQFskr1wPv4Tppuhphypd4jnvPv3+rOZto+t1h3KsrjCgTc+qyDlYnIVDANM2k0ZLxZv/ypIkxT0S1NT3jN3ua7L5NhfLLiIqu0UFbm7juVwpJPr7T4cpl/7m0w9Q1NbZXSq6nJq4WjoYzwWXAga2ZHQp1KQ1KuzIcGT1y/7RlGq8/+ot6LnpT2N+7KA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/KSphHijParWcxSswfmCdD2oc9pNmymvK1DEYJfcwcyih9gSOYGVctwdIE0r?=
 =?us-ascii?Q?pOwguJpcAzGsJOhoGh0SsNg7Gtz7pHx9t+dyrsgVFBmLi0RCiDrkkwi2Kpc6?=
 =?us-ascii?Q?79WV5j2Q1EFrWFhXLO+UgFRZfylsKZ66MsVhaOMFYw5Bg1EDTefKf5C5Zqxw?=
 =?us-ascii?Q?ZaybQlQxAh6NpfhSb6XFp1JCtr1VBeVX5JitTXqi8bVCBbMjZ+xoECutFb8h?=
 =?us-ascii?Q?ZG2A+CuZz7ulWbspi8YseQRlWfN6kyt9FVG+IXf+yuhzlNomorIBVVl1GyE1?=
 =?us-ascii?Q?P1gobtz4teLBxznGA3LkiA4f+2wTqTnaq5EEAw5MeGekwu0kh7KDdxRxdT4F?=
 =?us-ascii?Q?ekm0J3B5gVNTMfEB19jVU1eQZ0wyloklLIBCUzSCXj/U/n2zp/Ky+cz4URHp?=
 =?us-ascii?Q?yjUSqJO6bS6lf8+xG68ZRgZ2THgcx1LNXwomeM+RdcqsWcSIxILozQzIEp2R?=
 =?us-ascii?Q?NNkrH4ZTrl7xk2DjzMXFiy1RZzHOkQ7ey9dX9zaHBAZsSSOYtOrpC6klSzzC?=
 =?us-ascii?Q?LmSWdMPEUUVIiTvaa6ewEXqlY1rcGAlVBClmLLEEC2eR0KdfCsBLrgWyxwMC?=
 =?us-ascii?Q?RWEb13jI6C4xmtwBwW52c3WuoZLYjbMf4BJCAuLbxhv16tOcVva5gHpZ7HUg?=
 =?us-ascii?Q?afZe5XK7WfRr2OdYr0sUkQCUVD3nO0SjK4o+ZOz0OzvKrpNeym72bg8/8jfu?=
 =?us-ascii?Q?+73m0/+1etG5Njsa7Prn5mqmmIPnlfJtmb3a0IOQOsnqBtpr95U4t8zbG9Gj?=
 =?us-ascii?Q?T/HsF+mq6W13dYqTVoPzsIlFCIK4HFHiCn+WnlN6YZCEuCw6Q03NNe6n6nIW?=
 =?us-ascii?Q?5iwYhLUB56ymdoL10y05pN5YHgEUNgg9rJUC9FwdOFHJYTWO1EAeEPgiVpOI?=
 =?us-ascii?Q?SKnt5YDuGqs6EZjhR3YRqnnz4nnVAdG8OgA+z7qxwhd9z3sVOFe7wxPpBS57?=
 =?us-ascii?Q?47V71E8OqeWU5x3dMyCWCv3rYxniQio2qONyGRKVlOIP6BIr8DosduU1zdhP?=
 =?us-ascii?Q?L+oykbdIkOMDEZuuMYc/snqjf3UPwmHhUmWnBe65qFRpmtD49YULQzUcZoab?=
 =?us-ascii?Q?XG8uICOwYfJ6xDJr6wXXnL9OQeK6gEW5cuLZux43HaCvhAoHyy0LrWzzsNfq?=
 =?us-ascii?Q?qhSgYQlao8xmix0EPZbISSq+Gn9jr3tD05Umv3bM6xCu9MN8Aa2uyg0qrDCT?=
 =?us-ascii?Q?UVmdPa9QpR+bdMQv23prOMDnMJHh4Mj1/psPkDCI1TU1I+nKh3lJ2EBde06D?=
 =?us-ascii?Q?kqx797dW+yDMMBOvgOC8/vKJy/sNZrrOpNpf7Dv079vvxGVINF90SPar9MPn?=
 =?us-ascii?Q?JqpfsEAkyMGIJOhpgvdh78dmcVPPYK2KTc2Y1OiPhuLmzPrxJG9ktbLS4CFT?=
 =?us-ascii?Q?N6q6MgSDQCNtz6//sFEFTvjLNoJ8kfamABuG8uM0jycFIcl/7a+vbkz+H3xi?=
 =?us-ascii?Q?TDN/6z/MjwyALUVZNUDT+bXuNEBYoxZ9coeqdrQlwYHERbG84LA7pVA+UJo/?=
 =?us-ascii?Q?Rrr64+P6fH1uOCQLgH5FfXKGm/yIlZfdiLPArzDz61zU7WVrCtfwo6Z1h9dO?=
 =?us-ascii?Q?nC+jJlvFt+gVZDgIVKPcHzb3CY5xJC+Y1v+Dfk7KgWyqT6rUFmWVV4CImghf?=
 =?us-ascii?Q?POqbYIXBRFJWA1EWM/iHCMdbaoZ2TeRsecwqt+KKnHCrONQr6uHfPYY8s2kh?=
 =?us-ascii?Q?t6hp2Mzr8D/jmEhpbqEgMHJxBAcE7QkxD6QKYqfAdogk1JP+s65k69/3bzKd?=
 =?us-ascii?Q?C6gaGGbjWA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a2bc28-813a-4469-40e1-08ded34896f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:03:05.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRkYxod04EYjzNue4MIS4WApH3YXyAOLoEEyh8xUuRcqPBOFQYcb1gu+DUhUvTLWaIucujp2wIavhZgtNZiqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761



> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Friday, June 26, 2026 12:36 AM
> To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 3/5] mmc: sdhci-esdhc-imx: restore pinctrl before
> restoring ios timing on resume
>=20
> On Thu, Jun 25, 2026 at 06:59:32PM +0800, ziniu.wang_1@oss.nxp.com
> wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > SDIO devices such as WiFi may keep power during suspend, so the MMC
> > core skips full card re-initialization on resume and directly restores
> > the host controller's ios timing to match the card. For DDR mode,
> > pm_runtime_force_resume() sets DDR_EN before the pin configuration is
> > restored from sleep state. When DDR_EN is set while the pinctrl is stil=
l
> > muxed to GPIO or other non-uSDHC function, the loopback clock from the
> > external pad is not valid, resulting in an incorrect internal sampling
> > point being selected. This causes persistent read CRC errors on subsequ=
ent
> > data transfers, even after the pinctrl is later configured correctly.
> >
> > SD/eMMC running in DDR mode are unaffected as they are fully re-
> initialized
> > from legacy timing after resume.
> >
> > Fix this by restoring the pinctrl state based on current timing mode
> > using esdhc_change_pinstate() before pm_runtime_force_resume(). This
> > ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
> > is applied. Only restore for non-wakeup devices since wakeup devices
> > kept their active pin state during suspend to avoid glitching the SD
> > bus pins for powered SDIO cards.
>=20
> pin state change should only impact driver strength, why cause glitch ?

You're right that switching driver strength alone won't cause a glitch.=20
The issue is more specific to the sleep pinctrl state: the uSDHC clock pin =
is
low when the clock is stopped, but the sleep pinctrl enables a pull-up on t=
hat
pin, driving it high during suspend. When we switch back to the uSDHC funct=
ion
pinctrl on resume, the pin transitions from high back to low, generating=20
a falling edge glitch.

I'll update the commit message in v3 to clarify this.

Thanks,=20
Luke

>=20
> Frank
> >
> > Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system P=
M
> logic")
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index a944351dbcdf..7fcaecdd4ec6 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -2114,6 +2114,12 @@ static int sdhci_esdhc_resume(struct device
> *dev)
> >  	struct pltfm_imx_data *imx_data =3D sdhci_pltfm_priv(pltfm_host);
> >  	int ret;
> >
> > +	if (!device_may_wakeup(dev)) {
> > +		ret =3D esdhc_change_pinstate(host, host->timing);
> > +		if (ret)
> > +			dev_warn(dev, "Failed to restore pinctrl state\n");
> > +	}
> >  	pm_runtime_force_resume(dev);
> >
> >  	ret =3D mmc_gpio_set_cd_wake(host->mmc, false);
> > --
> > 2.34.1
> >
> >
