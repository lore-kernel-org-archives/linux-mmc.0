Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609BC3E8C5
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 12:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF1620809
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 12:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="M6bz1NoL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n3OQQsWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgK2MaC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Nov 2020 07:30:02 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57612 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgK2MaA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2020 07:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606654138; x=1638190138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=khud9bhqKfsG9/O3sKd6u9hNE23sTzzekSPn5zB/H4g=;
  b=M6bz1NoL1hLXiICw9hEQE2j94qHSpYaoUxflFsENzyPIT9ex/kRAQKIf
   O3XM6gfWPbkWG77zvvY4jj5SJnCPvZu0Lyvo4zcK20BhbjEhI+EQ9oTO8
   X44d9unmTQJDWD5fCQzSvN08QbUaYpNHbDxxXY1hZTzo0qTT/o0e9mL99
   1wN/FBcnp1xGXFuLywtaGiHmc/bppJutVaErVoxXFdLqEfyfMvOE3HqMX
   L/D7eIM69e69fm1EKu96KkIMleVM39ySmatP8Wguwo3Gp4K3ZPaDCmxbr
   iYHzvBP4drYwPgFYCo/ZzBUOZzoFnlZqmSZf9zIMySlTSolidC1q5ZwQM
   Q==;
IronPort-SDR: SkQTdLysxNzMYBbnFs6aZO3Y9it79a1+VJnuVRY/V1M0c4yburRo4zwyQLGjFDtvY9JWmejflk
 P/QKu2AOZOZGHNhO4fXrbrdfYrgAt8nT043w+8jArJYLKKqn8hUYagvryibSUG7IYUFr2arpIg
 fFXoYqultz0ABZPEZGAwSRiOn2VAZu6g3ACP/GYusshrt3cKHP1FZ/2XSYHPFA1uKPXtRd+iPH
 BkaV6KogsQWkbfXhtsKPufsea+6AQYm92NavC01M0p2RKM7+N6gIcxfj6sFwENGwGJiiB+w5B2
 DHg=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="257416224"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2020 20:47:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpc8BaHbI+JJg7WVX9/JqR2Gobya0fykPKfOMWuRf60SqmlZ/v0ExI0PH2owCD4iQvLzZ6kI3X61iUzCk4Ig+t+Kds9tKTErg8fvJnQxraVSFTxwymK4UYhTq2mjKaV9K/bqedNzVW5P2FkLvtOQVG3fsXmGopkEt4FKH37V4dIqxvRxe87YGCkDa1GMSZ86nAK45LERh1IykfKzoEWs9USzgg4eKX+azuM/eWuipYR/Ob/2Q2HZFg5OWAyGWJRpTbhFmTRe3v+JZXyz2SQb4KIx8AO/39gBAOOKE3WIPTKPj3bhk81ic1nynfk0u1OaA6+MWsTAvYog08pO8JLeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POFGKA9rJ8rgCT5OqpXavQzxWDkKYDs4Kc7HUJdB6+k=;
 b=HO9topPr95NbPEGtjuS+rHQznzba4QzQry8CJv7n3HlEH5W49Bj1/e9JOYwmOmC/rKEP+0kRn44FFdZChJdpQ7H4o5aVaeDmtk1ho1lMr1qKsMcdaIGgPMALav7ZoYct+cjiJcWaqbyMo2K/ahMyptkL/sh1WBiP84/USYfIlwvteJXquil1301hZ6cq03i6kSlMGB3cx4XKtlEzyECsJZVuVU304uUHo6KTiRoOhnnvdYpAS4CaX4GL/SeAdat+tRmnMXB9Yet7yTAUClY9AR5gH5F9q771l3enqrvYjhrSLatxHNLuDDPvxdsG4gGiRie9ArGOxHV6V3Z0RYtw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POFGKA9rJ8rgCT5OqpXavQzxWDkKYDs4Kc7HUJdB6+k=;
 b=n3OQQsWDbLdPJ9o1yCyDWKw14cPZ9D5r49OGu+X8DcIqKNxU3WjbJtHzNihX9DYha8dSE+b2v76AT4OJfzFon4kSLv/7SR/hBVP/7saSiqF2RCXe044lF8+bqqHzkEi2CP4m0uCSB2P8h4AWuV4BTq04g2s9Z3Ccjr14Pkx0sBA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7130.namprd04.prod.outlook.com (2603:10b6:5:243::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Sun, 29 Nov 2020 12:28:48 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::a564:c676:b866:34f6]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::a564:c676:b866:34f6%8]) with mapi id 15.20.3611.022; Sun, 29 Nov 2020
 12:28:48 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Chris Ball <chris@printf.net>,
        Seungwon Jeon <tgih.jun@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: MMC_CAP2_HS200_1_8V_SDR with mmc-hs400-1_8v
