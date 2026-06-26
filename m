Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F73D25AD;
	Fri, 26 Jun 2026 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453905; cv=fail; b=WWhglNF/z8ZQw6/xRkTL1hfbnztGgLPuKZKgThH6EYA/5Q2N5VUoiOx5KZ7OfUQjl+DCyHCG1gyc7M1zdRAA4ucdgB+D32H878e4LpsA4WNPJC3p5v0YAXzBRAOczfKAaopcNZzbU1M1DwnqnVOjPJ4DkQ53abco+VpCol2YFlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453905; c=relaxed/simple;
	bh=dKflyeG86IJLFTjC0Yrhq1XpG5/UPVN7RY38KufuvJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OyLLvUpS2EggGZQqQYofJoRHBtSC4eezUeZJmB3a4wblWTX7/8cAe4Dg+xCej8Bs3kFb5qz19q+15KKvhw6XqG+OgdeemLBEk3jdh1+1E19vxmzcIomnxdRz16RDYz30xPh+zM4G/UrKEVAzJnmUrAJnBgiXwN5Hof8Rx+mvxio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bV6ZvOfu; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bV6ZvOfu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIU+LrRYfiGeB6a6W1j22tNO6XEdNQEzuMqpue7FA8mGs3d/yMsu4evUg2PjCTS2MwFLxUb97rjp15jg+oTKTNb8Xeh0H1dOwQ+4nLgOmayWFtIuAt6TVHp854FXIrn0O3Wdv95j2vTpQciJPmFVQC5goYHb/E5aPcHkD8WgUBFHJ921dwD7vc1eSRiBCg9yqE2C5UIkLvj21q87zCUFukMZDZRDMYN/tXxvwlqKHPe9K8JK6cELZO2Rk9XdXZuE+sNujUDu62qt5V85cuD4KHmIzai0486JRwNxG+VG7yzvv+dq9BEgYTRW1dmvQbaKsG1EGu7VjADuBfp3yxhFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCac+2q2vGaZLxxI3z7OScBoyAL5OE/Dqdh8sIms+pk=;
 b=FHAQzEpJzW6SFGlFGNpDRZ++k/n2MIaqJo5TpzYmPugTZcm1Y/aXXrsOml/e2uSw/+fltnL2VjjvKVyWfeOyC4+lh4Ux5MIcZdwHvmqND54v5xZs4T/wHOW+no5BKpqu4DhmdGvpvnGBKPSHdX+5683r7Za4zxBNwSg5p2lWQFd0BAQDy15RwOiItNhh9wdE6vDBLl6s2ke1HRQNjja8xXNq6VKxqelnFoAep7lV3Wipz0vRIjYDMsz3j+TryZytHPAT9JJ+IHzU8cDLcVdLlsX1deJwMSUwgaXptQiH+gpau/Qj1uOZ/narsDHwOiujLzgvBC8vL7mqZA0HZKYkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCac+2q2vGaZLxxI3z7OScBoyAL5OE/Dqdh8sIms+pk=;
 b=bV6ZvOfu12Gzs8IW+7o+LKuO0j2+yWN1AEqEO4TDPVvzDd1FQf/8Q/G+simpigb3V6pv/gcdYmpwKTtK8Z29VFeyGHlCkGMI5Kh4E88FwU8CEUbO5mrvlRe2kN94mSwGMDgEvf4WIpuHHErCeXmrfPY8Cq+hDXeLA+PjF9FUUkyxnX4867C/bki3mMJF7yJoPZ6HIBgvdabTfm57WTX8gqnlqRHiKtsrB2+kIAOhgPhZWxWOnfXOM2G8KOruSZaY+VVHVAJFHImfbbIgGwHM4x7+qwabcNCzhgEXpVT2aXN0ZG5wCii3I/xaEG6TptrSmwXHT/CZv1OWPBzWIYZALw==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 06:04:59 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:04:59 +0000
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
Subject: RE: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
Thread-Topic: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: disable irq during suspend
 to fix unhandled interrupt
Thread-Index: AQHdBTG41zwYXsNKbUiNH1riSKYN8w==
Date: Fri, 26 Jun 2026 06:04:59 +0000
Message-ID:
 <AM7PR04MB6870F25BDE79663112FDAE0DEDEB2@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-5-ziniu.wang_1@oss.nxp.com>
 <aj1ZWZo_9MLUWDBD@SMW015318>
