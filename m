Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86387C64E7D
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 12:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5074F20809
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 12:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="OlJhS8Rg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JdL3GQVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgK2Mao (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Nov 2020 07:30:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57612 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgK2Mam (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2020 07:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606654201; x=1638190201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s/yzeXfC2vqa7gu5oHMJWfp6iPYKpiF+KAVs3CQ+Vs8=;
  b=OlJhS8Rg2gaU5Zz+b1sMwDJZSYlpahZXZ4QGKsPHEY0PydBTwoSqxdkZ
   TcI90KyCJLhRT41ljbsGxRl8cNDSjQzztqnkR21lWfM/8VE/hHEUlRExG
   dOh/utkasUFU8klmYCpXPNztymqElRDgdr3VCUt+WQhuHbnv+rqrp5MOx
   O9oPdrriEAsNTEtmhgIfyxIKakMOGyP8fypStSa4VcpoMOgsEd3rUBCbm
   WXw0yGNGZ+5x3IypSpaEiqChqca5ODZ0xGzTwa5kFVGGpaAjS2fwYo2cQ
   Ta394PFmqD1n5Nm5v3m3kB7pGh5xRXeRzMh63Gm4TIeikEEGc3EOqFYa7
   Q==;
IronPort-SDR: 2NWtJJoYd1GouoR83uULZ6MWcXmzk55ZO9aeYHEVeo3WAYLX8BTTJPbGpfKiFnGdf9WGwEJElq
 rIdG7DXtHy+b9xZ4VYQOqi0JHBRvYVKZUxzANyUZU05D4F69DioZKvx5k2aZC9V/j2upKqpeI0
 3szPoQeHK8NicAkySLAXGvYaU61SHWiAUOnPfrHFvvBefL33i8nTYULpxi6PXq5IRnN6ctZbVB
 pvrQTiiqVqHGic31yCbzcUdXLiPh28RrmIGo7FgDwCV+BjtVWoKOuZ7US28F5HftxBybN9D0KU
 inY=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="257416245"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2020 20:48:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDEdPqiPQfxUML4f8anFGGJuXCMwArk7PB7TUZG+p1k4f03oDW6toxrpSg/fpp2161UcnYUSw1dmyMbu0ZkTlWYKAJof1uupUxYif8bk7tfuW653NgGTrr4giTIUqi3nYRvaYOM6lrJia2O6alShozxYWTJy/rG3CMBMH6w0lFm0+2+sbS9RS1T0Frs1z7a+ijiDBObVl2ErtCz07dM0g3zp2Icg7soWwz0nFW2/U3DaEb3agVglMsCh8QtbcY1ZS0vSFhac383qDpt2oK1DVYTFAZSlLkhiS8nG6xVIT4+8v7hdzzBKbhG1bN7Lhicl9luu9h6SHqqz5Ku4JUhpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3LKx1pfKkXE4TWaaYL6GwHe/GwsuLdabwDAx4pPqnk=;
 b=UqvoV+iGtfqTol5qrcVYNtD2iFwEXSRC7BTAk5C/w52ZHtfEQ4zD0YzVnhPySbtx3hJV8seQKKuumTA31000RFC+Tz8xEAXRFxUGwTScVVzeHk140Oa/ZIIE0fivj99yaKbsRcepdXQRJoWgzDujQVyw4AW/0IMbFDbxjWhzNQIB3XRkpJ3qph83RkasYVlU1fqgLy17fRoMz4UAyjesMB7GFR2luuwFfkM+TbB/7hwMouKVrjkNKjZiWux54/X7IaUNSkEzk+AtYRpJlA1QP0KiX9aWQIID2i28VJHKcucfLxNebmuntkXzyQMaMUbs/dGOQyfRCIzzAncExm9Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3LKx1pfKkXE4TWaaYL6GwHe/GwsuLdabwDAx4pPqnk=;
 b=JdL3GQVsX+sVHHh1KRxne681O1QiZyFhrCo5aNZZZfPxYPluAORqsJV5DO1ADlIRX4JtKixd+Vx4VI1z59rzta7p0ArvS0KSNYhdzxec1lhdmOVMbLtPlhC/TBbS8/YOY49To+b22HQq29BhNQb7LEJRg2HCATH7RIerexahQew=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7130.namprd04.prod.outlook.com (2603:10b6:5:243::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Sun, 29 Nov 2020 12:29:55 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::a564:c676:b866:34f6]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::a564:c676:b866:34f6%8]) with mapi id 15.20.3611.022; Sun, 29 Nov 2020
 12:29:55 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Seungwon Jeon <tgih.jun@samsung.com>,
        Chris Ball <chris@printf.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: MMC_CAP2_HS200_1_8V_SDR with
 mmc-hs400-1_8v
Thread-Topic: [PATCH 2/2] mmc: core: MMC_CAP2_HS200_1_8V_SDR with
 mmc-hs400-1_8v
