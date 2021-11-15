Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B628C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3743760E0C
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 09:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhKOJK2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:10:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1818 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhKOJKY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 04:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636967249; x=1668503249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3T+RoINOb/3+imXFl3cqa5eG0ZJV+qxXyQqrxATd1dA=;
  b=DcouwqXtxFTSeKP5PYfjo/F7y/T7exeuhwRBDM/WmihciI+TwBquTk8L
   +Ea6yU62jrlh46OX4Enxdlu0V6aV6zggfUrndfWhzMaOM50OA5LQoCGca
   7cXz3ne1/Hfhp4HVOErXhc6RtVDdo4poCisPGKJ+y26SS+n8MvJKX6PAn
   OUeMkTSMSLmpbLso6Bz4bvebCAi5X8RoJG83I/7A4rEHsWR3TuB0Z/+Am
   J/zRxFmwnaB7LvloWrsVIjFfIZAhIVwSCymByt+0XrqqeBoQp+85nGUNK
   sejCnUgiDf29rV+y38LNIiMuazPf13RSLNn0s/A8o8rp3qMwybuGQ/bfh
   g==;
X-IronPort-AV: E=Sophos;i="5.87,236,1631548800"; 
   d="scan'208";a="289549469"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 17:07:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPwaq6mk85iz7Jyx38sR+vc34L4/Aein63nx85saL5UwPagoWQ7NG/YP5mqAiV1hPAjxi2D3C9Jwr6+qJocB9tpVpPNtgQq0+iSLhZiHmmOIn5FQgr4/hED/zNo+utfmzlfK7no0IBFgTBHR9PMCtD5Zfv6oTuQA3/lsWIbizdLW7wH42AHs6m6ckwk+qH5X+EVgG9C4lNaNhunZv0+HLJmU7jJgjtKVw00xTbme686uaz4X/dZDEmCOYispAqMKKf92BkqsG++WGsl2BBrf2C4kd01OhJlsOdff+6QU3b1QWcgaNr1WNQOxT4XudhCC5Nv+sXFnpGgjyiifWcuIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQmTusbWIPhZvhOnGJwIIrtFPWxfkS9a7XjHMqWRHHg=;
 b=CsPC/7GHahwzIpG9Silz67C2NVnJ5REdPCVCLmSnIxsXy/hiV57GcnoxfEQlRpTVE5LGlh0eONOuhM7Mt21d6RolhCtzwgobatzOe7djrURf+F33l3XLOtcwk44zp5VtY6eUimtdG/T/2lkDugUXvgc7g6oNRJzTEdMsMw05fPr4IdA/JwjQZAyUpgkfdCDDV5jISUN8zDzEeBY4eAvBA5RBzwJeIKJ5xLAf3rZpf6bZDZJXJvQsjSrrfJ1IwB1wI1sfHj+ebUfk3KY2quXD4xIE4azb6RhMXhyLWluh5wCFhCrJPKbroVtYfpkitoTd0IoaieoB7fa43QxHIRdm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQmTusbWIPhZvhOnGJwIIrtFPWxfkS9a7XjHMqWRHHg=;
 b=ZgszZ2/Pbg0Vzui92suXIQA9dA7JNATfNE4fUHFfO4GYGkEWY4wdrmLIWuU6KBRYtF2L0gY5RTGVHacGnlILmTx7WhVAFnbs1e5DoAJujg7Qsuy3MTc2pXJEsMZM3w0rmkkd0JfezsbCPeApS8O217b7DTujEQ002ya5/Iz5Isg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB3897.namprd04.prod.outlook.com (2603:10b6:5:ad::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Mon, 15 Nov 2021 09:07:26 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59%4]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 09:07:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH v1 2/2] mmc-utils: Add note for CMDQ_MODE_EN runtime value
Thread-Topic: [PATCH v1 2/2] mmc-utils: Add note for CMDQ_MODE_EN runtime
 value
Thread-Index: AQHX2Zhf9e9HEHmiXkWXwC0r/QJdQKwETNXQ
Date:   Mon, 15 Nov 2021 09:07:26 +0000
Message-ID: <DM6PR04MB6575C2BC1385ACE6E41BAD8EFC989@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20211114204331.39555-1-huobean@gmail.com>
 <20211114204331.39555-3-huobean@gmail.com>
