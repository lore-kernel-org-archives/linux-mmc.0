Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A08C56202
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AF720644
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 10:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hr1xm3Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgKXKWe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:22:34 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:35909
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728340AbgKXKWd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 05:22:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+PTUwxpowCuEVK4xbTQmFpBrUbeepG/vUTw4ewx1gDaYrIfqkSPnNTSHZnjuzpnVr/v7syOBfJaSbjYE+qvDQnvtn10Q/eaU84TRnYDYetuYuNFBmuxnve6vDkyxTtioFolJ7gZSrTfQbkTl2wkAjYzJJGHgVEKuLC8kFsm80kpuEs0A52iUVTMNsOZiRnvDbQUqC9sypD0DCfCfrg5hOy74wvItW/HIfXSv/FOuVrszjX2J6XgKRG2DZJGpG4Wadg0jIiRWfen8c3pqdjLN4AVELCoZ+0HehqB+mxvw3G6bRKv87U2rBxtPSLqRgXCldOi7J7ieLQo24ALUS0MHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61Jp3a6YGKmt3bEpnxmYuiLynjRCg6ioj5PWQgH9AFM=;
 b=LY6GdOOIP1/8JW2Rho39fjbmUSuG3wI0yfYu+00CnU6n98iutMK1gK2nE9PARUYkY+zMtLdtYBZd32R+2clYCHa/5xeOvWU1/I3WFuYaBU71ojyCCUp7hnmyDJwVcPHAaIoAVO2Q3+my+N6LP389cGBkU+e7Ry1fYEk+SPb6z+H4OSqfeCXscki1i2EB6cHpKxLbAZLZCTu+tvwT96B7wuPAuLAjuKXqysEBsx6+yerg4txsRlmMLBj/Vvzn2l6yBFbUJ5vlYid0ARr6pWDGp9sMk0rzxYumo7PVuXDBM7abn4Zb9Fm/UiHep1NBQiLx5dGonGbBg4mITW/s6DxwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61Jp3a6YGKmt3bEpnxmYuiLynjRCg6ioj5PWQgH9AFM=;
 b=hr1xm3NkhOC/DQS7Zs2BdlGKtmzm9G/HmX/H0kkpFYSvxSvYJOuPit3afW+lD5l/kILkXJCC9YNsVEYPflib/gLIhhgDwcNC4m8IaXP790oScOiJ0t+GYbfgpskg1AoM9jksWYIgaiH8mwBJooYbP4VhQG5Iuwm5bUTaxS7MDhA=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB5896.eurprd04.prod.outlook.com (2603:10a6:20b:a8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 10:22:29 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 10:22:29 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOCAAAokAIAAAQaQgAACmQCAAACNYIAACTKAgAAH/OA=
Date:   Tue, 24 Nov 2020 10:22:29 +0000
Message-ID: <AM7PR04MB68852A82CBCEC333A6343E25F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <de68e6861f0ab947642c847b3b645503@walle.cc>
 <AM7PR04MB6885044C8AE85FE369285186F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <d6ecf5fea0d8bde80f7563b4cb586b59@walle.cc>
In-Reply-To: <d6ecf5fea0d8bde80f7563b4cb586b59@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61eb5db9-f125-4754-fd26-08d89062d8e1
x-ms-traffictypediagnostic: AM6PR04MB5896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5896A0574A9885B5F6253FC1F8FB0@AM6PR04MB5896.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIZOKijT+O8vm2LT/XyAes0EK//HiH29SGWAYTMxcgySHhw9CQVnFS2DAzBlIydAf9/pRzUgQdgBGNk4f7RcGxavj8jBpppIYG7jBjVX6eE7q8+/2wtvpKDECDNClVtxnvDiOV7ryLdfaCH+S4JcqfBNVDRWnXamI+hj8DVy5CO9F9oZUEnGzX3XaETsPz/SwPGl6bKNoVTjdYlcT0QvjFwstLl8/8Hp9rifEEcJYWDehHZC6eOL95Mo0xrne6E12QydU8UC/jOw2fMTTe33IwmDlqIygqpjz70LhwP7U5k3hrlKAWrU0ky6YaIkvVIXgVSRhRk1nQh2pvHxToCJ7q+BY/B8ohm6oF3CHr7/XTGPlv3YMNDF3uVu76Qi2pf8uDyUQgODSPSx5jarqdZdFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(966005)(478600001)(6506007)(8676002)(53546011)(7696005)(6916009)(86362001)(5660300002)(83380400001)(52536014)(4326008)(33656002)(45080400002)(8936002)(9686003)(4001150100001)(2906002)(26005)(54906003)(55016002)(66946007)(186003)(316002)(66446008)(64756008)(76116006)(71200400001)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: N9GyHHV5NyoObvwyVbdDJtqhFAapPYSMozLqjTFQo7ubJ2q+TdEbv8aUATalN3/YFD2ZbkLtRWUfqTlobvAib60rEadhwXGi3TUczaHs2euBdcUk7a3ZVL4MSqFzmOO10/XDRAKfB80VEIOrUV9n0giOAMV/Hs6jFQ2i/k2cUkGGmU93YDx45Wh8QYvnkOd4M/Bx5zefaFR/ansV7X49Glp9ZoMgun5bQgYm8vSKNj9L3MHOun4FuXuAcuJ1+rU47p6f9b3PJPPE8i9cSNiRmdupFZA863wuy8qYFHmdlKcqlJ3O43XEzqSt2VnD2hKIRzTMjbGlU+S8PXiQiSnM2Vmj3825EfupPUFLKsuKdEPTrDAR2ps2iGdo6whdWIMhYFAskcEAqqprZy8Pz0nEYiJlguIcirJcbfv671hpM+dSqO1s2c4pgkR7GlkxUwRJyPPGHQysJHgWfRIqjeSxTXkGp6FuIK+6ZtnzFEoHMgb3Yfn0zXWVCA0vfBXKf7O2DSTIkUwrjMU2K5tfAs40xdzwkhONPPaKzqE2xZT2+UKLaAi8782XsPrw67+Ag/XlC0BZF7z7EGfS7dY9mm8IyTJogi6yNeC4jY+tjTxCn79U4HYBDjqBtLJ7kpU7oh2F8PVzd2Sakaqd+7+rIlNiUWOvJQTs8jce6lDfvWYNV40zVmNzgTHi6fPt9XCIu5HlXaOs0lm1LkUdoW6X3vAnrVuMijm/MKM/EAuEpalBacAjRT3sUIT9HBg7UlMQLvTUITQ37z1WoECD1fekQOMhIN1sSc/tuUoHRXIPYrBZZQzU13VEJDHC5n7iZTb3cCPqaVsyi/EToQUnjYXjNDpw37la+SS0VRay4SEEEX+qt0/17dkWWUlO0RgDwTxXaI/gJC19bxXGY+rlBNi+ip8clQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61eb5db9-f125-4754-fd26-08d89062d8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 10:22:29.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FronNYWEHLnyLItRrS/agPm2VmkX7X1SxgYcb/cFv2PzhUTlqnaFfuGbzpPGCqJ3KCRraDrjpnQrxBbwDcdhgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5896
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, November 24, 2020 5:43 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>; Ulf
> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> controllers use fixed indices
>=20
> Am 2020-11-24 10:22, schrieb Y.b. Lu:
> > Hi Michael,
> >
> >> -----Original Message-----
> >> From: Michael Walle <michael@walle.cc>
> >> Sent: Tuesday, November 24, 2020 5:08 PM
> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
> >> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
> >> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> >> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> >> Ulf
> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> >> controllers use fixed indices
> >>
> >> Am 2020-11-24 10:02, schrieb Y.b. Lu:
> >> > Hi Michael,
> >> >
> >> >> -----Original Message-----
> >> >> From: Michael Walle <michael@walle.cc>
> >> >> Sent: Tuesday, November 24, 2020 4:55 PM
> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> >> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
> >> >> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
> >> >> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> >> >> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>=
;
> >> >> Ulf
> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> >> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>
> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> >> >> controllers use fixed indices
> >> >>
> >> >> Am 2020-11-24 09:47, schrieb Y.b. Lu:
> >> >> > Hi Michael,
> >> >> >
> >> >> >> -----Original Message-----
> >> >> >> From: Michael Walle <michael@walle.cc>
> >> >> >> Sent: Tuesday, November 24, 2020 4:03 PM
> >> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> >> >> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>; Shawn Guo
> >> >> >> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob Herring
> >> >> >> <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> >> >> >> devicetree@vger.kernel.org; Adrian Hunter
> <adrian.hunter@intel.com>;
> >> >> >> Ulf
> >> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> >> >> linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>
> >> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD
> card
> >> >> >> controllers use fixed indices
> >> >> >>
> >> >> >> Am 2020-11-24 08:41, schrieb Y.b. Lu:
> >> >> >> > Hi Vladimir,
> >> >> >> >
> >> >> >> >> -----Original Message-----
> >> >> >> >> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> >> >> >> Sent: Friday, November 20, 2020 5:30 PM
> >> >> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> >> >> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li
> >> <leoyang.li@nxp.com>;
> >> >> Rob
> >> >> >> >> Herring <robh+dt@kernel.org>;
> linux-arm-kernel@lists.infradead.org;
> >> >> >> >> devicetree@vger.kernel.org; Adrian Hunter
> >> <adrian.hunter@intel.com>;
> >> >> >> >> Ulf
> >> >> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> >> >> >> linux-kernel@vger.kernel.org; Ashish Kumar
> >> <ashish.kumar@nxp.com>;
> >> >> >> >> Michael Walle <michael@walle.cc>
> >> >> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and S=
D
> >> card
> >> >> >> >> controllers use fixed indices
> >> >> >> >>
> >> >> >> >> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
> >> >> >> >> > Hi Vladimir,
> >> >> >> >> >
> >> >> >> >> > I have already upstreamed a patch for all affected layersca=
pe
> >> boards.
> >> >> >> >> >
> >> >> >> >>
> >> >> >>
> >> >>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> >> >> >>
> >> >>
> >>
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%2
> >> >> >>
> >> >>
> >>
> Fcommit%2F&amp;data=3D04%7C01%7Cyangbo.lu%40nxp.com%7C498622ade
> >> >> >>
> >> >>
> >>
> e704fc0042008d8904f6184%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> >> >> >> %7C0%7C637418017917635725%7CUnknown%7CTWFpbGZsb3d8ey
> JW
> >> Ijoi
> >> >> M
> >> >> >>
> >> >>
> >>
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
> >> >> >>
> >> >>
> >>
> &amp;sdata=3DOciS3q%2BmP%2Bz4x1ewPHDigmUkgIZmBgUlRRTm4yaxB7s%3D
> >> >> >> &amp;reserved=3D0?
> >> >> >> >> h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
> >> >> >> >> >
> >> >> >> >> > Please check whether it works for you.
> >> >> >> >>
> >> >> >> >> Thanks, one can tell that I haven't done my due diligence of
> checking
> >> >> >> >> Shawn's tree first. I'll cherry-pick that patch and carry on =
with my
> >> >> >> >> work.
> >> >> >> >>
> >> >> >> >> However, the fact still remains that Michael has expressed hi=
s
> opinion
> >> >> >> >> regarding mmcblk0 vs mmcblk1. Do you think that we could make
> >> the
> >> >> >> >> aliases a per-board option instead of per-SoC? Consider that =
there
> >> >> >> >> might
> >> >> >> >> even be boards that only use SD card. It would be strange for=
 the
> >> >> >> >> block
> >> >> >> >> device in that case to be called /dev/mmcblk1.
> >> >> >> >
> >> >> >> > I don't think it's a problem in board dts to define board spec=
ific
> >> >> >> > thing, like re-defining alias, and disabling any IP it not usi=
ng.
> >> >> >>
> >> >> >> First, why would you put it in the architecture include anyway? =
That
> >> >> >> is really board-specific. That is like you would say, we enable =
all
> >> >> >> devices and a board could potentially disable it. TBH it seems t=
hat
> >> >> >> this will fit your reference boards and you don't care about the
> >> >> >> other ones which uses that include.
> >> >> >
> >> >> > In soc dtsi, this is giving default alias for two esdhc controlle=
rs.
> >> >> > This is not board specific.
> >> >> > That's natural esdhc0 is mmc0 and esdhc1 is mmc1.
> >> >>
> >> >> How could this be not board specific if there are at least three
> >> >> different use cases the board can choose from - and needs three
> >> >> different configurations:
> >> >>
> >> >> (1) eMMC at /dev/mmcblk0, SD card at /dev/mmcblk1
> >> >> (2) SD card at /dev/mmcblk0, eMMC at /dev/mmcblk1
> >> >> (3) no eMMC at all, SD card at /dev/mmcblk0
> >> >
> >> > Not matter it's SD card or eMMC card, if it's on esdhc0, use
> >> > /dev/mmcblk0.
> >> > Not matter it's SD card or eMMC card, if it's on esdhc1, use
> >> > /dev/mmcblk1.
> >> > It's not related to board and card type, it's only related to esdhc
> >> > interface in use.
> >>
> >> And what interace is used is board specific, isn't it?
> >
> > Again, for all boards, use /dev/mmcblk0 for card on esdhc0 interface,
> > and /dev/mmcblk1 for card on esdhc1 interface.
> > That's not board specific.
>=20
> So why don't you enable the devices by default then? That would be the
> same reasoning, wouldn't it? Or even enable all devices by default.
> Nobody
> does that. But the boards themselves enable the devices which _they_
> are actually using.

I explained clearly.
Now the point is, I think the alias of mmc0 for esdhc0, mmc1 for esdhc1 is =
soc specific (no need to change the controller alias in board file), while =
you think it's totally board specific.
Let's wait others' comments.

Thanks.

>=20
>=20
> >> >> your include only support (1). If a board needs (2) or (3) it has t=
o
> >> >> override the configuration in the _common_ include.
> >> >>
> >> >> >> And as Vladimir pointed out, what do you do if you just have the
> eMMC
> >> >> >> on the LS1028A. It will be mmcblk1 unless you do something like =
the
> >> >> >> following in the board dts:
> >> >> >>
> >> >> >> mmc0 =3D &esdhc;
> >> >> >> /delete-property/ mmc1;
> >> >> >>
> >> >> >> That is really cumbersome, isnt it?
> >> >> >
> >> >> > The soc dtsi gives default alias to make esdhc0 as mmc0, and esdh=
c1 as
> >> >> > mmc1, the use case just needs to consider which esdhc controller =
is
> >> >> > used. That's fixed index for it.
> >> >> > No matter how the board is designed, there are two esdhc controll=
ers
> >> >> > in soc. It's probed as mmc0 and mmc1.
> >> >> > It's use case that should choose the right mmc device. It is not =
the
> >> >> > dts that should be changed to suit use case.
> >> >> > If the board owner insists to change alias to make esdhc1 as mmc0=
, I
> >> >> > think no problem. Just do it in board dts to override the default=
 one.
> >> >>
> >> >> Still, why would this be enforced in the common include? What is th=
e
> >> >> advnatage here? I only see disadvantages.
> >>
> >> You didn't answer this unfortunately.
> >
> > As I explained,
> > "Again, for all boards, use /dev/mmcblk0 for card on esdhc0 interface,
> > and /dev/mmcblk1 for card on esdhc1 interface.
> > That's not board specific."
> >
> > Without such definition, the index is random for each booting.
>=20
> No the question was why to include this into the common header. Not into
> the board specific ones.
>=20
> -michael