Thread-Index: AQHWxHACeJdCMAQbpE6dV6diyj/Hb6nfDZdw
Date:   Sun, 29 Nov 2020 12:29:54 +0000
Message-ID: <DM6PR04MB65750C394FEED7326628D1A5FCF60@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20201127033527.407-1-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201127033527.407-1-chris.ruehl@gtsys.com.hk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gtsys.com.hk; dkim=none (message not signed)
 header.d=none;gtsys.com.hk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55e57166-c04d-49e8-8419-08d894627a2f
x-ms-traffictypediagnostic: DM6PR04MB7130:
x-microsoft-antispam-prvs: <DM6PR04MB71306F877D2A42DDC5AA5788FCF60@DM6PR04MB7130.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9VluYhO0wha8+ymax7V/P/7cKqJ3lmXlSfZrNLE0VuS6nod/4hwsktL6dWTHx9ERE0CRcQmR6Jb21BpxznIVVmbQ9EIjsGk0XATZv28VEpnrAEICDJ1bm9576j6+FfbWNAWaqL8sQQUu7uknvRFYwd2fOzUQ11uORGFDHkNwfGgwNOA1Xda1XpF47GIrc4NUhAoIl+4iAs9T39WbuNxJn96vQHNFR8NEySpCxR3sr1nRQlKhZ6hYaSpirc5zNWbaHRXofa88u+9PotTPi1a2ZWZMuICsUvKVPxMMih/4Pa5KSzN/EG5co9/zz8Z8qRiE22XSeMVZvmC1Lj4tiIdDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(8936002)(26005)(7696005)(5660300002)(2906002)(66476007)(86362001)(76116006)(7416002)(8676002)(186003)(66446008)(64756008)(66946007)(66556008)(6506007)(6916009)(9686003)(54906003)(71200400001)(4326008)(33656002)(52536014)(55016002)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?CpxzM+RDFBLrgb5uSBWwinMRngRRFBtTKirjMlzR4sFK0kEwv3yjQkOXfp?=
 =?iso-8859-2?Q?bYv+UcMB4lTt+C3VxOsoDoN7MUgLygJxx0tw7JtGCNFlP1KJZWCr8ExkrC?=
 =?iso-8859-2?Q?OlxJX4tcPdGj9KsRxngrsW/YYOvH061Xqb9x+4+Gj5uoH9QQ4qiq8MHODQ?=
 =?iso-8859-2?Q?ZZTKAoW62SLt2kymKFDHdhngVmlSTPtfZ4y+OxiolO9sUxf50q5vX2OtUH?=
 =?iso-8859-2?Q?InzKn+2M+/idX/syM94i7wcRO30WDcQ3hIVAnlb5DtQldf6kC16NZkMz/K?=
 =?iso-8859-2?Q?Y2AlKLzQpnkTxDmrbSsUk9S2tJYcuP3hEm4vcXs0GEUByXRc/jvfRHosgZ?=
 =?iso-8859-2?Q?2eDHF9Qx5kdhUnGwc9ZEkcw4mHHCLYlwFnxYJYWeezkFgzYOUNjkpomXRd?=
 =?iso-8859-2?Q?S0W0A+YA1SyViZzCDIbSZbxtwgCqbVelKwEFaptzRAqDtSejwEC+8z9S6g?=
 =?iso-8859-2?Q?b75PSPrBWPFvFdJhJaHbx4kiq6pdy9TSIOxa8HbgJzENU0082ZS6E7vyrL?=
 =?iso-8859-2?Q?8wKGTTYob/S8FyzkkRDcK9sKLIpp2ye57eXeInB2LEQErDUgC42RKGWQfT?=
 =?iso-8859-2?Q?T3SvoKHaHxD7MDKmU1osesMUpBTPZQ3nSX7wzEWyanUlYSMCQn/rWX099K?=
 =?iso-8859-2?Q?lGZ20XelV6k4L7UlDJqE4283JIIaHX5pTjBDP1n7FJhwcVCr/jiPBvccfM?=
 =?iso-8859-2?Q?NL0xh9vxbWqJuU2QUosIzkIu/GT3KxyFVUethSu/uu0jsyr7QYYeME2hLe?=
 =?iso-8859-2?Q?JU6Ac9kj3zTvu8gNa0B9QmZcnJXIcTgOyZPEh5TkXf1pjoSMWtOdooKjXc?=
 =?iso-8859-2?Q?CEIojflHN6lbJ8zO9QOb8EFWP1MOpVH+Rf7IyLWpGQlCBbfd4eDzPG1uMt?=
 =?iso-8859-2?Q?T7L9YtGNOeAqalbkG0vDf8gfp1TJOBqCf8PhsMa0m+Zpzh+fZ/5X6Ul2s7?=
 =?iso-8859-2?Q?vZqAHLSId7WIs+Z4/8KglK88Ht7Z7lmsHY0e6FKiog/QoR5NDeLkRiKj+J?=
 =?iso-8859-2?Q?QYB4djkuNuBxIN9Sc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e57166-c04d-49e8-8419-08d894627a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 12:29:54.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RDgMKUNRkriiNWNDoaatO9z+axPpKl/GlKMOnvUiq1E+Ml4OtuIBeSCNphljho1IzYuCPQfNJ5IZTAYi9xBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7130
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
