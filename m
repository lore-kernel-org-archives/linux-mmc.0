Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8293F44DC;
	Fri, 17 Jul 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287342; cv=fail; b=dZ6ItzuzSmY282CHTBqda7LHtmZtCyKUk0yEIjSkHZMfnjnZXlp6pdAUlNFl8BHeXFAowzyHwwSSnCey06qI4n8OwYY1ve82q+dqZPNWBApC3IkrmNs7IjWoren0HDSlltYAM/5Xe5QSgVE5+WJp1NOg/qzvJKYM5Csp0Dw8xJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287342; c=relaxed/simple;
	bh=GSflTn16IK4gOTrgui7794ljmzMErj99IUy4bgt7yTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EzeH5skb6iL+z6TP+3b2qCreUBhyFyo22hQSFpJwC8sefrX8ACXw7ibcWug77NkJx2RLzPYTs7dMGHy3addPghYWMhO/lNJkI7CZzRV7bqaH5zcz9rfom69CJxtSTZyKRMX83ETSV2SYwzGpBf2c0HBB+UlAvKmZ6IRSS/cTJVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EUy3Ppto; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EUy3Ppto"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHOQzm3dDo0wjnTac1h192rKp0Hiw7P41lxQi8p2bIUTQwp5mAJLW1cX8RlCaYZwAB50gQEpZ0cc5hV7SiR+J8mhxtdRIfk8WSMIV391g0OEY684AjRyeG2PEfB9vAAi4ODMdekWwMnrUMVIPSZQDSHC9a04ACu7IkZfzZ1tHvWzHaavEhdaq7GqnYqFQ4CgLrDtqmW1y5LkcBpcj9xhBs4ncLpdVzpHn4yUZwQexR1uMy2YJOky1Q0ymlXg2UootFD0OVpoW4/GgMCDJZlEOXOt4g9cZqv2TfYPCwIybvtVB8cymRi6zKaf6PZygKsQLWJtt4NvdRnYklEB/BIqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ASdk41qTe4S7BwvymIneYnr8wlDdbLxSztpMCjBvAI=;
 b=SRH3nfeZbjUhxOSBTUl7T4C3d+qgt62Y5oyTpwElrzvO+BGx9vma5ndzwN1Dn5wkqQSKPn1yetkrEoio3imhEPKhrBkZwU2NbIyX/8wn7XE6/VDJ5j2/OMsLgwW7lrOY+rGGduah5GUAuFRpaumuzkXmwyisBAAKB+jPy+0qOQYEqebZgPHKyhIawpiWPZnnZ+yUVuvTJ/NeCKKbBEpEGVAI6JSJGRMw9Sv2VMb7z/6KZSfssxwSNHNIDRXNBrZnFmTOgqyQFJjpyOhLhw/CedDYZ8s1FGjEHUXMXmCe9K0EINetd3i7QgNSemm/e87aRc7jmMNp2ciGnQOJl7JICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ASdk41qTe4S7BwvymIneYnr8wlDdbLxSztpMCjBvAI=;
 b=EUy3PptoXCv5BvBFxVB9LWiSyfcXk/Vobr80yBj7OuuAlAkGUSoehAXZWjw2pIA8lQV9N6+5fEQBlG89iBehdeKqI5WzO2LDy5B+IV619hH2uheN/7boKGAYCzzYJXtRtWLPkDxYnurhmr2R42olBk8FLBDh02stL6ecJjvQMGgRsOSPTkX5YBCNjnaN/9c+1ZxbKcBSbqGp31G1g9IBK4ai8JhoFXRoJzMIMAket6uFW2SCWFx5IW0IbOqLixNx/ACbzrupl2ZUjIQu0GCWnLq1kB3U6/li8hTN0hg+42kKs/2pezW9LWQcWHU4yraMhGJOusyfwEMyta/UFOq4+w==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by DU4PR04MB12110.eurprd04.prod.outlook.com (2603:10a6:10:63f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 11:22:01 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:22:01 +0000
From: "Luke Wang (OSS)" <ziniu.wang_1@oss.nxp.com>
To: Dan Carpenter <error27@gmail.com>, "Luke Wang (OSS)"
	<ziniu.wang_1@oss.nxp.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulfh@kernel.org"
	<ulfh@kernel.org>, Bough Chen <haibo.chen@nxp.com>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "harshit.m.mogalapalli@oracle.com"
	<harshit.m.mogalapalli@oracle.com>
Subject: RE: [PATCH v7 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Thread-Topic: [PATCH v7 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Thread-Index: AQHdFd58UidzVqxJrkWeSU8tOlQZ7w==
Date: Fri, 17 Jul 2026 11:22:00 +0000
Message-ID:
 <AM7PR04MB6870A9E6138EC8F7C8B23E53EDC62@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
 <20260715071818.272318-9-ziniu.wang_1@oss.nxp.com>
 <aln_pFNqL8495Y_a@stanley.mountain>
In-Reply-To: <aln_pFNqL8495Y_a@stanley.mountain>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|DU4PR04MB12110:EE_
x-ms-office365-filtering-correlation-id: e9cd24a3-0097-4cb5-db85-08dee3f59f24
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|366016|1800799024|38070700021|6133799003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fpvy1/tPAI9QPLUFA5Iog6aQcZaxk+6u+fAkEb7Sy/qU71lgvQyWNzmc4Nc8FineNdLFtwQ+/gstBHoAr28fgPuLwOdSBOW9xBpgfH5YsCTp9jSFtv1xwwpFr3mceEkQBiP0UvdzAhSt5myETLwNetZfNktIk7k/b38ONYhQe56b79B45O060TVTN14VDQJfWeRMY9pGAa5VG/O7N3uQFlBBPeDYfmkE2ezd2oHEw0njRQmQ1ZClQDQcbNq/4KLTPAV/rBhEhTrkqimymXuVUi9pvilLf7mW71zhaXNogXO8xP0Gf3CtoYL/FPvYj2zBG3CwiVPtJbFttlOj4gAlO7Y7W8IkGnNj1xbYV24LxWqTTAAYHRPpeQXlK8NNGcjv1Q6VbYrgjDMNPcdeBFjIy4d2jwdiLuZ0yXl7WkUuYSJH6IDAO6TyyPecWkBRcU9SbsgrLKEb7uiAtVRbL9Q/V9hSyGHro1ortJyzOdZBiVBSAKxywjVRYCq3iWqZcjEAqMkWD2ZJ2r/L5VnmmEYRWbpDkCiypWIoy1Fsl5O7GNu5I+aNfMr+a8zJ/1/Hn9nr6DKji4XsgnmJZGwgz6mG63RepuCFmOD27cTC/1xq1e8wtnf+bLoEKEsgjmRTHvebc3Tk4RAEwb5A7rE7fwJKglHd7JFjs257CTy9PfsaZenpBFKDZZwP6prOkJcKxNrWFGCE+6p0wQdM9E913LpbBL62/nRw41ALL0j/Pu0nvXA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/Gg1wOh9CLrF4/GEZqpaBzdrcqS7gQdPvrh6ibJcv8pwldUhCYC69R1JZZPe?=
 =?us-ascii?Q?dZLjSeuU8PJgWpicmbefEhhlftQwXpRY0q4YTgLRUkLOD0RjuEB+VoxrTrwv?=
 =?us-ascii?Q?74uzuVrQDWesUDVZQ0u0Fat0R3GEHVhCgoolORxmf2VkvmFf2MvNbAuAx8vW?=
 =?us-ascii?Q?dtA3HAzMEP5ctHqWQ9qadGZROhlO5OgnWAcOGTOr+cOKzJSp3VH6TH9tO3py?=
 =?us-ascii?Q?ztkZBdo9bdOfHSOXh9js5bcV5C9RT1SzqIBLbmoNnWzwGQXiCp8a0nun25na?=
 =?us-ascii?Q?E2eR910dL7Xd7Txl1kcw7d7c11tcVfIvcx2WwX0ppKjxHiuZ0mntSdLSiVOK?=
 =?us-ascii?Q?iIzYnsTFH32D/GM1Qv3TsSyqPPheqhxVu6dQ6bl2OjhaDM8y8oAM7u/f814I?=
 =?us-ascii?Q?mxwukHFHTMvWN8ZV8xw1RT8um+q88MF/wpvEj98cQ119HujwwZ2D52cpHjfS?=
 =?us-ascii?Q?kQZA7ncgsrANWmSgJ94H/eE50c6+zrTAb7HJTbuH/6zKaZ5R/BHI5SG4QCk7?=
 =?us-ascii?Q?3B2p5BiwkRbHGEDMkehijq4t2+wwWp5ZahIXY0I6sKQeEuuCrke+kWEfFlhJ?=
 =?us-ascii?Q?R+raVQlRGcyRRh16flZkWdDEWYkgu9n1RaHGREIW0xB9hctaA48xbKUQMXH8?=
 =?us-ascii?Q?d3aO+Vedo/wHWtDUaQhA0NGjR8KovozRZ2D8oTESh8z2kW/taDgElHXM2yO+?=
 =?us-ascii?Q?zCEU85xdMMQvdBXtYp6xIViLLfvgieiOUAZPyQd3oUSCDrg92TDue+aapOYH?=
 =?us-ascii?Q?NDhfxl7Glk0n55KlKTQf3dnowQIk2dpEyO5UiNcxEw7P7iV/NkzxP6R+tGR9?=
 =?us-ascii?Q?IOCmcKtonYkYeGxQHI1k8reGaeWmx53hvk4RbmA3fJzINjv+n1qZvI49udjf?=
 =?us-ascii?Q?2RlVXTHzrqSP+mzGcvhOP8XZP9jpTiUuKHmRaNij5cILk6HA/e+ew4nIPHQK?=
 =?us-ascii?Q?1wJ5UwdK+TU+xGA9i44tSFnaiNQl1sODKJAgfH+s/wIXLH+HB1YfvE9iJexZ?=
 =?us-ascii?Q?YNQNDgKImFUaAM4QInHyD+uBLkhX2rKQc6HDP0PXuFEfxNkPV54Y9qIaPRr2?=
 =?us-ascii?Q?u0iy7vQko7HQJ8xER5g0WzgRkKrf92iJj+x5HyMFVMOLZQjzpxLioT9s8MUi?=
 =?us-ascii?Q?WCefm5sqv9NFjPJC/BIwdomUxkKVi3kS3APEFgP+qQ+1SnpvD0PHdouSKdfp?=
 =?us-ascii?Q?THq9KGPjFghNkMrzWq3qXhy7eIsPfA7Ro3dg2x2h1ZfxE1GO5dcDKhnnTD0A?=
 =?us-ascii?Q?aoTmo9PsQ8eyi4lUJD5TkDyTl6WRLxGyt9MJh0fSXpyG9BTknWHi8RsP/MgT?=
 =?us-ascii?Q?wU08PAO5tKxSZ6/mAXb4cdf9feZM4gXK+VmO+MiwY7qlPNCfRUJjKbD6SHKw?=
 =?us-ascii?Q?uPcu28+2+JstuhJpUwIIK0QICXpejw1KPdRsD4kvnUlk64U2BAhODq7RjqO9?=
 =?us-ascii?Q?V1sBYa2F1qSKdpWT7VrWLGN+9x0DBD9pvXP7OrwcQ0AKkZdeLXFRUG48hA21?=
 =?us-ascii?Q?GJ/VTxgW/Y3QTgjxyYiq6WC4O7RpjQAtzAOAT2LgcKzSvSsSDkcA1UCf19sC?=
 =?us-ascii?Q?Hh34wQ80og74NF0l+WOjePNa4wFUxFwnWgbISry/se3EcpmRnq4GvMS500cG?=
 =?us-ascii?Q?o1Apy9gGZpd4vaLyow1cZjxyXDQuN5nL0HlmGiudy4xXNMsxYoi71oPyfyMh?=
 =?us-ascii?Q?ihFWed/cG2ZW6wz4OyEU5VYH+BgzUPZmqymKu+EcLr/WKM8hI6aaoNXAT4AX?=
 =?us-ascii?Q?eSn/zPtuiQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cd24a3-0097-4cb5-db85-08dee3f59f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 11:22:00.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY5HogmFvInbEcdISReCO5C1G5ALo+pU7VdPPRFBCArlVAMkXTyJbXsZAC1Q2eXwPiwtHx7svzUeVj0pdWadpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12110



> -----Original Message-----
> From: Dan Carpenter <error27@gmail.com>
> Sent: Friday, July 17, 2026 6:11 PM
> To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> harshit.m.mogalapalli@oracle.com
> Subject: Re: [PATCH v7 8/8] mmc: sdhci-esdhc-imx: fix resume error handli=
ng
>=20
> [You don't often get email from error27@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Wed, Jul 15, 2026 at 03:18:18PM +0800, ziniu.wang_1@oss.nxp.com
> wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Check pm_runtime_force_resume() return value in resume. If it fails
> > (clock enable failure), return immediately since accessing hardware
> > registers on an unclocked device would cause a kernel panic.
> >
>=20
> The commit message says "would" which implies maybe...  Is this something
> that happens in real life?

Accessing registers on an unclocked device does cause a panic. The specific=
 case here=20
is `pm_runtime_force_resume()` failing on clock enable, which I have not ac=
tually hit
in practice - this error handling was suggested by Sashiko during the v1 re=
view,=20
so it's defensive hardening rather than a fix for an observed crash.

>=20
>=20
> > The early return intentionally skips enable_irq() and
> > sdhci_disable_irq_wakeups() because the IRQ handler reads
> > SDHCI_INT_STATUS, which would also fault without clocks. The PM runtime
> > usage counter leak only affects this already-broken device instance and
> > is an acceptable tradeoff to preserve system stability.
> >
> > Remove the return value check for mmc_gpio_set_cd_wake(host->mmc,
> false)
> > since disable_irq_wake() called internally always returns 0.
>=20
> I kind of agree with Sashiko here that keeping the check is better future
> proofing.

Fair point. In the `on=3Dfalse` path `disable_irq_wake()` always returns 0 =
today,=20
so the check is a no-op. And even if the internal implementation changes an=
d
returns an error, it wouldn't matter functionally here: the device is alrea=
dy resumed,
so a failure to clear CD wake doesn't break anything.=20

>=20
> >
> > Also return 0 explicitly on the success path instead of propagating
> > stale return values.
>=20
> Unrelated cleans...  :/
>=20
> >
> > Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system P=
M
> logic")
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index 290a3172931b..18f4905c15b9 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -2123,12 +2123,12 @@ static int sdhci_esdhc_resume(struct device
> *dev)
> >                       dev_warn(dev, "Failed to restore pinctrl state\n"=
);
> >       }
> >
> > -     pm_runtime_force_resume(dev);
> > -
> > -     ret =3D mmc_gpio_set_cd_wake(host->mmc, false);
> > +     ret =3D pm_runtime_force_resume(dev);
> >       if (ret)
> >               return ret;
> >
> > +     mmc_gpio_set_cd_wake(host->mmc, false);
> > +
>=20
> copy-paste-checker says that similar code exists in:
>=20
> drivers/mmc/host/sdhci-tegra.c
>   1879  static int sdhci_tegra_resume(struct device *dev)
>   1880  {
>   1881          struct sdhci_host *host =3D dev_get_drvdata(dev);
>   1882          int ret;
>   1883
>   1884          ret =3D mmc_gpio_set_cd_wake(host->mmc, false);
>   1885          if (ret)
>   1886                  return ret;
>   1887
>   1888          ret =3D pm_runtime_force_resume(dev);
>   1889          if (ret)
>   1890                  return ret;
>=20
> In this case we are calling mmc_gpio_set_cd_wake() before calling
> resume so it's surprising that that doesn't cause a panic..

`mmc_gpio_set_cd_wake()` doesn't touch any SDHCI registers or need the cloc=
k.
It only calls `enable/disable_irq_wake()` on the CD IRQ (see drivers/mmc/co=
re/slot-gpio.c).=20
So it is safe to call it before or after resume, which is why Tegra can cal=
l it first without a panic.

Regards,
Luke Wang

>=20
>   1891
>   1892          sdhci_tegra_program_stream_id(host);
>   1893
>   1894          ret =3D sdhci_resume_host(host);
>   1895          if (ret)
>   1896                  goto disable_clk;
>   1897
>   1898          if (host->mmc->caps2 & MMC_CAP2_CQE) {
>   1899                  ret =3D cqhci_resume(host->mmc);
>   1900                  if (ret)
>   1901                          goto suspend_host;
>   1902          }
>   1903
>   1904          return 0;
>   1905
>   1906  suspend_host:
>   1907          sdhci_suspend_host(host);
>   1908  disable_clk:
>   1909          pm_runtime_force_suspend(dev);
>   1910          return ret;
>   1911  }
>=20
> regards,
> dan carpenter

