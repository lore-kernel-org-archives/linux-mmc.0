Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C25ECAAA1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 18:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJXSa6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJXSaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 14:30:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E40853A58
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:12:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j12so8995323plj.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX6lchgbTLeyYCJJeMFMm6zW4t3o7jRcCwnfR6/LgV0=;
        b=J8kaB2ms2iYKYPIuYlwmcPG7QvCPBDE8IZz689f2sHqVtf7ezpETi8/9rk+YIrAf73
         XOEM9QhYYgB9TSxZZfJN+56avz5CV0TcZRq5SpF90TrpyNp5zNWxzRZ5S+FP7ZAOAXXf
         W+lpBI8IydDvzakRVnIuPk5rgZDRFPgdu3yODXX3jAmL/nKWy+XEIsl/bJr1vogvxUnV
         MWirOQSyy2lRrmeolHPTcwl5j9Fz/oXWJrNAfHtQoVxazau7uLpZvVTvkO03uQyzTAKf
         A1YuhLRKwgNOaKrwJRw0+fyU1OhuToGnu9Dv9HFKSAroUdVYe01EXUiNHuloSqnR8ImG
         C9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX6lchgbTLeyYCJJeMFMm6zW4t3o7jRcCwnfR6/LgV0=;
        b=FkwLAWjzuNDIw1sOxia0JNb/jtm7LulE2gLtTol1e0k5+X16NbSoBfmYKEwt8U8Ixk
         hfItZ+sRJiFt2UNL2rObpkOQnsvbAfx1b22eYB8VBAeeH2IeDSmPi2/ugeA5tw/M1mwr
         JUTT0VE6oqLGi/ueAVCdaCjYSN7jR6Ct3AnPEWp0sSUqSMyKG78UUjtN+Zs/Q5NwFfTv
         2MeetoqdPsPZh/yaAPQRFJg3NZLg5Gwj6Rhau8atAcFJvidxguyYKwFpMKvDzmBQB8qG
         JRyyQblu0zEV4Ino9M+vWfnJ9zLHH9LER77LKAo3YQNdw3xmxOglN0ZhHcWkOXUGlf3p
         V1dA==
X-Gm-Message-State: ACrzQf0RiI+yNSeO5SuB4CoNiKQrcfgVT3z3RsaRhQQ6+GJB5aGeAyfq
        QJQvIc2q5+nOPv6Ev4IpL4Qs7oZLxCgbINk5HOgYsozUTls=
X-Google-Smtp-Source: AMsMyM7k+FqKSEVe1hKFUisZlG1f4qgmact/ta77+ZpE5KUpLJdHZHqWqKpZ3tGUDJj9633DRC+49I3KZJcwe5VHr78=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr24047719plb.148.1666630936165; Mon, 24
 Oct 2022 10:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <a64ce8be9687452b8da6c9816ca42b5b@hyperstone.com>
In-Reply-To: <a64ce8be9687452b8da6c9816ca42b5b@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 19:01:39 +0200
Message-ID: <CAPDyKFrG7GrenvW6MGdhxrF1vP7tNJk-vcquuN4VUfLr083zAg@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mmc-utils: Refactor switch to allow custom timeout
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Oct 2022 at 11:10, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Certain commands require a longer switch timeout.
> Refactor accordingly to allow e.g. for future sanitize change.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 60 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 2957aa9..3337ded 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -76,7 +76,7 @@ int read_extcsd(int fd, __u8 *ext_csd)
>         return ret;
>  }
>
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
>
>         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
>         if (ret)
> @@ -341,7 +343,7 @@ int do_writeprotect_boot_set(int nargs, char **argv)
>         value |=3D permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
>                            : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>
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
>
>         if (native_sector_size && !data_sector_size &&
>            (wr_rel_param & EN_REL_WR)) {
> -               ret =3D write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR,=
 1);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR,=
 1, 0);
>
>                 if (ret) {
>                         fprintf(stderr, "Could not write 0x%02x to EXT_CS=
D[%d] in %s\n",
> @@ -650,7 +652,7 @@ int do_write_boot_en(int nargs, char **argv)
>         else
>                 value &=3D ~EXT_CSD_PART_CONFIG_ACC_ACK;
>
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -720,7 +722,7 @@ int do_boot_bus_conditions_set(int nargs, char **argv=
)
>         printf("Changing ext_csd[BOOT_BUS_CONDITIONS] from 0x%02x to 0x%0=
2x\n",
>                 ext_csd[EXT_CSD_BOOT_BUS_CONDITIONS], value);
>
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
>
> -       ret =3D write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value, 0);
>         if (ret) {
>                 fprintf(stderr,
>                         "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
> @@ -825,9 +827,9 @@ int do_write_bkops_en(int nargs, char **argv)
>                         fprintf(stderr, "%s doesn't support AUTO_EN in th=
e BKOPS_EN register\n", device);
>                         exit(1);
>                 }
> -               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AU=
TO_ENABLE);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AU=
TO_ENABLE, 0);
>         } else if (strcmp(en_type, "manual") =3D=3D 0) {
> -               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MA=
N_ENABLE);
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MA=
N_ENABLE, 0);
>         } else {
>                 fprintf(stderr, "%s invalid mode for BKOPS_EN requested: =
%s. Valid options: auto or manual\n", en_type, device);
>                 exit(1);
> @@ -1002,7 +1004,7 @@ int set_partitioning_setting_completed(int dry_run,=
 const char * const device,
>         }
>
>         fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETE=
D, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETE=
D, 0x1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -1188,7 +1190,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         gp_size_mult =3D (length_kib + align/2l) / align;
>
>         /* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to EXT_CSD[%d] in %s=
\n",
>                         EXT_CSD_ERASE_GROUP_DEF, device);
> @@ -1197,7 +1199,7 @@ int do_create_gp_partition(int nargs, char **argv)
>
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
>
> -       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, valu=
e, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CS=
D[%d] in %s\n",
>                         partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);
> @@ -1240,7 +1242,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         else
>                 value &=3D (0xF << (4 * ((partition % 2))));
>
> -       ret =3D write_extcsd_value(fd, address, value);
> +       ret =3D write_extcsd_value(fd, address, value, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %=
s\n",
>                         value, address, device);
> @@ -1317,7 +1319,7 @@ int do_enh_area_set(int nargs, char **argv)
>         enh_start_addr *=3D align;
>
>         /* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
> -       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1, 0);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x1 to "
>                         "EXT_CSD[%d] in %s\n",
> @@ -1327,7 +1329,7 @@ int do_enh_area_set(int nargs, char **argv)
>
>         /* write to ENH_START_ADDR and ENH_SIZE_MULT and PARTITIONS_ATTRI=
BUTE's ENH_USR bit */
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
>
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
>
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
>
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
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
