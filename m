Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9B3FA5EB;
	Mon,  7 Sep 2026 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763027; cv=fail; b=fIeG4EO09mZQviIMWMqHP9dPWzd1KdCrm+ey/7QLl9snaRGgwEhYO8mBWAlqz2shVCIBvJYHn+JNL/vmBCExcv+YBtqgdiACeBwNC5TuvUkogzkgDEdHKXOO1bY+1qtyFz/Y9RMNq8unDslZoZkH4FDFsgtjp93hbco+yH5THfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763027; c=relaxed/simple;
	bh=g8waLZ/r5wIB/AA+ZiezOt4woVzlDSpb6QquGg/C3hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVZDsxqPRvN+YYhUuRzIGJtCNbqkTXp27pqxvZgIKeF4PhC8DWM4yyecpb27rVmOIg4c1xZL4e3PgrFv/wFPsDTRg9gS0jtujJAPQS904Jpz4izhdyOQCkORafUYKNlXhihga4MGpNMP1nMFo8PAU9Iw8BSpXUXk+9gOtM9bCds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=t0TAiFi5; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="t0TAiFi5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvKi8JUL8YlWaNWNa3t27kX3EHhK4Zz93YQVn1b1PjLluZPlXFVlIXeWNxxJjQuDeAhDFdeJoDKXxN+WaheZ8I9Gecy6Bp4fJF0r6unXiua1WXxFRNW1W9PqXL80Tc/fqf1qHfaVVjUh1vWUFpWbQtJex/CaqdfiR2V07737S1jhZh1u5gn1lqpp5fFsqlGekG30oZ5W8NF0+60i56ImdCYf+mu2qE6CIO6ZJdmnyVH7lpkkzFevA/u1KdCnljwFlxlgL1RTwXAAjASpKNsAXFwdrorzTc8srMVDO/J4evwj9ZxNwfuZtLPu8EtgivTr3QK85LdXmW4GaQg3mpJnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIrRfxYza4E6TI7IXUlWHmOQ+y5PeqqDGKgMT8N4s+A=;
 b=wD+Tn82Fqk/kqkT/MbcRrYodAeDOFW5h1IOn9e9mmhK70ydoPA/iIQ+D/IDNc/sHq0g8+ZenoO5lugNaJ63WQCp0bzadlJPzjhzPGORjok6MHcrTNPDPGhnWZzmx7Fh3ke/9KyQPPidQzBFYDRSkAiqCOP1nZ8uxSuRPgpF/EdIPNoCPFx5wav6wxtnDO8ue0dKZG52mqcbetMnwm6vEwQQC+bON/c+f4hhY1wBCi+iPqpNViL5igsehRDT9IoQe4ZmNViP35Q7Gs8cCfXCMHtw7HBYClWhGc3nCqy94EmyNrwBVii9FHML/h0A3C4aidO200NhlEmwfX+KbBNUHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIrRfxYza4E6TI7IXUlWHmOQ+y5PeqqDGKgMT8N4s+A=;
 b=t0TAiFi5gqBWX8Xzo325j6Iqt8wpU1w21mvzGTIF0nNXCqlHvFEu+Py293udeMMcWwbkOB7lg1SwCYYj28W24EAz9Qe57EkUazxZG7WSn1zfl6CsL0PYgfnWGAQ2ImJHortwkGlpzoJtDSSYoQH6CVSG1mL0UfO1AqdylIxc8Z4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10353.jpnprd01.prod.outlook.com (2603:1096:400:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:37:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:37:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Ulf Hansson <ulfh@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Topic: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Thread-Index: AQHdMMe+SeXRDHnYx0S0S9Te31Iesba8rjuAgAYGtQA=
Date: Mon, 7 Sep 2026 06:37:02 +0000
Message-ID:
 <TY3PR01MB11346EC6636C810EEBA215F4E86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <apk_81IYqxrWZyJK@shikoro>
In-Reply-To: <apk_81IYqxrWZyJK@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10353:EE_
x-ms-office365-filtering-correlation-id: 5329292a-8fa2-4604-83af-08df0caa6cf6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 3mvk6WVpMEt+YVoG9fG+iA5kbR5Iw26OMIzYoZeS8iDKVt1gr3NQ9vHTYiX4Um16UNo50e1aJHTuLftWfCdiq0I0nC0MSjNpNl3rA4aC1xVWwRwanFEZdgZeKAg83l3Y/ImcKB2gkZG8C69WvdfJDOG8BndLwjhjc3J+rfNNxkYQWeTFeTe+WzhZR3riLS+WqbalmEV9lRwoNYo4obDgwz2XrHYtM7bJTZLtVOOnsf0kIhVNn93hlK5vVv63Zw2TJW2nhIi7nnd997IRMfNz+V8Gyk0TryvQrOO9PHv/ondPMmM/Hcdz5vBVRZgcQO3Pgbjqv8tuSl03l3CpaXC7WXtW7ys6Sk+2E2cXnfKg/9AtHWriHyCmdYlveGGpIl3FCVrAqUDdXdj1knq0SM2/fmNcDnDb/+a8hMg7j+pWyetWqGt92tL3zTWh2e6+4it+Ssf6bjUGF+6lG/3KyaSaZcaBGOGiYRqcptpfOEvNBryVCsLJ4+AqVt2hGV/WTY178MZh4HoVGWNncmf3+AZ2pId1BgI40EtClvDPN5gyMnlffLWD5G/tEdSQF9Z1i5N7XedJwMy4NU4AuNVpuEbLufCmJlwCCyZvVOyWWO/88K0T91OsAThVkGipr1/sKFXpxfpftFslemDWr9KtlJHjpJS5hyUt7CoHaydtc+8UbI9xoh3AOjzUQNiXSgjmQjD18ARC2rXK7leh+l+jis+ItqOs4PtDXvsaqf+S2LCfYFw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7bEGpqaLBhDQMoqxh6SRrPgc4jbYr9DZacH12nQzeEX3vEKWYTMX69d3N5bu?=
 =?us-ascii?Q?IX9axHf5xHIy8En2HBHhKqcLaX9PwV0AY5nvdhVv9i2JmlHHKrt1ovjcLwD5?=
 =?us-ascii?Q?/I1WPJ17AVgf5YF/5SZXlSUIgg2AZQ0kSR3KJrD8Qvkq9vN8FX6Qroyfr+1m?=
 =?us-ascii?Q?FadoYsi8EX4jBmr9f8Fh+RPbzbmesVYLm+Z468jOs01ds3JdpfPBRtguE1kM?=
 =?us-ascii?Q?lqtKvELiNzAKJFQ/CKCeo7TjoAriwS6alaLE2KmSYa4JeaeHbD1kjSp5Jp/M?=
 =?us-ascii?Q?j71smS29zpPW8L2IPKg5Ht1xDdJ4WcpXFxZY3hKfEhN2bF8OaNzioNucDn+x?=
 =?us-ascii?Q?W+Be3/7td7z7yHYFrZ1iPETxN2TMI/dJ6JYXXS6wJ+aA5YdIWlKHrCwog8Cs?=
 =?us-ascii?Q?JOMYarS417EMZqo9z/Cf2WhbeQPXRMHcS3Pvc2XDFhiCWoECsSAo7d0yoemF?=
 =?us-ascii?Q?KXCU3Er0G6R+10KPCE0G1+b14HbfS24/gNKdo1KZeSCukBrw3RjWNk//UGh+?=
 =?us-ascii?Q?nJCO3jOFAJr0Fs0vSNPjbRKF+/nyJPAHUuuj8Fd35+LBpiIC52P5G9cErtxn?=
 =?us-ascii?Q?Gbd51hz9+mbwe3IamFHYZnvUBSfWoH1jHY2nGI9tZ3L41l/2LHw/VssUzpAX?=
 =?us-ascii?Q?Cz98Z/2iadkSNsoKufU9l/Tz4jGSTmrX1uR1jda8qnSJ/5rfAixusOY52OKP?=
 =?us-ascii?Q?TOn7Tq8uZL4vhlTTHJpTj9SZ7kd4H9cc+9FfgUZOVXn1vU/fleZJ/DTwWeN1?=
 =?us-ascii?Q?zO4OYgLoX67HL6EcOzLc382gp2TRMoGTbyJ70lXxLAmLtcc5UajpD9/9ipDa?=
 =?us-ascii?Q?gJ/DGQY5neVwj90HKAqaglf5ejApAC3y2163N8c+oeNl8hqBUrXY8s1Biemk?=
 =?us-ascii?Q?z6G8Bbx2VBEaRXM6+ghUHrk20pQmGRMmepToW1mFBgJDjUWQYw9ez7aVs13L?=
 =?us-ascii?Q?aGFXB8oOenNx5o9g4LLqo0WAcdj0UBbulSh9ZRFyNCYIttOAoCIxk/GzK+Ce?=
 =?us-ascii?Q?30nH9O+z15YRKVFW8e7CfbVzqLhuwb1teMCiArRAKZ8pDDPm0n04jC3n9rXe?=
 =?us-ascii?Q?Gvnr93+dHzMFQE+Jhr0JFzw0pwJXBp+f2p2kYA5KEhJWfVs+ZWj92a7Rb7ou?=
 =?us-ascii?Q?u7i8RQErxjBg4dxsnIQBu3usV3bN2nG1xxoniXB7P4Xvz/P8F3vEu5ps4jyu?=
 =?us-ascii?Q?2yYLph2m8g2suuB5o6kDprVHZ+2E+NdtzaG/YOB3XzYnaJYyoVyfTaZNzK21?=
 =?us-ascii?Q?8adL3h4gY8TM8QTE6iaQgZ9l0mhcgaAKm85GeiR3ON6rJ3U8bS5c1JHbYgCX?=
 =?us-ascii?Q?6UFzuBHnJNxt6PKmtlG1gNZQLiHqZTBLcUPso3U/3pMxfXVD7GDRRLp7d5iB?=
 =?us-ascii?Q?5S1132oAEz1zz5OLJTALIfJ5IAGBGK9B7JvFEWkB0pdhHwCqhwTOon3y6A6W?=
 =?us-ascii?Q?VP54F5jEScjzbPyYmZfkKno558gKBi20rBIBfVURZ6z/Lqd9FogBBkQ9/lvU?=
 =?us-ascii?Q?BGSau+mxh7Ovc+WXbQlU//gPKzvHnfTXlroycaoRBPhx1uoGuR9qYLYmx93Q?=
 =?us-ascii?Q?dXWyUQ95ctJetfvbNuIpYTKUTEoduRVax6bebjjbf06p7pn4ODOSjK5g+PnT?=
 =?us-ascii?Q?KWZCo1i/desGfUvGpXGENyqZrTy3mM5Wubo//ksYVoGFM0cD3fAvcclwEbfM?=
 =?us-ascii?Q?A7W1fEpc64plWFw6EijAsj+lqkOjZ6dUl8vlAxQWJFf7o8zOndYCISH4KlCW?=
 =?us-ascii?Q?Gn63A3Y7IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5329292a-8fa2-4604-83af-08df0caa6cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 06:37:02.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/CQwz67JhMJMUWMPGJyrbsm4G5MAwOk3YBL+T9QY5xFYymc4Itc38WGqWqojKNbd+tnpLPfbO/K9R21WoTNrO0EJZpczyoPGGbmuHGJ0pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10353

Hi Wolfram,

Thanks for the feedback.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 03 September 2026 10:38
> Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_D=
IVIDER flag
>=20
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Fallback `f_max` and `f_min` initialization fails to account=
 for the internal clock divider.
> > --
> >
> > --- Patch [8]: [PATCH v24 08/15] mmc: renesas_sdhi: Add
> > TMIO_MMC_INTERNAL_DIVIDER flag --- commit
> > c4a63c19303286f5b383bdabaa2a3f3827a8c5c5
> > Author: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
> >
> > This commit introduces the TMIO_MMC_INTERNAL_DIVIDER flag to support
> > SoCs like RZ/G3L that have a fixed internal /2 clock divider. It adds
> > a helper function to fold this division into the reported clock rate
> > and uses it in the clock update path.
> >
> > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> > > b/drivers/mmc/host/renesas_sdhi_core.c
> > > index ff428b6187bbd..b5f2ff68db758 100644
> > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > > @@ -125,6 +125,27 @@ static int renesas_sdhi_clk_enable(struct tmio_m=
mc_host *host)
> > >  	return 0;
> > >  }
> > >
> >
> > [Severity: Medium]
> > Since this patch introduces an internal /2 clock divider, should
> > renesas_sdhi_clk_enable() (which is just above this hunk) also be
> > updated to account for it?

