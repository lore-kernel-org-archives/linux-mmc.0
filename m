Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DCC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 11:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiGRLWW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiGRLWW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 07:22:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533620BF2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:22:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so18747474lfn.5
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeTI+RwmRru9XP0Q22sqm7TVdWVKa/UTndLb9ZOqCbQ=;
        b=xlDRYghb9P+Qxawaz9xThoiC4sA2mPLY5XTfNF8GfSoZmIZemMpkU8JI3vDBzc9Y8d
         REAZnmccPo4fY0b3ioPEU0d1f59+oUMTGzNGOPdNEgEwKu6bKrEfEA8Xcabqp5b4Ee2x
         M5vAF59Zy3Rtnts+n131q1dWW9scnALyc5Q2UWFZpbHoQ3BZOjHWgA/21LEz+aa44CGb
         w8McOryYs4U0E77spfMvoIBeUS91n5qL+2ZW2mgH1EDFHS6z29sSolXjRD6KS9N/3BQB
         UIigKmKm2B3MrMc6E0AZij5JOu8gjgrosVNoYwM2jkeN0J0dXNbSWGkmp656hiZ+1aCd
         9tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeTI+RwmRru9XP0Q22sqm7TVdWVKa/UTndLb9ZOqCbQ=;
        b=lF3BFBUT3bLmeY7Ofqim+TV/aGh9Qf8EKDQVRFfLG44oQbUQY9qHuyZ29rLhb8rmUR
         EfFlO713Cfdx1NoTWNs3pNrvSZCPwK/Gj10uSTYFEKljs+g3+tUanPKMapzYPbfdzU+M
         RZY0LumdwROVps64Y7E+hooPMOhCoUKHbX/M3Q75Z817kWtNhKO4YUtqoi5AGx/DtkNe
         tqiupO3qza519D5Hz7JdvqnpYqlx95Mabo+7qoFi0SSQsI8KiqTh3PYktTLOaAdHrj4H
         QYyaXHBASwaNY75o6oTr+t8HNm+SCPNgYB8x5ZnP8C4J+zu1TiNXNNgZ5eR73l6nF0Lc
         TGPw==
X-Gm-Message-State: AJIora+Ah5OQinPnOSG31A6jax+lKwN8UwwwPdBM3w/wPBQgf/g+S9Nt
        zL6Dtpw1WxCKi7tLPubUrG7kIx/UoNdorh5FBL7fbojrQZzNxw==
X-Google-Smtp-Source: AGRyM1tKUiN/mJeAnlFdGC/zXXloAJFVDQmSA9hcs9twK/hO+7dWS7jzvVDEBW+s/RRzIqzcFmySCkPHhilXT00l2fM=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr14017147lfb.184.1658143339164; Mon, 18
 Jul 2022 04:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <1d1b023572934d71ae75bf46c5439ed0@hyperstone.com>
In-Reply-To: <1d1b023572934d71ae75bf46c5439ed0@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:21:43 +0200
Message-ID: <CAPDyKFq2QEqdP-9PQobHbEtj1e+1DS=j5MOTtVQ+577z85gJ4w@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Add softreset command for issuing CMD0
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Jul 2022 at 18:55, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> CMD0 may be used to see if the hardware can handle a UHS card
> that completed the voltage switch. If a UHS card has problems
> coming back up after CMD0 your hardware may not support a hard
> reset properly.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Please resend and add Avri Altman <avri.altman@wdc.com> on the to line.

Kind regards
Uffe

> ---
>  mmc.c      |  5 +++++
>  mmc.h      |  3 +++
>  mmc_cmds.c | 30 ++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  4 files changed, 39 insertions(+)
>
> diff --git a/mmc.c b/mmc.c
> index 6c56387..ba2c883 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -245,6 +245,11 @@ static struct Command commands[] = {
>                 "be 1.",
>         NULL
>         },
> +       { do_soft_reset, -1,
> +         "softreset", "<device>\n"
> +         "Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works\n\n",
> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index daff62c..9796d2e 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -21,6 +21,7 @@
>  #include <linux/mmc/ioctl.h>
>
>  /* From kernel linux/mmc/mmc.h */
> +#define MMC_GO_IDLE_STATE         0   /* bc                          */
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R1  */
>  #define MMC_SEND_STATUS                13      /* ac   [31:16] RCA        R1  */
> @@ -226,6 +227,7 @@
>
>
>  /* From kernel linux/mmc/core.h */
> +#define MMC_RSP_NONE   0                       /* no response */
>  #define MMC_RSP_PRESENT        (1 << 0)
>  #define MMC_RSP_136    (1 << 1)                /* 136 bit response */
>  #define MMC_RSP_CRC    (1 << 2)                /* expect valid crc */
> @@ -234,6 +236,7 @@
>
>  #define MMC_CMD_AC     (0 << 5)
>  #define MMC_CMD_ADTC   (1 << 5)
> +#define MMC_CMD_BC     (2 << 5)
>
>  #define MMC_RSP_SPI_S1 (1 << 7)                /* one status byte */
>  #define MMC_RSP_SPI_BUSY (1 << 10)             /* card may send busy */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..c027cfa 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -3039,3 +3039,33 @@ out:
>         close(dev_fd);
>         return ret;
>  }
> +
> +int do_soft_reset(int nargs, char **argv)
> +{
> +       int fd;
> +       char *device;
> +       struct mmc_ioc_cmd idata;
> +
> +       if (nargs != 2) {
> +               fprintf(stderr, "Usage: mmc status softreset </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +
> +       device = argv[1];
> +
> +       fd = open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       memset(&idata, 0, sizeof(idata));
> +       idata.opcode = MMC_GO_IDLE_STATE;
> +       idata.flags = MMC_RSP_NONE | MMC_CMD_BC;
> +
> +       /* No need to check for error, it is expected */
> +       ioctl(fd, MMC_IOC_CMD, &idata);
> +       close(fd);
> +
> +       return 0;
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 0f7c004..c112a95 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -47,3 +47,4 @@ int do_read_cid(int argc, char **argv);
>  int do_read_csd(int argc, char **argv);
>  int do_erase(int nargs, char **argv);
>  int do_general_cmd_read(int nargs, char **argv);
> +int do_soft_reset(int nargs, char **argv);
> --
> 2.36.1
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
