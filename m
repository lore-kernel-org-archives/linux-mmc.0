Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC273C433FE
	for <linux-mmc@archiver.kernel.org>; Sat, 15 Oct 2022 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJOGkH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 15 Oct 2022 02:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJOGkF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Oct 2022 02:40:05 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1828E04
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665816002; x=1697352002;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DAJLwUPsir2/bXZdXT/Qfyl7NlvX0k0aIOnIhYE7Fp4=;
  b=n0cMxtZ+6+o8gbN8xp425QE82MfhJ9k0LUBqH6xFNTJWtrdX9uQCZH74
   yS2MiaCcZVVeHU7jtEq9+Xxn59eQpa5hwHVU05FVivPbyqjKiedVMNGn2
   RjfU/d5TB86GjKLKXi5PgCzUtMO4730WQREfZneDvqqu6InDy9cWelnYi
   sJ3mhdxcQbz1m4YWEJTboQqBGxLX/tNc28Bzvzyh9GWtyUGZ2Et2zsvq0
   U1O/fsq16rU+ThmxGx39vvugUPD7yBo0MilxEXo0dhm3WBDY4T3YFRb3q
   POzfP97QSkJ0z9pj3nFsWGQfQfAXOoN9MHzoNZNNrIi8jyaGC0+7k5jaM
   A==;