For this patch, we don't have a SoC with TMIO_MMC_INTERNAL_DIVIDER flag set=
.
So, it retains previous functionality. Please comment if you think otherwis=
e.

> >
> > If the device tree omits the max-frequency property, f_max defaults to
> > the raw parent clock rate:
> >

This behaviour is same as there is no SoC has set with TMIO_MMC_INTERNAL_DI=
VIDER flag.

> > drivers/mmc/host/renesas_sdhi_core.c:renesas_sdhi_clk_enable() {
> >     ...
> > 	if (!mmc->f_max)
> > 		mmc->f_max =3D clk_get_rate(priv->clk);

The SoC with TMIO_MMC_INTERNAL_DIVIDER has always frequency defined in SoC =
dtsi
and this condition is skipped. Please let me know should I add a comment he=
re??

> >
> > 	/*
> > 	 * Minimum frequency is the minimum input clock frequency
> > 	 * divided by our maximum divider.
> > 	 */
> > 	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) / host->pdata->max_div=
ider, 1L);
> >     ...
> > }
> >
> > For hardware with the internal divider, this advertises double the
> > actual achievable bus frequency. If the clock provider cannot scale up
> > to 4x the requested frequency, the MMC core might negotiate a
> > high-speed mode that the hardware cannot satisfy, resulting in a mode
> > mismatch where the bus silently runs at half the expected speed.

SDx_Clock (HS clk) Figure 4.4-8 Block Diagram of the Deformed Clock System =
(7)
IMCLK =3D SDx_Clock/2

SD_Clock  Figure 6.2-2 Functional Diagram of Clock Divider for SD_CLK

SD_Clock is dynamic setting based on the speed mode.

For HS400 mode, SD_CLK =3D IMCLK =3D SDx_Clock/2 and SD_CLK_CTRL =3D 0

For Non-HS400 mode, SD_CLK =3D IMCLK /2 =3D SDx_Clock/4 and SD_CLK_CTRL =3D=
 0xff for 1/1 option and
other values for non 1/1 option.

We know the maximum frequency supported by the SoC and we must define this =
in SoC dtsi.

I believe we should support the below check only for non-DT platforms as we=
 don't know
the SoC max sd clock capability.

	if (!mmc->f_max)
		mmc->f_max =3D clk_get_rate(priv->clk);


> >
> > Could mmc->f_max and mmc->f_min calculation be adjusted when the
> > TMIO_MMC_INTERNAL_DIVIDER flag is set?
>=20
> Looks valid from a glimpse. Please comment if you think this report makes=
 sense or not.

Please comment on my response.

Cheers,
Biju

