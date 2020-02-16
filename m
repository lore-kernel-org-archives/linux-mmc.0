Return-Path: <SRS0=HRWE=4E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC0C3B1BF
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Feb 2020 07:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E42E20729
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Feb 2020 07:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pT21TGLv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JvJofQWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgBPHSb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:18:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6493 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPHSb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Feb 2020 02:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581837527; x=1613373527;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Mm7qFMixeaWPyH2v+H8vbGckRcUqfbCPJKUBeTvg9hU=;
  b=pT21TGLvFUEvNCYdUxvargAcLFQPKpQZbrx65NJfq1xuOyD1gDXEMSOr
   0GPE8tpWtDrbOAeTalEjeiKg64UUSEdvNAbHUIJMA2TuNTgq9RxRW2VuE
   xDyBSoQsffTtlBgde0Ow6bS4VH6eemFxDjmWQbjApx5qgls/PmSX62vlM
   RQ6UpHWFWjIvesIz/1Ghc3sn6t5qYIZiYMvja1dc92el3h+yjSuZPXK3+
   8eRa4rl/ljfTz9uDDirHrTJU4NKkd//J/+dab/nC3V2aJoRPQiWVdjyZD
   W7LDpc9ctdCrLzIdMFxj6IjmEm8DPdrkdeOb6Fdw+vciK1+98Q89gk8H7
   w==;
IronPort-SDR: F9OyG3ue9Iq4lDtm1Q18YD48B9ZcN3LHDhiXd6A7mxWkkNrqKpqWwnmBhfleulNUHbdKfJp1QB
 A2Q41NoOlLtMoOwXohNqATdkv1mlj5brTastQMEcj76v5hP0wEyLh/5CN/BzIHg1XuvplGfz0s
 q8mZbKgUs7tJiLXZqfmALI1fr/hJbM9M2ZXxSviiVdAIxOy5AWOoGUjTh+3way/m5a80yC2OOo
 9scnPOpxOHz5nhQTB3blpBmVyGespt6ndrRr01s/gzCNDrfnJkjC2R1mi4BqnVUCbOt08safhJ
 nuA=
X-IronPort-AV: E=Sophos;i="5.70,447,1574092800"; 
   d="scan'208";a="231787181"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2020 15:18:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwwjSOLX3B48Ccb5rJJ4CA8kWNxBV3y5SVcbz7iroZtkmkp4Jx8yBv9KbqV50Mv4SB2gxttN024ItpKnnosnpxRTido9e1ZV5yGeI2R4f/i17ZBdr3d+wuDmF2YgqNThiih+wjwOhZLtqVw9gv/M4wlXhpg1YrN16MgXVYI7J9UQZScCiD0ZT4M4S4ifY7CD/8uHxRpxA1at3oNyPdRKYVrmBJZwJIKKuhYRS9csP4NQWwrOKQ/WDjIRy6vOAOsTDQtgXu1YXnUcB7YalTCtlsVyDU0KeqerB7MLKNKzZCuGCGXBKIPJXxKGz2nHGbHyUXZ72ovgG4l35FkjqzKiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0sm1bDnh/6aAgni19qOJAEVfxMDudrUH4XAbK54PrQ=;
 b=i+Sel3Fet7QcPhezszDo98Cg57EiFI8nN+7aKSyyA4UswUIoZMV+8ve4jKINUshJRL6gUQ0yU1s2Vq2MGckjUeRX6N0CDC7uBwM/QIXTUfTKteBj3iKh5vvtQGBfj2pwlC9iurP+qFFjs6aHUyQh+n3oMup/iUhyAD6eS5X2tJquOqXCxdh8pHhf4Q+EquSsZoPGkqc3gEpmYu5U9mYW+o5zD8RxdwHTNYsOLzhwoI//4a7niU1nMvlv+57g/E71OooF7OWZppQfDT4Cug5UWavLOn2/UhZIAY/1m072ntn8YRWOySQYyElpAp8NxUgePcKz6+uvxPUpSTulXQRkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0sm1bDnh/6aAgni19qOJAEVfxMDudrUH4XAbK54PrQ=;
 b=JvJofQWJaRvw/OY3L4/9IzwegsZCk7ro5Jhld+7nh8dv6lD27t+hfbqQpeodlqvadiqGfV6gZlDOgT+gxvTsCEXhASOZX31tA/D4sQkJ+ZXa77WSi9E8J2TFZIF+t6cjw3J9Hd3faXcLtfljBUGDJW7uo8N8VCV23Hh+K7klbKM=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6655.namprd04.prod.outlook.com (10.186.147.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Sun, 16 Feb 2020 07:18:25 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::3885:5fac:44af:5de7]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::3885:5fac:44af:5de7%7]) with mapi id 15.20.2729.028; Sun, 16 Feb 2020
 07:18:25 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "patrick.oppenlander@gmail.com" <patrick.oppenlander@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Fix scaling of cache size
