Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CF2C433ED
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 05:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB06608FE
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 05:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhDWFTv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 01:19:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57653 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhDWFTv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 01:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619155172; x=1650691172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O9iv5ZikOYZAFGGMk3yTE/AcEg7+beKb/RDdZxHRbMk=;
  b=qHb7maY8PsWKGOrAv+061j8eDLvgZirp3+1xYCOs6bKfJ7ZAviE5joxY
   hzEpFP39+gwnsp/PYVhOF8itjYSK5Ul0txVQkm2MKagaooep6yanT42JE
   n9xZgMk7E6WDxixaIlK5aonANv7EEPCJEahGRUYonNdmfxJWZgQRV9ebm
   wPF2fafeVMrX22tgaoy7YZkH1tgBEaRJw1oJwvrA0DP+etss6F6pPSgos
   EVgDTxFlHzI5iJvaFrQ0dO90QIVPZylEpxfcL2glG6LTQ7uxb2MnfEjcv
   SS4LUNkn+AghFp7wvnzJ/mbiVenzQ7Vm3pRrIPucLK3IXNJ5rVKL6KVX9
   Q==;
IronPort-SDR: 7MSk/YGXfC2QzP55p/hi/xT5C/Lzm7hMryYRFhTIpuTB52/Ggk8rXetD+RaQhj0V733UU5Xgp7
 LbcN38QZUj6ENmrwLZAfRXITEvvr7ltrSD2qmfyYmEngMsLPvbaaiP7gLb/HWHjOya7mprtsdJ
 5U+d9WrPUHbh0hohw837S4Xovlr4RbDGPJbmIcFOfBvNqy1i48TaPTbyPh+p43kKBMlgDJZt7n
 JYYw7N4Q0vp7XMYdkP0dkREZCQ5FYwgMX9Lx2huZizJOka62K7G7FRyQKdDEWKgCCyfePD8wOl
 k3c=
