Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85BC63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47E12075A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 09:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmugiyYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgKXJWl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:22:41 -0500
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:22880
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731092AbgKXJWk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 04:22:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLWz7i+bXLiGuKzf3iAoaCRvyxprrLGUdVI3jipIvVrdXByHU3B6VXptHTdUka99p4lb5XHleVuZYLkQBrlNikfT4SW//ngIbJLoPO5SIzRNU1uS6rQcxpa34uhel+3VBh+F4zAW70oAYIWNPQhO3v0WcIfsyGnKWhhQm63FwFWTmnzO041L3szFV0bLKteLWJxnBR5BLMlByp0CMtphTKKzghf8vc624aDBJu8cXPRiGYa3Z6YR68osfNWgL53vRNgLbmjaQ4iZKPCCGGZgLo2+DH63EVMursQNuv9bS5e7Nd8Q9LPGLx3ZfqNySfxFJT8+KKhwY6hslZjYQQAOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I366prxcrjvZ+AUH0LynC/yuySmw0EbyN6mW8pb4ktA=;
 b=j614tiO22O+LBVExoigvtO3jajCORijopw1Cj1KlXx/Mk7PNQEEw8OwfaveXdTq5uW49ybVKwneCnzpPIKK4V2CtDprIGcQu6Ri/2CDJSm8rRKFLP6o+hrB7oVCpHqrBfXIF9s3z95RzhCtisfcuuMQwk+ItZx+bhvW3g1FufsP/Gb8mFRtdvzD5pJuOes1lZ3WJKaagPrrxJGRNM+n6yY6KYX+uwl1z2hM1pmKT43mym0vt8ApfWV0RMovbbgEpqRHprBRIT+ZIq3A27RLjwkNZFsJX+OxrfQEX8SnPGS5Y/HPo6qVJYOAG7nif7MlofVGfpqo+/r5BqiquOn+B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I366prxcrjvZ+AUH0LynC/yuySmw0EbyN6mW8pb4ktA=;
 b=BmugiyYkU6pX9thwYlLroGV3F1KMiKPa36bopv0thIQNFUkzx9/saMVirtXeRQSBzPlvXiwGyKAOFVhls/5dqWrUibb60LMJ9qe7IIDM6CiTc+wLI/EZtT8LAYWBel2K/d8ce2qaNNtozFsq7jeL9Sq4GZRA7S67xwodHXluMmE=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 09:22:36 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 09:22:36 +0000
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
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOCAAAokAIAAAQaQgAACmQCAAACNYA==
Date:   Tue, 24 Nov 2020 09:22:36 +0000
Message-ID: <AM7PR04MB6885044C8AE85FE369285186F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <de68e6861f0ab947642c847b3b645503@walle.cc>
In-Reply-To: <de68e6861f0ab947642c847b3b645503@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0937c76-8e3e-4671-5d25-08d8905a7b7b
x-ms-traffictypediagnostic: AM7PR04MB6789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6789B28A264D2BC1DF29BE4DF8FB0@AM7PR04MB6789.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSkEOS5KMzsfUMg/WoIJuIRm0ycNftWZlSHblWIBduhsNIEdB5NFBusfabqN5SoIOO99z00+3RwYcmipxwhmKcLcpKY80r1ouri0ABK1DPt0Ql5nUkeBc/j8wnAJnZpQxEi+s1fbjdwMhSJdMbtEUNlqt9LxXMWdiw3RvcdUKGib493szbAieqeHbeFFjPi5zk2NKfm1ZnVUqnM+ZaJSR6llFd/t6+32+X1SKTm+kGQ/6HcYp6wKfKLaigEKvA9p7Mtmgg7Mdv9gG3CJeriOHIdjg5QyqzLMod14K4sxaLgbCkEVe9nCyyCbTn2zK25kBg51lfPyBd+MLfdqKyVFtbJ+zP/557kQYvAvOqrsIEmej9K6DYhQvuBP4xenMr016upfHgD8PLRzb+15+8AHQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(54906003)(4001150100001)(53546011)(8936002)(2906002)(6506007)(66476007)(66446008)(6916009)(7696005)(966005)(64756008)(66946007)(83380400001)(66556008)(45080400002)(478600001)(5660300002)(76116006)(52536014)(4326008)(8676002)(33656002)(316002)(86362001)(71200400001)(55016002)(9686003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ugQJxOJUxdb7/BSZpH99+ZhyUwkX/4SPZMzv0yUR+vt0vjbnITrH1CysRGFfZK/u12Lo5ZLcpRwKOwFqSZp2BgCD33kl9LXpQP5G8nwS8XL6eRvnLyvK/jvhuCOPtJujry9oTlhAG8CFtWT1baa7IOAI+yp9zEzDAIy0ADxRIzcD1XWeC7uvzsfwjn5CuaivOIpTO9+tk0+KabJIdoYAROqvDunreTCGpMf6SE0BDqxdVBpoO3jWi3zlAcvyWTN4INamK7zevvr2UkiYrB8vNeflowgFVzAsSNgkDg8OawQm2D2uudqOO7esPjUCARELR3Z0sn7wx2fhkOwDxcgIHCxojEyLSJJmrf26MlVNuFSmlWErVNEDohqxBrDCBgrRA3BlCw/QsW5tENSJ3r9wmHk4ulu7Enx2sqpNq2vk1Z0uC/depkgy8MKThiVl/1QdvUZ+w/u78V+08XM/TNsRbZpr5zjFPFHljQ5gyLu4YYFP4cj9LmqywxNGQ9+ESzOcsCM93nFX2L/lg1CeUkvORmM4dgOo/ZZwlnuUFPdxsbYGyP2md0LPUzYEeC9Z4b/UlrerQAVP/bmBcQWeumEhzxrkw1ObCV98H6RMmQm9hxQIR6ovQU0ygIsZ/WfctN0VieuDm8ayT0DiWH0+gSjw4qfMTGY23HUntuGjcutW/dKMSOVXYo43sZLsjDLAold8rm6Tt5DyfK0mzqNq08S4sjNUq+c+po+EXMHBHBJe1yXSbERYB7mUUCnDr+60o+hZ2Na7XmhrktadGt3LS49SC8HzdW3Yqvwmjb6wFbMxwh0CPmBd2N+lXw3PYrPEZfuZtkeQJK+X0EWOlKI8iOQUwql3dTBKoM0NVEM7WeI9tLRd7cfkAGUHb/CcmrWUW+4GnHSCet/NSDI0NN82to66Cw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0937c76-8e3e-4671-5d25-08d8905a7b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:22:36.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQ6a2NlrrqN+1prfNYMEA9uANcLxHH725BHjZiMLq/Ry/Gm6lbePrSzP8QIw4PHMnvOsAVrKorXKbEc4lP6heg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, November 24, 2020 5:08 PM
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
> Am 2020-11-24 10:02, schrieb Y.b. Lu:
> > Hi Michael,
> >
> >> -----Original Message-----
> >> From: Michael Walle <michael@walle.cc>
> >> Sent: Tuesday, November 24, 2020 4:55 PM
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
> >> Am 2020-11-24 09:47, schrieb Y.b. Lu:
> >> > Hi Michael,
> >> >
> >> >> -----Original Message-----
> >> >> From: Michael Walle <michael@walle.cc>
> >> >> Sent: Tuesday, November 24, 2020 4:03 PM
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
> >> >> Am 2020-11-24 08:41, schrieb Y.b. Lu:
> >> >> > Hi Vladimir,
> >> >> >
> >> >> >> -----Original Message-----
> >> >> >> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> >> >> Sent: Friday, November 20, 2020 5:30 PM
> >> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> >> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li
> <leoyang.li@nxp.com>;
> >> Rob
> >> >> >> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.o=
rg;
> >> >> >> devicetree@vger.kernel.org; Adrian Hunter
> <adrian.hunter@intel.com>;
> >> >> >> Ulf
> >> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> >> >> linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>;
> >> >> >> Michael Walle <michael@walle.cc>
> >> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD
> card
> >> >> >> controllers use fixed indices
> >> >> >>
> >> >> >> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
> >> >> >> > Hi Vladimir,
> >> >> >> >
> >> >> >> > I have already upstreamed a patch for all affected layerscape
> boards.
> >> >> >> >
> >> >> >>
> >> >>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> >> >>
> >>
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%2
> >> >>
> >>
> Fcommit%2F&amp;data=3D04%7C01%7Cyangbo.lu%40nxp.com%7C498622ade
> >> >>
> >>
> e704fc0042008d8904f6184%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> >> >> %7C0%7C637418017917635725%7CUnknown%7CTWFpbGZsb3d8eyJW
> Ijoi
> >> M
> >> >>
> >>
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
> >> >>
> >>
> &amp;sdata=3DOciS3q%2BmP%2Bz4x1ewPHDigmUkgIZmBgUlRRTm4yaxB7s%3D
> >> >> &amp;reserved=3D0?
> >> >> >> h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
> >> >> >> >
> >> >> >> > Please check whether it works for you.
> >> >> >>
> >> >> >> Thanks, one can tell that I haven't done my due diligence of che=
cking
> >> >> >> Shawn's tree first. I'll cherry-pick that patch and carry on wit=
h my
> >> >> >> work.
> >> >> >>
> >> >> >> However, the fact still remains that Michael has expressed his o=
pinion
> >> >> >> regarding mmcblk0 vs mmcblk1. Do you think that we could make
> the
> >> >> >> aliases a per-board option instead of per-SoC? Consider that the=
re
> >> >> >> might
> >> >> >> even be boards that only use SD card. It would be strange for th=
e
> >> >> >> block
> >> >> >> device in that case to be called /dev/mmcblk1.
> >> >> >
> >> >> > I don't think it's a problem in board dts to define board specifi=
c
> >> >> > thing, like re-defining alias, and disabling any IP it not using.
> >> >>
> >> >> First, why would you put it in the architecture include anyway? Tha=
t
> >> >> is really board-specific. That is like you would say, we enable all
> >> >> devices and a board could potentially disable it. TBH it seems that
> >> >> this will fit your reference boards and you don't care about the
> >> >> other ones which uses that include.
> >> >
> >> > In soc dtsi, this is giving default alias for two esdhc controllers.
> >> > This is not board specific.
> >> > That's natural esdhc0 is mmc0 and esdhc1 is mmc1.
> >>
> >> How could this be not board specific if there are at least three
> >> different use cases the board can choose from - and needs three
> >> different configurations:
> >>
> >> (1) eMMC at /dev/mmcblk0, SD card at /dev/mmcblk1
> >> (2) SD card at /dev/mmcblk0, eMMC at /dev/mmcblk1
> >> (3) no eMMC at all, SD card at /dev/mmcblk0
> >
> > Not matter it's SD card or eMMC card, if it's on esdhc0, use
> > /dev/mmcblk0.
> > Not matter it's SD card or eMMC card, if it's on esdhc1, use
> > /dev/mmcblk1.
> > It's not related to board and card type, it's only related to esdhc
> > interface in use.
>=20
> And what interace is used is board specific, isn't it?

Again, for all boards, use /dev/mmcblk0 for card on esdhc0 interface, and /=
dev/mmcblk1 for card on esdhc1 interface.
That's not board specific.


>=20
> >> your include only support (1). If a board needs (2) or (3) it has to
> >> override the configuration in the _common_ include.
> >>
> >> >> And as Vladimir pointed out, what do you do if you just have the eM=
MC
> >> >> on the LS1028A. It will be mmcblk1 unless you do something like the
> >> >> following in the board dts:
> >> >>
> >> >> mmc0 =3D &esdhc;
> >> >> /delete-property/ mmc1;
> >> >>
> >> >> That is really cumbersome, isnt it?
> >> >
> >> > The soc dtsi gives default alias to make esdhc0 as mmc0, and esdhc1 =
as
> >> > mmc1, the use case just needs to consider which esdhc controller is
> >> > used. That's fixed index for it.
> >> > No matter how the board is designed, there are two esdhc controllers
> >> > in soc. It's probed as mmc0 and mmc1.
> >> > It's use case that should choose the right mmc device. It is not the
> >> > dts that should be changed to suit use case.
> >> > If the board owner insists to change alias to make esdhc1 as mmc0, I
> >> > think no problem. Just do it in board dts to override the default on=
e.
> >>
> >> Still, why would this be enforced in the common include? What is the
> >> advnatage here? I only see disadvantages.
>=20
> You didn't answer this unfortunately.

As I explained,=20
"Again, for all boards, use /dev/mmcblk0 for card on esdhc0 interface, and =
/dev/mmcblk1 for card on esdhc1 interface.
That's not board specific."

Without such definition, the index is random for each booting.
Thanks.

>=20
> -michael
