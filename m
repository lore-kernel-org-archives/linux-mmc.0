Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8294AC63777
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184B5206E5
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 07:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lppuKq9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgKXHlH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:41:07 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:57920
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728206AbgKXHlG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 02:41:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDchsOBmvS60zZDOS9Z+dH+QNrvGQJi7tBHbA5t2/7746pd7qbaimoLyJVPYJSK4vVzJ+lpZmVmrfZg0g7uw06Ff85h10RUm5rlKpLhttkN9iUH2aAdgyw1IgvEuQdBAEQqzg1vnVc95+gj1xraGDbklsOpgvDF6as6Yvc/7/HDRZV/tWrA91KSPX3FlAsFFh7zi9bEyTXUJvv/6CJR4vjlrIN4iZdMJ9ovVSrTcRaINpAI3ZLYus8omLCw0PPJTftI4EE+GzDwgFPOjvySSnIxcTnPKtv+F75sZy7I7zI5SsPZidgbb+SiX90xhZlkEWEyuDAcsDsI6VBxSNm1VKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCFRG4Sc2ft6HfXvLuHLH0KUF4ONB+D3FtsRTlQ+fgE=;
 b=eGZ4JnnrNnycoZcqCZlzhWfSAfI332uKNwIL+/n+VHlciq7UPha0jL5qrI2e5Ush2uoQcYwr6/c2xRT6dudofkYtRY0epNvfb/EzvfXFkw5jmf9MyKAao+v/lgzfmYU2GMKIMCbdBw5m3AdZhoAxAVi75zCSolE24FJ0hzc6k0lQ2FZbmbiQEXz8rDCxQYgv2wRcV9s/awUpAdSg5bE9jQgh1v61jPTRGN2jAgmca6dqAfnPFuNITECHWQMMmWNxYZle5qd3sz5NBfvXuEFNbumGAucBWswX8mV2uHv8G/YS2Cl7g5DtSqC5+zJBwUskZul36e3pk/UKca3zPtEh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCFRG4Sc2ft6HfXvLuHLH0KUF4ONB+D3FtsRTlQ+fgE=;
 b=lppuKq9NVBZ5E5oSnZ3yrBBkINv2peFaTnVRMjjdyd9G1AyX9SBmsswgP39+17Jo4Fmh7bA/gQCIaF41qyH6m0Y9uGokL0LFr0N3mLjIOolEiSmxwtkB2tcPzh5tFe22+vXMa4Xhb0rGRDACbnhVHhV6pLCrLqRd6lpNGzHbYYM=
