Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04325C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 05:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B816101E
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 05:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhD1F6T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Apr 2021 01:58:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53570 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1F6S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Apr 2021 01:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619589454; x=1651125454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5cCHw9IMk42Rq4QZzZ9Dap577fJlOKxxJvB5dpE0H0=;
  b=M/jyeWCcoSw9gCJBWUX1vvr9zu6FzBMTBhbuqpBA/VxAmQbcGZNXA4f+
   J25bzGmDROo7I9QuAxR8R0ATknKdMXABF9nmIfk0/4Wpg4n8WiVZCaPmy
   SrHi01iWeklfYEIUQ/TRCU51ttTjFABcl5ksG4zWvo25zKJuvQl2Qw9Fl
   m31J2JNjnrcX4dTVPuQjjlrqYnvJOqoIZCwvtg44treDRXJFrrAVYgXur
   KgROA6d2bLHpDXtlP7lrNL207WmzoGO7VPInxNODyOX5VQmJqx5sxmMQ8
   H5VUWXduWKYOQNVvFf1Qfm4ppKGqABUR1CRtGUSJXNE9zhV/chNn/E9rm
   w==;
IronPort-SDR: ZsVAHhcKts0EQbC/m3dVBQo4cC6rDz/nmyq9YbmpAJMwsL43cjnrwpbd2YSd7eInlsZJdMKySk
 XO/zLGMtoJO0PELmWDnyAkjMAcSbzUbtS1rjDE5DMxr84v/uIxxvwB8hhQHzcF/Yr63fsdXQ74
 EQ6TuoxPdbFEHUcLRN1um/Fhk7xVfGUvYAww2E11OZDT5FdNKNW22CpvpM3jplfn196PCaMt6g
 mOQwrec1+DYu5bP8PpfVowkVwAj4jLufodvoTOyOeTuCfqGhqt+MIvpZd0Duf0Plq1QqhLocSN
 rqk=
X-IronPort-AV: E=Sophos;i="5.82,257,1613404800"; 
   d="scan'208";a="166501337"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 13:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9w6SwXW9CpAeOAJDE6e904LZBpQHn8ysuiHwtBiqSYMNX2igwphR1SfdAN3xR+8mk6mllpTqZAoGBxl2aWg2UObxNlbc44g4WQwFSMU68TSpBwqk71U8Ran8JlWXEE8Wybfno3E9UqRIVmhQyUlXYSZGGoPH9zRt9/hLxBDodlnMA2LxQTKdWw/27beKWY0E/BEsbMSmuqZw+C4xjzeDZByEaJpPtTTTfTGagHgZMIV0Xma1zvS2KfPPfBIL5gVJop5UGsAn7StBjoM+IWfJy8I0Dzigp0ZnxtuGZTm6LvwXpvFPd1/aztf+uSZxS7ChWfXKrSSX3r8mPd93AUk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Mf8GQP+d966Er1I4dsL4qDrr5pCPb24a6kBXTFq72A=;
 b=i9RwL7St7cqUYClnIKREqsw6h0i8Tt+PLGFNfcpRO+5w6kzfQ1hO3kV58Dfg9vTnOa7xl77y+Vh9nC2BU3umTGbNiICkhhxOa07YLU/M+1rjPmj1CZRw191FLG3Ocj/TOoo1poRRnvxuw08ZjfO4L2rjidYyurPNe6ABpDoTcMGB6M5a0Dxs3hjGluVUTXed4WZiFvLxYo0trGgCEmMYbeNU/TnEfy6OVhzlNWYG4MpMfRJaLaL0R2WqjtnO3prOwzi4biRSxsBN9nxIaH1v4N0VU15xEf+NBYPAhdLo22o9wJxIYt+/45EjzWbb8zOnIX/CgTYMeushMxxtEwI7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Mf8GQP+d966Er1I4dsL4qDrr5pCPb24a6kBXTFq72A=;
 b=LTRGnLKForgj4TYb+xqIw6b/MQThkZVLEvdanLtkfsYVGoXpVw45UEP5raKNc1Qx6tB2T5T47vzKxx5aC0PS6GPR8EFBNhQ2vlokD7eH2p1mI1WMAQFM8AJ8wYiAoFcVPCOjJArQoSuVOmOoHqKb+5w7ZtRrFdyfJA2rkLCu7ig=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7115.namprd04.prod.outlook.com (2603:10b6:5:24c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Wed, 28 Apr 2021 05:57:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%6]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 05:57:32 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v3] mmc-utils: Add eMMC erase command support
