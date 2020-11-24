Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39924C63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4BF2073C
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 11:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1gpM2Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbgKXL22 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:28:28 -0500
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:20426
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732849AbgKXL22 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 06:28:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwrfn5N7plgdlz11hyjnfdF4I06UTYUio4hDGvm1X5sFKf6EaR4CkGXo92r8aUMErGKu40rnGy6tgXa+iLJxiwTVuIhnaa8dWyb825y88az8IhawF5yfabMY5c/GhG2bF6PdlpznkD7/6eyNQEHjh1uaTRPgbB6/rkjYhINIpVnPZ59Zq55wKb9AmOjJE2jhMuIF4mz4K6QllphDW1Jrl5/pfoIQJ9Uzn0l0izDMjVPs4yjMuQs67aE5RHLbVIS4wZ8SpzQEnfFQeWtST/UOjyPXDQqDa8doaO1vmMiwNy27wsOAw763QBTj4pnznlP6LdQGT7H2OlOnzNpvGDa1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1MALWwujwbNysiYh9YDyT7LXmxOl5+zy3PgRyCjRdA=;
 b=jfolN6WOF5bqJ834aCAhRJwx1ioJW6A69g6Uq5eu8TGYUF2EJMJD9AV+8JDJZD0Xhs9moAjD0woJ6WYD7GobgvVS5voHSqjFCqE3npoUkRTnMdQeihhMQM4+Hoq3O28axXkFHzekc3DDliaSiVfKXODRykjk0Tg5tcpcr5jsYQaivlU7mFYLKrwMxfh15PDgFksXWjrH+btzHzxews1JqectmkokNNXGnWndoCvrLmxVZCctksJuGXkN0n1BZzQVIBaN2Aoa0fqTLubgbK1SDt+b8Aln5xli9Z1VJBW5fe6X1gpoIiNlGJkVpbnitizctKy65rYjsJBQAWo8qYa23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1MALWwujwbNysiYh9YDyT7LXmxOl5+zy3PgRyCjRdA=;
 b=n1gpM2NlcDKJdbPgabKVkkDpArwnfjoe6+LianflGZFg1B1EFq4cgT6XrutrCS1vxMdxvyEaLnw+IdalNHlGY8S22NSU8c16LkST0uG0jdPOTFG9uieqEYa2ZqmbBZCgq7b9e4aSx3oIFRZkvKtZKB0Xk1v/094XxJKyTDVCD8c=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR0402MB2798.eurprd04.prod.outlook.com (2603:10a6:800:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 11:28:22 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 11:28:22 +0000
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
Thread-Index: AQHWvovBrojMBFt1EECB86LxwqdSo6nQRb0AgAB8rICABirOgIAABiUAgAAMfQCAAAInAIAAAhyAgAAYuwCAAAxAgIAAA6YA
Date:   Tue, 24 Nov 2020 11:28:22 +0000
Message-ID: <20201124112822.2ui57jmoc73top35@skbuf>
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
In-Reply-To: <AM7PR04MB688567CA698191E2DB73DEF5F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd422aab-e6a4-49cd-cbc1-08d8906c0d58
x-ms-traffictypediagnostic: VI1PR0402MB2798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB279867BF4A7C90730568C684E0FB0@VI1PR0402MB2798.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHfKnBVv/CFKupf0Z8hH87eD2m1wlBg/8y14PEdTa5Pz6j+MFgNivbVjCEE0KEUL/F8WV05uQAQ94IK8/PCjtgQsv3fIb8na5yZpmjeidVcC4iLLZmuV9VA1aihM+D/93lPhTK0rpF/ZtB+ioVn8HeJmNwuDQiDCnYU0W3hoYFMDoSCZHPsBUYR/ocB3/4KyQfIpoL0E2anYcsKghDAfeXkeVAzwcbJKfIpkniUVxXZ07qDejpvKxIHjzyf9bE2XwfQUAiZBOTFxOT3F9Uw/XE6GXdUqY6JzE8ofw4LjgYfcD6GjIotDwL6GGCiEYs1mENXVF46Nzdby3EsyFB5N3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(6486002)(186003)(86362001)(9686003)(26005)(2906002)(54906003)(6512007)(316002)(5660300002)(8676002)(71200400001)(4326008)(6506007)(83380400001)(6862004)(8936002)(1076003)(44832011)(33716001)(478600001)(66946007)(6636002)(76116006)(66446008)(64756008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sBQ9fthYuh/z+j1Dzl9JnhzL8M7+3ledOvsEbLXAbWTv5OqNflZZ0cJkMYars8bnZlOtbcR5gMGFJ5MxmyyIbitNJGhR4p9FbT/sZ8uGeZT+OEeK7tpbcZpki09+/PNFBumJPfxS3HIEzMgEGiqBezdCjCGEkKHnYGZbIACuoAAGK7TvdeNHHhNzldjBKgb1KZp8SHz+4CSM/wcnmTRVCthFQiu7O40lwlFgu9R1PyzxJ4439YqaMMA1TPGMPG5Bfgzwe/F+JRiRgLV19cmNuoBxy/ZXo3L7HvaMosWpKlruk5mX4BKEsfku2H9yFMZ7Beqjf7GLfk9Zc0zcRLhMOJKVMYTzohh1HoB6iuY5lhc+sZLoQdBvojAkfWUskTAaa6+eqIXThXnqdamW4x3Wjma5QWPAhGuEvcfKlnBgPe9mS30ldOjexR6zLaUGCY3ap+mOMVc4pqTflvE4EwRuOj4xNmSvuYAS8OXAa2I5SNAUHTaJCF66HTQidi0PWbLi1NNzF9cHYdMEan2PCp83Y4AXWNrqvatOfsm/ix+YdANleeVjQOGP3qtZ5XSra24GMMUbWGOxrSEKGUH4+j7oM5POtUmO90JpVBsBana2PFl4oq2+smlWeAl+3t/Oem8FbcxNgzmfWcbLX0RO+STn5ZtYN3ms07Uh/rM3WEIvERfEgXVckw5C2DGwvKQWdHpErSnqIVY6KjEEHrztfTNuJ+pEklfckMyDDpr38jpmt8PU2NG6XQbgdHR8VH+BoQmmDnb6QqUNAxeRu18JL1iJgUHia2RQ2Gtf5jqYx0iza6YZ/QPvQYBGzodVUiYaC9/gThHNKqWklg0ktwYnU4NeHLRHtHQQ8KpDTB6O1Eb9d+7diBabK88nWyJAYaVf9GumkseLvKrwAKZH0TuMiSdj0Q==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39B62B368FDE7E45AE289D15C1B5D774@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd422aab-e6a4-49cd-cbc1-08d8906c0d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 11:28:22.7126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpkoe+9NepFdi81/1NYrLetf9vzOFnzg6EfaMfuGCjrsto3x2NmpmVcXkrbnxKS0Uwe5FyJH8r5ViLidz3GLzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2798
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 24, 2020 at 11:15:19AM +0000, Y.b. Lu wrote:
> > > Not matter it's SD card or eMMC card, if it's on esdhc0, use /dev/mmc=
blk0.
> > > Not matter it's SD card or eMMC card, if it's on esdhc1, use /dev/mmc=
blk1.
> >
> > With the note here that you can't actually connect an SD card to eSDHC1=
,
> > due to the lack of pins for CD/WP.
>
> CD/WP is not essential to support SD card. Both SD/eMMC are supported on =
both eSDHC controllers.

Let's keep that discussion separate. While in theory you might be right,
I think the real-life complications associated with connecting an eMMC
to eSDHC0 and an SD card to eSDHC1 will make everyone avoid that. So in
practice they are still single-purpose.

> > But it is also natural for a customer to define the indices according t=
o
> > their schematics and what they use. If, say, there is a board that only
> > uses eMMC, I would expect that for the lay person, no one would even ba=
t
> > an eye if that was called /dev/mmcblk0. Whereas, if it was called
> > /dev/mmcblk1 (and there was no /dev/mmcblk0 in the system), maybe you'd
> > have to come up with some explanations which could be avoided.
>
> To make a product friendly to users, it makes sense to define different a=
lias for controller in board dts.
> But it's not the reason to remove the default/natural alias in soc dtsi f=
or two controllers.
> What needs to be done after removing them? Add the same to all other boar=
d files?

Yes.
In fact, this is also the reason why we prefer to have:
/soc {
	esdhc: mmc@2140000 {
		status =3D "disabled";
	};
};
in fsl-ls1028a.dtsi
and
&esdhc {
	status =3D "okay";
};
in fsl-ls1028a-rdb.dts
and not the other way around:

/soc {
	esdhc: mmc@2140000 {
		status =3D "okay";
	};
};
in fsl-ls1028a.dtsi
and
&esdhc {
	status =3D "disabled";
};
in fsl-ls1028a-rdb.dts

So, in line with that, I think that the entity that enables the node
should also define the alias.

It's weird to use /delete-property/ if it can be avoided.=