Received: from VI1PR04MB6896.eurprd04.prod.outlook.com (2603:10a6:803:12e::12)
 by VI1PR04MB5520.eurprd04.prod.outlook.com (2603:10a6:803:cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 24 Nov
 2020 07:41:02 +0000
Received: from VI1PR04MB6896.eurprd04.prod.outlook.com
 ([fe80::503f:883f:c872:63ea]) by VI1PR04MB6896.eurprd04.prod.outlook.com
 ([fe80::503f:883f:c872:63ea%3]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 07:41:02 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
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
Subject: RE: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Topic: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Thread-Index: AQHWvovBvcqJCTixR025fdiTeTkR06nQRXqQgAB88ACABimgIA==
Date:   Tue, 24 Nov 2020 07:41:01 +0000
Message-ID: <VI1PR04MB6896C22F6B304F365C3BA626F8FB0@VI1PR04MB6896.eurprd04.prod.outlook.com>
References: <20201119155025.965941-1-vladimir.oltean@nxp.com>
 <AM7PR04MB688536E10A0B35D75A9F8F34F8FF0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201120093015.duel3yx63cbya77w@skbuf>
In-Reply-To: <20201120093015.duel3yx63cbya77w@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc4f2a44-32bf-4bff-0349-08d8904c4b13
x-ms-traffictypediagnostic: VI1PR04MB5520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB552041F33184375FF2E1CB62F8FB0@VI1PR04MB5520.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJcNW1ZnEokvgTqjc49h2Iy1+BOeT63Ws7wVcbpd6VqaCqL3MArAh3QeuktuLs0zkpeGAF25wjd5lMo+ct9TF/8E5Nj2nggOj5wENGc55eXDBE5m4Hi2dTorLI1mvJUjeYWljs0jg2h2dSFqGdZufIR1SC3yDX3EGk8Z3NRUZynTJppG2DVqDsqHvUwfPMt2sg/Qq8scWdGe1E8a43r1QEHQLHm4ChJBYwXzWUgbtkW71KENVa7qXD1SyBJMIKhou68Vjzn/3w97Go+eiISP/QyreF8A0+przqHmLZxgr82ckNTuRPufvb0ASSQVt/GUAebq3TJrfZjsQzAEPN/Q3HVmaCwNJRQ58KWZy4TYwAZeThrIp32tQE0YykYuTtZ38gkwLMEUeWYzbq4mCqUOaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6896.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(9686003)(8936002)(6636002)(66946007)(76116006)(26005)(83380400001)(66476007)(66556008)(64756008)(66446008)(4326008)(54906003)(6862004)(966005)(186003)(478600001)(53546011)(6506007)(7696005)(55016002)(71200400001)(8676002)(2906002)(86362001)(5660300002)(316002)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S8B85Ec9myCnhQHUHwMUTnBZ12wHaNlKI8TFSOiNIlYwDjrScPY2RzAx2XcWime+XXe5qmNxAUjjwGPRRD8y6yD88kZQn3NKcGsCYmA+dy/5xYaWAF4evNllECVW0iTT4yDDgu1eCyjvvvets6qm6P8n13uPTBdi6knu3JsL9s7wYe/bF23OC2vU3EV2p+3pZh0ejtNc7m9Stv5jgT8QOJIdtQz63kmRq73FxIn8XFZD4xuiC/zIqoiks+EpvSYDbr1GbuGYGE80bLIsoHgBJ2KhIyqrjMrq/kYpaxzHqYJlfXWfTg0PdHr7XYL44FJJjhJgi9KLYlG59zYYvgOTA8REO+o4iTuE0pXmWxy46EEewaANBvAQM09ZD+Pdw4pjmKp61Iv9kkY7JN1xpX845gycsHM3UOBGfDnUBePMzTZVkxJu+LBsnlbh3FJPffb6DCZfUR5mP+EQjTORzdl669xs5cjZGuydit81J920aU/PxTeiD1BKR8k0yy4leM+UGHdVAxwAGSuton54XlajizwOpbsfmFA4kwTtPSrSaTc/dIj1VXz6GQmB0u57Bdbkc0SGkIHNVC4XYeNcKJBdFYVGTKs2lgMnPB6+l4hHcFinADZkuWHujFqXp5SxewM5plpMFpcWKhiT5QpLRz3edJv32ZHqnBAEVbcH6igzcMj+LXKliIc2ePrUaH7hqUyvfH5N2IPq3lIm5afJrP9jUo1Sce6rU+mv62F4IsemxoMFty8B9i8CfOR6QQRmWNll1rpBSkF/1tyeIcV265XZZPyGO5jTVQbNjyfmsj3J6H/N7PC/C4WIvUKNdE2u5DC1zF4+RBC6k8jyPHW1ZFS4Ro0/EAOQznYSs3zgtCJM+Bgf2TzfvWQGxEJ5nC8eFPmc6xu23DhYcN3aECV3LNVIYA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6896.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4f2a44-32bf-4bff-0349-08d8904c4b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 07:41:01.9049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMt+Ny2gVVve+5/pqKSq2WcJb+gRutCiILERbEEpqlwp8zW2iMNucVeQymqqFiHEvtICi/4Qir5QIey882CpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5520
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Vladimir,

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Friday, November 20, 2020 5:30 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>; Ulf
> Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; Ashish Kumar <ashish.kumar@nxp.com>;
> Michael Walle <michael@walle.cc>
> Subject: Re: [PATCH] arm64: dts: ls1028a: make the eMMC and SD card
> controllers use fixed indices
>=20
> On Fri, Nov 20, 2020 at 02:04:02AM +0000, Y.b. Lu wrote:
> > Hi Vladimir,
> >
> > I have already upstreamed a patch for all affected layerscape boards.
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit=
/?
> h=3Dimx/dt64&id=3D342ab37ecaf8c1b10dd3ca9a1271db29a6af0705
> >
> > Please check whether it works for you.
>=20
> Thanks, one can tell that I haven't done my due diligence of checking
> Shawn's tree first. I'll cherry-pick that patch and carry on with my
> work.
>=20
> However, the fact still remains that Michael has expressed his opinion
> regarding mmcblk0 vs mmcblk1. Do you think that we could make the
> aliases a per-board option instead of per-SoC? Consider that there might
> even be boards that only use SD card. It would be strange for the block
> device in that case to be called /dev/mmcblk1.

I don't think it's a problem in board dts to define board specific thing, l=
ike re-defining alias, and disabling any IP it not using.
Thanks.