Thread-Topic: [PATCH] mmc: core: MMC_CAP2_HS200_1_8V_SDR with mmc-hs400-1_8v
Thread-Index: AQHWxHd+UJnrloRz6UOywQYV58SgA6nfDNEw
Date:   Sun, 29 Nov 2020 12:28:48 +0000
Message-ID: <DM6PR04MB65753FC7EE5058C4A20F6D6FFCF60@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20201127044044.1127-1-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201127044044.1127-1-chris.ruehl@gtsys.com.hk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gtsys.com.hk; dkim=none (message not signed)
 header.d=none;gtsys.com.hk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21886604-1203-42d7-6d6d-08d89462529e
x-ms-traffictypediagnostic: DM6PR04MB7130:
x-microsoft-antispam-prvs: <DM6PR04MB7130F4703B5A4805E0C2F4E8FCF60@DM6PR04MB7130.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqjko4DLYoeLO9vGXm2kqgIoE+JfHsDqpEK8f3wIhjGZMGovR7VZyMfiz37WH4DsgYnjuPyMvcXws31lfAE3sGf1ep3St/MNHQ5mxakpsz1HK6/4BNfD66dSvz5ZK5u4wy3DhzCp6xBDTqmFkLEyj7Qm1Ek/DMEhU6tqYABz7cZBH0q1hk2oe+SHCXBmOPfuRmjn5HsE6LoQ6Lel8lOKSI8R1VsfcEDcb5lDI9QVmquxrFM2PTh1mYWRVyyk0Q6ORnKp6NAKP+sKXjT9m9SYnoQgxkKCPFkDp+sAtKOGVH/Z4Qlv8rSX/twBTqJmXhXTsebuwkdEMQHYRiEMNSitvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(71200400001)(4326008)(33656002)(52536014)(55016002)(6916009)(54906003)(9686003)(316002)(478600001)(7696005)(5660300002)(2906002)(86362001)(66476007)(8936002)(26005)(66946007)(64756008)(66446008)(66556008)(6506007)(7416002)(76116006)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?BS1JX788OZW9/466qUihpYqpGvIH3WoxcdfjMz5onEF2AQBwCvpv3TH0o0?=
 =?iso-8859-2?Q?9LWaKchaqZVpy/wZ6vZEZJMbWKB2RRNrCJoMOSIh+aCIYV934su1uEuion?=
 =?iso-8859-2?Q?pjYM5q6KvlPJcWPXTv3jjhm4xE/6czAIMH7rIH7CXGiHvnl8rp1Ph6ANpf?=
 =?iso-8859-2?Q?lBQzZccMpp0Ci5N8VsyGQM+hRNGXwj4P9S1XBNoEo+aOK5sraryadTeraA?=
 =?iso-8859-2?Q?7eGSrVF+6pcJO0KXMcYFvX5/FopilZDyX7WkcJ1+0uXINvIWRHbZ3hkDwK?=
 =?iso-8859-2?Q?Ub4cX9rdo0Q7A9wSv26x174S3z+p6sxZIyk54FlhgxuwuB3VIpKJmscmnC?=
 =?iso-8859-2?Q?/HmiE3DVQADxy7yozZNwGeoN7TtIjCLq7j4gHO7FwUAYal0iqykPw2QQqh?=
 =?iso-8859-2?Q?NuU/Ai4RpEVFuujw038abANgNmKaT7MSC85G107q0sqUYHxfzo4nGfRBgt?=
 =?iso-8859-2?Q?QWvRqHESh2PtCqurJRCKwM3XvCmDakn3fboDXNbuvptRSlPjHau2r1viuP?=
 =?iso-8859-2?Q?4AokJR605mbeDt1PvIW64tGWoo+WMDATrDgwkNA1/FUvb/H/YImhfo8ej9?=
 =?iso-8859-2?Q?62s2t/TmgMgkFc4pV3Jbfy+qHsczbnql9gNDsVfGkHlwXePP0Mn5FTQd44?=
 =?iso-8859-2?Q?dOjBZFcbHa3tH75k25oQ0jHIPuFjp5ARw5WJUhBFZbfM3Nhigf8R/m+D/J?=
 =?iso-8859-2?Q?IsMJDSxrzJrvegdMTUmM2N7pehQqScM0IPCAcJxV32TvzH9AsQjGouEtPR?=
 =?iso-8859-2?Q?0yMTRVseZFGg16N9VDj2lcFOyHO/akeSRcdlj6dQIN5qYP+Q16aPYUyCqF?=
 =?iso-8859-2?Q?HZtxJOdNRnOBG4PfIIhxFTu+FKTnOADB9eSxWDwBxNgBpbD7OtfvInNTc+?=
 =?iso-8859-2?Q?tNA4Nt42HwIk4Jqq8fBckSq0lrkvQtTr+7NoFZz1hCDI7QXjtPw1KvxF5g?=
 =?iso-8859-2?Q?2MtAGj/eTYaia63s/zPlK1T28RWiKL9bk4l3fW3KV8DgrWP6lRleE+v9Lj?=
 =?iso-8859-2?Q?7UjxwPOUz3js+fA1Y=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21886604-1203-42d7-6d6d-08d89462529e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 12:28:48.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMzQMTwJEe+qF+x0MNn3QETaCIZCkg7IbC/Cv6HR0OXvQY6sCDo1ctrpuMolcGXkipjjrnuPI2RD89ar5R+MUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7130
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> This patch remove the MMC_CAP2_HS200_1_8V_SDR capacity from
> host->cap2 when the dt property mmc-hs400-1v8 set. It cause
> error and occasionally hang on boot and reboot.
> Board with this issue: rk3399 with SanDisk DG4008 eMMC.
>=20
> This patch did not change the mmc-hs400-1_2v host->cap2
> added the MMC_CAP2_HS200_1_2V_SDR.
>=20
> Log shows a boot process with a HS400 5.1 capable SanDisk 8G
> with mmc-hs400-1_8v dt property and the MMC_CAP2_HS200_1_8V_SDR
> append to the host->cap2.
>=20
> [    1.775721] mmc1: CQHCI version 5.10
> [    1.802342] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci]
> using ADMA
> [    2.007581] mmc1: mmc_select_hs200 failed, error -110
> [    2.007589] mmc1: error -110 whilst initialising MMC card
> [    2.413559] mmc1: mmc_select_hs200 failed, error -110
> [    2.413562] mmc1: error -110 whilst initialising MMC card
> [    3.183343] mmc1: Command Queue Engine enabled
> [    3.183355] mmc1: new HS400 MMC card at address 0001
> [    3.197163] mmcblk1: mmc1:0001 DG4008 7.28 GiB
> [    3.197256] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
> [    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
> [    3.197479] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, charde=
v
> (242:0)
>=20
> after patch applied
> [    1.746691] mmc1: CQHCI version 5.10
> [    1.773316] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci]
> using ADMA
> [    1.858410] mmc1: Command Queue Engine enabled
> [    1.858418] mmc1: new HS400 MMC card at address 0001
> [    1.858897] mmcblk1: mmc1:0001 DG4008 7.28 GiB
> [    1.859002] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
> [    1.859097] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
> [    1.859182] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, charde=
v
> (242:0)
>=20
> Fixes: c373eb489b27b mmc: core: add DT bindings for eMMC HS400 1.8/1.2V
>=20
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Acked-by: Avri Altman <avri.altman@wdc.com>