In-Reply-To: <aj1ZWZo_9MLUWDBD@SMW015318>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|AM9PR04MB8761:EE_
x-ms-office365-filtering-correlation-id: 462b9a4c-6c42-4fee-4ca7-08ded348dafc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|6133799003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 LR4jf4pYG5xUooEwBc73Hpcq6vM/y4riB43kXPtdvfiTtJCy9+OrIMHdIjXpk4YzL3X+KP958z33+jywMxL+q9QLUxEe3+Av5HnJFoRGHHYPYRwvzcpgxdMabuljgRX5eHBzmKHZtlV+eK1nZ7L2NuyssSFDAKTG473cZFGhBVFnY8nI+fmcMq712E2K5UOuujVh4273StVILHesfx3CVa/vJ28ikbLe97UNR4JRovSmxyXiyUpqO8TfhIIEkxQh+3xky+D9Ckma8thwUUNiX4ecQjH1rmIk76CyST7cDDIEpwGFWTav7i3YXc1OyCUPa0XdIR1iCREm9egDERokk2ufAsIbb5MwCH3d3dz3hrXgxrGc5/NQY3KUCRiTecMCnmF/ZJP8l4umnpcHgQZKlnYLvASoRz7gHelvgJKWzqLg8hWB2ItcFO0mcHBpAxSHi9eA6y8fhzmrRhXPl3zfhcbJc4Dfc2CM5v9oDDFfBcybGzJiB/1QSlXg06jWM27RdJ8AzocqAtJQuESmk7ldSBI95CtsMUIFXbwDau4IL7YLvgRK92nHgR898yEV4lajUeb05rJ8mj/7Xhiqv70EpRXr0rg0/2lPNll5+Pyw0WCR50ROC+DlvboD5JOxH/tXfnVB9Fif5Flmbr6VbpYUbdwWQqeGcGJkedTzKxc2dl5RnKuG8Cad62TvZtxtSjwayfQaO1nlwuvQuCqTK58Jh8Bigl/vg/b1ApyQwJgojMk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B1duG7sNIFwcBCDzlTNDNyi2ArpnDZQgEAyk9v4++SSZmht+X5yNMwFs8GcJ?=
 =?us-ascii?Q?Pbmz/92C4Q/U5NMetcXt9oeFkIQ8K1/faFgLuyts0hypoC4Seu6UJbOiIGjC?=
 =?us-ascii?Q?aycaJs3nKmS3VFJ+argSjf9EBQbChnZU3/9fGJh3QYOEjY0i/RCf10MTGV9v?=
 =?us-ascii?Q?rls/viffvONw2rm0FFtz4hq6CywosO0QSYQl3pTvqh7TxNWU2d1RnASxMqdG?=
 =?us-ascii?Q?QitCCilMSx8CSYU7EgGbI3Gg2u5SVa2vXlbcixcO7ZSLcYWns7fSBd4J7G+7?=
 =?us-ascii?Q?u7sa7I9MG2/XuesFDTppQckO/fOcfEwaNeEVeWMYryHTxBm/XPNiRsSy/V3A?=
 =?us-ascii?Q?DjK15R6raZFCJahSa7SrOBRqw0R9KTRfREx8O9ZZEQ7ztqDFfUl2qzS55bIA?=
 =?us-ascii?Q?/dNiv53HJ+J1X1lzv5ixuJsMqI8yPErB0ZWl5MqxNecXxruxP8GbCbcIkY09?=
 =?us-ascii?Q?CBBgauiEwmX08f86NnbxoKP9C33rjFPy4+5XCdnfuc+GfKwQyVI7I2e6KHJC?=
 =?us-ascii?Q?NN4lmgxyq6erDf+jKUf1aATJx8s5Zu209+xnjH9sanb7ceXC9XZFtQY7SGPr?=
 =?us-ascii?Q?NOqkCYxKPi7BXDLvIO7xcos4wc9EtMKotXq1fVOVzRo3O+PxO3rp9hPOxrTY?=
 =?us-ascii?Q?+d3iOlX0f2F13rktOWPVMu+avArTOIpPsoNixqbwG9pnfAwbjsTAi9e7rcDB?=
 =?us-ascii?Q?q0vdH0566nATPVRP2fUl7CdlQFlyIynr4JKNn1F1Lr45dtoPz7+GDX+f2yjT?=
 =?us-ascii?Q?Ije/5pWZaQjw+pL7xy+fp4bv84j3QwVubz0vlAm2ZNhxo4OrW/lThaBlVIGw?=
 =?us-ascii?Q?lOlzFQkQdGIin4k+EDNw3F/q+bI5fyhnNF4PnKxSS+uaWziaWGtJnpaTsOLZ?=
 =?us-ascii?Q?NxYoQYvW3iE+ZQxjNrz39KHyVsZLCFoXqpgPFXPr++ECmxpKC6bKQIS8QZab?=
 =?us-ascii?Q?qb8vvwoHXGjBS/TA4DH+ydxWvLWSdfmxGrotEVHBd6XchXH7si11Rsg6zw2i?=
 =?us-ascii?Q?a3CrNgp7psfDQPhXMNy88o+SgWKITPnCGFKcOEi3gro/CvSPXacq/5UDtb8r?=
 =?us-ascii?Q?tyOyipjJ8mIEpMAEG8E9GHjB+/5+FMNowxJ4ujedtEWhZLz/FIvfl6GE0Jq2?=
 =?us-ascii?Q?1bcbhwQumRGg66DAdXcWiIVl1dvmjqcevvYrdBGV2gRdvuNMbmOLgWNyb+oL?=
 =?us-ascii?Q?5uVl9w+wEExQ9QOt2+ey/oQJ8gXIrlEK+0x34V5KC0xW4stt6DLHC2uLyU9F?=
 =?us-ascii?Q?7GKbgnDeFTBd5qxYjUSsghHIHZ4OA76yzw9v6LXkHxAMs7weATkghO/WMk80?=
 =?us-ascii?Q?njYsqQH4ttkxlUL8Cwd79jEBNmbnrY5oaODcGmcalHlNRT4i+Z3WOBfN33a6?=
 =?us-ascii?Q?G35o9AfUZF1Yo1ZUUCKi5s9Z0y4mO66EwhTwXNtdAO6f5etoqa1L/ZMjgbRI?=
 =?us-ascii?Q?CWU/vWB//g4AH3sn8vi6RX2Wjc0R478FCQu45EEsvKbFqxWatlEItMzFk6Jr?=
 =?us-ascii?Q?1vVm7xAqUtzCALxyAqBeu4wZ/t5/E5uqDol8KSaZ/DW8RYGdBK6WTGv1vbt9?=
 =?us-ascii?Q?PvpJkTvxzejUhqI9o/x3lHPFmZitN0H4uXNRv3ZhppkLumnOSKUxWJlP3HdD?=
 =?us-ascii?Q?VGdMLrj2tz0A9ai+7DEI/Qxz4vVd9Mg5Fn1z0H1GvzaUE8/Iiq7Np/Zr2uci?=
 =?us-ascii?Q?nYi6FhEPAeNcEQQk6RPH/oF/wgtdN4fIemY7YHqceMEm4bDql/anq59XepTg?=
 =?us-ascii?Q?hlKbFkpcJA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 462b9a4c-6c42-4fee-4ca7-08ded348dafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:04:59.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGs+cPexedvIaXvgsCChsc2cKVrlVivK1yjSnhHUi4jGILyzveeaoqzQMDC968RNkGou4Rkt4gMztsszu2+q9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761



> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Friday, June 26, 2026 12:38 AM
> To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: disable irq during
> suspend to fix unhandled interrupt
>=20
> On Thu, Jun 25, 2026 at 06:59:33PM +0800, ziniu.wang_1@oss.nxp.com
> wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
> > occurs. This happens because the usdhc interrupt is not disabled during
> > system suspend when device_may_wakeup() returns false.
> >
> > The sequence of events leading to this issue:
> > 1. System enters suspend without disabling usdhc interrupt
> > (because device_may_wakeup() returns false for usdhc device)
> > 2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
> > 3. WIFI sends a Card interrupt before usdhc has fully resumed
> > 4. usdhc is still in runtime suspend state and cannot handle the
> > interrupt properly
> > 5. The unhandled interrupt triggers "nobody cared" warning
> >
> > Fix this by unconditionally disabling the usdhc interrupt during suspen=
d
> > and re-enabling it during resume, regardless of the wakeup capability.
> > This ensures no interrupts are processed during the suspend/resume
> > transition.
>=20
> Does it impact the case if WIFI don't use out-of-band wakeup?

It doesn't impact other cases.

Thanks,
Luke

>=20
> Frank
> >
> > Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system P=
M
> logic")
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index 7fcaecdd4ec6..c4a22e42628e 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -2076,9 +2076,10 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  	if (mmc_card_keep_power(host->mmc) &&
> esdhc_is_usdhc(imx_data))
> >  		sdhc_esdhc_tuning_save(host);
> >
> > +	/* The irqs of imx are not shared. It is safe to disable */
> > +	disable_irq(host->irq);
> > +
> >  	if (device_may_wakeup(dev)) {
> > -		/* The irqs of imx are not shared. It is safe to disable */
> > -		disable_irq(host->irq);
> >  		ret =3D sdhci_enable_irq_wakeups(host);
> >  		if (!ret)
> >  			dev_warn(dev, "Failed to enable irq wakeup\n");
> > @@ -2129,10 +2130,10 @@ static int sdhci_esdhc_resume(struct device
> *dev)
> >  	/* re-initialize hw state in case it's lost in low power mode */
> >  	sdhci_esdhc_imx_hwinit(host);
> >
> > -	if (host->irq_wake_enabled) {
> > +	if (host->irq_wake_enabled)
> >  		sdhci_disable_irq_wakeups(host);
> > -		enable_irq(host->irq);
> > -	}
> > +
> > +	enable_irq(host->irq);
> >
> >  	/*
> >  	 * restore the saved tuning delay value for the device which keep
> > --
> > 2.34.1
> >
> >
