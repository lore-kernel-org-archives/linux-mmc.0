Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5942EC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 10:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKIK5q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKIK5W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 05:57:22 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A53898
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 02:56:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v28so16330228pfi.12
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 02:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkw+vW2NMSzKB2AZKkVBQXnLaluF8ypgV57XvHvaEw8=;
        b=bAKG7wJe7NcFMMjmUw+MmnpagUHATEHqlUrjUJk5UEDrKscGnZE1CDWMNP3KfMBELC
         5tDO//QOh3hJ40S0IvRGOdBEmQ7buuS0RNTcCHYh/ajkyUdYkVHc6/HTHLyQlRTrEnN7
         vFxtRWiMiDh7XYG6apGhs76h815Skox03mkKbqYtcHHcNPVte/AffSh6TPzCRCRVwejF
         f2iwWpSAvcClKUHTGISE9Rls/hY4wj7gEdFRPUuXbxqzztbEpMjzuknKjMbWVJ0u8Oi6
         W2pni1hrBB1RmmLnNlcyxwYoH0IgHqaN242hONg1ViUXq/GWj/MZmkpctVxWQpX1RGj+
         Mnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkw+vW2NMSzKB2AZKkVBQXnLaluF8ypgV57XvHvaEw8=;
        b=333c3ZDgYDWWC/G2f3/0lDwRoRlUKY+wMs+YJk+nI1TBjB+XonMa6uvT/lmiWTEsbb
         DwvseIrQbGru9+D1PqoCp3Efqy43GxdufP+FRBBMAXd9QPmJEKUyhgb2/+Kn/9FYp/Nz
         GM6NR9/MZkItvklfDrCH/gI3rNgi3jc5V2TFoZbG5D0PVcDZXEEDBtH12PCseQjCXy8G
         57Db7brsYbJBJIsPgDcpyz7bqjnNx/+BZ3Z8swrhep+hi7JFyjapa0c4kgNxUjnzgb6l
         Suq5MamXpI9XGwAvTndDEfA2yZVVBqohYhhFG33G6Ra8vmJhCsHeZHHYCr7vFQ0aSbiD
         m9lg==
X-Gm-Message-State: ACrzQf11KodYEnJPtx7WrySsTGUVfTNfbQUTalRkZCj718NOHJJB8kt+
        r58TNFCHTNBhPdGo8NzjsKn2m/wHYDWXF61JvAR5xVM+QDNnfA==
X-Google-Smtp-Source: AMsMyM5Jbt5aLzH6D5QBX/DHKn1teelsonShU5M0C3RfLS32JNh3tQBoogDWfN/ueLTyOwnZcuiGVqYe0/aYXG37dCM=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr53226946pgk.595.1667991403416; Wed, 09
 Nov 2022 02:56:43 -0800 (PST)
