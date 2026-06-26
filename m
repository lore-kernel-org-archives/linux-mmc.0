Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133173C5855;
	Fri, 26 Jun 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454075; cv=fail; b=UV1P3yUTPunPbhIH1TLkSIUYrJRlrTX7GaaLemyF8CAqcblEzJicBTgjwWeOytN8CqudqbRNbhmDB52iBeP8MZTcorySr1JD3mxiRPK4ItUHaHcvhLwHNKc8L4bK767OG/FJ0KFoMST4JKl+0MGDvqNH5UxEyjbrk6c9aogmboY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454075; c=relaxed/simple;
	bh=QpAYO4DVoPF1hQu4WQGUhh1Fjm01Arfm844PwvVzHaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A7YeWb7mHOPXnas/9vKZz1ZzlAihuInsS5AQ/S1wjqfL6iY4iHb28URY4Y18atmVZIsLLkarXqX7kJU/YKbht9IBgAfJHPYqgfMRGNxTGBG2L6MSZQdtMCCNL52pwtaD0ElWLsMemQ0wEZ6FmcPs3W1FCNmcNTh3PjrXeDT4L/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U94lJs9s; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U94lJs9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FifWxbKbF/xRqp7VnsGa5jK9P83JMZg5jkegiBuUZQrvb9aXAbmlD5xvpElduL/btO5cSlgEtDUV21YmShhy4Lc/e5Kciwu0lm6IwYIbOeZ9a57pXbNHQACwV7c/LQ3Oh1vPnubsi2D6PtzBM5+6gQOGLu8/AkMfGTX2JXgUabalV1j+ntCeG9bjeHVwUL24LUwB2YLAMh6/PpXizX7GdIcdGiNrnQKrxV9ccWqhxiRxDp/znSdFmDCkqtMLlqJZmMwx0nz6i/zfvXzVGH7UrQuSxV5g72DQUz++0wBuNK1oza6vLE9w6Y2VvQCgpRD1QUr0wKCi7NDUL+QSeOOUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAcktOzfZdqabYVdzER4PUOxGQlguq4h38qJj2IDEmg=;
 b=DSWr7h+lQ2bQ4auE68oDGbRNZIDivXnJXU7M5fP7kr1yMU5eJsCzOgUHQPYjxdkvpQNoGE/A3o6+gYcMv/c76LLKlpoxraRgq7vN9smUinP7MfJi6kFnLygEM3C3J3BUI9KARjv3MIFMYOPbN+2CJuJsgasdYHy17HfYg3jo+M7KysGF85PMw6lsVIB+d05kW1zVofsE6te18+M/gRXjL7s8k4HapioRF6MGg0bRHHbgO/kKLgArhrXraCCHAmlM53EN8eXVoFNKQBSD9YZ9gooFAnmFC++ce650bFgc5kOBIwEa2dp3Xr3upIQCTqxAaK2nYhNlGDHTpHvXcRiugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAcktOzfZdqabYVdzER4PUOxGQlguq4h38qJj2IDEmg=;
 b=U94lJs9sP71T9qiXXccMp9AIMZYDF4Luo7Z0sO61Dbxq/Lc2hZXMSFdEbS/iE6kU8NyXZILzs9CV5LuIoyTmA4Cn6xi1tU5fPsf6JOhvX2JyId3nrpNxSJEHXByb/La/MZ3a6fRszZG5Frc88KuoGDHFf8zSbrAO0qa7mcfYbwGDhRm/qRRB6b3vEv07rKTbPxzAfAItTUkb5h9O+Q/vSMHA4mwiF8/+cqOmSUvtOJsMaJKWt/3w8wiZLhxjyyGbu4JSxef+aNAnv3j7xkGdoHk9ngzGZLTpKUhPhV92InUQaIXBTIva7CcTUmr7k7RERXFAl5dprM52O2wDatIEIw==
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 06:07:50 +0000
Received: from AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f]) by AM7PR04MB6870.eurprd04.prod.outlook.com
 ([fe80::f080:2b31:578e:716f%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:07:50 +0000
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
Subject: RE: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: fix suspend/resume error
 handling
Thread-Topic: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: fix suspend/resume error
 handling
Thread-Index: AQHdBTIeVFLAVwtxMUGkhvuhKDcvgQ==
Date: Fri, 26 Jun 2026 06:07:50 +0000
Message-ID:
 <AM7PR04MB6870CDFEB76003273801DA26EDEB2@AM7PR04MB6870.eurprd04.prod.outlook.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-6-ziniu.wang_1@oss.nxp.com>
 <aj1Z0fYSVY4cw0Mq@SMW015318>
In-Reply-To: <aj1Z0fYSVY4cw0Mq@SMW015318>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6870:EE_|AM9PR04MB8761:EE_
x-ms-office365-filtering-correlation-id: c095caa7-0e99-4bfd-2ab7-08ded34940e2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|6133799003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info:
 mQMCFZxWHlnr0AfmIscmcZLL/JvChAD7Je2fpiJKqa3ut8gXndVmNKthoq97AswndqzUf81AY1Jb/6dqAWWGV//mllIrvUNaqjDs9IOdxwZs4fEq8E2ybmrFifv7EMcgjFwvhZg9J2kutb3poNCErcqYTvTsc3bBQWuIyKrOYAt+eI4ZKxTBRWzStA2MdS5wHik5aY6onpoCb4zOZJHvE+y7M+E39t0Y3MC7suZpxqFWApfhrrhjmVIlhQ78L+jxjvZbExn5sO41xFJojSrIbcNwXWVBlIxPo43QoM2avVkIV88AjId9K25PTJzZl6PuA2MWTqrTh2DVGozRN+kc8bwWhQUfWdDVTPm3H02KwkSksiUNMQtYbYvVHZVBXzrYf+5/Bi90p9locJMh5jW0pGuoAJuTnHPS72PqLg3u3cL6j5xX6Ok8aQ/nDf1AQkm3j+eMkR9cE0OFCKOR6mVcHdfyBMkMixcxr0quTp5B+L6W7zsNokptdwjo1NxbK33M7rT1atSg0sf/xzm3+Q4Syx7FRitI3T/nLb/Wm2VXui/57SbOesth3Ox+W/O9J63bzF1apwHVClkmCsUbxJ4R6jNLBYF3YCnyfHp7nZs3EAvZMPyxj+ZaWzTtJwKFoGqLGP35DMH2c/pN6tdGmCGfe1/rbnfct9gj4gotByli7cc+4Iq63+QdwLVNu+3N2vrel4fcVMliG+24qoEDZTQraKz57SoIaoGZtzhmUj6c5dA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6870.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QdgI6647OpY0cxDt2E2ItY19ZjJ5Dyl5nLWxi1ZAEdUdCcv7BUt7kFHMB6CX?=
 =?us-ascii?Q?KXE2n2K3iFUMMSMAx77KZ5mvITn1AHzCGiY+0zM4LOr1WeRQRkNfs1ko188Q?=
 =?us-ascii?Q?Bowa39cO/xPc2A3gz1ZR1Zm1fbFQ+GnO7GGkxAo4evbbh3m2HLS7Yus6RDDp?=
 =?us-ascii?Q?WZLLYEIU/XZ6NZ/ad71G8XkJ3T/fqfyBlzTsEl1QcWI31wWVTRsufqyVzWmN?=
 =?us-ascii?Q?DYXVg6uh6Om1VUArwW8E5nIP1Hgz4EwzBAdShmX9xdS4yCDsPzR+40QyQwIA?=
 =?us-ascii?Q?a+4z8R5obWxsqUY+iAe7Bl233Spk+rj+kVmm+CeCXxpLWJThLNeJP/PXTXZE?=
 =?us-ascii?Q?0xyW6FC1eidIiQ528ccKq26F2jbMl2nJEYv5PjviZIVLfTVLF4HP041GwlmO?=
 =?us-ascii?Q?qJolmJrH8si0tE6a4Lnv7rW8GlFm+68aO6yukfnTGO2elYPscflIbdSAzc0c?=
 =?us-ascii?Q?GdXsyNkpj2J8i/CQfsXt9dDXcg+WsMJhWm8CHHsg6dtMPfr1Q7xZTbQq0WA2?=
 =?us-ascii?Q?pcJ8BhMpJHdM+UVXAhvhCpNe1ZmqAFH8PhgjYlH/VSd111FENY0WiM3airk9?=
 =?us-ascii?Q?X7p9496pPatQRQL1ZeG8citCXQ7tcaZHq/2p/+T3gxyB9YOYSCfuLsVUarQd?=
 =?us-ascii?Q?Bu41XTsfwaXphf4G54g+AGmbarffFl4Gn/pwuFaySlK+/kOgwzOB8gpOKszy?=
 =?us-ascii?Q?u3L9yCWw5azgyHVYokbKE2chBuzaz8EmRMoovt6GhwIJCVqBVg4IaLQ1szBo?=
 =?us-ascii?Q?D1cMbxqFoLLryzeguFF60FZwaALezHX2P5BIfNCLkxL1fo5Jh3MteLz4rJk5?=
 =?us-ascii?Q?oxatA5VXD9P5YNkK8CEzOo0UXXOLbwp2v2Y5es/xfB0NKqY6dNH2Fje0APw6?=
 =?us-ascii?Q?JdNsckTwC/v6c6HOPOThe3f6sgAGG0M3iFxlrVpqOqBWEZwROm293nLBOgHe?=
 =?us-ascii?Q?YZeJZI0XWRxF4DaiVBrILjkPdvJ+jkoxsBxMrJLd1JBjRtrJqsP9bORK6wbK?=
 =?us-ascii?Q?qpa8UFR1jvdhuibHUJFVd3rvgBQnz7xDBMV5bRTkdei6Q8E/VFga5z/Lt4aw?=
 =?us-ascii?Q?jI5yd6HSROb+Rxr/BpJMIAXhcCHvdQANq3UyqNU1izFC4ejiwSycWtXdrc9I?=
 =?us-ascii?Q?HIwY67+1jjAhHWl0wBqijTa0rgG4BKJlX/S9391YM4ILJRMKgEfG6YD42xb9?=
 =?us-ascii?Q?r+HZmsGEMVUBUqhXi0P6gJ7fdxHSqhBppoLQUJj0adSHpPz/H+FiWyEOjd9I?=
 =?us-ascii?Q?Q/bEpsSOaZR+ZuG7a8zEdkGkEXP9mv1RqLim239L2jR2ijntzz2ITh+p49Iq?=
 =?us-ascii?Q?c2BV9rc2CpfGUUzADpAafcJfvQkgbbi/mFK1BPUnbM8XOUPRO8/UDyqIwgBG?=
 =?us-ascii?Q?GOBVQcia46EKXCgnidvef8rC4zULiGOH11IF/bwEuoBDqaRiVB/aRyz3BMyQ?=
 =?us-ascii?Q?YrK51EIByaHIkHSF8YIA8gv1Jrbv/2878hKnupAmJ1zSEDK3LA0IevZRHocK?=
 =?us-ascii?Q?pX+Z/B9bzBZ8Qhbd/oLeptlM2+cPmkBwcdEEGWqqCg6EuLBXdXeKQ/xB3u+7?=
 =?us-ascii?Q?TsWnh04s+7Ls+Muc8igdAtXMZYG+KJPFKApeQv1SgJZibM2+7315nSIgi6oN?=
 =?us-ascii?Q?uY9BBSbH3/rWdZSwzilBsA+eb0MNiZu5slK+GdFDTcGKL4OKmtf/KwUiFrdz?=
 =?us-ascii?Q?ghHds2Hnn8Es2OXOONbTtrY771pk3J068j4fAX0Ej38z3UX7+1vsZxVdEBNn?=
 =?us-ascii?Q?+iOVrcXnkg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c095caa7-0e99-4bfd-2ab7-08ded34940e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:07:50.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcPCJGAbH81dw2LdS6j9CPLqdl+xdf83gwi2JY7lGyq7tKUcjgS5/M0NiQuzq78nkRBC2q3f4M+cnzHEYoKRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761



> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Friday, June 26, 2026 12:40 AM
> To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: fix suspend/resume erro=
r
> handling
>=20
> On Thu, Jun 25, 2026 at 06:59:34PM +0800, ziniu.wang_1@oss.nxp.com
> wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Fix several error handling issues in sdhci_esdhc_suspend/resume:
> >
> > 1. Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
> >    to simplify error handling. If it fails, the device is unclocked
> >    and accessing hardware registers would cause a kernel panic.
> >
> > 2. Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake()
> >    failures non-fatal in suspend path. These failures only mean
> >    slightly higher power consumption or missing CD wakeup, but should
> >    not block system suspend.
> >
> > 3. Check pm_runtime_force_resume() return value in resume. If it
> >    fails (clock enable failure), return immediately since accessing
> >    hardware registers on an unclocked device would cause a panic.
> >
> > 4. Make mmc_gpio_set_cd_wake(false) call in resume not check return
> >    value since it always returns 0.
> >
> > 5. Always return 0 on success path instead of propagating non-fatal
> >    warning return values.
>=20
> each patch fix one problem.

I will split this patch in v3

Thanks,
Luke

>=20
> Frank
>=20
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index c4a22e42628e..4d6818c95809 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -2060,7 +2060,9 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  	 * 2, make sure the pm_runtime_force_resume() in
> sdhci_esdhc_resume() really
> >  	 *    invoke its ->runtime_resume callback (needs_force_resume =3D 1)=
.
> >  	 */
> > -	pm_runtime_get_sync(dev);
> > +	ret =3D pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		return ret;
> >
> >  	if ((imx_data->socdata->flags &
> ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
> >  		(host->tuning_mode !=3D SDHCI_TUNING_MODE_1)) {
> > @@ -2094,10 +2096,12 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  		 */
> >  		ret =3D pinctrl_pm_select_sleep_state(dev);
> >  		if (ret)
> > -			return ret;
> > +			dev_warn(dev, "Failed to select sleep pinctrl
> state\n");
> >  	}
> >
> >  	ret =3D mmc_gpio_set_cd_wake(host->mmc, true);
> > +	if (ret)
> > +		dev_warn(dev, "Failed to enable cd wake\n");
> >
> >  	/*
> >  	 * Make sure invoke runtime_suspend to gate off clock.
> > @@ -2105,7 +2109,7 @@ static int sdhci_esdhc_suspend(struct device
> *dev)
> >  	 */
> >  	pm_runtime_force_suspend(dev);
> >
> > -	return ret;
> > +	return 0;
> >  }
> >
> >  static int sdhci_esdhc_resume(struct device *dev)
> > @@ -2121,12 +2125,12 @@ static int sdhci_esdhc_resume(struct device
> *dev)
> >  			dev_warn(dev, "Failed to restore pinctrl state\n");
> >  	}
> >
> > -	pm_runtime_force_resume(dev);
> > -
> > -	ret =3D mmc_gpio_set_cd_wake(host->mmc, false);
> > +	ret =3D pm_runtime_force_resume(dev);
> >  	if (ret)
> >  		return ret;
> >
> > +	mmc_gpio_set_cd_wake(host->mmc, false);
> > +
> >  	/* re-initialize hw state in case it's lost in low power mode */
> >  	sdhci_esdhc_imx_hwinit(host);
> >
> > @@ -2153,7 +2157,7 @@ static int sdhci_esdhc_resume(struct device
> *dev)
> >
> >  	pm_runtime_put_autosuspend(dev);
> >
> > -	return ret;
> > +	return 0;
> >  }
> >
> >  static int sdhci_esdhc_runtime_suspend(struct device *dev)
> > --
> > 2.34.1
> >
> >
