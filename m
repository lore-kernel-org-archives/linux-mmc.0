Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C48C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FC264F14
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 13:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBZNtx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Feb 2021 08:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBZNtu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Feb 2021 08:49:50 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92527C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 26 Feb 2021 05:49:10 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id q17so1942166vkd.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 Feb 2021 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnFJ0ZaOcMKBIPRmQwoMlKLp9vD0DCji+RtxHs6R/Gw=;
        b=UOxLlh/Sk3FdDJ0lC+7Q+YuzgS/RVbhxqLxRQlcZKq8xyKn7rAeAaedgE9XPAo5dZX
         woxWZXTvwpSOs2g3kRs38k+qxa8MQNCtNg/jXcEAtaptVJD4eiLzxlxIndL2xoMis4xD
         jVZtWCkvz5uiD076IWq6dQIPi9sQi0olFSTLegOfReTiDzl2XtZPsCVo4/JcSqXjh6FU
         yMSb32El0MGoByRTbmrIiEerSd5hnDNoDPt0maXpEZph3vjpRS2AyXpxylyN4Eydw4Uw
         PNPC8q4OEymzpf7FFrPjw0oJPrCcNS5AmmIll+DK5/N/C6cVzgVW/T8iKVRZd0bwe5ig
         NelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnFJ0ZaOcMKBIPRmQwoMlKLp9vD0DCji+RtxHs6R/Gw=;
        b=dVIRaKqaws+pQtGyCwcVX2fk/1sxh9oLwrjAnztE/lRprOjW2v/bWCDwWdolmAZQm9
         5WagQp3a2btBjwFsIS7L2ZkQ49tCNE/DRMGKjVcXpre8Um+m0voTsxRPIHSOwTCysuoK
         TTVB9U4DEqbxEeGP+NXdrgIdoXfyedxdP72OVFyxCbny5+3/E5mF7loZKuITm9wvSDNY
         FquGsXctMYx3BpTFAr6b1k1IupzHyuMisHaUwkUHKC+I3OnOpGgIOCzfZF489zoH1L7q
         gZrICDHO+DSeChzwS7whTHDOWejz+uJC0Ef8+4M5Vu/31aKgPogjgb9wwGPTiBehR/ts
         2dvA==
X-Gm-Message-State: AOAM5310nSvySIC4emnQOxUr8V52STTaMt+iFDqrJSDHq85i6Q4pZkLG
        ut04DYG4dIOzQlwUAichAqFTjwT9YsNMorz2xFe4Dg==
X-Google-Smtp-Source: ABdhPJzQA5fMsgg87jUXtwyIvhdowRVaThTjCWXOOd1U3JOZ/yXPVQ759l7fr4pGxgDvzwYVQrXvnxSe8TkkDBigoIM=
X-Received: by 2002:a1f:93d2:: with SMTP id v201mr1370444vkd.7.1614347349650;
 Fri, 26 Feb 2021 05:49:09 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR08MB5951783BA8508D7C50907044B82E0@MN2PR08MB5951.namprd08.prod.outlook.com>
 <MN2PR08MB6397DB58E881F03AE2AEEA82B89D9@MN2PR08MB6397.namprd08.prod.outlook.com>
In-Reply-To: <MN2PR08MB6397DB58E881F03AE2AEEA82B89D9@MN2PR08MB6397.namprd08.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Feb 2021 14:48:33 +0100
Message-ID: <CAPDyKFrPCPX42rWvSt7QGh6OrG+qoO2=xSXyt-2OSH3mppq4TQ@mail.gmail.com>
Subject: Re: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Chris Ball <chris@printf.net>, Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Yaniv Agman <yaniv.agman@sandisk.com>,
        Avi Shchislowski <avi.shchislowski@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Feb 2021 at 10:25, Shivamurthy Shastri (sshivamurthy)
<sshivamurthy@micron.com> wrote:
>
> Hello Chris,
>
> I have sent this patch almost two years ago and reviewed by Avri.
> I am not sure why this patch not yet mainlined.
>
> This is gentle reminder.
> Do I need to resend the patch?

