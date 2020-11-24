Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E240C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16E22073C
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 09:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="feuEnn35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgKXJDF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:03:05 -0500
Received: from mail-am6eur05on2066.outbound.protection.outlook.com ([40.107.22.66]:54624
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbgKXJDB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 04:03:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZrvPUPJL5GHycYkeftwVA/Gy8mtmKiN2sYAyYEViCS3guuGtvMuwq4VYom3dT6rbPi8BkR1B7pltJfdUYqH4+PQ8vd0OJz/wtekPatxF7RP7KDqwZNzK3sgBWE1jRXj4IiGsAkPIYkWV5SLxyjHMj92FBfkcxgbgag2AyXMeFiGpexXqaLCAQ4NsWc1ppCPYcpwrC5wi1VucDvJeDyVglws7zUJzEjdeldCm13aA3v2H/p475rvloKjM2k9nMNknSEcnevA2bRG2Lamfu8lG1Zl8EpSeYrhr1qeIfhAY5UU5xFiqF6vkZhgkKX1wA0iTfUoUp43P7C3q8BVgfVEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo9mjSkU+PJ5rBzXXkgXY+Jw6V+5zFPLpmdo9IWxBWQ=;
 b=igGLgt1qVQmeexh5tSCaQ6MLrOdjKRfgbl5A0wrX4xJdSJjS1AafzCCvVuxkr9mcdagu3WI+pZuSbSDNgFvJXpWgWW1x7JrWT2Llb1uM0B9y2NCn0Shh4E5kVBGlOz8udKDh0P1qnnSOtpK4GvY2U3wEAOISKnbwhJoA7VGhKaujlS/1BnbzPM1fZkfUPCS/B6u99nccrKGypAIEYqyQAX7KmhxSRy5A6HBtdP+Qn63ZFYbSHVauv01fEddZOpYPZkPEgNAo6HXCzFwpu2sBrG8si+ZUxuL/eIUH3g1NO5S/eIgDidIi2gTPNkCk3KPBVrtjSd0IKyEySzO4uSRupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo9mjSkU+PJ5rBzXXkgXY+Jw6V+5zFPLpmdo9IWxBWQ=;
 b=feuEnn35Tx7Iakp8pm6xRAXruH+QYLtnPnuOStIi+wZ66Q2t2ADv8WynQ2xbV9wLzBrjElYrSeDc9Ks/7zbznqI8gB6JvD6ISPxuWwh3jaxePw5zd3mqVxmK0EN1jrzaaJzII7eRokUI8d8bn9FsGghFgqWRtH2+vzCI/36UApY=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AS8PR04MB8054.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 09:02:57 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 09:02:57 +0000
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
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOCAAAokAIAAAQaQ
Date:   Tue, 24 Nov 2020 09:02:57 +0000
Message-ID: <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
In-Reply-To: <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02bf2c12-5517-4d0f-d4ce-08d89057bcb4
x-ms-traffictypediagnostic: AS8PR04MB8054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB805465C879498BCCB9D3BB71F8FB0@AS8PR04MB8054.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtL6cp76+M/AZt3XnjOqhJOXi/9vrK2hoRgI1eoYgvz/rkR8e8uBwMshglmEV3SunupNLLtdWCB93PkxU7yt/gi/k7PxCmiRneT5IZ7AKsR13mJNNZkQHIUVr9clJY2Q24JYynQYRCs2gAWNy+RljxlYGoTQFIFWcFwtO/gIW4SmXXk/mBvGhmyhXnGOcAvuGrbT1noUeSOc6MA9MQTGrWxfiuJqDL3NVo0ZmH1vDzbv+cxjQg0+c2sHS3goovPq6mnImeJy52ptRSSTqM3nnWnHPPsKIdzUrDqSAo5jJlJjQezpffY1sSwb+n6Nt7QQRL0lLG2zXS3x4eQHx0r0q2xfo3C0F8tLInBW1njm/I21uVhOXW7FjuS+pNdI44JaBmUozD8Gw3ZFGVZ2Jj6IEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(6506007)(53546011)(45080400002)(52536014)(71200400001)(6916009)(2906002)(4001150100001)(7696005)(4326008)(86362001)(5660300002)(83380400001)(26005)(8936002)(966005)(478600001)(55016002)(316002)(186003)(9686003)(8676002)(33656002)(66476007)(66946007)(66446008)(54906003)(66556008)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DXhm8ncNNNAehGiYSiyPPzv35aAHj6XC9wpldRW17gGQWkqzIw3W4FYmIrm67h75X6P4nkbCuSc2IB6zzhBxVULlgD6OEwFxT08IFKQ2x/TubABgE/IZfdGkQHqu3E7fjQi8XfcsQtUwC2xorrxTKt3wRRCqGTm38stajuEXJe4N4cxCYqHp0G2yBkudMMDqJpI338es0OwsrmGOhPfTuyqq7ovlo4Spkzc8mu/3hebnxa7oBdK4az/oZAnv6ujx1hCuYAIEevQVAGU9oY9SmBJgBc0dsFQ/wGsUstxTxQIZBaok9+LxfS1Hl+iLP+GLNThwiPAMAV891o4wHhrY/EJPMtaBh2xCcSZJh+1TYrVHx3f+WXev7A3e9YEPUYoE6TQEpewqbAs582LIX3CLKcPK/JlXbubfzZmOXrczyqFGXPHF4/eWqd3aQQFBq/MZXbVPt3YIl2qqFLOd4Z5DUHvPSUddlQhD7NlYsMHFYrtTiC1DMmkcPGgydcU49FtuG8pjfjRrq3HBwnMqnl+0olQziqCmHospk5urEQctoj/cJQoqBfbOTRt9KUwh0dREHDYlRPQLePa4WVzp27DxyI/FP5pqLubujwuBEmCMiC2RWEkB8CMp1bRzVZuZmJidI2IrSS6euMhPPaO2+nkVMXXG4N6AsiQAPkhFFtEhZmAKcy4klZio3902Z/nFJ7SUjwim6RuVsrgRpUsEQ9+x0Oly3632mI0h/2LH36nCwXcm0aE63M0cHZS+jqFQGpFttMtpkwMfVZlXuXGKxnu9/xlXrV+NZEcUEBNZ42G71HU/6fUEhAnVI7ovc3YXOykIYGq7cmpM7uk9Syd5gtnXSPgzc32KskvW4A+2faCfvEh7bSQG7O/jtN6EK1eL6WnGhcZSBcObzbewembStnVBog==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bf2c12-5517-4d0f-d4ce-08d89057bcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:02:57.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4JfRhgwoZce4/kPV5EbS6kjuPYZwTMEJeqfc/rvBK2Wdr3RSdBmjJY/LFHzh1Hu4t6I57je9Zdl2AjwgaHZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8054
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, November 24, 2020 4:55 PM
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
> Am 2020-11-24 09:47, schrieb Y.b. Lu:
> > Hi Michael,
> >
> >> -----Original Message-----
> >> From: Michael Walle <michael@walle.cc>
> >> Sent: Tuesday, November 24, 2020 4:03 PM
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
> >> Am 2020-11-24 08:41, schrieb Y.b. Lu:
> >> > Hi Vladimir,
> >> >
> >> >> -----Original Message-----
> >> >> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> >> Sent: Friday, November 20, 2020 5:30 PM
> >> >> To: Y.b. Lu <yangbo.lu@nxp.com>
> >> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> Rob
> >> >> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> >> >> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>=
;
> >> >> Ulf
> >> >> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> >> >> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>;
> >> >> Michael Walle <michael@walle.cc>
> >> >> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> >> >> controllers use fixed indices
> >> >>
> >> >> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
> >> >> > Hi Vladimir,
> >> >> >
> >> >> > I have already upstreamed a patch for all affected layerscape boa=
rds.
> >> >> >
> >> >>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> >>
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%2
> >>
> Fcommit%2F&amp;data=3D04%7C01%7Cyangbo.lu%40nxp.com%7C498622ade
> >>
> e704fc0042008d8904f6184%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> >> %7C0%7C637418017917635725%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> M
> >>
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
> >>
> &amp;sdata=3DOciS3q%2BmP%2Bz4x1ewPHDigmUkgIZmBgUlRRTm4yaxB7s%3D
> >> &amp;reserved=3D0?
> >> >> h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
> >> >> >
> >> >> > Please check whether it works for you.
> >> >>
> >> >> Thanks, one can tell that I haven't done my due diligence of checki=
ng
> >> >> Shawn's tree first. I'll cherry-pick that patch and carry on with m=
y
> >> >> work.
> >> >>
> >> >> However, the fact still remains that Michael has expressed his opin=
ion
> >> >> regarding mmcblk0 vs mmcblk1. Do you think that we could make the
> >> >> aliases a per-board option instead of per-SoC? Consider that there
> >> >> might
> >> >> even be boards that only use SD card. It would be strange for the
> >> >> block
> >> >> device in that case to be called /dev/mmcblk1.
> >> >
> >> > I don't think it's a problem in board dts to define board specific
> >> > thing, like re-defining alias, and disabling any IP it not using.
> >>
> >> First, why would you put it in the architecture include anyway? That
> >> is really board-specific. That is like you would say, we enable all
> >> devices and a board could potentially disable it. TBH it seems that
> >> this will fit your reference boards and you don't care about the
> >> other ones which uses that include.
> >
> > In soc dtsi, this is giving default alias for two esdhc controllers.
> > This is not board specific.
> > That's natural esdhc0 is mmc0 and esdhc1 is mmc1.
>=20
> How could this be not board specific if there are at least three
> different use cases the board can choose from - and needs three
> different configurations:
>=20
> (1) eMMC at /dev/mmcblk0, SD card at /dev/mmcblk1
> (2) SD card at /dev/mmcblk0, eMMC at /dev/mmcblk1
> (3) no eMMC at all, SD card at /dev/mmcblk0

Not matter it's SD card or eMMC card, if it's on esdhc0, use /dev/mmcblk0.
Not matter it's SD card or eMMC card, if it's on esdhc1, use /dev/mmcblk1.
It's not related to board and card type, it's only related to esdhc interfa=
ce in use.
Thanks.
>=20
> your include only support (1). If a board needs (2) or (3) it has to
> override the configuration in the _common_ include.
>=20
> >> And as Vladimir pointed out, what do you do if you just have the eMMC
> >> on the LS1028A. It will be mmcblk1 unless you do something like the
> >> following in the board dts:
> >>
> >> mmc0 =3D &esdhc;
> >> /delete-property/ mmc1;
> >>
> >> That is really cumbersome, isnt it?
> >
> > The soc dtsi gives default alias to make esdhc0 as mmc0, and esdhc1 as
> > mmc1, the use case just needs to consider which esdhc controller is
> > used. That's fixed index for it.
> > No matter how the board is designed, there are two esdhc controllers
> > in soc. It's probed as mmc0 and mmc1.
> > It's use case that should choose the right mmc device. It is not the
> > dts that should be changed to suit use case.
> > If the board owner insists to change alias to make esdhc1 as mmc0, I
> > think no problem. Just do it in board dts to override the default one.
>=20
> Still, why would this be enforced in the common include? What is the
> advnatage here? I only see disadvantages.
>=20
> -michael
