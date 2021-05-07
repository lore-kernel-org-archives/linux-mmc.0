Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4054AC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1878961154
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 06:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhEGGh0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 02:37:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30399 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhEGGh0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 02:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620369387; x=1651905387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmrN5nAQFrHaUrbmq6DCAkxnwDQ8iDf+ziW0/OKP0bQ=;
  b=G2/AvwlofNQOQBxf2U0CmDhFAzeHucE5X8JKmh34kqSxD+eu7UG80Ybl
   6c70YOpKVbwj6RSOZ3cNEp0WdSc4OS9MSngFMZLohtygJxykRtEqQ2S7D
   rC5LXg8HtczdToSK9MPpBz2ZiDtURn1Km6LKxkq7G+koVjJVRoUlboU/7
   04wVOYI0gQG4pPfh+ZooJkbs0T6pGckrWXK3HdYgFPgF7Cszy5w6MHIhd
   z2q/ncDpYE8ORFKocc6wVdTBCZreZZnaHHs2ZlNo7HrlpTJwr4Ks769sG
   smeXrH+rpPtub0iLL/r+OZ0q7tJBAg1kjMjg2ae6A33XBWOwUKFhzzwQE
   w==;
IronPort-SDR: ZT9hi/4LiQufjy9VNpN7jT2/kwkFNugejpuhfoH5BS6CL4NtL6N5IYx9NGTsnEli1G+rIkC1GT
 ttn7ztl6E7BV05EW9vyv+qlarUSoXjik9rKclrp7Za6pLxETdwueag7CZaCVky2BD2X2ebMgdU
 83twX7plbD6ptw0MHfiQwT8lVbqtKRyj012FQcNdVNUr5K/7c8sBq5lo8RfcLii+AHCo/KSBCE
 nkfcy9FDH1ML5YR2orx11Ic4CoFi3fG41TRcMProfKPUSfpOr4vVSnjYlBTLo0aU3VVpImsxTa
 nWg=