I am working on getting permissions to help with maintenance of the
git tree. It seems like Chris is busy and hasn't been maintaining the
tree for the last couple of years.

That said, please repost the patch and I will have a look, as soon as
I get the needed permissions in place.

Kind regards
Uffe

>
> Thanks,
> Shiva
>
> > Subject: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
> >
> > As per specification, the host can use either CMD24 or CMD25 in
> > closed-ended or open-ended way.
> > CMD25 is better option as it can flash the firmware image in one go.
> >
> > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> >
> > ---
> >
> > V3:
> >    - Checking the firmware size with MMC_IOC_MAX_BYTES
> >
> > ---
> >
> > V2:
> >    - Removed optional parameter '-c'
> >    - FFU mode use CMD25 instead of CMD24
> >    - CMD25 used as closed-ended
> > ---
> >  mmc.h      |  2 ++
> >  mmc_cmds.c | 70 ++++++++++++++++++++++++++++++------------------------
> >  2 files changed, 41 insertions(+), 31 deletions(-)
> >
> > diff --git a/mmc.h b/mmc.h
> > index 285c1f1..a4cbba4 100644
> > --- a/mmc.h
> > +++ b/mmc.h
> > @@ -25,10 +25,12 @@
> >  /* From kernel linux/mmc/mmc.h */
> >  #define MMC_SWITCH           6       /* ac   [31:0] See below        R1b */
> >  #define MMC_SEND_EXT_CSD     8       /* adtc                         R1  */
> > +#define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
> >  #define MMC_SEND_STATUS              13      /* ac   [31:16] RCA        R1  */
> >  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
> >  #define MMC_SWITCH_MODE_WRITE_BYTE   0x03    /* Set target to value
> > */
> >  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
> > +#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
> >  #define MMC_WRITE_BLOCK              24      /* adtc [31:0] data addr        R1  */
> >  #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
> >  #define MMC_SET_WRITE_PROT   28    /* ac   [31:0] data addr   R1b */
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 19a9da1..43e1f8b 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2414,12 +2414,13 @@ int do_ffu(int nargs, char **argv)
> >       int sect_done = 0, retry = 3, ret = -EINVAL;
> >       unsigned int sect_size;
> >       __u8 ext_csd[512];
> > -     __u8 *buf;
> > +     __u8 *buf = NULL;
> >       __u32 arg;
> >       off_t fw_size;
> >       ssize_t chunk_size;
> >       char *device;
> > -     struct mmc_ioc_multi_cmd *multi_cmd;
> > +     struct mmc_ioc_multi_cmd *multi_cmd = NULL;
> > +     __u32 blocks = 1;
> >
> >       if (nargs != 3) {
> >               fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX>
> > \n");
> > @@ -2439,14 +2440,6 @@ int do_ffu(int nargs, char **argv)
> >               exit(1);
> >       }
> >
> > -     buf = malloc(512);
> > -     multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> > -                             3 * sizeof(struct mmc_ioc_cmd));
> > -     if (!buf || !multi_cmd) {
> > -             perror("failed to allocate memory");
> > -             goto out;
> > -     }
> > -
> >       ret = read_extcsd(dev_fd, ext_csd);
> >       if (ret) {
> >               fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> > @@ -2471,9 +2464,17 @@ int do_ffu(int nargs, char **argv)
> >       }
> >
> >       fw_size = lseek(img_fd, 0, SEEK_END);
> > +     if (fw_size > MMC_IOC_MAX_BYTES || fw_size == 0) {
> > +             fprintf(stderr, "Wrong firmware size");
> > +             goto out;
> > +     }
> >
> > -     if (fw_size == 0) {
> > -             fprintf(stderr, "Firmware image is empty");
> > +     /* allocate maximum required */
> > +     buf = malloc(fw_size);
> > +     multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> > +                             4 * sizeof(struct mmc_ioc_cmd));
> > +     if (!buf || !multi_cmd) {
> > +             perror("failed to allocate memory");
> >               goto out;
> >       }
> >
> > @@ -2483,14 +2484,19 @@ int do_ffu(int nargs, char **argv)
> >               goto out;
> >       }
> >
> > +     /* calculate required fw blocks for CMD25 */
> > +     blocks = fw_size / sect_size;
> > +
> >       /* set CMD ARG */
> >       arg = ext_csd[EXT_CSD_FFU_ARG_0] |
> >               ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
> >               ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
> >               ext_csd[EXT_CSD_FFU_ARG_3] << 24;
> >
> > +     /* prepare multi_cmd for FFU based on cmd to be used */
> > +
> >       /* prepare multi_cmd to be sent */
> > -     multi_cmd->num_of_cmds = 3;
> > +     multi_cmd->num_of_cmds = 4;
> >
> >       /* put device into ffu mode */
> >       multi_cmd->cmds[0].opcode = MMC_SWITCH;
> > @@ -2501,37 +2507,42 @@ int do_ffu(int nargs, char **argv)
> >       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> >       multi_cmd->cmds[0].write_flag = 1;
> >
> > +     /* send block count */
> > +     multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
> > +     multi_cmd->cmds[1].arg = blocks;
> > +     multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> > MMC_CMD_AC;
> > +
> >       /* send image chunk */
> > -     multi_cmd->cmds[1].opcode = MMC_WRITE_BLOCK;
> > -     multi_cmd->cmds[1].blksz = sect_size;
> > -     multi_cmd->cmds[1].blocks = 1;
> > -     multi_cmd->cmds[1].arg = arg;
> > -     multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> > MMC_CMD_ADTC;
> > -     multi_cmd->cmds[1].write_flag = 1;
> > -     mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
> > +     multi_cmd->cmds[2].opcode = MMC_WRITE_MULTIPLE_BLOCK;
> > +     multi_cmd->cmds[2].blksz = sect_size;
> > +     multi_cmd->cmds[2].blocks = blocks;
> > +     multi_cmd->cmds[2].arg = arg;
> > +     multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> > MMC_CMD_ADTC;
> > +     multi_cmd->cmds[2].write_flag = 1;
> > +     mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
> >
> >       /* return device into normal mode */
> > -     multi_cmd->cmds[2].opcode = MMC_SWITCH;
> > -     multi_cmd->cmds[2].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> > +     multi_cmd->cmds[3].opcode = MMC_SWITCH;
> > +     multi_cmd->cmds[3].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> >                       (EXT_CSD_MODE_CONFIG << 16) |
> >                       (EXT_CSD_NORMAL_MODE << 8) |
> >                       EXT_CSD_CMD_SET_NORMAL;
> > -     multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> > -     multi_cmd->cmds[2].write_flag = 1;
> > +     multi_cmd->cmds[3].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > MMC_CMD_AC;
> > +     multi_cmd->cmds[3].write_flag = 1;
> >
> >  do_retry:
> >       /* read firmware chunk */
> >       lseek(img_fd, 0, SEEK_SET);
> > -     chunk_size = read(img_fd, buf, 512);
> > +     chunk_size = read(img_fd, buf, fw_size);
> >
> > -     while (chunk_size > 0) {
> > +     if (chunk_size > 0) {
> >               /* send ioctl with multi-cmd */
> >               ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >
> >               if (ret) {
> >                       perror("Multi-cmd ioctl");
> >                       /* In case multi-cmd ioctl failed before exiting from ffu
> > mode */
> > -                     ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> > +                     ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> >                       goto out;
> >               }
> >
> > @@ -2558,9 +2569,6 @@ do_retry:
> >               } else {
> >                       fprintf(stderr, "Programmed %d/%jd bytes\r",
> > sect_done * sect_size, (intmax_t)fw_size);
> >               }
> > -
> > -             /* read the next firmware chunk (if any) */
> > -             chunk_size = read(img_fd, buf, 512);
> >       }
> >
> >       if ((sect_done * sect_size) == fw_size) {
> > @@ -2597,7 +2605,7 @@ do_retry:
> >               if (ret) {
> >                       perror("Multi-cmd ioctl failed setting install mode");
> >                       /* In case multi-cmd ioctl failed before exiting from ffu
> > mode */
> > -                     ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> > +                     ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> >                       goto out;
> >               }
> >
> > --
> > 2.17.1
>