X-IronPort-AV: E=Sophos;i="5.95,186,1661788800"; 
   d="scan'208";a="212196849"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2022 14:40:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzCy7EQ4NZUF8JXvTYg67lqaWkGVSWuB55DUEfVDc0XMGA+3TTQdAczbeq/iYECFXGyhaPOTsEW20ZwlySJFT2dkfDkdRSqAE7ZOe8KolXWgx5W2uW+dSfuWL9I0zH1WWi88meWyu7pHOcCVFuiYfCKGL8QJ7COQowy+zQ97egaObX3BeNs5gK8K94VUvlBq6MABed2lpOa0mC4IUPXVJBforPNon4Dp7DJ6zD4ddlyo9HqU26D5Me1zLSrI9J3tlMGy6hsuUmuW0GfpVug/wpFfBqLfV1BHlGY7Mie97EP9rQt55ErDD83ZZR87zU2uECl+hWcVv1O6TR8rMeNqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbd1ChKhXoh73ZRgw4UoJanxhIUZLY/xrXAL45odhHc=;
 b=WwX5e8MtqmUAHfV7nEDHMW5chuD6wOROOMDUDoB85tJVh8qwc+ubO1xfo6DHBl3EzExFwLW92VqfFgAj3vZMrZYlDKoHa70X5afHHAKIdL0Rp0T65FVj+VeebYLwToPrGGnLWTd489r+EI8oYt8znMSdeo9qP+UxEhsXOy8wo2rm9vs6QBv0NwBHMBJOygbZdqluJNrwID/lOJ6zauVvSqmAfXtQw5/lM0Yy6V5YtffgQ7rWsgwivmdkb3nvp+lmlQX45g/b2UTBNp3gpnOt1llCkk/rz9Na42o66UAWjaGSJRUdx4gCKe+L/ySrW33t1HtqbXKvJov9ZK8p+1nyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbd1ChKhXoh73ZRgw4UoJanxhIUZLY/xrXAL45odhHc=;
 b=wPBdysANDhX6EfgioOeCdk2KzAqDPJP+NnaMeBIfmORGiF12Uvsf6qxl/fvrxaP28OS5Y/KBN8q77QgkrlxZuBTmx5mlHijctIRjGJhAWY0paxKFQe3b2Fl5wXBW4QA3BzD770JBsYSZRy0sDOFI6g9bv4uHOeW/a7wI1wMccyw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7633.namprd04.prod.outlook.com (2603:10b6:303:a0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Sat, 15 Oct 2022 06:39:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%7]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:39:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv3 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Topic: [PATCHv3 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Index: Adje41rybrEPkk5sSweJDlsaX00tLgBfXC9w
Date:   Sat, 15 Oct 2022 06:39:58 +0000
Message-ID: <DM6PR04MB657583A838A0F7B34B56FE20FC279@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <a64ce8be9687452b8da6c9816ca42b5b@hyperstone.com>
In-Reply-To: <a64ce8be9687452b8da6c9816ca42b5b@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7633:EE_
x-ms-office365-filtering-correlation-id: da327173-b8b8-4182-12d2-08daae78145c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyT8jJ9jGj7WEUEmsx+1JvGwvfhIlF7VoPCD2n5mVKGUf7ybRQ7QsmP2JlLuRyIi8UPKcowbMcv4urE18a0ly7vPDkHxKdDxN0hHjW71qVAPUBkzofJhnebpzdy71j4FkVEZO5SKx3Rj5sUN0mXmKWEUmkBaq794VPAexB7PmNl0/Frz4btOzDJyHEHquQJm/caOweaBKQCiRDOvfrBzzsy853bUMu0DF9RLQZ3N7CsVux/M0kDcjygkJzrY6h0inUjEffccHgOxGGwWEFL7MC6VGVf4PxMruxZ8XdfIm+yBkVUK1w1USrkZra8te4VRQTIUnckhl/b+9Bq/jepescNn19dSPD+TZdMDq5kbUvVbwr3+Z0yu6vue7xLjgZzgbh/Vz5QjgYnzLygtkYwbcMGaHm1c+oV7jsKzhUpxnyyv5oHl10zhqHx2uKykHsXpufH+LanDcEMGJqvTaedNxJiSc8oCTgd+CJsmsUon9yn22GutVt7S7y619qXqtfCe+7U3ucPJgY5dLr7L+b3PcWA7412QEW2s6eR46I1Oe/w0+DxuCANalXmuqvpl9vsIpbIy9wH4aw84Ru6b+qRTuCydUqlae+cpOxk9Il7+wzRYHvzN53HJi/BqS/tnVIywYNMu3pr5xCvFhsXRvdzk7F5azPF2JTVThu7EVz90VNETVF/vNDnvhArhWLkjLzGXlnrRBEO1bNJnR7XNNSfp63GRYRPxKE17UkWeOh4jP0oL+/RATA8D0qyUH8CMc6itxt68yDcWRTqybihBp0VjeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(186003)(66446008)(82960400001)(7696005)(6506007)(83380400001)(38070700005)(122000001)(86362001)(30864003)(38100700002)(2906002)(5660300002)(8936002)(26005)(52536014)(316002)(41300700001)(55016003)(8676002)(64756008)(9686003)(76116006)(478600001)(66476007)(110136005)(66946007)(66556008)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q9UkFcrPU8t9CWTMldWf0i5Y03v0s3cOb1E+J6lRVzLPkQs8AgHoSgjNZw?=
 =?iso-8859-1?Q?xdu7Qaky6+Ssl+/VYNFrH4wxSNjER1mygyWd15HlTk0u/rJKiuPLrIZHFu?=
 =?iso-8859-1?Q?MBYLw000GxmILNq6WDsquOJtY6Uu2MKLFoLBaFEIJL94GKl3BUrKSkEW0X?=
 =?iso-8859-1?Q?7ndo3bU5iwBLTo4tytpKZFKKVY8N8ML0dHxUdWMxdTM6VxUIBg6A3c1ed6?=
 =?iso-8859-1?Q?zFTVvCNit3lHftQAdgOse/8RP0vGAnTtISe/hxYabMOZAp81N7gEYwDEeG?=
 =?iso-8859-1?Q?HIDHwYV54/Nq2n9HgSlaCzXMB+IjZZXcHZrWM7aT7vlQdKvlBi3muSOLtH?=
 =?iso-8859-1?Q?++XcVyLd2zJmo5PrvzTf6N2nq1XEqjadBNcrZCtdGbTYaDov1vJxbUf9LV?=
 =?iso-8859-1?Q?QvdL/6AXhKTfUkF17+/9QxZSLQ+KN6i/IIrEua0bW74bt9g29bNkRsZW51?=
 =?iso-8859-1?Q?yvzUSFj7ulQnumPPzciReCEhLZ6X7kauGH/SLKPy5dQFVeC0q5uole4HFp?=
 =?iso-8859-1?Q?r1o9RwKURba4bKNgsXygZcu8P+in7fdbVkRTQhjHNweUb2KlCO4ydONw22?=
 =?iso-8859-1?Q?jkn9IUYMNqs3koY1SQyvtcQWMl+AK151lrrnBqQeLu8Ph+rDgec36MbTC8?=
 =?iso-8859-1?Q?+EammF2Kb+HbTKtpcPkMo5yRIDM7PVjuzuSRchVsrlalS7Hx2o+upZ3ecB?=
 =?iso-8859-1?Q?wW4tQ8nJSa5dQ8lneKFddza9VH907kgip+nyaaYJ7kZMxjBnbq2Z+lsqJB?=
 =?iso-8859-1?Q?31sQdFxxVdtWlzaUf6kGL4Y5d6qy1Q6QgwL/3bbuEUU39Cqe0k5Edj4Uab?=
 =?iso-8859-1?Q?RAkcELa292tBXDJJGGoWN4msUaNCayOEnfmjz0FcbmRuecS3xcKFPIVHYZ?=
 =?iso-8859-1?Q?0sxEzT4sgLOTRFqkxJmyEbOzZ+w3KfLV1J6W51xGf2VBnhAsI0jOhAidWE?=
 =?iso-8859-1?Q?70hd479isWejNvIYTBqplH6bIZ3zihsQRw1t11CkMGurNiEoNSo6j9yx8j?=
 =?iso-8859-1?Q?ebwtj4uZ2mdmw8sOm/s1E0gRNc8VPnDAvxMZMtn28x0kOg/gGXeSG6tJGK?=
 =?iso-8859-1?Q?cjEuC9sGdEcntNlySLG+l+fhgoGMystZyFyJHkQXFkyAZHNeYYF5H0qgS6?=
 =?iso-8859-1?Q?LpYu+ZTnAxw80a3LJatAO2p0G4YTrQx7TH5ajFDajaswySKo+tLh0WIsqd?=
 =?iso-8859-1?Q?PJLoXLWoWnpYvIrWUWbrDeUEu06EfAF4mgHxLQjKkTICGt8G0hJjDdOg87?=
 =?iso-8859-1?Q?uazsW7vguJXmfqkQ02pRZjp2u0r049uDj107LIzEkyn+Pw7eGLiyljey+C?=
 =?iso-8859-1?Q?2cQUFxI4JKwmrv+nfk23BY17JdUSccOmcivpvjKD/FlJ91bZ3ZZ6oLgRTG?=
 =?iso-8859-1?Q?oJr2qSRlKP7xEdWXu/1rDyyEjyfEztlD51UIulUyj40nFYnnAh2yBiInsk?=
 =?iso-8859-1?Q?95qVD/4mXu0MvgkmR/XX6vqEOrteWlNKETCaIdCUSuXy5FUsKh45n53r4g?=
 =?iso-8859-1?Q?PITRUHPiHvD9mFm6FQ4WFkorlsOqBWqxK6VUQ+iBeEA2w78ufOnv7P7nIh?=
 =?iso-8859-1?Q?bovFBvtnGteEJ7lZkUte7uZOT9EGw9zYUBGPNYvQy3lVw8y0DgCYDu9/S1?=
 =?iso-8859-1?Q?IDtrFMx9kV+ylFeNtUv/3bBOBKGDXsqspI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da327173-b8b8-4182-12d2-08daae78145c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:39:58.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XD6Yh2BtjUaCjKYrl8RgrqT3pk76ZdKtJ2hRY3ctZtBTQE8VzYXCpKIYdoxDtqBKg6F2Z6qRcga7SD9gfyVmRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7633
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> Certain commands require a longer switch timeout.
> Refactor accordingly to allow e.g. for future sanitize change.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  mmc_cmds.c | 60 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2957aa9..3337ded 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -76,7 +76,7 @@ int read_extcsd(int fd, __u8 *ext_csd)
>         return ret;
>  }
>=20
> -int write_extcsd_value(int fd, __u8 index, __u8 value)
> +int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int time=
out_ms)
>  {
>         int ret =3D 0;
>         struct mmc_ioc_cmd idata;
> @@ -89,6 +89,8 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
>                         (value << 8) |
>                         EXT_CSD_CMD_SET_NORMAL;
>         idata.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +       /* Kernel will set cmd_timeout_ms if 0 is set */
> +       idata.cmd_timeout_ms =3D timeout_ms;
>=20
>         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
>         if (ret)
> @@ -341,7 +343,7 @@ int do_writeprotect_boot_set(int nargs, char **argv)
>         value |=3D permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
>                            : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_WP, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_WP, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -508,7 +510,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
>                         break;
>                 }
>                 if (user_wp !=3D ext_csd[EXT_CSD_USER_WP]) {
> -                       ret =3D write_extcsd_value(fd, EXT_CSD_USER_WP, u=
ser_wp);
> +                       ret =3D write_extcsd_value(fd, EXT_CSD_USER_WP, u=
ser_wp, 0);
>                         if (ret) {
>                                 fprintf(stderr, "Error setting EXT_CSD\n"=
);
>                                 exit(1);
> @@ -526,7 +528,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
>         }
>         if (wptype !=3D WPTYPE_NONE) {
>                 ret =3D write_extcsd_value(fd, EXT_CSD_USER_WP,
> -                                       ext_csd[EXT_CSD_USER_WP]);
> +                               ext_csd[EXT_CSD_USER_WP], 0);
>                 if (ret) {
>                         fprintf(stderr, "Error restoring EXT_CSD\n");
>                         exit(1);
> @@ -571,7 +573,7 @@ int do_disable_512B_emulation(int nargs, char **argv)
>=20
>         if (native_sector_size && !data_sector_size &&
>            (wr_rel_param & EN_REL_WR)) {
> -               ret =3D write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR,=
 1);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR,=
 1, 0);
>=20
>                 if (ret) {
>                         fprintf(stderr, "Could not write 0x%02x to EXT_CS=
D[%d] in %s\n",
> @@ -650,7 +652,7 @@ int do_write_boot_en(int nargs, char **argv)
>         else
>                 value &=3D ~EXT_CSD_PART_CONFIG_ACC_ACK;
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -720,7 +722,7 @@ int do_boot_bus_conditions_set(int nargs, char **argv=
)
>         printf("Changing ext_csd[BOOT_BUS_CONDITIONS] from 0x%02x to
> 0x%02x\n",
>                 ext_csd[EXT_CSD_BOOT_BUS_CONDITIONS], value);
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value=
);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value=
, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -771,7 +773,7 @@ int do_hwreset(int value, int nargs, char **argv)
>                 exit(1);
>         }
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value, 0);
>         if (ret) {
>                 fprintf(stderr,
>                         "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> @@ -825,9 +827,9 @@ int do_write_bkops_en(int nargs, char **argv)
>                         fprintf(stderr, "%s doesn't support AUTO_EN in th=
e BKOPS_EN
> register\n", device);
>                         exit(1);
>                 }
> -               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_AUTO_ENABLE);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_AUTO_ENABLE, 0);
>         } else if (strcmp(en_type, "manual") =3D=3D 0) {
> -               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_MAN_ENABLE);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_MAN_ENABLE, 0);
>         } else {
>                 fprintf(stderr, "%s invalid mode for BKOPS_EN requested: =
%s. Valid
> options: auto or manual\n", en_type, device);
>                 exit(1);
> @@ -1002,7 +1004,7 @@ int set_partitioning_setting_completed(int dry_run,
> const char * const device,
>         }
>=20
>         fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETE=
D,
> 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETE=
D,
> 0x1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -1188,7 +1190,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         gp_size_mult =3D (length_kib + align/2l) / align;
>=20
>         /* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to EXT_CSD[%d] in %s=
\n",
>                         EXT_CSD_ERASE_GROUP_DEF, device);
> @@ -1197,7 +1199,7 @@ int do_create_gp_partition(int nargs, char **argv)
>=20
>         value =3D (gp_size_mult >> 16) & 0xff;
>         address =3D EXT_CSD_GP_SIZE_MULT_1_2 + (partition - 1) * 3;
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         value, address, device);
> @@ -1205,7 +1207,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         }
>         value =3D (gp_size_mult >> 8) & 0xff;
>         address =3D EXT_CSD_GP_SIZE_MULT_1_1 + (partition - 1) * 3;
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         value, address, device);
> @@ -1213,7 +1215,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         }
>         value =3D gp_size_mult & 0xff;
>         address =3D EXT_CSD_GP_SIZE_MULT_1_0 + (partition - 1) * 3;
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         value, address, device);
> @@ -1226,7 +1228,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         else
>                 value &=3D ~(1 << partition);
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CS=
D[%d] in
> %s\n",
>                         partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);
> @@ -1240,7 +1242,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         else
>                 value &=3D (0xF << (4 * ((partition % 2))));
>=20
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %=
s\n",
>                         value, address, device);
> @@ -1317,7 +1319,7 @@ int do_enh_area_set(int nargs, char **argv)
>         enh_start_addr *=3D align;
>=20
>         /* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -1327,7 +1329,7 @@ int do_enh_area_set(int nargs, char **argv)
>=20
>         /* write to ENH_START_ADDR and ENH_SIZE_MULT and
> PARTITIONS_ATTRIBUTE's ENH_USR bit */
>         value =3D (enh_start_addr >> 24) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value, 0=
);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1335,7 +1337,7 @@ int do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D (enh_start_addr >> 16) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value, 0=
);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1343,7 +1345,7 @@ int do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D (enh_start_addr >> 8) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value, 0=
);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1351,7 +1353,7 @@ int do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D enh_start_addr & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value, 0=
);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1360,7 +1362,7 @@ int do_enh_area_set(int nargs, char **argv)
>         }
>=20
>         value =3D (enh_size_mult >> 16) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value, 0)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1368,7 +1370,7 @@ int do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D (enh_size_mult >> 8) & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value, 0)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1376,7 +1378,7 @@ int do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D enh_size_mult & 0xff;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value, 0)=
;
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n", value,
> @@ -1384,7 +1386,7 @@ int do_enh_area_set(int nargs, char **argv)
>                 exit(1);
>         }
>         value =3D ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] | EXT_CSD_ENH_USR=
;
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -1455,7 +1457,7 @@ int do_write_reliability_set(int nargs, char **argv=
)
>         }
>=20
>         value =3D ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
> -       ret =3D write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                                 value, EXT_CSD_WR_REL_SET, device);
> @@ -1998,7 +2000,7 @@ int do_sanitize(int nargs, char **argv)
>                 exit(1);
>         }
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         1, EXT_CSD_SANITIZE_START, device);
> @@ -2587,7 +2589,7 @@ int do_cache_ctrl(int value, int nargs, char **argv=
)
>                         device);
>                 exit(1);
>         }
> -       ret =3D write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value, 0);
>         if (ret) {
>                 fprintf(stderr,
>                         "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

