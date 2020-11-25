Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A75C2D0E4
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 02:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3583C20B80
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 02:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8sxKO1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKYC7q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 21:59:46 -0500
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:49600
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgKYC7q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 21:59:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEz9ekiHWvx90cXm2J5ghhye/QBBDhccyyMD6VamVe83KVdHZrTJSD+leHDP1TVgy0eXEUHo4ie8v+zjinJao14yl7Z0WqfkefpNDfnLF7vYYZU9zHJxvC2aufVTCUNFBJIh27FWV4m6HtvCdaHYCSbeTEJiTgS9UWKLZtKenarO898OiZhX+uX8fgZHVh8oMVufHRQfIqY3CZui327DlP5Ug2L4rF87B2OJuQetMIHUZgW+DoVeiVPgbDc1VmtV/n7pEH1QUUxcA3cNIqH0C7uqdW8vLudI9PSD6Xnd4IYdgKc2VGEO217LJqXtOP8Ta5WrljL05GitM2HZTXPQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoYQUV4fSquFTLPb3y6/gdgTJDONkKYBn9H1+AOdj88=;
 b=HOBAB/pvL2U/Q2t41qfarPMd3hM5egAk/zEDw+p1bLon9iP9jAhCqxhRXjiHf0e/SCfNEKRX71XYvsYMRxERV/CsqU21T0gNuVxOAZ4W5VrDRAApQ0v371B6++LMfWWQvLSKV4/4wwAKGSeFuCCCLFfk33Fp0R2lpXKJqU0u1prM/lXDgdwtvk14pESmCMb3snPmYGuCyiuwYBF1Nci1Nij4d7+8PnqV+VWqCyc5G1ZJ4jAwWn+dfsQWNMuw6XcikM2GenRC41FkJy+7pdtW6/6ik1gTdRQMrZX5E10GRjne835ZvwaRJHjd5KL4jkydpCCaeVyP8s7Zc4VeOYo2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoYQUV4fSquFTLPb3y6/gdgTJDONkKYBn9H1+AOdj88=;
 b=f8sxKO1T6GnvHWqg8AAw3Wk30WAlxM+qqpnAq1m8QIrp5aRlHCBhckIII2KRucY5HPs++oWgnavPwxbJ6YhaFiHa1hwmlCw/V8CdWoYQOOv5eAX72P+iYOrLqJ+OXv3/8KLvegA7ek/y+GLnu7gtSgWZkTOLdTqc/6GvI+SObTA=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB4200.eurprd04.prod.outlook.com (2603:10a6:209:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 25 Nov
 2020 02:59:42 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 02:59:42 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
CC:     Michael Walle <michael@walle.cc>, Shawn Guo <shawnguo@kernel.org>,
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
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOCAAAokAIAAAQaQgAAZ0oCAAARV8IAAC5AAgAD/ncA=
Date:   Wed, 25 Nov 2020 02:59:41 +0000
Message-ID: <AM7PR04MB688524B26F99EB2C5B86ED48F8FA0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124103128.zucizod344dgme4o@skbuf>
 <AM7PR04MB688567CA698191E2DB73DEF5F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124112822.2ui57jmoc73top35@skbuf>
In-Reply-To: <20201124112822.2ui57jmoc73top35@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 383fed26-aaf5-41e2-3366-08d890ee27fa
x-ms-traffictypediagnostic: AM6PR04MB4200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4200600C2234756EC97BE3ABF8FA0@AM6PR04MB4200.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Emyq2f5kDzyo+tfYHPgSkkAeA2RNJJsF3wZtipndPvCmhE9mtb+IwashjqesVjRy3OhEIDtfZl+V7LWxvYbcHRcA+kfDZRqf0HQx7RjMkHSixlDVIsIIVwPenmy7ddGxRKlx4mGEAoiEaWLB1bRb4aXj9yWfeckduAF2MOSdiAJtevJKPr4t2ujqmHFeZQHzvP/OkvB1JWRQ8I7jPTZdpK4AVUNh7PFDp6fso8RdkLVqtZ/YavY0CDziXMuBc0s4EdTX332/TO6Vz2yyCtMwgMGpumayGDmVrYM4fR1RBTSxBz2zDkQQ0Dl7bTGglLdwx6Qb7SngOn/fsDHWiLrC6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(66446008)(76116006)(66476007)(86362001)(64756008)(478600001)(66946007)(66556008)(6636002)(55016002)(8936002)(83380400001)(9686003)(7696005)(8676002)(26005)(2906002)(5660300002)(316002)(6862004)(186003)(4326008)(6506007)(54906003)(53546011)(33656002)(52536014)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9UHb9CD7UMfTLB/fTA5E9qzfMbZ/W1hH1x1CBdD5BvYF8UvuZnM+B2jWu0I/gD+Qxr2zH/u/0VaNEfbKP8LksM63jCunude143UGlTjwFzc5ARkZVHco4bskk+sweffwxVcdCY+SdbD2kNHK+7iGFYiYn1OAbg+MhgKwJeGDqssE0IyzdDPxQrizERo7vzhJAlo2eC3SlUsT5I87CCYMfXA/IpoOK/uoVJnL5GU95eu7aq03ZjcQsuX546xUm1rOE2SooJac7XOq+XYHTAT/WJEKDXaS1EZo+R/xHhxEQGaJ0ENKvhsIEj1ZKvph3Mn86Uat1f/+4LBu2iEtDkxsQry0wCNWaPtafpmht9J82dZtHwc9pcFTXHhGSD2N4FSGwU0kkD8onMWi4+Hn8CzNrfs3vkXVplTlrmGFuT8UopKqHD4F/OgnQnNS+PXPDMGFBEvAt96/zcCf3+V/qub8vLYTZOKOK0eP4h93LFSW7bVC9lZ1jEiJEVXIr8af1+aC9OkgeZRj5l7ayO3uJ/8IMoM4FgVi852WbS2EL0QWxX6VAd4YJh5lHpdV0eNlXwD7x+uqWLO6NXy6YIGdqjwKezWGqkai1Eilogb9Mx6Dh0hCc38ancEFMYTylzVpXk4PaRPiOrxbCEmVSQ54O1cx/LIxpafXg8KC50wsor2cDV5kBrfcYrEzrqn9EMjKfad40+sfPRoIYkpJaO/lHeD8oFz949lIvf6KT/nozV7Rkp+5C3ntquSyZ8aX7iZDBZTE+GiesrtgnME9d4OlDOc2co3+AsKbKMprJ+n1Jqq+NswbT4BM1d8/NvlV9+MBccyod+2Jl4cHGFwv/R/ZzJ3NqCdSWQwKHX4ncVehQHT5ofyj2y++vgU91VhrtpJKUf6rQv6ajeop3Okp0WUFbr0uUg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383fed26-aaf5-41e2-3366-08d890ee27fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 02:59:41.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFKEcD2s+QDbb6kv0cysqiD2tWw/ldBqdAPf/mdSIAYKgMNDwXhFGtdDiGMPmCe9ftFpGWgcwg97XyxeJVuW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4200
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Vladimir,

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Tuesday, November 24, 2020 7:28 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: Michael Walle <michael@walle.cc>; Shawn Guo <shawnguo@kernel.org>;
> Leo Li <leoyang.li@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; Adrian
> Hunter <adrian.hunter@intel.com>; Ulf Hansson <ulf.hansson@linaro.org>;
> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>
> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> controllers use fixed indices
>=20
> On Tue, Nov 24, 2020 at 11:15:19AM +0000, Y.b. Lu wrote:
> > > > Not matter it's SD card or eMMC card, if it's on esdhc0, use
> /dev/mmcblk0.
> > > > Not matter it's SD card or eMMC card, if it's on esdhc1, use
> /dev/mmcblk1.
> > >
> > > With the note here that you can't actually connect an SD card to eSDH=
C1,
> > > due to the lack of pins for CD/WP.
> >
> > CD/WP is not essential to support SD card. Both SD/eMMC are supported o=
n
> both eSDHC controllers.
>=20
> Let's keep that discussion separate. While in theory you might be right,
> I think the real-life complications associated with connecting an eMMC
> to eSDHC0 and an SD card to eSDHC1 will make everyone avoid that. So in
> practice they are still single-purpose.

You may refer to Layerscape QDS boards. 5 types SDHC adapters with PCIe con=
necter supporting SD or eMMC could be used on each esdhc interface.
Another reason using default mmc0 for esdhc0 and mmc1 for esdhc1, is becaus=
e that's also the order before esdhc driver introducing asynchronous probe.
Distros, bootloaders, and users' cases using fixed index before could avoid=
 issues, and been used as they were.
Thanks.

>=20
> > > But it is also natural for a customer to define the indices according=
 to
> > > their schematics and what they use. If, say, there is a board that on=
ly
> > > uses eMMC, I would expect that for the lay person, no one would even =
bat
> > > an eye if that was called /dev/mmcblk0. Whereas, if it was called
> > > /dev/mmcblk1 (and there was no /dev/mmcblk0 in the system), maybe
> you'd
> > > have to come up with some explanations which could be avoided.
> >
> > To make a product friendly to users, it makes sense to define different=
 alias
> for controller in board dts.
> > But it's not the reason to remove the default/natural alias in soc dtsi=
 for two
> controllers.
> > What needs to be done after removing them? Add the same to all other
> board files?
>=20
> Yes.
> In fact, this is also the reason why we prefer to have:
> /soc {
> 	esdhc: mmc@2140000 {
> 		status =3D "disabled";
> 	};
> };
> in fsl-ls1028a.dtsi
> and
> &esdhc {
> 	status =3D "okay";
> };
> in fsl-ls1028a-rdb.dts
> and not the other way around:
>=20
> /soc {
> 	esdhc: mmc@2140000 {
> 		status =3D "okay";
> 	};
> };
> in fsl-ls1028a.dtsi
> and
> &esdhc {
> 	status =3D "disabled";
> };
> in fsl-ls1028a-rdb.dts
>=20
> So, in line with that, I think that the entity that enables the node
> should also define the alias.
>=20
> It's weird to use /delete-property/ if it can be avoided.