X-IronPort-AV: E=Sophos;i="5.82,279,1613404800"; 
   d="scan'208";a="166731485"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 14:36:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvhE7FYh00y1SllMUMaTJD8Ygudpbo1gy5l0jex2KewO6vM7RIJPusP+nmtb1jM4YD949/QFuqCTDTXRmxT0XMusUWacrSr/zMRBbfS7OVeOIDa3vrryq5AWApdd/b5E5EGQDo9i5v9RWtt9Y7CuUmCruKvC8o6fcIS5xD6Iar9u2GywdBwmwCDMv68/U9s3SGdd4AZw2AXp+5odzbyd6jcmZViioVYCGZZ8GIdl1nk1sjMQRfaR8ENKgOdRXFDoct1TczbQWGHmDad/Srn8Ik9zAspp0ml1PZPYE38fJqbSQlClAKbBc49WpDN9msIOqfGSFljdNyKBYfHTYwRiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zskkr4YayZbmzdX7PYDl24/3JIhn4ZhsfeE/HG+o+MU=;
 b=W488Tv+vICRIhgH4A3BzjXBKdBi9VrPoqMyP2zFjq0H0mhnZtc/W1nEsjgCQ2I+I16C9NZblb9pxsMLYs+Zt8ISoA+FUAeu9l554PSirloUDz3HxUZKpgeDdDFiRaAVDAK+uw6i60wvU2Y4VEmFeCshVHbjJ6pckFk4nnOJQEEeh2/CBYrr6iVuuDH1iOhGft5enG/RcAeFbBMssSI7mxjjwwREK5ELU70ITb5WarTu5Wg7QvNZQlg0KmGHIDVjB5IN/yPV/QgaZMi6Eeas3sW2KHrlXHEWPzBtYp9FGZZgGJXDoNuu0mwtNOJ2P+72Cp3uj/uceHR12PlZfULp/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zskkr4YayZbmzdX7PYDl24/3JIhn4ZhsfeE/HG+o+MU=;
 b=uY7U6o4R8Sqpret9jpRgi5cZNME63bWqjMOo6Vl+wscJDxUaFfhFnWx6qfHy6d0rFzSDr3WxL3VYDrvR7a0o281zkgYNKs4seNNrX50CGLf4ARXfp7MsmMO/TQ23CQOwmKMq/hHdrxaTb9BC/HpbpM5tgyUJ5Tpv+T16RgSqun4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4937.namprd04.prod.outlook.com (2603:10b6:5:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Fri, 7 May 2021 06:36:24 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 06:36:24 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "oracleks043021@gmail.com" <oracleks043021@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <kimito.sakata@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Kenneth Gibbons <kenny.gibbons@oracle.com>
Subject: RE: [PATCH v4] mmc-utils: Add eMMC erase command support
Thread-Topic: [PATCH v4] mmc-utils: Add eMMC erase command support
Thread-Index: AQHXQquGi5Ln+LtU6kyXfYwzjwvvFarXkP9Q
Date:   Fri, 7 May 2021 06:36:24 +0000
Message-ID: <DM6PR04MB6575AB417EACE5AF3E006723FC579@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506191041.1178-1-oracleks043021@gmail.com>
In-Reply-To: <20210506191041.1178-1-oracleks043021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e89812fa-cf5b-4196-621a-08d911226f90
x-ms-traffictypediagnostic: DM6PR04MB4937:
x-microsoft-antispam-prvs: <DM6PR04MB4937D9605625106C5F15B3EAFC579@DM6PR04MB4937.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byNdWe/O2UA25np29Rp3XjCeWgIrbK+ZUIguezasjGS0LwLfi3syFjM6axsVT0OPeY8GlR2BkNG4WeF+xt8CF2S6yFvhjfxCdx6IX/BAcTTsfOK8wPBJ6zz0UTqlRzZ5snfWQfz792UJ2/OqfX9ynJh0XmANz3GFkuORn9Cd9++uVEtEDhuvpkfjMWPBgnSjJ8JeK7Znf+KjniAQ4mkL0J2w7BMW64vX6O86j6mdkielu0PS/T+A0fMeyoLebqOdVxRcInC5dpgEgj2OdorX/QnV/fmeKZH2Z0gy8srTad8nH4SAQhNaN97qfq4oULAziYqPfM7A2k5s4lue1EOAKaOPth4tCdl/FsJckVnIWnlT5JcmZmNoBLwkLlEQ1P02DmsprotEwiuVIo/IWDyUZKOHWMfBFnhupN5MbslUpXUH6Xz7GO+P49l35lFOQ6EK7bGScOiVKxlVl8XncIYY4u+tk6Ya47dhauXAA2wWiIgl0sxYzuUrHHiZH+NNF921FF3B2X9Yi9n3idBaR7TOLqsV/m1MsMtMyFAefjCP/zGR0IPJVuoGm6eFjLDxwpoNer0PNMxiRJ65rqs+qD85nuKKe4Dx488RZieEnKTULgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(316002)(86362001)(66476007)(186003)(45080400002)(76116006)(478600001)(71200400001)(2906002)(33656002)(5660300002)(8676002)(110136005)(4326008)(83380400001)(55016002)(66946007)(38100700002)(64756008)(66556008)(54906003)(9686003)(8936002)(66446008)(6506007)(26005)(7696005)(122000001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1SGx+F6Nl9O9MQ2ednJh1qWo1bo33QzZgcSxAZUmViwmVcbWjzl/8oI61/K4?=
 =?us-ascii?Q?eXL7iWh7xkvIajkiB+SQz55sd9zYh3S0HRGxpuSJFMjyVn1BMLiM7e4otxP6?=
 =?us-ascii?Q?NkC4TycKAuq5K9MRzJDyFKMOQDJD5nnrniy0Q6zX0uRMDSagOgQQKkeon/HB?=
 =?us-ascii?Q?Du3I4CWKOlMq77u6Xi69oKN101O1ePtXfGq9zaN5RWKldKV4w4l2tA/cO7XJ?=
 =?us-ascii?Q?H1nVgZUQxXuZsGIkiiVUIFJDUq0Dh0BTi7cw6ya/PkCDUJe4ktGnSL37fTSA?=
 =?us-ascii?Q?d6w9IY/IBhSF5esbfvnoWREvY3Tm6tyPCHlJ5OkXFL80u9kHAJDSOT/aDVvO?=
 =?us-ascii?Q?aRNaONKd9+obYkDN6CPXrlNSL+l3GYYf6b709vUVpbvTb5r6CqdbN3nYLpRm?=
 =?us-ascii?Q?h+0zUPfjAK6bod6sOxgKOnd6l9haqWEaVh9PenFyTXl2lOo1EF+b5KEHZ2qM?=
 =?us-ascii?Q?DOAWsLU3zEwo4JPWx1ajOSdmqV+fX1kZDuZDneINS53P5yhCOzsGUgzdwcGO?=
 =?us-ascii?Q?3may+WmeiQVC+RwphQSM4MdNRwKpKUm/jZDOka/rThaX8Aa4ExyBOlS7KhMx?=
 =?us-ascii?Q?zmMrrWA7d8uo++LoAYOvaxm7SAFmlGht+HFg+DKuISIqI9fIFYUpsJB4Kjul?=
 =?us-ascii?Q?ajRBCqTz/CR4x+Y/DIy+Nnq9xACGuUYeaKl/PA5kmvlCO4WKomCFYJz35EEX?=
 =?us-ascii?Q?9ufGvFrm5eo9ns0WafVoNStddT/dyLoonkdEDlnjdxt6894DzMtrAri7LQXY?=
 =?us-ascii?Q?jirmNL0/D7pdAQ8eFrtziF78dt1rbczwPNWM+9Em0Lge0cDzhtJYEz9s0SCL?=
 =?us-ascii?Q?zTYgVou7jcbFNtnc2LjcNb1m/Z+q9KiBP4WF6vKySdlXkZ2PsklkOW56w9Dx?=
 =?us-ascii?Q?ILvn80PH0vmTvXdscu0NVW+yJAKFas39p4lSyG+Anfln6lFX9EtGDNsgxAKA?=
 =?us-ascii?Q?cEFMojmmHok+t1QFSdqpVfjdWC7j4tlhl88+VPNIspQQRH+fIyW57PH9f3Mn?=
 =?us-ascii?Q?/WSM8w9p31kHgJAbgHCpqvb30m9U3ZzTPIiLxnSXVh48mfyUrrHSiFjehqfx?=
 =?us-ascii?Q?jd6vA2kO8/l3Q0OHO0sK+nNvAmHAomiVM560VRVVDZS1OlshPegUGcY4tv9E?=
 =?us-ascii?Q?ieVdLyT5311LB93HR/WJiDN4Rn8GeNDhHAAXD2uDLawlplOxXq5soF3mulAh?=
 =?us-ascii?Q?/gB3qho5PEoF5IykjwsbaBj+LTF+5jLS1hMnOeBYAI7aQN24dLN/XhMMH5CZ?=
 =?us-ascii?Q?LvJEydUPdL2ZD7L+WLxYDgC10mKrKkGsD70SwTU9H8q3LuenvwcsArYDKxI9?=
 =?us-ascii?Q?2WY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89812fa-cf5b-4196-621a-08d911226f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 06:36:24.6455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGj9oLuwnYesOYzhet86cCkdhBMz3i9uz9nARHegxF9h4d4XFYDaKAues0UKBBUUGaeO8D66ZxDVDifqd8a8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4937
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
>=20
> Co-developed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

This looks good to me.

Thanks,
Avri

>=20
> Changelog:
> v3--v4:
>     1. Replace unused pointer var with NULL.
>     2. Added msg if ERASE_GROUP_DEF enabled for HC.
> v2--v3:
>     1. Remove redundant ifndef
>=20
> V1--V2:
>     1. refactor Kimito's original patch
>     2. change to use MMC_IOC_MULTI_CMD
>     3. add checkup if eMMC devie supports secure erase/trim
> ---
>  mmc.c      |   8 +++
>  mmc.h      |  13 ++++-
>  mmc_cmds.c | 144
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 165 insertions(+), 1 deletion(-)
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
> index 6c24cea..afa85b7 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2514,6 +2514,150 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);
>  }
>=20
> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> +{
> +       int ret =3D 0;
> +       struct mmc_ioc_multi_cmd *multi_cmd;
> +       __u8 ext_csd[512];
> +
> +
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD\n");
> +               exit(1);
> +       }
> +       if (ext_csd[EXT_CSD_ERASE_GROUP_DEF] & 0x01) {
> +         fprintf(stderr, "High Capacity Erase Unit Size=3D%d bytes\n" \
> +                          "High Capacity Erase Timeout=3D%d ms\n" \
> +                          "High Capacity Write Protect Group Size=3D%d b=
ytes\n",
> +                          ext_csd[224]*0x80000,
> +                          ext_csd[223]*300,
> +                           ext_csd[221]*ext_csd[224]*0x80000);
> +       }
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
> +}
> +
> +int do_erase(int nargs, char **argv)
> +{
> +       int dev_fd, ret;
> +       char *print_str;
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
> +               start =3D strtol(argv[2], NULL, 16);
> +       else
> +               start =3D strtol(argv[2], NULL, 10);
> +
> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
> +               end =3D strtol(argv[3], NULL, 16);
> +       else
> +               end =3D strtol(argv[3], NULL, 10);
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
> 2.31.1