Thread-Topic: [PATCH] mmc-utils: Fix scaling of cache size
Thread-Index: AQHV4rrbf3/Z94BThUyO6uTTrnOzd6gdbNpQ
Date:   Sun, 16 Feb 2020 07:18:25 +0000
Message-ID: <MN2PR04MB69915A49A1F17BD2DBBD5C29FC170@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20200213221332.2228810-1-patrick.oppenlander@gmail.com>
In-Reply-To: <20200213221332.2228810-1-patrick.oppenlander@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b2a0833-f8be-4454-98cd-08d7b2b0699e
x-ms-traffictypediagnostic: MN2PR04MB6655:
x-microsoft-antispam-prvs: <MN2PR04MB665502B007339CF5CDFA762FFC170@MN2PR04MB6655.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 03152A99FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(52536014)(86362001)(8936002)(33656002)(478600001)(71200400001)(2906002)(6506007)(186003)(26005)(110136005)(316002)(76116006)(66556008)(64756008)(66446008)(55016002)(66946007)(9686003)(7696005)(5660300002)(8676002)(66476007)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6655;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dt9Wy+lqgheFG97dzfi82YqL14WKCEoApVhI8wIdMbWNcx0WcqmkrF32X4XM+HXJ4yr8gviAc/3398k8izljM6JI5A7cHKkmmaIrQQJbiTENf6sFfCrSCwA6iY521Pxv/jsGboNTY74hqv7m2zdl8YuQBUJEIIGKSeX3YvM/rfD02AhrF/rn6aKXWYb6UP0eCdvX6GXlhXk2OBlsCPoQkKb/IaMxXvd0+7Hs/mskojrsoF1/cVLyMUg9+vCFKPbh+XgBCmBMz5LXPQdj02YJYj0NvOtWUJSim8QFMdzQzK7weoatS7lP2oHwSHqk0MJQ5JuArbCsxdOERKuEYxMZZFLd/hou+OHUAoTjGN4c5LANzueS9GN5tXIdqz0tE8IwP9Ok0Wtb2pDH5rRxwyjNlm4SvsD0BKeGZ30Ubs6rYzubanFpbbUANl9zhehcmi0t
x-ms-exchange-antispam-messagedata: 8+lCfLJR6hhWYIk7qg8pPjex4aAIOv02+sTvwmyYkhfzj91WU7vBcPlsIGe3W9XK8tPVOVqV3Piyn69gjoh9e+ITKPnOathXmH+t74H7+Kncy8+b4//nAXiI6dM1OCtv/DTRhM2Z/hYLW/S9xAQt9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2a0833-f8be-4454-98cd-08d7b2b0699e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2020 07:18:25.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/CXX5KGWRgI0//kH355/j6FtNAnQeVauFxG5F2dBCoWORZ385KRFGLl0fuFgAwatCrY5U+9zxRcMqFmKQXnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6655
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
>=20
> JESD84-B51 7.4.30 CACHE_SIZE [252:249] states that "the size is
> indicated as multiple of kilobits". This is also supported by Table 39,
> "e.MMC internal sizes and related Units / Granularities" which lists
> "32Kb (=3D4KB)" as the cache size granularity for 4KiB native devices.
>=20
> Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>


> ---
>  mmc_cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..a1b1d75 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1419,8 +1419,8 @@ int do_read_extcsd(int nargs, char **argv)
>                 printf("Power off notification [POWER_OFF_LONG_TIME: 0x%0=
2x]\n",
>                         ext_csd[247]);
>                 printf("Cache Size [CACHE_SIZE] is %d KiB\n",
> -                       ext_csd[249] << 0 | (ext_csd[250] << 8) |
> -                       (ext_csd[251] << 16) | (ext_csd[252] << 24));
> +                       (ext_csd[249] << 0 | (ext_csd[250] << 8) |
> +                       (ext_csd[251] << 16) | (ext_csd[252] << 24)) / 8)=
;
>         }
>=20
>         /* A441: Reserved [501:247]
> --
> 2.25.0