Thread-Topic: [PATCH RESEND v3] mmc-utils: Add eMMC erase command support
Thread-Index: AQHXO57NnhsDqu5+ekuwErAvlXojOarJaxCA
Date:   Wed, 28 Apr 2021 05:57:31 +0000
Message-ID: <DM6PR04MB657542B3CB77F6D894B1EA84FC409@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210427195157.26568-1-luserhker@gmail.com>
In-Reply-To: <20210427195157.26568-1-luserhker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddf5f4e9-d966-4791-1800-08d90a0a837e
x-ms-traffictypediagnostic: DM6PR04MB7115:
x-microsoft-antispam-prvs: <DM6PR04MB7115923DA5ED031C725856FDFC409@DM6PR04MB7115.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yeL9w9Ei/t5Urg9kbKNVnvF6Fqz9g5owyl18M2vn0y+6zRTTpNwmrJfXBRtTA4IXSqLvBDsmMaBOHIwXt54YxZeDxqOZSozmC9ho/AwCgp15EG63Q8+39pWCsFkcSHLb2LVRNRWKOFn+CLsvusIjlVhxAITbJS8t/2tTr1jvyR72YUQp5DGZB6ng17lZ0ksET9WnSQryRE4FecZsX+O+mGIOwvFZwC7Y15Ypd1CxvKk50qg4qRcxBS56A3l9pF8Dw0GhMJQMD6+3OmDZpcQjw0HFifXC+DIuw0AbBPcBcMoKeL9gWY79Fs7uvKziflDUCeN24sOWPTxXzU7XQPyE96Xn2aRipYz/KKjKbSqHzHcj5qet1NPVrafeJZvH1kEP9IZecId/D7fI8c0fehJXSPAWhVVq8C3zrmU8mwLZabMshrJHvTCNux4cZAErlh238aOm0nAZBjTJ+disapxLf5ozsFGcO5e14wXUU7kkE/7tHgIJ/PW6G7UXyF0+40xkgjyQ8Wp9YXMi85C/0V0zSFNMLitjRDQn5wpd/Va2DL2vm++AotITQ56ndGgZdzimgrer1bJ0T0GnvYo+hITd1xN0d3NnvAh4bJe0K2nAxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(110136005)(26005)(9686003)(83380400001)(316002)(8676002)(55016002)(38100700002)(478600001)(64756008)(122000001)(4326008)(66556008)(66946007)(66476007)(66446008)(76116006)(6506007)(8936002)(5660300002)(52536014)(86362001)(71200400001)(33656002)(186003)(2906002)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9xQ3GEAsExmzshw3O0QhP3V0d3DNCmWgs0KmIYwF5010NPu3CQslIPJ9W/Aq?=
 =?us-ascii?Q?ixIQn5++PTqA3p0yGiuB2RguKbQ23z1Pqfwvx+9HC69x+yta5pxO2RoBqRQm?=
 =?us-ascii?Q?V8eFStiPJ+FkEiGuU6rwy/xvuBMUxWrXGssj/QlXqyKkHep15oWsZEIW8ERI?=
 =?us-ascii?Q?yyVAlExEAQzOqRwZgf0Z9ifRp8WbRSlupOvTiIQv1Tt4dezu5eBgYd3KAiap?=
 =?us-ascii?Q?bCFp4tPVnXLPG8TFnvI1rQtrRAPPaPpTLJb8rklLy0zQJiSOyQIqM2EUnGPx?=
 =?us-ascii?Q?OrX7ga1Q7trV3NVatcR4DqLZYsLEvc7+iCW/LEeKCBCSebyRl/E1eKScdx9n?=
 =?us-ascii?Q?2KUXzKPnRSrkCtG8uSVk5tBE9Ox0tHb03sXSDN35EwpSuHo8K0xju2ptdqR9?=
 =?us-ascii?Q?TrtD+BiK7xil2htv3Q4TLK+8gGX3pjJZEoRfQdX+bLiyXiQZ8ySgBj/eIofC?=
 =?us-ascii?Q?wsO3iDMx8kjWrgXarTalABgkcZiULC1HfBaVRCTS/8nfng6DWRsJVnwPVo9k?=
 =?us-ascii?Q?Jl943FAxtMbzD/W8lsGMccnE6Ti8tyrgN6ZY2agRihT5uPibxAkWiAYTO17e?=
 =?us-ascii?Q?ivVZingrOdCyeRdHCz4CTmwI6uc6J8VRfbclgzCEpB7WemYTQ9puA2Hmln35?=
 =?us-ascii?Q?BO0Kq5P3WwHWDmlSo3R1+UoPPTjTwLJywWB82Lq3rMNOdCX5me1uZPwyuB8k?=
 =?us-ascii?Q?XnSc4SPRwKXZzh1iNMKldkKGw1z/7CRSzczpaTmHhEv20vWjuhiIxx8yQisu?=
 =?us-ascii?Q?xWb+1KV3ntrckdi0EFFvvA+OgRCPjAGMA0jPRFRAJizeMKrqZEuWQo0OmFA8?=
 =?us-ascii?Q?464HLPM+8FEtFtvsJlABedzZXhDKhtbxAqtAAEROQJKU0vXzLbtbjYMu22Od?=
 =?us-ascii?Q?/jgl7sXr/0LmHbCcbdNWWAzyjcNcn1WX1mqhGYmpqbODVwzCfjgLbS5M9HuY?=
 =?us-ascii?Q?fBtHPLW5R2vAVK3tjB2pIsnD+hPWS3LPtV/lb3x9Cxd9A9FhS4WNHbVAg0Jd?=
 =?us-ascii?Q?UNAklrdtmaGpZOoeXuAMAmhK0EioXu5TNZGqvD0ME742zC8blUYPjyA5hrf4?=
 =?us-ascii?Q?iNX6h6PvRz5G7zvA8PZhTLrmUHZILXJ264jrjhnCJ+rqC5LmdsNZiV7qEg5D?=
 =?us-ascii?Q?MaDhkG7lutOuEsR0KB0sRoNTi6M7ub5iBTvVbr1GqMwoD3a5PQ03LU37V/tV?=
 =?us-ascii?Q?6NGp+CHbSgXx4qDmzYcF5XfR5azrRHYojryKEV5Amoo/iOt8090WUKTodeaB?=
 =?us-ascii?Q?z7DkGuLVzgH6lCWcmtMrQ9N6493Xu2MH68FE83Bf4HJgqix1TR/dcUOpetGx?=
 =?us-ascii?Q?PHc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf5f4e9-d966-4791-1800-08d90a0a837e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 05:57:31.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4riz3ovP7mcpkDc3reTt3pLEpgPQQBij8RxxxOF6EN3JVHqyMqW29EXesW/F3dqKuLli53Zc02yXfd0A4cYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7115
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Kimito & Bean,

