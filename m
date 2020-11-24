Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA75CC63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C89D2075A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 11:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QQXOkv14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbgKXLPX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:15:23 -0500
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:55713
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732485AbgKXLPW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 06:15:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrOZxXo4zX2tpBkDRymgzjh0tXhueGhVtWOO0joC0unew5JQUdTtHQ3MIuSMxFAPH8DsxFKRgs8ANWaoPvwbntMRdRhntaH4Mobxun9tUu7ujq4GAgWg0OO9gETbd09uBKxD5I87c9G8UOnWElaWNG+t5dMFa4xgN+2FefnwySKPbEMh23rvhO+umCWe8Mw3WUXnXkgLNMInImQgNKFHDWIpDkGMnggTNJJxUjg5lxBamCFvcAYD2PB+nGLQu3FtZyz1xwTagDRRsxpkUF6VcRHXG1wdm8glLQtKRDrZAEinQd3g1lUp/J5Cgr6KHon07mZiDUCY+KRBMlbYlv26GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH0E6AgJdd//jc2yODcOtHQ5cfdkQckVgaTV5MiHJJQ=;
 b=BvfMZ+r6TyHAtxB04f4IcGmGPJM8ec8/LxOK+fme+SN6w11BLhgVLo1EMp1gb/MOimtCOijan3FlNBLECubI1ngh5UZSLCwPnK28Wd+mq+Kqd8HnZnZP+NpHilTt5Z29mloVVQWDYCT7utK/Pfhd1AaK5In0dfEUfI2eVY5VXU7xas5zQAQK2IXUS1inM9neys7Oy2Rk4UAdi6em8HRLD902/UtzVXHOOUeaGIYnIVZ13jzfQMUAx3qrYxLdsYf73HNkrhEKmh+jwiQFmrZU2iUw8nBAskQzP0bND7xVOH6W6quGOyKJlXby/3/GFbB+rJ5ekUID8ZbC75SrffQZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH0E6AgJdd//jc2yODcOtHQ5cfdkQckVgaTV5MiHJJQ=;
 b=QQXOkv14dCyGYPnZh4X2bk6jl1x3D/DzThdzc0FFT7blJvRb16HT1YM3HUihVJs5dUTUoYMumu+cYVUzJOQDfBzK3m0mPUqhTnZC8RgvfGjnQalOwqJ9YG8eq11qtV+ioT7gFu38ZS42LPCD4QIKNx6E/dkjtlZRFWLAwC30qvc=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AS8PR04MB7608.eurprd04.prod.outlook.com (2603:10a6:20b:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 11:15:19 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 11:15:19 +0000
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
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIIAAB1IAgAAEgOCAAAokAIAAAQaQgAAZ0oCAAARV8A==
Date:   Tue, 24 Nov 2020 11:15:19 +0000
Message-ID: <AM7PR04MB688567CA698191E2DB73DEF5F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
 <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
 <71a86b0fbc95892f8fd240e0919e7e23@walle.cc>
 <AM7PR04MB6885CA8A965A49C456454254F8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <3293d698bf26ecf08f22e7e2ffe55e74@walle.cc>
 <AM7PR04MB688518B8AE836C2CC37FED6AF8FB0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201124103128.zucizod344dgme4o@skbuf>
In-Reply-To: <20201124103128.zucizod344dgme4o@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c72867a9-3ef7-444e-993f-08d8906a3a46
x-ms-traffictypediagnostic: AS8PR04MB7608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB7608AB51C1B4C6ED2B147AC6F8FB0@AS8PR04MB7608.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aY0uZxdXLBpw+qojlhfyOD4vQW70AQYg8d6pTpTPxjHOYnPqIKaWfIOyxqsJHqw4QJZDzpmqbJQN4aDnyVYTPcGqhh3rEbXgbAGk7xhpYmlTxggrR2hPd9+KzJ7CzZW8fCmGlK+KYY9LcdZsqvgiIZrmBlLFbbZLIFw9eSidNoTvFCS97SeqgoOb6m/zFAG1NNZ5vXheJv3hfCofTMp/N1qY2vKqOeTnDau8t3dbuQxlEhfSVDUBmXCexjmABW4HOdgP2hBryicu9LPhQaq6vZcCWY12PR/gJGV7MCRtcK3z/8yV3h1Jd7IIjkQ88B4zZB5d/JN8LB69rVrHevgQJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(33656002)(55016002)(26005)(83380400001)(8936002)(7696005)(316002)(9686003)(66476007)(66556008)(53546011)(6636002)(6506007)(186003)(2906002)(6862004)(4326008)(66446008)(64756008)(66946007)(76116006)(52536014)(5660300002)(71200400001)(4001150100001)(86362001)(54906003)(478600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NByRFBp3F5hDGNAk1BAxE2OENFAqsE2LPfVehh3ZGiQdyVZ8nBB32LlYu3BR2zPpX/apRx4hakeC0oZZ/FbWsZSVK+Mb+/youbq82VlLqKxkXulDh2ORLf7Ca0rcKhtmYxhBq7K1/M0JAjEZDzQiK9hc0L8yalcR0ohWuKp5iYUMtfaxHl7+QsdhW5p6v09HR493joCZLcTXc3AHm2b83fiaSZyiHPKhQ0i/eUC8piGZ3Pi371b9A21s573+SfejM91sliVSZxYK2o4ZdeUBlKsKsvv7tiQD7biDMSQCeO60uZaNT2z6gHe/+ppyHmxJ2sdwnP28p5P13SYqG4nqacN+X3XD/jL49mgQWJUqme+s6E54yTCZD8aSjA7WDk6R+XuTSMApMMMYWtVFdY0FGdTNXEYishCoF6LUH0u96bypG9Qutn8Es6bzBNY/SUWlfcnnq0Hs9a1au9Y2naGz8B+QVxEzQZeW/TzINbE7i9498d9K/VLvr/ntHHCpZcuITJyGPqTZZnW1jMPHqqKdAlaI5Q5Zbn/aE0Q3Sl9BgzbcZ4dZScbPw0C29gg0LAcEiNwm0AWwrAa9gMefBE41aJC0wNKWBRbzyRmmrLiJvXqgDGau7emkKeVYt7bioWHIYrEAxf8nrbcKG3z5NyHKBPbouJhHEXJrfHXgJkp9VoYNs9bckfOdfemzZJUP7zaEg83D/it1pM/8OAqOLhKfsZy3F8cuN+ptM7UNLap3jxb0G8uDhXglqRfX7X3pkIiG19SWk7a4MCihk869fKFgiP8WT+sptVYKKIQRd4vqfeHGVZ1H+NvuoeAD7X39QL4SwG/4k3MNZmVzj+Iqrn2al9BEKEqUh6K7bm8BfJX0sc1fdPtKNESYYrCjb8DDWnEN57uU/+383Ir31pjr1vrG+Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72867a9-3ef7-444e-993f-08d8906a3a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 11:15:19.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueAEvh+gG7fsN/KXSvrsQShy2hjRS2lqZ44YfvI+UDamQo916A8qcRIzkRkODlD86LbZ+cZHjwt+xYBDd0t/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7608
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Vladimir,

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Tuesday, November 24, 2020 6:31 PM
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
> Hi Yangbo,
>=20
> On Tue, Nov 24, 2020 at 09:02:57AM +0000, Y.b. Lu wrote:
> > > Am 2020-11-24 09:47, schrieb Y.b. Lu:
> > > > Hi Michael,
> > > >> > I don't think it's a problem in board dts to define board specif=
ic
> > > >> > thing, like re-defining alias, and disabling any IP it not using=
.
> > > >>
> > > >> First, why would you put it in the architecture include anyway? Th=
at
> > > >> is really board-specific. That is like you would say, we enable al=
l
> > > >> devices and a board could potentially disable it. TBH it seems tha=
t
> > > >> this will fit your reference boards and you don't care about the
> > > >> other ones which uses that include.
> > > >
> > > > In soc dtsi, this is giving default alias for two esdhc controllers=
.
> > > > This is not board specific.
> > > > That's natural esdhc0 is mmc0 and esdhc1 is mmc1.
> > >
> > > How could this be not board specific if there are at least three
> > > different use cases the board can choose from - and needs three
> > > different configurations:
> > >
> > > (1) eMMC at /dev/mmcblk0, SD card at /dev/mmcblk1
> > > (2) SD card at /dev/mmcblk0, eMMC at /dev/mmcblk1
> > > (3) no eMMC at all, SD card at /dev/mmcblk0
> >
> > Not matter it's SD card or eMMC card, if it's on esdhc0, use /dev/mmcbl=
k0.
> > Not matter it's SD card or eMMC card, if it's on esdhc1, use /dev/mmcbl=
k1.
>=20
> With the note here that you can't actually connect an SD card to eSDHC1,
> due to the lack of pins for CD/WP.

CD/WP is not essential to support SD card. Both SD/eMMC are supported on bo=
th eSDHC controllers.

>=20
> > It's not related to board and card type, it's only related to esdhc int=
erface in
> use.
>=20
> I understand the hardware-centric view that you are coming from. It may
> be natural for you that eSDHC0 is for the SD card and eSDHC1 is for eMMC,
> because these are the designations in the SoC.

Right, from hardware-centric view, it's natural esdhc0 interface is mmc0, a=
nd esdhc1 is mmc1.
That's what I explained for why I added the alias in common soc dtsi.


>=20
> But it is also natural for a customer to define the indices according to
> their schematics and what they use. If, say, there is a board that only
> uses eMMC, I would expect that for the lay person, no one would even bat
> an eye if that was called /dev/mmcblk0. Whereas, if it was called
> /dev/mmcblk1 (and there was no /dev/mmcblk0 in the system), maybe you'd
> have to come up with some explanations which could be avoided.

To make a product friendly to users, it makes sense to define different ali=
as for controller in board dts.
But it's not the reason to remove the default/natural alias in soc dtsi for=
 two controllers.
What needs to be done after removing them? Add the same to all other board =
files?

This is just my opinion. I don't decide on this:)

>=20
> I am only a passerby when it comes to the MMC subsystem. But in
> networking/DSA, it is frequent that the board designer comes up with
> their own numbering scheme, which has nothing to do with the numbering
> of the chip. Consider this extreme case from
> arch/arm/boot/dts/ls1021a-tsn.dts:
>=20
> 	sja1105: ethernet-switch@1 {
> 		ports {
> 			port@0 {
> 				/* ETH5 written on chassis */
> 				label =3D "swp5";
> 			};
>=20
> 			port@1 {
> 				/* ETH2 written on chassis */
> 				label =3D "swp2";
> 			};
>=20
> 			port@2 {
> 				/* ETH3 written on chassis */
> 				label =3D "swp3";
> 			};
>=20
> 			port@3 {
> 				/* ETH4 written on chassis */
> 				label =3D "swp4";
> 			};
> 		};
> 	};
>=20
> You just have to go along with how the hardware is being used in the
> product. I could have insisted that hardware switch port 0 is named as
> swp0, but that would have not helped anybody.