X-IronPort-AV: E=Sophos;i="5.82,244,1613404800"; 
   d="scan'208";a="269883231"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 13:19:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW+31Wdu0Ov6hQgeKNP7e2m1nF65UiajWA6jfGfLLVO9droOvl8QIp6aPyDtVEm0fECJuZC/Hh/XGzrddL/GZhsMO0JdgZFYKZkq3V07SGWRJQZhO6KM08gbbvKDr7lyggUIjRhRnIMivkVXk9a0djqlcJy8D/lBVxKarN0kA9e9OXk+JzZVJ9R7NIOISkdNwWTZ+dj/wf2JZuX+TCHb3dMR599f3n8EFACbc+jfOxQ7keEcyfAviRXzyy/iRamg2Yn7VoB7xkvE1YErsMsIvrDNNa+cJrctmFbWJEt8LKo0eNkRsbQifriNeLlgxQFI6mumLUgLfg9ZhtG3XoGezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yy6dHxPrMjYLxFcrhlLHypYpyiSn83/k0fO/AqF8aY=;
 b=MI4XnXECKN8F2LQXLCq+s7vxMKdvPOFuKQ5y5wG07LAh76I8rzeqesRiEd+Bfe5tXdjxhM5JObnQ1JQQsHmjqwZly0pXs2GLPRRgv8LXljjbA+5xAjguqMaJNExid7DcLFykRnBmx35Twgh9o3PNj2DVJh/jloyZ3fl/TcLLyZGrLdEH+Y6KgmJBkmdwoYeYUQlVzLTzgH7z7u/GYl8rDhEh5QGjJ8R0oyC7y1CpPJHeilpuJbqf6F9gyYeOBi0MxBrgtMBgFJiDZI3qHqsS9blEP/B0bW4Wb5YOF299pJPkhGrVu84OvJEnZkXYNvfW67hKiVVllrYQBaFhMDWT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yy6dHxPrMjYLxFcrhlLHypYpyiSn83/k0fO/AqF8aY=;
 b=zL1MjZEqUkNd2FOAbkWad21G8eXdLWfoDTym+1zLZs7ITgl80qY2qKd9e54aS75tq+hQW7vor1Q375tWNCmhbmpXNos1K0+Xr0Y45yE8Y/Ok92n4a2/BUbZC+s5zrmXSyGhcG6JIsosN8vnbdbfr72xr91s5OEEipQ/oHnxdfJ0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4425.namprd04.prod.outlook.com (2603:10b6:5:a1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Fri, 23 Apr 2021 05:19:12 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 05:19:12 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Subject: RE: [PATCH RESEND v3] mmc-utils: Re-submit of the erase command
 addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase. Re-committing the
 change per request by Avir.
Thread-Topic: [PATCH RESEND v3] mmc-utils: Re-submit of the erase command
 addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase. Re-committing the
 change per request by Avir.
Thread-Index: AQHXN5JfYd4MGzWFC0OPnwBESIafXarBkC5g
Date:   Fri, 23 Apr 2021 05:19:12 +0000
Message-ID: <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210422161255.4610-1-luserhker@gmail.com>
In-Reply-To: <20210422161255.4610-1-luserhker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b65ba3a7-6d82-4d52-03bc-08d9061754a2
x-ms-traffictypediagnostic: DM6PR04MB4425:
x-microsoft-antispam-prvs: <DM6PR04MB44254B7D6F57A85EB397CD15FC459@DM6PR04MB4425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyXBfyRXanT9MM7cPjefNbMT4wosZnVZiCPq28W/V7/B6jePTA00PZuzT5TbAwifnCKaQOh/8++O7QqCZYcFfH79kmKlFsrsX3cMmB0WlgsFurilb9Y23fIyCCao0oo9pHHdHI3L0ALrpyJ5bmycH32acWNwlJeqSsngtrCBUAT6ur04MUsSvLars2lRDsin+eaDlRAjrQvjUyBRu7nhqamHnB/D534zwMBq7/lQ4fOuwvA+NL9/9PeRpqB3GO31VKvoj1XXnOLOiH1FArkQqfwbB3afRJZVZpnjlbtw1QoD8of4pxUy2IonlcFZy6cWNwPtRjjkEEvRRhHZ2lDiKHoZkr6NJiaEQ95I7asRcxdhDUqMAOOlSZ+bDPiOKE4C2jbgaM14Csaz2r8bJqOWzk1rYO/g9ZZ+N09H8470JfGZPbXLInXY/PbL/zT7Gm5kG7DrkxGU18ASdjn0C1QaVeMi4qnanZZyVFO28N/6nVaVCZg1flCen8t7bjSjqpuXuibE0rx3RBS2BVN7TsXrx+PCfeBNCSrI3HR9Ed/RqyMe33G0S9SIJXUjNAoa79KRdhO4W44BwyIq9zY5uAl/CBF2zEVxlwP6Of5WL9A2WppaAUglgdwWsJ3HI6xU3BPcDY/dv4CL02HU/ePHLXA6RQM4mCKwPFPbhmU2TMCOp2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(38100700002)(8936002)(66446008)(76116006)(9686003)(83380400001)(5660300002)(2906002)(6506007)(7696005)(7416002)(26005)(33656002)(66946007)(316002)(55016002)(86362001)(52536014)(54906003)(66476007)(110136005)(64756008)(122000001)(71200400001)(8676002)(478600001)(66556008)(186003)(4326008)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YN/YeRP8WknlrfnKq1zBo5jI4PtDhhea2abjcbRi3HtM/JGEd39mcVk3hLB0?=
 =?us-ascii?Q?MkhmGhTweHZYeSDx/wraWYWB6bsvnyPFOgOl6e63i/q4GvH+TD7nda4bGA3C?=
 =?us-ascii?Q?XjQETGLPlriTR5efMffjV8b01rfXd6yN9WV5Su6LPrbhSByJrZLmOyxydD1i?=
 =?us-ascii?Q?jsIspL5Ccb/5ehqbUbOeecHKG1gftu10GZLbN2FMgHpA5FxITecQFBr1a5A/?=
 =?us-ascii?Q?17NPlylsrLO0+TgocmWnH9C7z5zXNIi2urXegl33yD+XeAWYcZ3RIY4UrITz?=
 =?us-ascii?Q?l1tw+EHZYH6NjLeOMYoMe5bHxm6OinoHrxiOOzWweJa1Rijq/DdVL/TQf7oR?=
 =?us-ascii?Q?V5ZcmgRWYcVInWTU2sdpyr1TJLZYkAEPbWC+Dwe3MV5FP5I9yS+sgbzjthGU?=
 =?us-ascii?Q?plvJDzX2bxDrkQ5C5NTLXZra+yY554X+a6uokmiq6Axnx4FrrB/LSOKfdCS4?=
 =?us-ascii?Q?iMYr/+ToiPIrqBRHlwj5LtfT83ouIU7K9qhaHNIDa6OUdOjGLuvX6sxbtbr6?=
 =?us-ascii?Q?Rbcs6s0ro8QNX+crKLQvIZDCodOkhZ4mcHZIEVmkLzMMlp79MkzpizfWDe8a?=
 =?us-ascii?Q?/lTrnlU0NttElf2mTGKxIpuXbAgdz075LQaWaTeH3u2ttJKgdnc2Dc5zjUYc?=
 =?us-ascii?Q?ArEU94v8JyLJUpEpEUdGtJMb5K4wyh+Dq6CCugFrRhhMBwCXhbeGnzpFCgah?=
 =?us-ascii?Q?bEZSGYl7A1fXeqK4IQPwEqgozi7Y6BkIjgAne/goOmBizBYEagBAFY38e8SP?=
 =?us-ascii?Q?ijpgaKE3/61A9A3ebO7UBrOGUfHkjlMixqwS0TUeKbafWZLESf35SlN/UFI8?=
 =?us-ascii?Q?Iab+dRUAQ4WgIGXBfu7z0XFLheOm0oRDNh86EtVIaKEgtl0ZPRmm1dIMg0Ia?=
 =?us-ascii?Q?eHGF88dQPc4IzaZzYBauiVrIjDzAQ4f3iaW4I3MQ7OHjRJZn0LyrLIAZvgBw?=
 =?us-ascii?Q?XUf9Z+Sn349cz+HpH3dQwIhq2SsmAb3BsM8HyjXVEpLmvUdGDrZGya30NzOb?=
 =?us-ascii?Q?iySQi+cVK1uDf7SM/lwFMvVIJPKtUoawbbaVZY1LdGxlLmaCLqvqGMlgMFLQ?=
 =?us-ascii?Q?reXJ3E6YC5Sbhap+PXuJukytgjv+bMAlrNZhlSzj+VVEr1E2QAVAqc+2+NEZ?=
 =?us-ascii?Q?7adtnW6lE1/K0BqpLq8uVRgbHWvmRvrdlpdA31mDnRXh88xOvZKZTHZ/ot8O?=
 =?us-ascii?Q?13iD9a0iJMLf2hQIdvXJEcL4QEhGZ5xN0nV9UJU9n9HLSj9gaxW0M7QnGErz?=
 =?us-ascii?Q?LmK6j4mUriPRkAZ1xPKj873Lvz2Jaua3qBcaWYL79iO0Ji1x9oHGTX5aKsQt?=
 =?us-ascii?Q?js8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65ba3a7-6d82-4d52-03bc-08d9061754a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 05:19:12.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/KYZybaMwPmEk5a1xb/EF8cFncLmyCRUi4jCw0p70JfLTUMu1RArroacs11GlTZXLm1A4O+E9BXQp1vmef/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4425
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> From: Kimito Sakata <kimito.sakata@oracle.com>
>=20
> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Hi Kimito,
Please use a proper subject and commit log body.
If you don't understand the difference between those two - please ask.
Also for consistency, you might want to use your oracle mail for your Signe=
d-off-by tag.
You need to change your git configs for that.

Thanks,
Avri=20

> ---
>  mmc.c      |   8 ++++
>  mmc.h      |  13 +++++-
>  mmc_cmds.c | 135
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 156 insertions(+), 1 deletion(-)
>=20
> diff --git a/mmc.c b/mmc.c
> index f3d724b..eb2638b 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -229,6 +229,14 @@ static struct Command commands[] =3D {
>                 "Run Field Firmware Update with <image name> on <device>.=
\n",
>           NULL
>         },
> +       { do_erase, -4,
> +       "erase", "<type> " "<start address> " "<end address> " "<device>\=
n"
> +               "Send Erase CMD38 with specific argument to the <device>\=
n\n"
> +               "NOTE!: This will delete all user data in the specified r=
egion of the
> device\n"
> +               "<type> must be: legacy | discard | secure-erase | "
> +               "secure-trim1 | secure-trim2 | trim \n",
> +       NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>=20
> diff --git a/mmc.h b/mmc.h
> index 5754a9d..e9766d7 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -35,7 +35,15 @@
>  #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
>  #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
>  #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
> -
> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
> +#define MMC_ERASE              38    /* ac   [31] Secure request
> +                                             [30:16] set to 0
> +                                             [15] Force Garbage Collect =
request
> +                                             [14:2] set to 0
> +                                             [1] Discard Enable
> +                                             [0] Identify Write Blocks f=
or
> +                                             Erase (or TRIM Enable)  R1b=
 */
>  /*
>   * EXT_CSD fields
>   */
> @@ -62,6 +70,7 @@
>  #define EXT_CSD_CACHE_SIZE_2           251
>  #define EXT_CSD_CACHE_SIZE_1           250
>  #define EXT_CSD_CACHE_SIZE_0           249
> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
>  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>  #define EXT_CSD_HC_WP_GRP_SIZE         221
> @@ -190,6 +199,8 @@
>  #define EXT_CSD_REV_V4_2               2
>  #define EXT_CSD_REV_V4_1               1
>  #define EXT_CSD_REV_V4_0               0
> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>=20
>=20
>  /* From kernel linux/mmc/core.h */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 6c24cea..9340e3f 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2514,6 +2514,141 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);
>  }
>=20
> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> +{
> +#ifndef MMC_IOC_MULTI_CMD
> +       fprintf(stderr, "mmc-utils has been compiled without
> MMC_IOC_MULTI_CMD"
> +                       " support, needed by erase.\n");
> +       return -ENOTSUP;
> +#else
> +       int ret =3D 0;
> +       struct mmc_ioc_multi_cmd *multi_cmd;
> +
> +       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                          3 * sizeof(struct mmc_ioc_cmd));
> +       if (!multi_cmd) {
> +               perror("Failed to allocate memory");
> +               return -ENOMEM;
> +       }
> +
> +       multi_cmd->num_of_cmds =3D 3;
> +       /* Set erase start address */
> +       multi_cmd->cmds[0].opcode =3D MMC_ERASE_GROUP_START;
> +       multi_cmd->cmds[0].arg =3D start;
> +       multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
> +       multi_cmd->cmds[0].write_flag =3D 1;
> +
> +       /* Set erase end address */
> +       multi_cmd->cmds[1].opcode =3D MMC_ERASE_GROUP_END;
> +       multi_cmd->cmds[1].arg =3D end;
> +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
> +       multi_cmd->cmds[1].write_flag =3D 1;
> +
> +       /* Send Erase Command */
> +       multi_cmd->cmds[2].opcode =3D MMC_ERASE;
> +       multi_cmd->cmds[2].arg =3D argin;
> +       multi_cmd->cmds[2].cmd_timeout_ms =3D 300*255*255;
> +       multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> +       multi_cmd->cmds[2].write_flag =3D 1;
> +
> +       /* send erase cmd with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +       if (ret)
> +               perror("Erase multi-cmd ioctl");
> +
> +       free(multi_cmd);
> +       return ret;
> +#endif
> +}
> +
> +int do_erase(int nargs, char **argv)
> +{
> +       int dev_fd, ret;
> +       char *print_str;
> +       char **eptr =3D NULL;
> +       __u8 ext_csd[512], checkup_mask =3D 0;
> +       __u32 arg, start, end;
> +
> +       if (nargs !=3D 5) {
> +               fprintf(stderr, "Usage: erase <type> <start addr> <end ad=
dr>
> </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +
> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
> +               start =3D strtol(argv[2], eptr, 16);
> +       else
> +               start =3D strtol(argv[2], eptr, 10);
> +
> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
> +               end =3D strtol(argv[3], eptr, 16);
> +       else
> +               end =3D strtol(argv[3], eptr, 10);
> +
> +       if (end < start) {
> +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x=
]\n",
> +                       start, end);
> +               exit(1);
> +       }
> +
> +       if (strcmp(argv[1], "legacy") =3D=3D 0) {
> +               arg =3D 0x00000000;
> +               print_str =3D "Legacy Erase";
> +       } else if (strcmp(argv[1], "discard") =3D=3D 0) {
> +               arg =3D 0x00000003;
> +               print_str =3D "Discard";
> +       } else if (strcmp(argv[1], "secure-erase") =3D=3D 0) {
> +               print_str =3D "Secure Erase";
> +               checkup_mask =3D EXT_CSD_SEC_ER_EN;
> +               arg =3D 0x80000000;
> +       } else if (strcmp(argv[1], "secure-trim1") =3D=3D 0) {
> +               print_str =3D "Secure Trim Step 1";
> +               checkup_mask =3D EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN=
;
> +               arg =3D 0x80000001;
> +       } else if (strcmp(argv[1], "secure-trim2") =3D=3D 0) {
> +               print_str =3D "Secure Trim Step 2";
> +               checkup_mask =3D EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN=
;
> +               arg =3D 0x80008000;
> +       } else if (strcmp(argv[1], "trim") =3D=3D 0) {
> +               print_str =3D "Trim";
> +               checkup_mask =3D EXT_CSD_SEC_GB_CL_EN;
> +               arg =3D 0x00000001;
> +       } else {
> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
> +               exit(1);
> +       }
> +
> +       dev_fd =3D open(argv[4], O_RDWR);
> +       if (dev_fd < 0) {
> +               perror(argv[4]);
> +               exit(1);
> +       }
> +
> +       if (checkup_mask) {
> +               ret =3D read_extcsd(dev_fd, ext_csd);
> +               if (ret) {
> +                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
",
> +                               argv[4]);
> +                       goto out;
> +               }
> +               if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT])=
 !=3D
> +                                                               checkup_m=
ask) {
> +                       fprintf(stderr, "%s is not supported in %s\n",
> +                               print_str, argv[4]);
> +                       ret =3D -ENOTSUP;
> +                       goto out;
> +               }
> +
> +       }
> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start, =
end);
> +
> +       ret =3D erase(dev_fd, arg, start, end);
> +out:
> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
> +       close(dev_fd);
> +       return ret;
> +}
> +
> +
>  int do_ffu(int nargs, char **argv)
>  {
>  #ifndef MMC_IOC_MULTI_CMD
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 9d3246c..8331ab2 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>  int do_read_scr(int argc, char **argv);
>  int do_read_cid(int argc, char **argv);
>  int do_read_csd(int argc, char **argv);
> +int do_erase(int nargs, char **argv);
> --
> 2.24.1 (Apple Git-126)

