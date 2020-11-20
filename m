Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBCBC63777
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF1422227
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TrjSCPDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgKTJaW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:30:22 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:51329
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbgKTJaV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 04:30:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4RVJnr0qlNUa8urc9T1K5Ci4CnNtugWmvDricMaQKc9q74ELeQFohp5o64N7+vT/6ifPfYv2Dao4Iy4UbNhzbSVQ/+SdxJC631hjOFTTPFZBXkaNbu+kwUWtgJVxfxWdmo6o8Kg6MDXsHoNZwSiSrGADoUeGhdikAIr6cwTMbmY5are5UiI7PeJKalkdqCy4TFchZSLb0DHxn48xlEjWzo3MLe/F90QCpH0H8bNR+Fxa/fYXm76RqE+HjCTEcNAUsI+/5tYe6ub4+qnTlegw66oESEKaOwO7ngRcHTQPVVzYQPmlIfYJt/dgmvLdPStjPN2fxaUJoS7oaDmC8HYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBM15V8blh8hHkC0R7jXZPtNBh4BS+G3h9/KNJ9KXh8=;
 b=VMRc6a5o7ePc79LysxXhwPw1gobZufw+lTmzQFh8cE9fOXQ8sL71uYJdsU4rixNAv7ysMMhyO4hAuBH7+L9MBRA5PRuH361yt/eQ+wKlANP8yLXZ+01zrE8f8yqzvlqxIRUxU4zEoSI/BMizeUMBgMU5m4qb7qQ8hgPdbcMTnSQuNQsvm9aMDxJ4n+e+qPcrDd6pTFEujpJ6+s3plYpx4oKNq0Vnr4ZXl3ErE6QqZkjUalcOYVnZp0gNF6MFXpVLNd29DkO3AYTizKiX4MeefxtpVKCwBfJz0/sVoY/7jxFQFXRS9SprRi+dZ12GhvFMSB/nyXChup37lcn962J6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBM15V8blh8hHkC0R7jXZPtNBh4BS+G3h9/KNJ9KXh8=;
 b=TrjSCPDcLnViKSWvttsGxsDUawtiDEPElwyizmXF6QwaY/QBjWAT6ikYbr1oZvlMEG5LuRSn1UAUUQGAxiKx/jNl7glwK+X+KY7L6hBp/ip2jMNoAUz2PL8jM9HdpMiQ1rVkHhectGKIvazDzpfvgAzRVtCsYNJxOaKeensZ4jc=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR04MB4429.eurprd04.prod.outlook.com (2603:10a6:803:6e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 09:30:16 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84%5]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 09:30:16 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Topic: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Index: AQHWvovBrojMBFt1EECB86LxwqdSo6nQRb0AgAB8rIA=
Date:   Fri, 20 Nov 2020 09:30:16 +0000
Message-ID: <20201120093015.duel3yx63cbya77w@skbuf>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79227e0e-fed3-4680-d01f-08d88d36e416
x-ms-traffictypediagnostic: VI1PR04MB4429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB442937F4F4B8C152ED30E7D0E0FF0@VI1PR04MB4429.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYlvYTqJQHwpnZOsfccFeEP3rOpHh5vPS2ck3GLkdaZjt5OwMXGRQYC3FkOgf1AdY/TsLnxfPki37am9io0OWc/skyEGofeB4ylvE6VGtuW4XLsZoFZET1Q8ln2ByThMYSJUHKkDbNyLcBhwfvM43WvUJM8mAy346haNx+tpafOkjvEWN0CEsAp/3n0MeD273onkfHvA252ja6KhAUfYXygwa8oQNWzf5VOMW6w8Fm3iZopauxZrX4ij/WYEymwHAEB6wXpyKu59tLqhz91csaWs2jHLYMz5Lhcq4Jo2D/GhRg5bte6nrAQJdI8EjtGwLRkacmTmAsbI4NlDPPHF+JFyVNNygIFYgKoxXV0DK5extAHIkcrFXCK4+/TiwoZ8FFAqR9zgroo7VuhqOZy2uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(66476007)(83380400001)(76116006)(64756008)(54906003)(26005)(8936002)(4744005)(2906002)(316002)(8676002)(33716001)(86362001)(186003)(1076003)(6486002)(6506007)(66446008)(5660300002)(66946007)(44832011)(966005)(71200400001)(9686003)(6862004)(6512007)(4326008)(6636002)(91956017)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kE5TJL+93mgsD32rMxQsn2ACrO1L4nZWgBhO/0wd/u3EQn32xN3nLEORvqv6ABgsaxabkj3t9FeAZ+bSPRwg8bNDMpE1ia1H+T6H6eucW2g7v0SE4TSQwjYQz0Tp8AgVPMVdBfDGM/FUR5SuhRgvoH1ThUGHkIBmzD1gEfUlOZ3lHHr5KFLdHtha8inviA1PDgyh28s3fssNtS3FWG9R5fX6ebcxsmwART/Kxm8Fq9u5fFuHtZdoWQgoSTFG8gye1IFV0NOve5j9eULiC/USuc9ezBoxPeF1eiCELi5el3DAlSpq8FrJK3kJWAl318KxzBZZj6V49x/RyNb8/42iMc0F0hfuGxD6ciffaoorTZuDv44ASF1KziVypA9Z3G/6mAfxXPJUrojnUEcqcW9u2ezynqXL8HU9BuogR5lCzzApWaXDOOOIa+1WnhwLjq+KqqtTYrbfv2s9jhEnF07IibAkdfq8LCpddU3F32AxxEeD2vNv7YBlV7nsIIJs5xENmuiLf4JdkzI8XkGmFs1M+PzzRKKeMDUCAjgXgFys/HMDJcbYW2Ma9j1gnuC+auSt4Gbjz0AKbyiAS8OX3utcU60wKzN1gjD9Sz6gcqu81aEWHLNEG7GdIdDfFtXFZS7eAb31BleaTPP1AkVodxxEuA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B4C7972AB25C6439AEE8F367D94CFDC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79227e0e-fed3-4680-d01f-08d88d36e416
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 09:30:16.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUnUUh2ifwYv5OfD0cgk3EZByKwLKfndKmpncQLw1AqzK0Z94lC2NAuI8hT2p7BpKkbAVoIt58EFFIiKazZElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4429
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
> Hi Vladimir,
>
> I have already upstreamed a patch for all affected layerscape boards.
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit=
/?h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
>
> Please check whether it works for you.

Thanks, one can tell that I haven't done my due diligence of checking
Shawn's tree first. I'll cherry-pick that patch and carry on with my
work.

However, the fact still remains that Michael has expressed his opinion
regarding mmcblk0 vs mmcblk1. Do you think that we could make the
aliases a per-board option instead of per-SoC? Consider that there might
even be boards that only use SD card. It would be strange for the block
device in that case to be called /dev/mmcblk1.=