MIME-Version: 1.0
References: <f999a7ed7bb645948ac74d5d5341e913@hyperstone.com>
In-Reply-To: <f999a7ed7bb645948ac74d5d5341e913@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 11:56:06 +0100
Message-ID: <CAPDyKFr0tVn3U_ihdTptWEjcFy-PiqZcSnKvfDT=RcPhST=u9A@mail.gmail.com>
Subject: Re: [PATCHv3] mmc-utils: Implement alternative boot operation
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Nov 2022 at 19:51, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Implements the alternative boot operation for eMMCs.
> Note the limitations of the help.
>
> This is mostly useful for testing purposes if you set
> up the boot partition configuration correctly.
>
> Usage:
> $ sudo dd if=3D/dev/mmcblk2boot0 of=3Dbootdatammcblk count=3D2
> 2+0 records in
> 2+0 records out
> 1024 bytes (1.0 kB, 1.0 KiB) copied, 0.00482308 s, 212 kB/s
>
> $ sudo ./mmc boot_operation bootdata /dev/mmcblk2
>
> $ diff -s bootdata bootdatammcblk
> Files bootdata and bootdatammcblk are identical
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
> -v3: Alternative boot mode support check
> -v2: Frees, closes, removal of boot_blocks parameter and boot ack check
>  mmc.c      |  12 +++++++
>  mmc.h      |   2 ++
>  mmc_cmds.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 118 insertions(+)
>
> diff --git a/mmc.c b/mmc.c
> index 170ee39..adcd814 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -255,6 +255,18 @@ static struct Command commands[] =3D {
>           "Issues a CMD0 GO_PRE_IDLE",
>           NULL
>         },
> +       { do_alt_boot_op, -1,
> +         "boot_operation", "<boot_data_file> <device>\n"
> +         "Does the alternative boot operation and writes the specified s=
tarting blocks of boot data into the requested file.\n\n"
> +         "Note some limitations\n:"
> +         "1. The boot operation must be configured, e.g. for legacy spee=
d:\n"
> +         "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2\n=
"
> +         "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
> +         "2. The MMC must currently be running at the bus mode that is c=
onfigured for the boot operation (HS200 and HS400 not supported at all).\n"
> +         "3. Only up to 512K bytes of boot data will be transferred.\n"
> +         "4. The MMC will perform a soft reset, if your system cannot ha=
ndle that do not use the boot operation from mmc-utils.\n",
> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index 6511dbc..6f1bf3e 100644
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
> @@ -97,6 +98,7 @@
>  #define EXT_CSD_CACHE_SIZE_0           249
>  #define EXT_CSD_SEC_FEATURE_SUPPORT    231
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
> +#define EXT_CSD_BOOT_MULT              226     /* RO */
>  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>  #define EXT_CSD_HC_WP_GRP_SIZE         221
>  #define EXT_CSD_SEC_COUNT_3            215
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3db17e1..e6d3273 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3101,3 +3101,106 @@ int do_preidle(int nargs, char **argv)
>
>         return 0;
>  }
> +
> +int do_alt_boot_op(int nargs, char **argv)
> +{
> +       int fd, ret, boot_data_fd;
> +       char *device, *boot_data_file;
> +       struct mmc_ioc_multi_cmd *mioc;
> +       __u8 ext_csd[512];
> +       __u8 *boot_buf;
> +       unsigned int boot_blocks, ext_csd_boot_size;
> +
> +       if (nargs !=3D 3) {
> +               fprintf(stderr, "Usage: mmc boot_op <boot_data_file> </pa=
th/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +       boot_data_file =3D argv[1];
> +       device =3D argv[2];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open device");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               perror("read extcsd");
> +               goto dev_fd_close;
> +       }
> +       if (!(ext_csd[EXT_CSD_BOOT_INFO] & EXT_CSD_BOOT_INFO_ALT)) {
> +               ret =3D -EINVAL;
> +               perror("Card does not support alternative boot mode");
> +               goto dev_fd_close;
> +       }
> +       if (ext_csd[EXT_CSD_PART_CONFIG] & EXT_CSD_PART_CONFIG_ACC_ACK) {
> +               ret =3D -EINVAL;
> +               perror("Boot Ack must not be enabled");
> +               goto dev_fd_close;
> +       }
> +       ext_csd_boot_size =3D ext_csd[EXT_CSD_BOOT_MULT] * 128 * 1024;
> +       boot_blocks =3D ext_csd_boot_size / 512;
> +       if (ext_csd_boot_size > MMC_IOC_MAX_BYTES) {
> +               printf("Boot partition size is bigger than IOCTL limit, l=
imiting to 512K\n");
> +               boot_blocks =3D MMC_IOC_MAX_BYTES / 512;
> +       }
> +
> +       boot_data_fd =3D open(boot_data_file, O_WRONLY | O_CREAT, 0644);
> +       if (boot_data_fd < 0) {
> +               perror("open boot data file");
> +               ret =3D 1;
> +               goto boot_data_close;
> +       }
> +
> +       boot_buf =3D calloc(1, sizeof(__u8) * boot_blocks * 512);
> +       mioc =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                          2 * sizeof(struct mmc_ioc_cmd));
> +       if (!mioc || !boot_buf) {
> +               perror("Failed to allocate memory");
> +               ret =3D -ENOMEM;
> +               goto alloced_error;
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
> +
> +       ret =3D ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
> +       if (ret) {
> +               perror("multi-cmd ioctl error\n");
> +               goto alloced_error;
> +       }
> +
> +       ret =3D DO_IO(write, boot_data_fd, boot_buf, boot_blocks * 512);
> +       if (ret < 0) {
> +               perror("Write error\n");
> +               goto alloced_error;
> +       }
> +       ret =3D 0;
> +
> +alloced_error:
> +       if (mioc)
> +               free(mioc);
> +       if (boot_buf)
> +               free(boot_buf);
> +boot_data_close:
> +       close(boot_data_fd);
> +dev_fd_close:
> +       close(fd);
> +       if (ret)
> +               exit(1);
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index faab362..5f2bef1 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -49,3 +49,4 @@ int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);
>  int do_softreset(int nargs, char **argv);
>  int do_preidle(int nargs, char **argv);
> +int do_alt_boot_op(int nargs, char **argv);
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