>=20
> From: Kimito Sakata <kimito.sakata@oracle.com>
>=20
> we have been using this erase feature for a while, but it is
> still not merged into the upstream mmc-utils. Especially, for
> the customer, every time when they update the mmc-utils, they
> should re-install this patch again, let's try to make this
> erase command upstreamed in the mmc-utils.
>=20
> We need to send 3 MMC commands and it is important that they
> stay in sequence. Therefore we are using MMC_IOC_MULTI_CMD.

You might also want to indicate on which platform it was tested.

>=20
> Co-developed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>=20
> Changelog:
> v2--v3:
>     1. Remove redundant ifndef
>=20
> V1--V2:
>     1. refactor Kimito's original patch
>     2. change to use MMC_IOC_MULTI_CMD
>     3. add checkup if eMMC devie supports secure erase/trim
> ---
>  mmc.c      |   8 ++++
>  mmc.h      |  13 +++++-
>  mmc_cmds.c | 130
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 151 insertions(+), 1 deletion(-)
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
> index 6c24cea..24f80db 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2514,6 +2514,136 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);
>  }
>=20
> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> +{
> +       int ret =3D 0;
> +       struct mmc_ioc_multi_cmd *multi_cmd;
> +
> +       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                          3 * sizeof(struct mmc_ioc_cmd));
> +       if (!multi_cmd) {
> +               perror("Failed to allocate memory");
> +               return -ENOMEM;
> +       }
I am missing reference to ERASE_GROUP_DEF.
It affects the timeout, size of erase group etc.
Don't you need to query for before starting to build the command?

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
You are not really using eptr - maybe just call strtol with NULL?=20

> +
> +       if (end < start) {
> +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x=
]\n",
> +                       start, end);
> +               exit(1);
> +       }
Start & End are in bytes for media < 2GB, and in sectors for media >=3D2GB.=
=20
Should also check for legal erase group restrictions.

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
Maybe use an enum for the erase type to avoid the strcmp?
Then need to update the usage message.

> +
> +       dev_fd =3D open(argv[4], O_RDWR);
> +       if (dev_fd < 0) {
> +               perror(argv[4]);
> +               exit(1);
> +       }
How do you differentiate between mmc and SD devices?
And for SD you should send different commands(35/36 vs. 32/33).
Do you intend to support SD devices as well? In another patch?

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
EXT_CSD_SEC_FEATURE_SUPPORT might also contains the sanitize bit,
as well as reserved bits that you shouldn't assume they are 0, so I am not =
sure that this condition is correct.
The checkup only refers to bit 0 and bit 4 - maybe add a helper that accept=
 &args and returns 0 if allowed...


Thanks,
Avri

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