In-Reply-To: <20211114204331.39555-3-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4299ed40-cf87-488f-5885-08d9a8175850
x-ms-traffictypediagnostic: DM6PR04MB3897:
x-microsoft-antispam-prvs: <DM6PR04MB389790D0360D1886B20A7A58FC989@DM6PR04MB3897.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ntP9w4XP2M8oBUaIOoU0L5iRTEB9sN2fjFE/gX4YjoXMblD7eA3UVXSMsk3DiKibumJTFo72j3RTEZCKuWhgsKu0/vkzD1GeBsv0/hk0BGrMqcAPnx02BPYNmMPkUqw+fYb17fOnlAIzVcwX2FFP3E14ourQAgsxL41sn4RJbcOrjQKfEnI2f3PEG4XR5+5T4wDtXVuEC5ihForBQxQ+5yM1qqxhPkdlpwZjMB27nkpCzw2yrTP91Z15mEtA7ZOlz5AhCUX1L60QCPMDCzGXN+Ou9my5XCGjRl3XIiZ5OFNf1d9N3fwyebavE5JD/8jnT/ffGhU8UicZZ/w87plT7zUMlb1XsZNI9tapzQSRPv0gOti7SrJA2SYlaQ+fVKYro4/8xEeW3DcuM4IBWTtzQM9P99GL5hCEzcM1vNautNuAVE7woHFBe0vs41hzfgqAYlf8NrUqGy3N0wPuZiOPzt6wVAtIswnlFELpIIlHur3wmSMp9UUKVpWQzdQu/0X8rtvQx1QZmRTWlyF69It9f0/CulXbOALH4BGX8mXdIsDaSVwBpzDXUtzddN93yCZQxdFMFFS7ghdFEcfdYw+JBrdMOilUzC4aJ6/MyixKLFnt/SGUcackYyrTQVT1n3dnz0aFElH7FQLXsdxUbbtixL06bJwSt7nlAaOsvDlSFrcibOyEz1g7TxvwuA9VZ97JhPVPwNRix5i2qphIosmj7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(4744005)(4326008)(186003)(33656002)(82960400001)(122000001)(71200400001)(26005)(86362001)(38070700005)(83380400001)(66946007)(110136005)(52536014)(38100700002)(316002)(9686003)(76116006)(2906002)(8676002)(508600001)(66476007)(66446008)(5660300002)(66556008)(64756008)(55016002)(7696005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eh4MuRxDdkADdcEL89Tqf6B0CKHst6+uinrQBprUfSl0XGTrixnm24bivh72?=
 =?us-ascii?Q?QE/7g5xDXRD0+7RM/ba7obyI29rsTeYe3GOmPhn8R1n71AemKHuRHW+fdb7T?=
 =?us-ascii?Q?sFtl16bVWyqR2RwzbayR9YnT+mbRUoYNmukvP52ksRZR4+ppQM6mcjSFabzH?=
 =?us-ascii?Q?CTjtIjNP4xWt/DjnxsO+wqDjUL4Vmt1IM+qZlN0ubdSn4ogyU2HyrCmEiH3r?=
 =?us-ascii?Q?BLOmqByKfAXqOvkthnXsssCUvazSJQ4821BQczawkNuysVEaUHka4wC0vuXU?=
 =?us-ascii?Q?I/NAP9dTdrEamIJEDjJu8gNk4z4gBWoZtNMYupE3ZEKdB8qLAokKBsj26H3L?=
 =?us-ascii?Q?4ij+bQjuq/rN6OHlMGz9knVE+Q84jk1HwIY71ZtCLj2V46vOreQHL17GerTs?=
 =?us-ascii?Q?0QkmNyA2SjB3zxXqrrfv7CFlGq0GX9TX+o5LTnAz9bD6qhEtHOf4W9uyElD3?=
 =?us-ascii?Q?4TprnqYWC9YypXELgRrriYv9qd37sL7917XqQU2h/vAuZXvEZe/2yGy9rspD?=
 =?us-ascii?Q?FyEXC7YmZkw1ptaZIqPiSb6Gszivz0D6Fy7l9nViR/Mw54+vijENsFqEA0VD?=
 =?us-ascii?Q?Qq5XvklURxrzOmBw5LpzB8avvX3mHbFCVrMAC92VWSKf/LXOiKekgTLQMYVn?=
 =?us-ascii?Q?AyLeQ7M2QjXaErXx0uklIpL2mLBwf018OJH1j5oDjCAychYl9RULJrd8hnuy?=
 =?us-ascii?Q?R5QBRhfY+zkT3D5yOioI0l8+QEULzquxwU7vBLVhyzG3UV5Rsbpg/biih0qB?=
 =?us-ascii?Q?TOtoXlrOQWJRIkQBS/VGm8qARZ8iZsccVSgEwuIDQecw0ER8ky7tavfI04XQ?=
 =?us-ascii?Q?/v76Iswb+YhBvpdB4ZSK5XVLpg+G5xrW78JNybF0982L/GeWbJcQTGeP/Pty?=
 =?us-ascii?Q?CHlYkJBzVqkjphglgfRvN/WktKCYrhO5kOPTPSkLfgdk2jlSyLize65ijG9F?=
 =?us-ascii?Q?HVRQWUpJeWKyUDl0ftEjTNoTJr6FFbcFm2ap6BkC7N2EDMZHbCCWQ3q6za3O?=
 =?us-ascii?Q?ne2+FB6WobmrsxGN9vmS9F1XDB6c2kMOf5UAFPSJPMK+T3ACbXfZBK7x/deD?=
 =?us-ascii?Q?KjiUTj1BTS74VFgiE2SfIBGBT74drolu1nE0pyyNhA84AOc0dQO1wfzr4kam?=
 =?us-ascii?Q?z0moiGIm6u3qJiQAtPU9rbwyDKitLyy6l1EoOdSotRFTZjL1swayxsDqnW0F?=
 =?us-ascii?Q?30DauVDA/UtVMHnPuLHfWaWh5LZh48qB1WlTpMmQjBu89JFtcmbsG1l40d0Z?=
 =?us-ascii?Q?DUGHYVdK0edt2O+ehS/5Gpj8LRnvWlVaQ4fOmxyWgCGy8vRKFXIXPcWSuOSM?=
 =?us-ascii?Q?WmrrWohCZy8HrbR4iei9jwviPjLR6mbxgf2JMyP2C0U8Bvbs6L5YBtq+Qo4k?=
 =?us-ascii?Q?Ezv03tm5Lqxoj8la9+hDXOBA35tHbMJx7wlPcZPQB/GVD0KDxdYI4gYQ84iv?=
 =?us-ascii?Q?i67YuXcss0UJqZYyU0EsPIrqgArdeEWZ6YZPHrN4pMkDkQuMFY1Y+fxQOAHH?=
 =?us-ascii?Q?Ws2yhVEWGOWJNr3Ck2hsLZpNVR76bKjWdHw9sIlS+7ZjNHJ9Dgu/bO/5UkMV?=
 =?us-ascii?Q?czROmhWrsS8IHYnEzORQ+jFFAFrPBX6dHmVfI4WLuQoeHNi6rJeexnKJca2b?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4299ed40-cf87-488f-5885-08d9a8175850
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 09:07:26.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp5VQwCXcKUg+J0I9rHfI7QDG1c4Ucin83TUOziek1a9VE+WZNtN6av5f+/xHcyhk+kJznqqHg2Dx7q8SXMOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3897
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Since the Linux kernel commit 70b52f090805 ("mmc: block: Disable CMDQ on
> the ioctl path"), CMDQ in CMDQ_MODE_EN[15] is disabled before reading
> EXT_CSD.
> Therefore, it is more accurate to use sysfs node to check CMDQ_MODE_EN
> value.
> Add a note print to highlight.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
>  mmc_cmds.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ecbde3937c81..46c5f5faae02 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1885,6 +1885,8 @@ int do_read_extcsd(int nargs, char **argv)
>                        (ext_csd[EXT_CSD_CMDQ_DEPTH] & 0x1f) + 1);
>                 printf("Command Enabled [CMDQ_MODE_EN]: 0x%02x\n",
>                        ext_csd[EXT_CSD_CMDQ_MODE_EN]);
> +               printf("Note: CMDQ_MODE_EN may not indicate the runtime
> CMDQ ON or OFF.\n"
> +                      "Please check sysfs node
> + '/sys/devices/.../mmc_host/mmcX/mmcX:XXXX/cmdq_en'\n");
>         }
>  out_free:
>         return ret;
> --
> 2.25.1

