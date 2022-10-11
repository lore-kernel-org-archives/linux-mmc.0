Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F5C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Oct 2022 06:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJKGbE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Oct 2022 02:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJKGa7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2022 02:30:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ACD895CF
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665469856; x=1697005856;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=D+1cwF7lt6HWgb2alUO6cWf3Vmy27BGQARgiEmKdGzM=;
  b=Wh3U0Lmra+zMoBlEfgJUFgldD6q03M+D+zpoAVZ0eqGFau2Du14wesho
   esFd0R0WAL8cN7Y/vvS09PCldqMthUzNx7cdOX+KB0lOtJAkuf4lSt6vC
   vgX3pJQbwR8S2AY67bGQPJ/vCuIjEkPcf8Z2BixQDOVCRE/pTf7A80NBG
   3xwsNORf5gKAb4FstYtg+Cf8hPASLwqmsVxiOZUb2nOrpYcSr4ugIBtFX
   VQN3yUvT0x9W7si5VRvZa7xW3qF2uxbdYYr0iZcOghrEhVChV3z8Z9f+d
   jcbR3BvQZPgawdMMGqrON8bDX5ATMOlkSf2tRcK2ZFCbhqlRSU/50p+jH
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,175,1661788800"; 
   d="scan'208";a="317765355"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2022 14:30:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S97GIHnP08HlDZ9WKrqmaJPrEgWh73yC9HyenwKnc8NVs6sXIeM0WsnuxBvLKVaagiOJclj4JFy5h7SVqKzNR3TC5Fypv6pgYYPtCiXkJc2Rd2sHnHawLlbyrJs5NKLdBiaTzw3pSY2UsgTb9VS5fBhvpF/tLkJO+kPfddA1uCI07Jlbo5/bXsyZCMDw0q4qQENm4fHqPgaxef8lFb3I/WupJoHFVujSmi42CRRhc/kD19+qzrnsOqA7IKTY0w/YlWU15grTN5gZKGoGMMZc9fflYDE3rEGxKWN5is3Q1+ICJsFTl1o46wfMOwzFBbvIJ8EV10a3bGFJs+TK0lA1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EF9OSyNBxnni8aK0eAJP6MnSqN4FQCMa+GRO8xCxrc=;
 b=ib1eeTh+zuigUdfKfhghpmTwp6ddVA900ZRtBVbhYjdEGK7cDNFQtYiQ5idgHrrZb74ChJcXgDlY+8AL/XTy2dz+Hwkzu19RmmKo3NTIyb7QR1jqeYmoAYHy4EL3pcoFes7akLCGydJ6hx5jj3alTxm00OJ/tg2aOu/sJN3qjuVCuWoNAvD7e+aCabRggqxHKFxreXTOrMxkhnEiTBFYJBQu4vmUKpyQhw+xf97qVwd1Kgf9m1DJPvxS2Vvae7U11usjfj1Qk19luyscsthYmUYrcdvQYDeaDSv6ph2FlRwgyLWfYJnPPOGFJFVR3A3Db73NaWCLLb5KgY41JILpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EF9OSyNBxnni8aK0eAJP6MnSqN4FQCMa+GRO8xCxrc=;
 b=GD2ANVxolX/rGkjClTPIZaOefta3oFpKzH5EqBqvjJCLHn4TSbntEN3rgGfdA986Ku3UNfEz7QwWUnYpBT6DxIjUO218PrTcgQ3ML11tih0OOg3doNtRaegRWDbql40tY4Ddw9pa9WZu7G86gHyFzEwYnWnHGvnh2uhjKJO4gLA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB0530.namprd04.prod.outlook.com (2603:10b6:404:92::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Tue, 11 Oct 2022 06:30:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 06:30:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Topic: [PATCH 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Index: AdjcsYDW5DwYIKhGTcWDMha37dKSlwAh3tQA
Date:   Tue, 11 Oct 2022 06:30:52 +0000
Message-ID: <DM6PR04MB6575E8EC138515A1E16E17CAFC239@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <e0a51700e7ad4f8a9af3d6f95fc9e905@hyperstone.com>
In-Reply-To: <e0a51700e7ad4f8a9af3d6f95fc9e905@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN6PR04MB0530:EE_
x-ms-office365-filtering-correlation-id: 98eb6a5b-fdaf-401f-ad44-08daab52253d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctsLj0rrOrIL+8dCKC1jYQD0f+C3RxE9c5xwiQ/CiEbIQnbETLcCPaDIjRJtkkSCp4xFPNIvClOajr9bAbbp6v/B+zkyn7EGF/uOjd0gaH8iOs39Z1H9SGOVPMr1fGzfiYyEvigLjct5ENdFwubsiTe1MEhsRxGsBGC+9bvO+oFXmwPercHBlBc9PkkOqbiz8TYekcqbjJSZrsDQrp/dLuXXP/VCwbgOshDm9fi/maA/7p1Ct8mZiRZ+PFpcoAMktaso3Osz+m/h9UXFzolnLnKdgvbTocRgLMLqjwVBub/lGhJfIuD/yUurwGyuIT4mgnfk2Tc9NoVeT3ylL8IdO+4u8442+cKCpHvhCuQYSprJKcZTY6AoPIN5QPk/JtbGHOp+pXOO6J6HxmMh8BOoZUMRQX3iJ+vOjnFLtXo6vM7xYF+A0IzD1iZ68OqpDoLA/5ofQYZiAmAi2QroFK+OA2EWmNlpKjMTMuKR+bEQHiB6qN+UgP/bIHq87Ng3HR2Kdw8j+yvhPr0vDLrwu+Y+k+FaNMOa+YKQniMSWJzT30Rg/epy5VU+CSjm6pRMGRlPeMOHDy8CGfes6YxLALPulDjN7BUyn+P/byvjgTALyrTULV8ZvQ37AF5diOaCsHGFTs5SKdAPZIXZDEsVjRQjcEevyVHfSmxjX056uBTmLbdirADU+r4XlzoUtu1xTLzhqQINZoSU4k6rMkI6mbPPn25OB5PngLs3Gva0f3/QTEHyFrbJnoQ+aq/4yOKraHUckUwNwEKHnwMNpFnPATTLfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(110136005)(316002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(478600001)(7696005)(122000001)(9686003)(52536014)(30864003)(26005)(8936002)(82960400001)(2906002)(5660300002)(6506007)(41300700001)(186003)(83380400001)(38100700002)(33656002)(86362001)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wmr/Fc1aet8VvCFzorG1soNjUoz8NXAfX95OxOAPTgrOs9Cr+srB81rRLJ?=
 =?iso-8859-1?Q?pp9Oi34XplTRH4X4HMPZlaqmNl0r9nMNieVYreMu7Xq2F5O8zBegvOAzsg?=
 =?iso-8859-1?Q?nthS7EbCjBkbt8a7VY8HISxUM2mhUyurDTghwfRoKev38AeCl6Zj9h9OcT?=
 =?iso-8859-1?Q?Lqfr3nbgEBmNyKXfpY549O5QoSulrREmJ5UjbA0qhmaBdrJISQ1DBIz/zL?=
 =?iso-8859-1?Q?ujgJLbHuSjVn15e8nUlSTxeh138ITAcPRo77oafmBKFNbpVL3C1efWjYp8?=
 =?iso-8859-1?Q?d7+GZ/mPA6SXy3chPlz9NS7C883DGfUBIsdPin3fE7AT06zHIAcUdb3fYB?=
 =?iso-8859-1?Q?a7mBBUgbT5JpTj/+jd59rXrmu+gWBENi8CUfeQRvnKEvPQwxzh0pWIYe7d?=
 =?iso-8859-1?Q?evVzAIjYmam2awc45eoALJG+7M2gYY97Ym/cq+d1IKeFpLfVMk0qZsFzTp?=
 =?iso-8859-1?Q?SaP0TpaQBeZpf0kZPlQn4CcKQZLywPVdQ/Dh0rJVSPx3aSHyx0RbVRb/rF?=
 =?iso-8859-1?Q?vKwkGxTKGvfUR5Uqr/U4wx/UMYmRoNbHTUhjWBp2T2ZBjK0/LgrbBd+s3E?=
 =?iso-8859-1?Q?LzKMYgH1NIMxzEdMVeS4Yfbf/rJ3gdnXgz2yEHDDsr2/EY32p7b2Rsflg0?=
 =?iso-8859-1?Q?vOjMcYkqIoJzIPuQQWq5pn/ATLUJ+HNPh38sPqC0h6eNLmAWwpfOMjCEMQ?=
 =?iso-8859-1?Q?frpmZkLbKqdScobtT19ZQalxjVxC5vzixRZSGkRWXLKKeoU019elTY9K73?=
 =?iso-8859-1?Q?clKOHeSVV41thVaqXP9I8HI9WSBB7t7XS4lWT6nd0R11Wy+LUKWCIOeDiZ?=
 =?iso-8859-1?Q?UoM+ur7d/DzYxtZ60uZOGRGBeYRH5d7pIe+SSPhOXeQKuDTRs34IuX79/L?=
 =?iso-8859-1?Q?QrN67IIfXSNTc3YOCzpyn5+cbvuQF/FVsSgMus0m68elUda05ChZutBE/W?=
 =?iso-8859-1?Q?cUWBXKmyWepKpNK3g9W991MJkJoGGHqOU17EvE9NfukDJx3vIugnnF1kMF?=
 =?iso-8859-1?Q?Qc2nChPzgGBdW3oWbnhhNtVMwQLcx8OPB9ofx0ngmURvoXcOu4TBD7RX3H?=
 =?iso-8859-1?Q?w9QrqQoAAnE62xaoXY9bXId4YFXhJ+lt22jFNWTDAMROl3EVYIMOH2Po7T?=
 =?iso-8859-1?Q?Ls2RGl6HrUmbm07GV2sC6plktn/c6IBpJ25HYybkj51owCaCW8RdcADLZx?=
 =?iso-8859-1?Q?UXY/zqkth5UjdFt9hT0h6cNPEeqBTbRu9cPcOEF9RKz+41I07FchB/+SnP?=
 =?iso-8859-1?Q?Nwf5Non4tdlJ4x8UeSU/WET+nWA0u56bpz21Fs2egmjq5ta1A4jLk62Coj?=
 =?iso-8859-1?Q?JgdhydmyIo5nx6nRPP7wxBySTCs+ICU1buWWt/rLVD0R4BBOC+P5WX5Jbm?=
 =?iso-8859-1?Q?sJ6ksMlib4BaU4ivKwggzVtQUVVKa5hcpxRU/ElKFTArH8qyOFp87iPR7m?=
 =?iso-8859-1?Q?wIJ5l/ue3bk1c+beZaQbWX5yuEz1K0zB2AvsrZBI32XsfbV8EjwNMWlVcu?=
 =?iso-8859-1?Q?U2rm81XvlGFrtmLJxyPxe2frLv9PyoHqB5nG65uKR2Ax5Mu4FDo9iqYIES?=
 =?iso-8859-1?Q?qk7nw/IEO6fAOTjcJoep8wpYZT3L09KhxmXNSlk5ifzYc7ZdlTt4801rj0?=
 =?iso-8859-1?Q?mktyuTUbRCUVpSKmMe65COBHBDtUaT0N/m?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eb6a5b-fdaf-401f-ad44-08daab52253d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 06:30:52.6188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMTv2QNtReKeAsMg8vmU/NVZv3LttGLWujgyXvDoUUl/tn+xaS0oME1kNgZ3jQyYqdpc2+4eVtzFRq6zJPlQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0530
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
=20
> Certain commands require a longer switch timeout.
> Refactor accordingly to allow e.g. for future sanitize.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Please include a cover letter when your series is more than one patch.
You can use e.g. the --cover-letter option of git format-patch.

> ---
>  mmc_cmds.c | 80 +++++++++++++++++++++++++++++++++++---------------
> ----
>  1 file changed, 52 insertions(+), 28 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2957aa9..4278b8a 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -54,6 +54,8 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> +#define SWITCH_TIMEOUT_MS (10 * 1000)
Maybe MMC_BLK_TIMEOUT_MS so it is clear we are aiming for the driver's defa=
ult?

> +
>=20
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
> @@ -76,7 +78,7 @@ int read_extcsd(int fd, __u8 *ext_csd)
>         return ret;
>  }
>=20
> -int write_extcsd_value(int fd, __u8 index, __u8 value)
> +int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int
> +timeout_ms)
>  {
>         int ret =3D 0;
>         struct mmc_ioc_cmd idata;
> @@ -89,6 +91,7 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
>                         (value << 8) |
>                         EXT_CSD_CMD_SET_NORMAL;
>         idata.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +       idata.cmd_timeout_ms =3D timeout_ms;
I would expect here: if (timeout_ms > 0) ....
And setting timeout =3D 0 for all callers except do_sanitize -
which your forgot to include.

Thanks,
Avri
>=20
>         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
>         if (ret)
> @@ -341,7 +344,8 @@ int do_writeprotect_boot_set(int nargs, char **argv)
>         value |=3D permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
>                            : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_WP, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_WP, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", @@ -508,7 +512,8 @@ int
> do_writeprotect_user_set(int nargs, char **argv)
>                         break;
>                 }
>                 if (user_wp !=3D ext_csd[EXT_CSD_USER_WP]) {
> -                       ret =3D write_extcsd_value(fd, EXT_CSD_USER_WP, u=
ser_wp);
> +                       ret =3D write_extcsd_value(fd, EXT_CSD_USER_WP, u=
ser_wp,
> +                                       SWITCH_TIMEOUT_MS);
>                         if (ret) {
>                                 fprintf(stderr, "Error setting EXT_CSD\n"=
);
>                                 exit(1); @@ -526,7 +531,7 @@ int
> do_writeprotect_user_set(int nargs, char **argv)
>         }
>         if (wptype !=3D WPTYPE_NONE) {
>                 ret =3D write_extcsd_value(fd, EXT_CSD_USER_WP,
> -                                       ext_csd[EXT_CSD_USER_WP]);
> +                               ext_csd[EXT_CSD_USER_WP],
> + SWITCH_TIMEOUT_MS);
>                 if (ret) {
>                         fprintf(stderr, "Error restoring EXT_CSD\n");
>                         exit(1);
> @@ -571,7 +576,8 @@ int do_disable_512B_emulation(int nargs, char
> **argv)
>=20
>         if (native_sector_size && !data_sector_size &&
>            (wr_rel_param & EN_REL_WR)) {
> -               ret =3D write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR,=
 1);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR,=
 1,
> +                               SWITCH_TIMEOUT_MS);
>=20
>                 if (ret) {
>                         fprintf(stderr, "Could not write 0x%02x to EXT_CS=
D[%d] in %s\n",
> @@ -650,7 +656,8 @@ int do_write_boot_en(int nargs, char **argv)
>         else
>                 value &=3D ~EXT_CSD_PART_CONFIG_ACC_ACK;
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", @@ -720,7 +727,8 @@ int
> do_boot_bus_conditions_set(int nargs, char **argv)
>         printf("Changing ext_csd[BOOT_BUS_CONDITIONS] from 0x%02x to
> 0x%02x\n",
>                 ext_csd[EXT_CSD_BOOT_BUS_CONDITIONS], value);
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value=
);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value=
,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", @@ -771,7 +779,8 @@ int
> do_hwreset(int value, int nargs, char **argv)
>                 exit(1);
>         }
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr,
>                         "Could not write 0x%02x to EXT_CSD[%d] in %s\n", =
@@ -825,9
> +834,11 @@ int do_write_bkops_en(int nargs, char **argv)
>                         fprintf(stderr, "%s doesn't support AUTO_EN in th=
e BKOPS_EN
> register\n", device);
>                         exit(1);
>                 }
> -               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_AUTO_ENABLE);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_AUTO_ENABLE,
> +                               SWITCH_TIMEOUT_MS);
>         } else if (strcmp(en_type, "manual") =3D=3D 0) {
> -               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_MAN_ENABLE);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_MAN_ENABLE,
> +                               SWITCH_TIMEOUT_MS);
>         } else {
>                 fprintf(stderr, "%s invalid mode for BKOPS_EN requested: =
%s. Valid
> options: auto or manual\n", en_type, device);
>                 exit(1);
> @@ -1002,7 +1013,8 @@ int set_partitioning_setting_completed(int
> dry_run, const char * const device,
>         }
>=20
>         fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
> -       ret =3D write_extcsd_value(fd,
> EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
> +       ret =3D write_extcsd_value(fd,
> EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to "
>                         "EXT_CSD[%d] in %s\n", @@ -1188,7 +1200,8 @@ int
> do_create_gp_partition(int nargs, char **argv)
>         gp_size_mult =3D (length_kib + align/2l) / align;
>=20
>         /* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to EXT_CSD[%d] in %s=
\n",
>                         EXT_CSD_ERASE_GROUP_DEF, device); @@ -1197,7 +121=
0,7 @@
> int do_create_gp_partition(int nargs, char **argv)
>=20
>         value =3D (gp_size_mult >> 16) & 0xff;
>         address =3D EXT_CSD_GP_SIZE_MULT_1_2 + (partition - 1) * 3;
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         value, address, device); @@ -1205,7 +1218,7 @@ in=
t
> do_create_gp_partition(int nargs, char **argv)
>         }
>         value =3D (gp_size_mult >> 8) & 0xff;
>         address =3D EXT_CSD_GP_SIZE_MULT_1_1 + (partition - 1) * 3;
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         value, address, device); @@ -1213,7 +1226,7 @@ in=
t
> do_create_gp_partition(int nargs, char **argv)
>         }
>         value =3D gp_size_mult & 0xff;
>         address =3D EXT_CSD_GP_SIZE_MULT_1_0 + (partition - 1) * 3;
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         value, address, device); @@ -1226,7 +1239,8 @@ in=
t
> do_create_gp_partition(int nargs, char **argv)
>         else
>                 value &=3D ~(1 << partition);
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CS=
D[%d] in
> %s\n",
>                         partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);=
 @@ -
> 1240,7 +1254,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         else
>                 value &=3D (0xF << (4 * ((partition % 2))));
>=20
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %=
s\n",
>                         value, address, device); @@ -1317,7 +1331,8 @@ in=
t
> do_enh_area_set(int nargs, char **argv)
>         enh_start_addr *=3D align;
>=20
>         /* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to "
>                         "EXT_CSD[%d] in %s\n", @@ -1327,7 +1342,8 @@ int
> do_enh_area_set(int nargs, char **argv)
>=20
>         /* write to ENH_START_ADDR and ENH_SIZE_MULT and
> PARTITIONS_ATTRIBUTE's ENH_USR bit */
>         value =3D (enh_start_addr >> 24) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1335,7 +1351,8 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D (enh_start_addr >> 16) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1343,7 +1360,8 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D (enh_start_addr >> 8) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1351,7 +1369,8 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D enh_start_addr & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1360,7 +1379,8 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>         }
>=20
>         value =3D (enh_size_mult >> 16) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1368,7 +1388,7 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D (enh_size_mult >> 8) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value,
> + SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1376,7 +1396,8 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D enh_size_mult & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value, @@ -1384,7 +1405,8 =
@@ int
> do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] |
> EXT_CSD_ENH_USR;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
>                         "EXT_CSD[%d] in %s\n", @@ -1455,7 +1477,8 @@ int
> do_write_reliability_set(int nargs, char **argv)
>         }
>=20
>         value =3D ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
> -       ret =3D write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                                 value, EXT_CSD_WR_REL_SET, device); @@ -2=
587,7 +2610,8
> @@ int do_cache_ctrl(int value, int nargs, char **argv)
>                         device);
>                 exit(1);
>         }
> -       ret =3D write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr,
>                         "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

