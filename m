Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25221C04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 12:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJYMk6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYMk5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 08:40:57 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D01849A3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666701655; x=1698237655;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5Sm6+KVNgQesMuMxuTiDoOWtK8C4U3q16AjiNTev5Ik=;
  b=NjVNYeqqXJgp/VvXRR/S33mg+L15wPlVkEH5xvAYEBAQaibC6CW9eclM
   YNVpfAm7QRSpJPv6cVd0IE5IpOcRcW3h4GS4eMoMrIz+XuaHOWYk3WhEo
   H4E0hD2AYM1VBSVltdTC/oKVO48aEnSCdu8Cl2sIA3cMqR3Si4FWfTJXc
   Q/2QYUBnCkdaDZr6imdHQMG0uP1pIKi3whce3LAH6Kz+dWQcgEgUwT5yj
   3UBoK5cmBnbtFpgSLPSpsYVbW4cSoL9IlmO4Qq7h8gny1CR4+6mojOSgt
   29hjQKbIfjpzCH0+NNfrwhdpbP1r6ZtcQsh0iMOo/S1SD9d6NzIi6wKnv
   A==;
X-IronPort-AV: E=Sophos;i="5.95,212,1661788800"; 
   d="scan'208";a="319009197"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 20:40:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MREsVfDNbd0jdUkUhyKEeIj08Mbm0VphWUZDIg596FjJIAg81M7qadkidPy/FxBFrJOetd6qZ17GYyUAS/7pk+kz1dR2UOK5/tYRgDKSNqI/9czeuUPVknqszwnBnG5Vxx3FSgdPHZTRVumPCcryyjuqEx3rkPJIIosopq9dYroYXXFthYlEKAeCc+IVIezfEc9GVVKBOTctYT4vXgXkp8C5jei/Ls14yWatHQnu2fnqU6z1lbmQ+GrOIFzHHORfellGOPgvkwT9HyvnLdhmFFQLYwlcAuucowQig/TQeelBEBRtaLV2FGkkn4G+gLr1np9IR/kSzV+H+vuvGGU5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SlkyOFmY/IN+avTvwzeTDw0L01z0mE7/P2oPjZCSJY=;
 b=DmSrcmi6Eg1By6aBjxp2Dav0tNBbWlrTmNJgUcmYzoShg1L9/9w/q8rwikl+KqvCyvX8nTDDeD4ta7vX1GSO2DG3lLVYPErNJVSKJSJG/rJrg2JMJHhlJ6wZjhTCxKOa43jav4d49pJKWYydaqzoa8CBdmQq2mW1mSiNoWKgpWroBcGffgpvY372ih6yNv554485Lu4qT0gYaTAySMy9cK9Re+j19sOwobG1Js9Tn1EpHRiVPnmy1nO+B35XWvqdS2AT5cOO9RmAK0rcTHWXB+aeTTRAK+aaa06VG3WxFwtSLxQnb0LAdBIud+qErNJHxHUb+4lQwQLZTtOF6B3dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SlkyOFmY/IN+avTvwzeTDw0L01z0mE7/P2oPjZCSJY=;
 b=I64zMTQDFY1rXTO7Wu8FSyfS2VBOgYM7bouVeKGRqgYepBow6tdNLnriYuLJrE3eLshcZipzurzhJoKfnx1w/UrobxNd0W22veTYCDnouq06lTjcWXi7qkPMn6S5jJK97EurUQwOsphzexrfYfVrYi8jpv70l2QJtggfGeSONrY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7282.namprd04.prod.outlook.com (2603:10b6:303:70::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Tue, 25 Oct 2022 12:40:43 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.025; Tue, 25 Oct 2022
 12:40:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Index: AdjnzoBSTaQo1pFFRXi0S56OT7wLqgAjLvCg
Date:   Tue, 25 Oct 2022 12:40:42 +0000
Message-ID: <DM6PR04MB6575BC99A106EE2D430CA9BAFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <d4ac7077d94743ed91c1b2b81fc5e164@hyperstone.com>
In-Reply-To: <d4ac7077d94743ed91c1b2b81fc5e164@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7282:EE_
x-ms-office365-filtering-correlation-id: 22d3fbea-9de6-48b5-bd35-08dab6862186
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTcX1IyLIzEMZxYgZtCCkCLgOi6jexWOnRPJ0D3DUsc/efj53J3bbrnR+dgGbUQVStz7CU8MPS5Y1BtYcUoxeMMbWkk/Ge24Onz0EWOxc3cxEmYCKK4kbUkvEJjhzmIxGjr9o4YxkLRprF+g7lTn+QKoIANwTDxkfQLG10yppWMKras0R75qzikiLeo4afcz2UKR/ijdmqs4iLk9y4f75K6M3FzY3UjLJe1WBkRePi8koxHtUwYSlZHUCZjxjIq1po/KVFG7+fmASu4bj1sq4981p/6U+JoQ1peax8zRIrDVpEBpiqeGtw1nOcX0ysiCVrtBcarB8AGagOfiBfEQIJ3WsDGrhf5F7zf/I96MucjBDu2QLSk9Z6PSOUx/KxTFllXFBR645ptlCPWpaR9I3MzSwPVhWwPI3nXLU5Zm3RE4LkLfKYiogo5VMUboDEyTpvEmxWJybsmJhP1y9UOQ9GyhB2kjTsnp5+XfF/iYqetQj5WxMGoyXhLLFEU5ngrvEpk7O3gHwAa9JXrsl2XJ7jSDm6NjzfV5MJaPFSqq9GPIlcOn9ukCE9aOrbFC5LSLi96o8VEYe5TskyIRewGYUPsv7Kn4kEu37ry0ZSKLF95afXf/w0vYx3xaZ3Ajb1UlMCNkBivvuZKe5TI/Av1VBEoviXsVqv5X4y6yhw7nF67xOVDcEM66C54dCcuhFuX4DG0gxzIGVwF/9GZJigfe8nIl/nSULlnWl5Y9Tf6bHKQcxbs8rtUmFCGnd3PuB4/Km5ZNjgUHqVUIZfqwxuoWxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(55016003)(8676002)(41300700001)(316002)(478600001)(122000001)(38100700002)(82960400001)(8936002)(83380400001)(52536014)(33656002)(71200400001)(110136005)(38070700005)(5660300002)(86362001)(40140700001)(66556008)(66946007)(2906002)(186003)(66476007)(7696005)(66446008)(26005)(64756008)(76116006)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?isOc+Wup3J1i5bhHd+gmvjoINed3emYTzDikJdlIbH6pdPMAOC1dMJ4UqE?=
 =?iso-8859-1?Q?AbBTD/1CnVFM8faCYIltyQct0uKlBSoR1eYV6XxOEaxAznY6eR3CaW9eg5?=
 =?iso-8859-1?Q?gt4g+jr1vDCq69XHV8qcwJ822Xnvn+4JJBZV7iOU529/5IZ9CJ05MCW5JL?=
 =?iso-8859-1?Q?kDSvn0DfIrFuvNi0sInzEdBK+G43+KbNOOn8///ZLS9syh+S7MOk8+mHpM?=
 =?iso-8859-1?Q?2l4cFRVaLmzJNYfGYzuzSMjpsU9lmMV7a7J5n9nFMIge38Z76TaY2Ub4UU?=
 =?iso-8859-1?Q?xoZZz6pC+L9eIdrR2Ss6T8WvgZoA/Wvk/sN85w0ptSNwXXMAi1I3G6nHYg?=
 =?iso-8859-1?Q?7WSbEvREMnPbHHRNCU8QwiQ/76vPzwttWOmIruXWr/Pa76eU63Xn7daLPm?=
 =?iso-8859-1?Q?0Id0yTcK4WjIhgJw3imcZ73f1Bvs7b/yPvBGe+HzwRPB2vNTgOKga69K6/?=
 =?iso-8859-1?Q?NThMC4Sc6WfmhXdF8UoUIWk8Q1XROqrs/8qGtcLgaoPyiELKvbA/9gabmw?=
 =?iso-8859-1?Q?PYkxAncgBRwdxkmAXBtpMvWrmIidOcd6EqGoq51+0rstnZ+PEP7fuPQps/?=
 =?iso-8859-1?Q?yjkH5H/VQz7knqNt7RIvcIoj2dHhcQSX5ofU98NKvMOWu+Okx2LmpyUJRU?=
 =?iso-8859-1?Q?sODw9PsWV+Ftv/7c7yGgJ0hG2y+Eo2zysjUr8xAfv5WNcGdjCINChBg+nv?=
 =?iso-8859-1?Q?ESzw4z5geWThUhChouuKt1EUY+t9zjVPP7q8LbFkuaDlZQHV/9G6EtXKLi?=
 =?iso-8859-1?Q?OF3qp6QnSOqFVppHCuZ68ViG4D1dUyBLoWe7a0XdMIHhX2b1YNtnEtstjj?=
 =?iso-8859-1?Q?U0xHTo+vWESfopg0zF63VR/xzNJaNl+IUTMNn3CQFZYt0nQca7hI0Xmn7t?=
 =?iso-8859-1?Q?0uVuEL6rG0wEu3Ux56DjrXbax+VrOhfxp7IR9B4sW83jkYkXEek68S1LpV?=
 =?iso-8859-1?Q?NM99yXZHDe+c6zRaKOIvRTHmt2Z1cOAXdl/3BpOt4PhU4LBN+7HoxVLXPD?=
 =?iso-8859-1?Q?1HpyyBcXOr8akw5VuxsZoQ/Mk4eVULGZ73+ZvWMOPZb/XZiGsoH4e3cnRe?=
 =?iso-8859-1?Q?62y8nl5l2RSJ8D0quqVXzmGOG4IJLclw05PG1JIUMamecmjWxitpT32pPm?=
 =?iso-8859-1?Q?RCCFJhnQZzAaQR5lmtAdaXd2ggL0dOm9oSjd473Cxp8xa23lvAbTDUxMeB?=
 =?iso-8859-1?Q?Cr+1TC9h+APjm33xh9LhgIbFv2waeE7dNKs10Vz1DBKxHufSZzWprAB+rU?=
 =?iso-8859-1?Q?AJO/LKRkYl+T/c5AxcO4jNc54cYSgF5Iwh4VZ8SF1WxQ859cp6Rx6hU9eg?=
 =?iso-8859-1?Q?kuDKdPITHq8NAHUicZ4PQdq8EvK1LObxObnf7A0bRWyPLVsE/87g9RJupx?=
 =?iso-8859-1?Q?6NMDOpAsv/ZF9HEW4dvtYqgCvn/DbXLlaR4IuRIzXEJZnxP2w2jNlQDpVO?=
 =?iso-8859-1?Q?gw5EjU5BB2Y0HcG3sArCrIJEEJDdVToA21aWd62kZGTdRC8/ebd5Dby3HZ?=
 =?iso-8859-1?Q?aApt0TZ8vdPU6Pnake2gLIJlgf4YBLUSWTO9gXs/1LRASJIbV37DIq1Rmt?=
 =?iso-8859-1?Q?c+T8Fbn6KpMR+Ac3akpg4cSNaPAZ22rRu2cZV70bZx3Ikb6/LXk5yLvL2k?=
 =?iso-8859-1?Q?PKA0CjQAHZMjckgECzHGo06+E/kK+i3V8R?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d3fbea-9de6-48b5-bd35-08dab6862186
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 12:40:43.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkTcY5vl0Kf494L2q9jEcTfMNefqQsSQWgAxrKvdgWiA1q1X6wL7xI+rsK+c37Sae3eG7XkSqE+gf0+I+3Bevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7282
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Implements the alternative boot operation for eMMCs.
> Note the limitations of the help.
>=20
> This is mostly useful for testing purposes if you set up the boot partiti=
on
> configuration correctly.
>=20
> Usage:
> $ sudo dd if=3D/dev/mmcblk2boot0 of=3Dbootdatammcblk count=3D2
> 2+0 records in
> 2+0 records out
> 1024 bytes (1.0 kB, 1.0 KiB) copied, 0.00482308 s, 212 kB/s
>=20
> $ sudo ./mmc boot_operation bootdata 2 /dev/mmcblk2
>=20
> $ diff -s bootdata bootdatammcblk
> Files bootdata and bootdatammcblk are identical
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  mmc.c      | 12 +++++++++
>  mmc.h      |  1 +
>  mmc_cmds.c | 76
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  4 files changed, 90 insertions(+)
>=20
> diff --git a/mmc.c b/mmc.c
> index 170ee39..f328585 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -255,6 +255,18 @@ static struct Command commands[] =3D {
>           "Issues a CMD0 GO_PRE_IDLE",
>           NULL
>         },
> +       { do_alt_boot_op, -1,
> +         "boot_operation", "<boot_data_file> <boot_blocks> <device>\n"
> +         "Does the alternative boot operation and writes the specified s=
tarting
> blocks of boot data into the requested file.\n\n"
> +         "Note some limitations\n:"
> +         "1. The boot operation must be configured, e.g. for legacy spee=
d:\n"
> +         "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2\n=
"
> +         "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
> +         "2. The MMC must currently be running at the bus mode that is
> configured for the boot operation (HS200 and HS400 not supported at all).=
\n"
> +         "3. Most hosts cannot do transfers of the typical size of the b=
oot partition,
> adjust <boot_blocks> accordingly.\n"
A redundant arg?
Since blksz is 512, Maybe just set it to be ext_csd[226] * 256?

> +         "4. The MMC will perform a soft reset, if your system cannot ha=
ndle that
> do not use the boot operation from mmc-utils.\n",
> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>=20
> diff --git a/mmc.h b/mmc.h
> index 6511dbc..98fad16 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -24,6 +24,7 @@
>  #define MMC_GO_IDLE_STATE         0   /* bc                          */
>  #define MMC_GO_IDLE_STATE_ARG          0x0
>  #define MMC_GO_PRE_IDLE_STATE_ARG      0xF0F0F0F0
> +#define MMC_BOOT_INITIATION_ARG                0xFFFFFFFA
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA      =
  R1  */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3db17e1..1da61d4 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3101,3 +3101,79 @@ int do_preidle(int nargs, char **argv)
>=20
>         return 0;
>  }
> +
> +int do_alt_boot_op(int nargs, char **argv) {
> +       int fd, ret, boot_data_fd;
> +       char *device, *boot_data_file;
> +       struct mmc_ioc_multi_cmd *mioc;
> +       __u8 ext_csd[512];
> +       __u8 *boot_buf;
> +       unsigned int boot_blocks, ext_csd_boot_size;
> +
> +       if (nargs !=3D 4) {
> +               fprintf(stderr, "Usage: mmc boot_op <boot_data_file> <boo=
t_blocks>
> </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +       boot_data_file =3D argv[1];
> +       boot_blocks =3D strtol(argv[2], NULL, 10);
> +       device =3D argv[3];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open device");
> +               exit(1);
> +       }
> +       boot_data_fd =3D open(boot_data_file, O_WRONLY | O_CREAT, 0644);
> +       if (boot_data_fd < 0) {
> +               perror("open boot data file");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               perror("read extcsd");
> +               exit(1);
> +       }
One line space please.
Also, need to check alternative boot support: (ext_csd[EXT_CSD_BOOT_INFO] &=
 EXT_CSD_BOOT_INFO_ALT)

> +       ext_csd_boot_size =3D ext_csd[226] * 128 * 1024;
> +       if (boot_blocks * 512 > ext_csd_boot_size) {
> +               perror("Requested boot size bigger than boot partition");
> +               exit(1);
> +       }
> +
> +       boot_buf =3D calloc(1, sizeof(__u8) * boot_blocks * 512);
> +       mioc =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                          2 * sizeof(struct mmc_ioc_cmd));
> +       if (!mioc || !boot_buf) {
> +               perror("Failed to allocate memory");
> +               return -ENOMEM;
> +       }
> +
> +       mioc->num_of_cmds =3D 2;
> +       mioc->cmds[0].opcode =3D MMC_GO_IDLE_STATE;
> +       mioc->cmds[0].arg =3D MMC_GO_PRE_IDLE_STATE_ARG;
> +       mioc->cmds[0].flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +       mioc->cmds[0].write_flag =3D 0;
> +
> +       mioc->cmds[1].opcode =3D MMC_GO_IDLE_STATE;
> +       mioc->cmds[1].arg =3D MMC_BOOT_INITIATION_ARG;
> +       mioc->cmds[1].flags =3D MMC_RSP_NONE | MMC_CMD_ADTC;
> +       mioc->cmds[1].write_flag =3D 0;
> +       mioc->cmds[1].blksz =3D 512;
> +       mioc->cmds[1].blocks =3D boot_blocks;
> +       /* Access time of boot part differs wildly, spec mandates 1s */
> +       mioc->cmds[1].data_timeout_ns =3D 2 * 1000 * 1000 * 1000;
> +       mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
Don't you get "010" prior to the boot content?
Most cards have their EXT_CSD_PART_CONFIG_ACC_ACK bit set.
So you need to eliminate it from the boot file?
But your compare show that the files are identical - how so?

> +
> +       ret =3D ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
> +       if (ret)
> +               perror("multi-cmd ioctl error %d\n", ret);
If an error occurred - do you still want to output the boot file?

> +       close(fd);

Don't you need to send CMD1 to terminate the alternative boot sequence?
Without it, isn't the card stack in Card-identification Mode?

> +
> +       ret =3D DO_IO(write, boot_data_fd, boot_buf, boot_blocks * 512);
> +       if (ret < 0) {
> +               perror("Write error\n");
Free whatever you alloc'ed

> +               exit(1);
> +       }
ditto

Thanks,
Avri
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index faab362..5f2bef1 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -49,3 +49,4 @@ int do_erase(int nargs, char **argv);  int
> do_general_cmd_read(int nargs, char **argv);  int do_softreset(int nargs,=
 char
> **argv);  int do_preidle(int nargs, char **argv);
> +int do_alt_boot_op(int nargs, char **argv);
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

