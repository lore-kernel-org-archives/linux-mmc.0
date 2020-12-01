Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C3C63777
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456D520857
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 02:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rCURioND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgLACjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:39:23 -0500
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:48352
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgLACjX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 21:39:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWsqWYeGX++fVTFmFZHZdexvT915ZdjatLdet9pY+rVLNEoD8S3Ffp2RhzfQ1dJb6JD/G1taaqkZO6UOXP9hKC2Q0Mot/ahccb3Yuc4iYzCxq1R1dZcXcuzSzPwddD5Qhkh8WVHnIckMlr5dbV+evVJIgwYdTXppcvtd6rtDyi7yhAVf5OCC/I0M++avm+1ZNH0KJeDh0JkFYvptWrjjOdwWie2AmZyxiHKfpoHuZLUIZtoo4QwAWmoEFc0vc6ahwFSCH/RJk+I9gZ+S4S4z7bLdNO9p0RB4iyxkIqEaRQ03EUCKBzPG1fS6JVvzCWpXbi4Pjej/HvwPJfBGT5Nhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeRRzp15yMvGiKAdFjtG47jY5vEO2tfpbszZMVTsrxA=;
 b=aGwkk3X1DvnHF1QU4qhXJounnBNTs60kJabKqWzjw8yM1Fg2n+LRoae7kXokAnk7HDGiB5UxU6tABU9/N7ieViVQvlGw0dpRnlQFjzkovsejI8/uqt99Z4Cl7es8gZpkAZLcW12hUCB921MZljt0XcElDy/cgYSw8x/936WcWiGKZrI3/T98DVbtkqWX42twTs7QziMSbTMYnEI6AaiybLm4bfnIscMInfZknZzqhk0Jb6OE47+yERvljB0Xc+RHHTxPnRgvZuZX//VlWmnViVTsI+NBp457PokT4/foccdJIw8weVJkR+a2iD+VTi818u2Ah6zDi638RCiX+OYx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeRRzp15yMvGiKAdFjtG47jY5vEO2tfpbszZMVTsrxA=;
 b=rCURioND7RIlLiHa/L6Rd8lSQa3wgibXnchQrAbQK5GCUg7FkVKOyUfB0O3hFJu5lLx2jQLJUuJXoGDQJk8rT+lnLHXFtINcI2FKqafaMWNByNyA/KN5zSpeGObSZ7PjMmNg0Rs9pgU75l9HQYouHaPeG0vgf5bcaoqGAujrrlM=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6903.eurprd04.prod.outlook.com (2603:10a6:20b:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 02:38:33 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 02:38:33 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Topic: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOCAAAokAIAAAQaQgAAZ0oCAAARV8IAAC5AAgAD/ncCAAF+YgIAIQVaAgADLcWA=
Date:   Tue, 1 Dec 2020 02:38:33 +0000
Message-ID: <AM7PR04MB68854DC5F2C391130581FD8DF8F40@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124103128.zucizod344dgme4o@skbuf>
 <AM7PR04MB688567CA698191E2DB73DEF5F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124112822.2ui57jmoc73top35@skbuf>
 <AM7PR04MB688524B26F99EB2C5B86ED48F8FA0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <31db48954bdf02fc0af73871043fc76b@walle.cc> <20201130142918.GJ4072@dragon>
In-Reply-To: <20201130142918.GJ4072@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f2dfef9-3c0d-4546-d3b5-08d895a2322b
x-ms-traffictypediagnostic: AM7PR04MB6903:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB69030ADD36FB47DAED2AB355F8F40@AM7PR04MB6903.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVW0So0TFqnpEzYFGpAs1CVhgt1k8HFgHOswkbCUgW6UulpK77wmrOrLY/cWE1dqMqTsZ6Cc1424c7OEbvYKs1cTe1YrHj/UrVgEIM+pFhX3Jl/DEJRh+HqYKv44MPMPl/JnpuFQfKwNffgFfL28HSlx/SBTAHeDxIBAXGCsxpa94JEpmrKUp+PwCIIzyEIZOKF6EORmjy1CjJ7B1QRbhuqQ/E94/YzO0ddW+mwHvuhBsZlLaUCYbGWv8yKNA9Z+cpqxeFmdHuOg9aew5+B6pcimcsfTrDX1geYZ9QOues69VJPVDjpl9TB54q4IQmteHdYIxxhdnAuXorGoy5Vp0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(52536014)(4326008)(5660300002)(71200400001)(86362001)(2906002)(66946007)(66556008)(66446008)(64756008)(76116006)(9686003)(478600001)(110136005)(7696005)(316002)(54906003)(8676002)(55016002)(66476007)(8936002)(186003)(6506007)(26005)(33656002)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qih9OAtCpwYixQkLrDOg/tLZKsrzFJVF+6Asl1WoocoURjrhBqb5LE41V/h4?=
 =?us-ascii?Q?M+rZSuoppeitmo7Zu8chAXT+tIu0ULE8fXR76G2XMAPOasTEXsRbtd05nawY?=
 =?us-ascii?Q?KodGnF+KtvN1xUgpzwVXEwmKDuDV0H4NGKA8pp3TtbsdeNxMLjisN5u0HT/O?=
 =?us-ascii?Q?mchD+U85rAefYXwcch4oh91RXeK38t5FR8GhElaiIJSCYc6QiAUcv/U0vVWQ?=
 =?us-ascii?Q?wGW6UqsWTupa9wtzfGaG/X+CnzwmyFPMZ2+LnhnJwIo8AIfymH1Dg0f3BVJj?=
 =?us-ascii?Q?OnXnmaYRgich5abywF7SIozhsYAmjGIcMf7SC1APOF8L8JLu23wxtYwQOTjG?=
 =?us-ascii?Q?vv8Iw/EYzeRnH+XpQJxQG5efptNuEQ3fHklwSifIWrF9o5LuinK25FygYwOG?=
 =?us-ascii?Q?Rhm8MPnw6btEI9Rncj4W/hcj/oDyBEoVjMLP3HqhzvTxyIhQhBOv2m/dyoJS?=
 =?us-ascii?Q?pTcwT5I4Pkrdv31eIhqVEb5UWd0bGA5/euCNE69NQPhF7+656FdDseEZBITl?=
 =?us-ascii?Q?6kat5IYxrmVWW6e4O82RcoE8mFV4OE1Bs0+ouyrrhK3bDMBqds1IEdu4Jtdv?=
 =?us-ascii?Q?crfhInbEPBliC4woPZhpgZSVE7I+AIwwxJz4Mau83aeo2gjSVpUkhn1D2uqF?=
 =?us-ascii?Q?+gWc11Ef9W8xG5J1V5d+LURP287N1yAfNc5bZ8eCmToR5XcRKhMVH8qfUhJk?=
 =?us-ascii?Q?gLeDVRsgOdD62VkEGi/FWRqATtXuufWUmPfVGEmGCLdaN8Rc9Xs44RavUaqM?=
 =?us-ascii?Q?uR6miSpQBiiXFryw7G5vemh6KYx5AkCv3pblb+sVfus3BZB8vLtqMoMUQkYK?=
 =?us-ascii?Q?tjIKILeqAgXCoBwCDgEaioaymhMCflWYPf375ymSp9u+GAn/rg4zASII0ZaX?=
 =?us-ascii?Q?UzlvQmNfy4wTRbakLtR6az9229lj1icPrslfJJY7cBlkLFimYsl6+tUuYL1r?=
 =?us-ascii?Q?IPlz/tdo13N/xeC0L8MUrdzhaUi7F8y1N3WvdPu7qmE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2dfef9-3c0d-4546-d3b5-08d895a2322b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 02:38:33.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIae2l1rQgW1xjZomShIsq96pgBdrUWGaLyE3jOunVk8jZDenT9Sb+m0BCY9HavCAiiRvpDSGkZo2e4uDl6IQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6903
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, November 30, 2020 10:29 PM
> To: Michael Walle <michael@walle.cc>
> Cc: Y.b. Lu <yangbo.lu@nxp.com>; Vladimir Oltean
> <vladimir.oltean@nxp.com>; Leo Li <leoyang.li@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>; Ulf
> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> controllers use fixed indices
>=20
> On Wed, Nov 25, 2020 at 09:25:23AM +0100, Michael Walle wrote:
> > We are going cirlces here. I guess Shawn (as the soc maintainer) has to
> > step in and decide if a common soc include should contain aliases for
> > nodes which are disabled. That is what it boils down to.
> >
> > All other arguments against having aliases in the common include can be
> > found in this thread.
> >
> > > Distros, bootloaders, and users' cases using fixed index before could
> > > avoid issues, and been used as they were.
> >
> > Nobody argue against having these alias. We are arguing against having
> > them in the common soc include.
>=20
> 342ab37ecaf8 ("arm64: dts: freescale: use fixed index mmcN for
> layerscape") is dropped from my tree.

Ok, fine. Let me send board dts patches for NXP development boards instead.
Thanks.

>=20
> Shawn
