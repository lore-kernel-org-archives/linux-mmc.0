Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F0EC56201
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 16:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F4720719
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 16:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Txy9T5On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKSQcG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:32:06 -0500
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:10328
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbgKSQcG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 11:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbFQXqEQ3xF8sXt+62vE/EsSkDy+kVEEQ+yttP9Sx/OaBJ92WETFlW5ryR2Lg8GZ2EjV7X9OiIQqrEIvjAOVJ4V5kTTNeMFN7hZ+Yj9i01L+nTpUvYqoIV6eXjHTxRkUb0qVVYw5TLSVPqaUOi62CvuBG6LXaUsqeQkrXyevYOWiwj4VOlPjzPtsjMcoKz16w3WCvN2Dtk8s4OppGph4pqFxS4u3A0QFNIz9UtJxgGThMkao2/Qjzxv7voXOwCHWQY/XMBm59Achsu/BD5B+ttZo9+DbX4/Qccxz7xFqYxaifvK4t60eMIM7L1oy1HwQqI6brP7lsEqPS8VcJgeLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1YtYL6fPnBxzCmEZ7AwHvWeQ+Bi4jto4c+VWeZfKbs=;
 b=NH5JD/xNQX0r/NUgB9GtyWsisdgebMseRJXSHZb3l2hsP4D0j06uslJx5Xq71FTRvESlivYLOHp11ONM2fJTYPipgoMWY1Q1EMt+9ZRaUhzb/qn0lyOVtm+1pm8q4d8wnlsSKPxDhRg8S8JZCtUh03HjKHopG8UOnX90EXICgX0RGRQI5ph41pW7C6H2InLSkFmGOpgqWyoUZxM5snoQ9D+qIGsF+NyiBqYvpEyngi4TJucKETlZQl/YzlGHLf1SzyTS90RCgEzopXQGBn2us+ahvPoxYmfVgm1DsagfSzhV6y1i6d58vowZ2U3IKHbm7KqFQgYvW5yBDndrrzQQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1YtYL6fPnBxzCmEZ7AwHvWeQ+Bi4jto4c+VWeZfKbs=;
 b=Txy9T5OnkjNXE2RjKVElDpRku1KgqpMqIVdEo4Eg9Jmv+dSSkTNVZ0wYYJpRZzO9wPMaJcQ5lAz+blh9/Wu8eJ2VWKPIqkUnJoVUE2KnpIzESBh/p2JLwB5zYNE55OT7BvGG6Ef8MKidkDXhl2ECmlIXXwr4SBel/mymk4tINJs=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 16:32:02 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::2dd6:8dc:2da7:ad84%5]) with mapi id 15.20.3589.024; Thu, 19 Nov 2020
 16:32:02 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
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
        "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Topic: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Index: AQHWvovBrojMBFt1EECB86LxwqdSo6nPn2SAgAAGhgA=
Date:   Thu, 19 Nov 2020 16:32:01 +0000
Message-ID: <20201119163200.g4uwoemh7n4c6ogu@skbuf>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <e1926b2c2cccfe19f66562b50a686088@walle.cc>
In-Reply-To: <e1926b2c2cccfe19f66562b50a686088@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9be977bc-def1-4992-15d4-08d88ca8a4e3
x-ms-traffictypediagnostic: VE1PR04MB7326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7326FEA72455A52D699CFBB1E0E00@VE1PR04MB7326.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/ZF/9tkITFKU88R3G960zT3dXLhy+740jO0b36YjGjrrnw5Mes+k8eC7ncOP6azbgIl83WrnAPJokEB69CvEV1DWpNLWVagyZ2BHMcUc1AwfeMJrgfgOnJ3iQjIopCk9KzEI47cLs35pDmQ+J6x6Nx9ECQo1eGxdKqiT/r+vf61jy3OXZti6UZN5WORNO2wtaqvUNVaQ6quIyWNLKoK4TYBZnSuFhAR1ANweyYHjJAky8ezhQf9ez9a/S9u3EACua8Ek3mvFU/6Pgn+feQ+LTFiD5Iy7DaQdq2jW5yCSiOJcmPAovzvXkIYSGA0oh5dlDmNzmXv6DOtFjSS676u+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(26005)(8676002)(33716001)(86362001)(83380400001)(6512007)(6486002)(1076003)(8936002)(9686003)(478600001)(71200400001)(4744005)(6506007)(44832011)(5660300002)(66556008)(66476007)(316002)(66946007)(6916009)(2906002)(186003)(64756008)(66446008)(54906003)(76116006)(91956017)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MACMS9fvQEOiZsmMW8GRtOeGM0CPCiqm4kbT/RxCCrMK0XsmklQ7wmwgfC7jr0hgZWsfvEu/yxiyUgh2pXViENNzly4eBp5bvRbLT0FAy4CREjq/dHLsezLDzfOJNAU/ApMBCayJa24p8TO8xpgEry14CLi1aB3G4xy/ebdbP8xVevaXzATx1CZGT1fhHJvUxTHue3qBdBRXNAjdRz7m82RCMZ63a35yU2L165ocEmfQwY6k/R9v19UXxmeAXUimoiXjjDB/QIKJaMXRKt9HJqu9AejbuwbjGesQbDhtKHhtxFBNgJoqZSODrG6/J6JBThBwcb0TO0N4vs6cV5VuJnHlu141/2+OQRLn8BLZPMvUkeDfBRuP6kyVeJqpoKDGyu9E/C1mTGTH7IBYNuLt0Z59FWpDdKVKO4+fBUBR49Q1F+YB9bchqbJiYi48/DNJ+yhyAmr1HQmiOo1pVNSBFjXQs1au4OwoWFrhXj6hGwQyEwTL8UL3wVZuJ5d5jF5Qk52wYvJRek7bsUoGC4173DKjqDSPvUDab5c/McxedxusXO9rZqvMvP76SyWgInNovMLQaHKvkUv+ZH064PlhvXe/y/EOueZZR8Ca1Evc8MCByh98ARIUQlVKF3la4ZE4w1+rsnV//fb5HmAuZYvONg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A07552AB0D30524D9F40499CF219D7F5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be977bc-def1-4992-15d4-08d88ca8a4e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 16:32:01.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LDzHqtU62k3N60CZWw6ajZ1BBgZUtlE32BasWWovg9adLPUt2mCFlu+hB5esQY5s2oAWKNJlX96KpjWYzyV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 19, 2020 at 05:08:39PM +0100, Michael Walle wrote:
> Could you change this behaviour for the sl28 board(s)? I've always
> found it counter-intuitive to have mmcblk1 being the eMMC on a board
> which always have the eMMC populated. All our images uses UUIDs for
> the "root=3D" parameter and, technically, the order wasn't specified yet.
>=20
> So I'd like to have the eMMC as /dev/mmcblk0 and the SD card as
> /dev/mmcblk1.

Sure I can do that.=
