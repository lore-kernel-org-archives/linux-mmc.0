Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC74C56202
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 10:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEBC206D4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 10:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ETh0HkMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgKXKbe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:31:34 -0500
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:34017
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731488AbgKXKbe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 05:31:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/Dlwd+dXnOzioQDCWbg2WZ+HhAOBnWeY2PCJAtKdp2bIRp46hXNFjWyiiGfQ3Ewkv860EcjnGlMnkVK3w5RUpTJPJM3nii2OPhEwiwNXiNFlVWelFXIMhPja78npouwFwCXJ8FCJcx0TE+e0AEMqYgSNRkWqWmQbZhVdWOZrs4YUdxlH7nG9+RaG5q0eLJKhdJCGhtu8+KNCtIoGoHyyEVqSXwB/ZRzEQKcMjmgqwAX8J2wZzWW919/g5oT8dS2dhB7Rz9195bSn1KYBfoQhagdQz/K5nqlXRjOjOd/peCoXF4ajioD5ZjOmTIrZ3bl7xX1Rz1QJzXP+EffbuK9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmYcCYfBJi0ZncfTxnmmV04EAAzsmluPoEzy14sUg68=;
 b=VD2nTKAVYlbXych8NIWp4a1ZIDsGzrs+T2y2F9eXLyecM51lEqioOre5sFVNhBsYVVP8xZ37ejaPS+t81vPxAmjlOugTNGbXtt2Mh4O/nNEbHS1Sdkph22gFhFYJtRCmdislMMEwrUCvQJJIVFG94PnnCgPuMdA+5k51GNMoukQr1C+k1c8KKQsSuqm9qhAlU0EDpyxCGZ0RzhmI/N1Bj8kNuqyVs2jY6Zcd/FsEjIED3S86PMrhG/FrUVpxXJxbD1+DM2VxbfqT37CzPq2gvlMIq/KiThdB9f4Se57FzPJ6hcZSIVm4PONtYHX4KDotaSoRNyFH2FQqpiAq6LqUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmYcCYfBJi0ZncfTxnmmV04EAAzsmluPoEzy14sUg68=;
 b=ETh0HkMAiKwhXT7ZIQnMZd+Z9Jr88W4F+XwopmCo6QxkVM/SI8+ud+hyLFEg3cjTgmWzckHzivPj4CKL1g/xwsAEfhe8nF5cBf3bd+EGfA9fPdtBRBvwcanjyoC1CmJvRfpo08SHcAMo7VxXjouMBXCC1U19o1hc0SYk9LWgec0=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR0402MB2800.eurprd04.prod.outlook.com (2603:10a6:800:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 10:31:29 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 10:31:29 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
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
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Topic: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Index: AQHWvovBrojMBFt1EECB86LxwqdSo6nQRb0AgAB8rICABirOgIAABiUAgAAMfQCAAAInAIAAAhyAgAAYuwA=
Date:   Tue, 24 Nov 2020 10:31:29 +0000
Message-ID: <20201124103128.zucizod344dgme4o@skbuf>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1839ef6a-70f2-4ceb-fbdc-08d890641aba
x-ms-traffictypediagnostic: VI1PR0402MB2800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB28005DCDDF91AA09570A7E36E0FB0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEsV4vo6UkGD/1YbVDbPL1HsSy44EBYJ1e+RjyN5S/ACfNiegg6jAQ/joi8bWB2Qs+WGR0ESOAN14x9b6a7eYguUK/CXMoW79JqVcdMicUlIO3blyc7moWKU3nLW177T2TFwHigtODJeN7gj+zFbFtaj6KUZkS1MAMk+I3J41Vrwe8BOGmWnkl+cuFc12Eo8LZt2/oBiUbcWeSze/P/mJEiAoMILTd1SBh8cI3u9ERLUCmu/oNM0OGOj31CLqxxtXBV4Od8YVS98PO7532bAcmVWw54+lSx8xi41ROFJJbX0l2/6OBCYtiWSYfh8hvne1hWKQ5ynnh0dGSw2Ugh3vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(33716001)(6862004)(26005)(316002)(44832011)(1076003)(4326008)(8936002)(478600001)(71200400001)(86362001)(6486002)(6636002)(66476007)(66946007)(9686003)(8676002)(66446008)(64756008)(76116006)(54906003)(6506007)(66556008)(6512007)(5660300002)(186003)(4001150100001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MvvHGRBD7llVtFN3H28T4LjebPHi2IAlC9VJrDtdU74OmMRkxyGMSD+qmT7FpifYQviuxTCcxwmmISjeqlPPGX86vHd8pSlPVFuujohIyhAX0e39TgPEeyyRI4U+hrueJzvWQFHNXCBMjXgy6igtKP3XiRocgXGVMZ4wwhsU9NERxDsUa4TmBHhaHvUaJRGE6z+2qGp/9zUP4Ztdy/2RI3+mLWU6Dus515hjTDN9W13OcTwX2IVL9lkumEan0C0jNYf9RrQUSjxhCEYe7B2D+e2+rs/R3PpUCcHTPpiILuFxwdTQNwovvonNIdnfCOqJ+lETLoI261+5a9h89QKzHjLWpKbaIwuqDeBiR2U8K7+QQb1KUcosDJqcb2xBGWZhDMZtPI9r0jGQvY5+sVIXt8RSpFUDmUdguXm6GmRCuRLSPk3k20bZ+yVXuPeqpc3Z/qTVQgfA1M6dQa5o9E1JM7dU6pkKMZ1RPU/DsQZGfwzHhtXaRweEG5rHtfHbz6CiqbBTc9uv3rzAl3nhGJrSqIEMIXE1FWuhTkChKsWUipupPdRBORWMthslrfv2oJbtW0/RCPladK0FWtFxYDNcWMlGzJrIckbJzpOGql/Qnwnk8YaYNhE3BIWSb7mTAAje4dHAdpDKiPa25xEcEoA1VoMtyOxi4clyGE6zFQ2eFvLK5PYJF1vyMaCn2K3X+9ylVEHuRxQjXCqezRYBzst2Ezfe7qZHNMZvHxRcw6cOBnzq8Q4yozJ/CUq/glfOiNMYOgkmV2sXj6IBXeNoo1IH+UYuebeksI8ZqIMC4Cs8P1SNjAni3c7X03yLBpAJIAXmfCGr6ohpYXkVZ3aqLWQ9HK/awJ8TsrKmcqjH3BiSy1MbO+SlrvocnHsdzCDC83nsCuKljsjcu8bkux2e+sbARA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85D12CB16FCD95419E232278741C5556@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1839ef6a-70f2-4ceb-fbdc-08d890641aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 10:31:29.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEjM3f6ReCWQD/A5yBhUIXyCpjHOHgo5zO5XB0I+64dCBpleSez9TyjLAi7EbjDmi/5KcUnMb7lPqT6ooV0uXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2800
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Yangbo,

On Tue, Nov 24, 2020 at 09:02:57AM +0000, Y.b. Lu wrote:
> > Am 2020-11-24 09:47, schrieb Y.b. Lu:
> > > Hi Michael,
> > >> > I don't think it's a problem in board dts to define board specific
> > >> > thing, like re-defining alias, and disabling any IP it not using.
> > >>
> > >> First, why would you put it in the architecture include anyway? That
> > >> is really board-specific. That is like you would say, we enable all
> > >> devices and a board could potentially disable it. TBH it seems that
> > >> this will fit your reference boards and you don't care about the
> > >> other ones which uses that include.
> > >
> > > In soc dtsi, this is giving default alias for two esdhc controllers.
> > > This is not board specific.
> > > That's natural esdhc0 is mmc0 and esdhc1 is mmc1.
> >
> > How could this be not board specific if there are at least three
> > different use cases the board can choose from - and needs three
> > different configurations:
> >
> > (1) eMMC at /dev/mmcblk0, SD card at /dev/mmcblk1
> > (2) SD card at /dev/mmcblk0, eMMC at /dev/mmcblk1
> > (3) no eMMC at all, SD card at /dev/mmcblk0
>
> Not matter it's SD card or eMMC card, if it's on esdhc0, use /dev/mmcblk0=
.
> Not matter it's SD card or eMMC card, if it's on esdhc1, use /dev/mmcblk1=
.

With the note here that you can't actually connect an SD card to eSDHC1,
due to the lack of pins for CD/WP.

> It's not related to board and card type, it's only related to esdhc inter=
face in use.

I understand the hardware-centric view that you are coming from. It may
be natural for you that eSDHC0 is for the SD card and eSDHC1 is for eMMC,
because these are the designations in the SoC.

But it is also natural for a customer to define the indices according to
their schematics and what they use. If, say, there is a board that only
uses eMMC, I would expect that for the lay person, no one would even bat
an eye if that was called /dev/mmcblk0. Whereas, if it was called
/dev/mmcblk1 (and there was no /dev/mmcblk0 in the system), maybe you'd
have to come up with some explanations which could be avoided.

I am only a passerby when it comes to the MMC subsystem. But in
networking/DSA, it is frequent that the board designer comes up with
their own numbering scheme, which has nothing to do with the numbering
of the chip. Consider this extreme case from
arch/arm/boot/dts/ls1021a-tsn.dts:

	sja1105: ethernet-switch@1 {
		ports {
			port@0 {
				/* ETH5 written on chassis */
				label =3D "swp5";
			};

			port@1 {
				/* ETH2 written on chassis */
				label =3D "swp2";
			};

			port@2 {
				/* ETH3 written on chassis */
				label =3D "swp3";
			};

			port@3 {
				/* ETH4 written on chassis */
				label =3D "swp4";
			};
		};
	};

You just have to go along with how the hardware is being used in the
product. I could have insisted that hardware switch port 0 is named as
swp0, but that would have not helped anybody.=
