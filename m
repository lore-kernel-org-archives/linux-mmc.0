Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCEAC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 08:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJMITp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJMITo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 04:19:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F332AA
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665649176; x=1697185176;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uJRKSiZCTSqGvk2k5hXhMFoX111jnQ6o6Oc82CT8fgE=;
  b=jL9LikEpXGyafzqHyX533TDVssJtyZ7bzW21o5cu/OoA0U58lFUWpSLl
   IAMvpsxMB7Nlb+d8hGF0281K0aJY5S3yjGZXvwx+rhqb80DxYnQLkhBFF
   GPkbMQI3XhJUS/2T01QU6vHyF50dMcWxkj3RTmHRhXShB4tqqqIk3cZLu
   GVoYvMxFFnNXuNa8ENjfY+LboHg8XIcunyYkOBmqGwT8mN5h0t3Uzw/6D
   +hGvSuZmu82TNhPTnqkYj9nOPmiMXMhAnquXxYNR5dAL7kzXJBVut4ZkA
   mw21T85oFYYbLDKN60j3C6s2DGuprk79SpZq4mGLzBtCJMqH9zcSAr6ok
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="317985233"
Received: from mail-dm6nam04lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 16:19:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfVRgJAcqLyM5W6G+oarmc0M1Pa2iRN8N6iPOx08BFViWXMyNWK3DnA4ZWi/xav37WJ8qnHWNYaacNjzDCD1/4tAnS2oHzRnGaqcgaDBgAila+5fpn1Qn089ogNaQCN9ewEc0aP5HOzcn0+QG3DEj5YA9IoHnbCW7amaVBJSLAroXWTE4boxPr9ZLWawJ168abPSqDoZynpt6ucqAPzwgkWWc9bpzl6lsK8Bfw2P6iYIPgfYLfl6Sr35KXw8VK8f4/PMy25gEjey+9TovbPB/xL1LORekvHloaRjGDzcFjpSGJem/VXRDW018XSn9mVj3rEsZaxrgL4aVYne+f0q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf4XW7xOTO460awDjTQRLOCFJp9q/jAdYabLxfNTmW0=;
 b=E06+3MzpNxVzzFQ/VEG8AF6qUoFJi0Obo8RXfiTMU+RAJ7+rJrfREByV0lvxXgn9+7lK6TrQDKhrGR/0ITeLUtmcxWV/GEUM3iazCBcseyjSKJvRVSAVKyEkTDqiawse92P0wvWU9bNoN+k5ISUV49rPNIA0Xp7iQueXGnPDEgyvcQ2+seo9AVqvHnMICVVLsxXqbitIFYoxM0QO1UeVSf9SQ1pCecfxSlP+303Tsrx6uK2UL0S6c9FY9wDCeA3yjL7K5qVa6euN4d8pPG5sizLmmfqczH/ycyMLyvX+ZxLUfe/LbZEcK+WGFxeCWv9Cf0zH12mraFTU5quIKgfgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf4XW7xOTO460awDjTQRLOCFJp9q/jAdYabLxfNTmW0=;
 b=IZvviZPwVApNlPaL5A+pRRuw+RQfG+Ury03OdUo1Mh/nh2AuHJV4F6LvHYKfHX9aEMHaHADC9wQLLO5lp/lhMa0JsSvfyNh4TmCp2SB5MUqJfl7dsynm7Ndz9eVtPSonFk3nG3SCTE9FFUMYaKpI//P6zwbv6cZE0A0Ga0fg2PA=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by BYAPR04MB4725.namprd04.prod.outlook.com (2603:10b6:a03:59::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 08:19:33 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::152f:249a:afc7:d6d1]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::152f:249a:afc7:d6d1%9]) with mapi id 15.20.5709.019; Thu, 13 Oct 2022
 08:19:33 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv2 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Topic: [PATCHv2 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Index: AdjebSjVc+AEAThvQj+uqrbmgvcwAQAZ3tvQ
Date:   Thu, 13 Oct 2022 08:19:32 +0000
Message-ID: <BL0PR04MB6564149CA860570CA546E51FFC259@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <4152c899b638429fb5ec1fb93009b42b@hyperstone.com>
In-Reply-To: <4152c899b638429fb5ec1fb93009b42b@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|BYAPR04MB4725:EE_
x-ms-office365-filtering-correlation-id: 82566129-f2e9-4792-b6da-08daacf3a87d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1bcqzGVtDKXvBfCTwmbO5hM7lHjvrOO9KmPw8cCfA1wBA4VGi1BB/h/OsBjDkCcY1xkb766CKTky/syKNQVzbHvRAlWCROUGC2CWl2WPuCTBqy7D1JQMeDDsaHqg/NtXhH25k43WK8mTd1tfIpZh6pw1MBBaB7b9fyZXbfUt7xhhQAyq8pep8sDChv7GN4ob+Q+1j6wGaJAckuF2cYuu7aHBJtiOGL4clpD3/Uu50lDdFkR0rBqZFHsuPrCHvGiYsOGwi84qajyaQckKQOUaHQgfprkRe+VkZ3oLi9YenXQsZ9jH4RT7tuSA6IVLzVvN+TWjvTNaaNq11HrBYgwPkJRtQeLsYlZBsSSTYEySGNWgdI1Y2pNLjFCxIxueflBb0Aapr121CDsTpJXZOgDE5OdOaECI7h/V6VmSHgotdeZB0YTtHcTJ+IXywzoVqGBd2EwJkRS3n9vKhWScK3rIDgVSwuJN1MFpyZ0RjTKeXCJUhTBy8vY5HDF7tsXTmSh4ACijsZYHDNl5DjcLHsFi6uYO/P58XWcIt9SjKAVMLOz60zz7E5GwUaTjC5VBvXPkAdYPP3sc8t/VmHpwlkVpqJu8k6v36+8DwoiuvgCmIRzqovSsBBaK1NQD4LypG8iWWzJyGMfS5SJMb4t+L+uiFt6QXqNDWypvi1jg3KHuGI70I+Vi+22SYLGiwR0NwMFuJ1gMgGV/FXcG6NgdFSTRe2iLwEqYog8wNt1/Z5vDQqTjP/AjK3gsbHG/I6eOhq0KMJSHqWu6P7dS89f+Oouaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(86362001)(8936002)(26005)(9686003)(5660300002)(66556008)(41300700001)(76116006)(6506007)(7696005)(8676002)(66476007)(64756008)(30864003)(83380400001)(316002)(186003)(55016003)(66946007)(66446008)(2906002)(33656002)(52536014)(38070700005)(110136005)(71200400001)(478600001)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/4GPZfEQF8eRmHa5BWSagV8GIig01ozgZ4ButMDjAegJN47tBOoQRl/4Nu?=
 =?iso-8859-1?Q?yNR3f1m6tINBDQkIF4LCeoUaPhWEgPrbVM9sH9zn6zXb1zrNHKAqillMB2?=
 =?iso-8859-1?Q?HBxxet8maJ/5rei39e8nPyxBkGq5GdQIxHI4ove9ojiv8x66p2IUm0IxPo?=
 =?iso-8859-1?Q?ycxo/QJfQpPCXg+zkIe471BoPyfYjz2Fexp0ZbJLvWWs9DUWaK6Mqquuns?=
 =?iso-8859-1?Q?jWWOLSIULR9kTv0TH6OAo4FoQOLG61yqAwnZYVjI5OWykQ9p9rkX05vL4o?=
 =?iso-8859-1?Q?SlWeYytF5XZ217R92kPbQIjQg7luHdqs2osjBmDLOptB38WAZJmuqcmJW1?=
 =?iso-8859-1?Q?s9IH756fdchAJ29TM4C0fhb+QY3X8/+0AodqAuPpx6jJ+OUv62z0v+UByx?=
 =?iso-8859-1?Q?8n8UYd6mMi6s/W3BU3hBimhJY0lHWgA9moh+MIMjzeqvC0WwzQbn0PLznw?=
 =?iso-8859-1?Q?i5gFABPNj+EYRI+/J7L6Pu5XPfEnOrgkRl0Wga2CvwvQ3BPAMV3d+g2t29?=
 =?iso-8859-1?Q?2dxKet5nY35Wlp4d1wpFT2x240XFNUySa56xk9ScZmZCLEdZKOxe/VotO9?=
 =?iso-8859-1?Q?4NktzZ7+laSrsxi4lFWdUIc4e2D5mWjyBCm/PJB/+KhS85xAmSq+FF0hi0?=
 =?iso-8859-1?Q?2ZeR5QY7r2pBqQZFZf9Mh1FP+anjx33FyzrArGRthxfx7IXugGVwroFq7Z?=
 =?iso-8859-1?Q?HfBkIabuadMi/klDcJyahJWFRLacwHPbl127NDGzmmaUcFTEu7mluxkY0L?=
 =?iso-8859-1?Q?h0TQiqehPO/Lh0jYQPvoVanOJrkszOs7gCLOwVHp2lsepomKrsdXO9h96K?=
 =?iso-8859-1?Q?PbCE5hSNuHd/dOacl+xHtTEUm5s0lboFugXD+j7B37xzYmY/XYoAtJf9lY?=
 =?iso-8859-1?Q?tek2gjlgQa7JoG+zeWM92PLb1sVoLW2wcvjqhDCa2o1ePSk7OMNLYralAe?=
 =?iso-8859-1?Q?pw6QDM8iDq4z7TeNCWuLhWqiDTaVQTDw2yVg9CRIwWx7AZP+3tO5Rufl2p?=
 =?iso-8859-1?Q?VEZq1fo9JaDrpbEfJU6VSzaJf4Rkj/5Qw9SzghYWH3CNfTvksn+ETiK0ll?=
 =?iso-8859-1?Q?qysN9iB8CmzM2gIrv/qt48OtwHmMlMGNjnlUwkd1519RAOQEfn0U6lsnX9?=
 =?iso-8859-1?Q?Jxb+jmRorCDMCghWZ54QT7Qz3m6ZZfj/0g3N+f1L6eFHxFsp77G4g0WEIJ?=
 =?iso-8859-1?Q?kJuBXNIcfhL4Q5OE0WAmdYsurihF+26Yli8FbJlffShIfN8ir+qxaJJGVI?=
 =?iso-8859-1?Q?W9a0LfZwXuH4WiczyOZQ8U4peJ5chVL+XJAXguGq0JzQhYV7KaBhfBtbt1?=
 =?iso-8859-1?Q?MnNlFyPb48THcjDLTNWQlpE5RLylPfngWtJ58k5KqhKd2A4bgVfPVZ7wcN?=
 =?iso-8859-1?Q?uP0iwJNOMxv2Njz0N7yz5J5WpvLiLvgRhrutJiZ4AqXPebPpKF9NlcOX7R?=
 =?iso-8859-1?Q?kkTHWzdispWDVI5O+FuB538m1wfiD2UNNkcQZDGKFZMFspAowazBHguSba?=
 =?iso-8859-1?Q?N+PUx4w0WicoKK9QYVNNTWm4Dc3Fd98aN58u/gpnpIJWXvHfFAvPJY0N2C?=
 =?iso-8859-1?Q?KjNlzYFyjkl0NGK6fSB9DJRH5TbVoxsPMaQSRN+LhFuQxgGc9HN4u3QPdz?=
 =?iso-8859-1?Q?U1Iw4XnhTbd7j4ox+Gjcphh8d7zdd+noDL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82566129-f2e9-4792-b6da-08daacf3a87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 08:19:32.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qUMkE8lmtfi7tJyy+yLTq6qHySIfqOwBJDGuvGe5UrgtLUWvh5706wzVRsD4CMXbpE5Yw43mlczGYoIBXIu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4725
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> Certain commands require a longer switch timeout.
> Refactor accordingly to allow e.g. for future sanitize change.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  mmc_cmds.c | 83 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 29 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2957aa9..8bc7a56 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -54,6 +54,8 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> +#define SWITCH_TIMEOUT_MS (10 * 1000)
Why 10 seconds?
Maybe add comment or at least explain in your commit log.

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
If cmd_timeout_ms not set, mmc_sanitize will use 240s - MMC_SANITIZE_TIMEOU=
T_MS.
I thought that you need more time, or did I get it wrong?

Also, I am uncomfortable that you are setting this value for all other comm=
ands.

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
> @@ -571,7 +576,8 @@ int do_disable_512B_emulation(int nargs, char **argv)
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
>                         "EXT_CSD[%d] in %s\n", @@ -771,7 +779,8 @@ int do=
_hwreset(int
> value, int nargs, char **argv)
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
> @@ -1002,7 +1013,8 @@ int set_partitioning_setting_completed(int dry_run,
> const char * const device,
>         }
>=20
>         fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETE=
D,
> 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETE=
D,
> 0x1,
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
 @@ -1240,7
> +1254,7 @@ int do_create_gp_partition(int nargs, char **argv)
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
>         value =3D ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] | EXT_CSD_ENH_USR=
;
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
>                                 value, EXT_CSD_WR_REL_SET, device); @@ -1=
998,7 +2021,8
> @@ int do_sanitize(int nargs, char **argv)
>                 exit(1);
>         }
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1,
> +                       SWITCH_TIMEOUT_MS);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         1, EXT_CSD_SANITIZE_START, device); @@ -2587,7 +2=
611,8 @@
> int do_cache_ctrl(int value, int nargs, char **argv)
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
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director: =
Dr.
> Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

