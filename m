Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33F0C56201
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 08:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9EE2073C
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 08:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bk5VBFIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgKXIrs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 03:47:48 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:6062
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgKXIrs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 03:47:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyEQ3QfLtYEi9atYDeGLKYlqOae6citZsLDRelWT8Frps0IQe9jR5HR0aV7PAb15ATj4IPHj7D8Usdnin57IIoOPdjgbJ2CzjASEoE6dXw3S0sKQY/Do9zsLkB0YT3qaStZoHbrdNAbwx91qJ8Ds2xm09zSI8wG2KE2kD+c6moXC3XuYohiGMrgD4IIzxi0jrSX2Qg96XxGEwG71y9IIJm/0P/bRfcEngw25OAEqqP9CUssIvoP3djIzqhZIehUOkQgg3nYM48JwJPV8C4E0iex04DAs7lMt9Zoy1ftTwmJagpz/UlZ72T5+iAxOTVqh/iW0vGhxJ6BqQ8V202GiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXEyuFSF4jHoZkjFOIpD8jR5jqFt996rkytLYazo/5w=;
 b=RpDh2BPitYFRm0fuWzdSHK3KRhlL4KutbJ9IKYUuSXb+Gb32rlIyI3NYcAP3YKkJK4IBZWhjsf5fxcBB+VPEv6TkojN6BVEjnGAQ5JoAO8wK+hJwrO3bRyu6F1ZRtkVilDPkCkIjCcjN40VDwe6cUVJH1ug5sSeibr/l3o4YZbrOGhSAxrkeL5t6Fm+Z24EJ1lO4PhGFtiTHWakz3lex/8Dc5J/+A70tTlwtOMcDI+pLODf57g6qxnv5b14Jy8DdeEHrDA/Y1rF3V+CwM8SdnmMYrbfa80ouz3Y2HqNzzxUak3Xs0vYhjbv+htHDsUe5V794BVhHRMMUF0nMGLmShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXEyuFSF4jHoZkjFOIpD8jR5jqFt996rkytLYazo/5w=;
 b=Bk5VBFIGtK9sWqEMhyAeIZcwLsgQM1G2EFCKMOx8lDkRbOdXxWppxEW4WlZ/X5vk/Xxir3vlPSCYtpl7sOQnXQ31jKHG9QqDT7M29FYXJrO3EwSePy2Da9jLnwtwbz/clUSRSpsehcAGj2N6yb/tEBdVbt+6JP4wVJD6VHuo03k=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB5191.eurprd04.prod.outlook.com (2603:10a6:20b:1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 08:47:42 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 08:47:42 +0000
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
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOA=
Date:   Tue, 24 Nov 2020 08:47:42 +0000
Message-ID: <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
In-Reply-To: <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c77092d-f983-4068-bb70-08d890559b70
x-ms-traffictypediagnostic: AM6PR04MB5191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB51916C3E36FCEF6CF445D7E9F8FB0@AM6PR04MB5191.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L61IzNFEgXRIHImCq0FHju3vHY2hVvE5SUxbNJlqsjVNkOMMMaOMzLH95Cdmyvqt2bS+fxwMq44QImFGHM85G9XyK1UsyX4xkjWILJcYSbob/ZWnoaCCP058xwvlZ9qUJ9VGtcCA1UJkWIo0xtwI93fhYXxkDygnzFwq5smkNKiohmjsSVv+j60kvDffREgKdnYclN+Ifmdg2lAml7E8eIiUlWazT/AqB/XCDYPGgJFq1DF3tPBpOtTDMwaofDYpb3V3t2yI2fgjVByC6VFBO0yhILNK6/R8BHU/a2XCrcsaew2/5PCMitaxRQI3Rm+kFVdPvimJTUv6UrVRkRL/F5mc3FHGRBkPnkyxxOVu2gIiafJ/f749DnBkWABCrDYWa1eJkchXHomMrKwx/k9szQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(71200400001)(66556008)(33656002)(66446008)(26005)(5660300002)(52536014)(64756008)(86362001)(76116006)(66946007)(66476007)(4001150100001)(83380400001)(45080400002)(8936002)(9686003)(6506007)(4326008)(55016002)(478600001)(966005)(53546011)(186003)(6916009)(8676002)(316002)(54906003)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: b4HCbdPDVpzIQfjnFoBL4rBZtZEar7s7RZBdUPQBgNjkkQ9eW3XvFqvO5feKPTcU5RXU066I2BmjUF9ehwuqsANEvCyPFnxtA6LaFe/cXSTNNizXtBLrGO8yE8+zg3pftfOUZtjXdlxUvxQ8jnBmvXS1I6osm/pG1lTxHj5j0JemTEXOleHJH/wzhlUCXWwQraC7foPqb/l0H4zGg0c2I6tuCZvRvSLsEwlzgcmXdd0M6y1nPpbcm39E9TbhpLuSMiXtKiHvfWNChorDHSDy5oH6RhLxQATvCue3DHCMK1QoYRdd3L1y+SqG5ay23XX9/G+B/CfDaBq3tt/x2uJKL1rAXW0q0S6QVU3agvs8O5qt/mT549jKpyPVFR39LuFFyKbN6TAvhXQjSiPj40IwHo5FyIFpSGPzHgigvkdCcT/UO1++p39uj5pkmMOtyXS3Ly1DvCq7j1TVTJu/I7QlAbu3GErAD63+fYKVtmRwKB/fw+iaDwoxjCEkqNOo7ufhyb2U+yPBpsjxcZ8l2TVGv8nyMom8k2Ew/uxU/p2POT+cqwlIUbBLB9kRkpzZ4NeS7CTZ1Y6Np/wqL7Br7MKraAGArxKEgfTH1+p+34dBBDgU4Cy47X9FaeSKX0vRfohGgucq47uj1YWEeQ8nWZPrPi17GNvFJhiHNKlzwjjg7ftQML8UPWlVEGXdGGJxzddZT4TyijaMZveirwKe/vqirn3tIobEYih6szEhEwObfHnHzT85Sq49Hfm4GPWyIXFlNPPWDB6pIVshWNbIyf+PlYmlLlNSRtSPNcfcbVaQgpg5Wa379BN5M/DB4h/7xT/5ZQKEQlLTTbDmVBG8TIupgKGkJhkhYgR8Hl85IE6jqhlXuUb3DHqXTGef5Q9qaBCiJWDcwcgaTnL85UZQ1VoVtQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c77092d-f983-4068-bb70-08d890559b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 08:47:42.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deS/K7zvR3UZLF/XF3CC9esBv4o3xvtSKQXjLn1keUm2/VOnjXnx4GoLXcio8Tdk6fzD15W5yWq2/Gr3CdZ4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5191
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, November 24, 2020 4:03 PM
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
> Am 2020-11-24 08:41, schrieb Y.b. Lu:
> > Hi Vladimir,
> >
> >> -----Original Message-----
> >> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> Sent: Friday, November 20, 2020 5:30 PM
> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> >> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> >> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> >> Ulf
> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>;
> >> Michael Walle <michael@walle.cc>
> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> >> controllers use fixed indices
> >>
> >> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
> >> > Hi Vladimir,
> >> >
> >> > I have already upstreamed a patch for all affected layerscape boards=
.
> >> >
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%2
> Fcommit%2F&amp;data=3D04%7C01%7Cyangbo.lu%40nxp.com%7C498622ade
> e704fc0042008d8904f6184%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637418017917635725%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
> &amp;sdata=3DOciS3q%2BmP%2Bz4x1ewPHDigmUkgIZmBgUlRRTm4yaxB7s%3D
> &amp;reserved=3D0?
> >> h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
> >> >
> >> > Please check whether it works for you.
> >>
> >> Thanks, one can tell that I haven't done my due diligence of checking
> >> Shawn's tree first. I'll cherry-pick that patch and carry on with my
> >> work.
> >>
> >> However, the fact still remains that Michael has expressed his opinion
> >> regarding mmcblk0 vs mmcblk1. Do you think that we could make the
> >> aliases a per-board option instead of per-SoC? Consider that there
> >> might
> >> even be boards that only use SD card. It would be strange for the
> >> block
> >> device in that case to be called /dev/mmcblk1.
> >
> > I don't think it's a problem in board dts to define board specific
> > thing, like re-defining alias, and disabling any IP it not using.
>=20
> First, why would you put it in the architecture include anyway? That
> is really board-specific. That is like you would say, we enable all
> devices and a board could potentially disable it. TBH it seems that
> this will fit your reference boards and you don't care about the
> other ones which uses that include.

In soc dtsi, this is giving default alias for two esdhc controllers. This i=
s not board specific.
That's natural esdhc0 is mmc0 and esdhc1 is mmc1.

>=20
> And as Vladimir pointed out, what do you do if you just have the eMMC
> on the LS1028A. It will be mmcblk1 unless you do something like the
> following in the board dts:
>=20
> mmc0 =3D &esdhc;
> /delete-property/ mmc1;
>=20
> That is really cumbersome, isnt it?

The soc dtsi gives default alias to make esdhc0 as mmc0, and esdhc1 as mmc1=
, the use case just needs to consider which esdhc controller is used. That'=
s fixed index for it.
No matter how the board is designed, there are two esdhc controllers in soc=
. It's probed as mmc0 and mmc1.
It's use case that should choose the right mmc device. It is not the dts th=
at should be changed to suit use case.
If the board owner insists to change alias to make esdhc1 as mmc0, I think =
no problem. Just do it in board dts to override the default one.
Thanks.

>=20
> -michael
