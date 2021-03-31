Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC7C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D6161981
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhCaJl0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhCaJk6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:40:58 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CFBC06175F
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:40:58 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id d82so4213162vkd.3
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPKXCbBQ6MLmvA2x0+kwnCnmEII6VuYmlVud9KJPlFE=;
        b=wIxhXR+vq1j188ZifHBHYW73Sv2mGWYukQBhrCK52oU9TkK/w98T/bWNngw/RrSl0G
         C3TjDccbbd9Y9faFUsZ4SQ3S6Ea1pmhu/ANGqr5X5sl6STd9xXJqNdSh3GBGQFGVNnTQ
         AcRQPLwaWpBmAHXi8KcxqXqgzrh4ZDgVNKFZomEkT67MZAEqm1aH7SCd/6iw7871JXDw
         wAQj6GSd/Z8FwbtaS8crmsjUtPLy0aMQBRTFz4lcb2uQGCXl2yi6ervZAukD6+m2jYg1
         OHJpiMUl3URiVLq/1jC31d9Q7ZviSljMqkesj1SHHb3ToxOMclLcHhwrFxtrIymYqQ0s
         ZXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPKXCbBQ6MLmvA2x0+kwnCnmEII6VuYmlVud9KJPlFE=;
        b=aQyesWvjven8M33/YyEgRt+backIUTbiJNG0ccDUfjZHPnalUtMpLRBgFnGlaBnb9C
         CaceSw9N/zF4fJ2Lv07ijnemgos5w/rKa00KudGE5efOGAmLEj5jlHc6rBY/wXxvFIkB
         TLukt32QozmgaQ0jdKmBK+yALd9wF8lP/W/hbdMeo3xb/0s+5gIGF1mh33ik09LwZxyj
         xkk1/HcNO1EoeT0jWzT/9DXS3pRRFv0kBZPPEaZl7rJcN714Ai4gT0bImMutIoEcvrKJ
         SmXReF8dCi7Ft6Aw+uLiBjHX6YUkzmsGTl+3vKl1h7NPBBEjLUGpsqLBTmN5qaP+192v
         oT4w==
X-Gm-Message-State: AOAM532ejgHJ3rBolLqLZZ/HsqqsO5IiSX4OHzCbchnpr4E1pGhz31JM
        SRSwWAWcZvkU9o/POvAX2QMysRtdB1OWR/foBV2mqg==
X-Google-Smtp-Source: ABdhPJxt7GqwyVdgobABm5+hXR4HenXY2A8WM1pKxhHTLliNI5QlwVBMjeDGHnB/apShkjdLsbf6wxl7YbEAF15LwG0=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr976300vkb.7.1617183657318;
 Wed, 31 Mar 2021 02:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR08MB63973BF8F3C6959487BF5707B86A9@MN2PR08MB6397.namprd08.prod.outlook.com>
In-Reply-To: <MN2PR08MB63973BF8F3C6959487BF5707B86A9@MN2PR08MB6397.namprd08.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:40:20 +0200
Message-ID: <CAPDyKFr1E+MTi2G8Zkp_H8c_6BOaP3mpV90pJ3qaqoTyoc-Gwg@mail.gmail.com>
Subject: Re: [PATCH RESEND V4] mmc-utils: let FFU mode use CMD23 and CMD25
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Chris Ball <chris@printf.net>, Avri Altman <Avri.Altman@wdc.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Mar 2021 at 11:42, Shivamurthy Shastri (sshivamurthy)
<sshivamurthy@micron.com> wrote:
>
> As per specification, the host can use either CMD24 or CMD25 in
> closed-ended or open-ended way.
> CMD25 is better option as it can flash the firmware image in one go.
>
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Tested-by: Bean Huo <beanhuo@micron.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> V4:
>    - Removed MMC_STOP_TRANSMISSION, as it is not used in this patch
>    - Added reviewed and tested by from Bean Huo
> V3:
>    - Checking the firmware size with MMC_IOC_MAX_BYTES
> V2:
>    - Removed optional parameter '-c'
>    - FFU mode use CMD25 instead of CMD24
>    - CMD25 used as closed-ended
>
>  mmc.h      |  1 +
>  mmc_cmds.c | 70 ++++++++++++++++++++++++++++++------------------------
>  2 files changed, 40 insertions(+), 31 deletions(-)
>
> diff --git a/mmc.h b/mmc.h
> index 648fb2672d6f..cf2d4766a16d 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -29,6 +29,7 @@
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
> +#define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
>  #define MMC_WRITE_BLOCK                24      /* adtc [31:0] data addr        R1  */
>  #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
>  #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb371892c521..6e6c09ae3b85 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2446,12 +2446,13 @@ int do_ffu(int nargs, char **argv)
>         int sect_done = 0, retry = 3, ret = -EINVAL;
>         unsigned int sect_size;
>         __u8 ext_csd[512];
> -       __u8 *buf;
> +       __u8 *buf = NULL;
>         __u32 arg;
>         off_t fw_size;
>         ssize_t chunk_size;
>         char *device;
> -       struct mmc_ioc_multi_cmd *multi_cmd;
> +       struct mmc_ioc_multi_cmd *multi_cmd = NULL;
> +       __u32 blocks = 1;
>
>         if (nargs != 3) {
>                 fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX> \n");
> @@ -2471,14 +2472,6 @@ int do_ffu(int nargs, char **argv)
>                 exit(1);
>         }
>
> -       buf = malloc(512);
> -       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> -                               3 * sizeof(struct mmc_ioc_cmd));
> -       if (!buf || !multi_cmd) {
> -               perror("failed to allocate memory");
> -               goto out;
> -       }
> -
>         ret = read_extcsd(dev_fd, ext_csd);
>         if (ret) {
>                 fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> @@ -2503,9 +2496,17 @@ int do_ffu(int nargs, char **argv)
>         }
>
>         fw_size = lseek(img_fd, 0, SEEK_END);
> +       if (fw_size > MMC_IOC_MAX_BYTES || fw_size == 0) {
> +               fprintf(stderr, "Wrong firmware size");
> +               goto out;
> +       }
>
> -       if (fw_size == 0) {
> -               fprintf(stderr, "Firmware image is empty");
> +       /* allocate maximum required */
> +       buf = malloc(fw_size);
> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                               4 * sizeof(struct mmc_ioc_cmd));
> +       if (!buf || !multi_cmd) {
> +               perror("failed to allocate memory");
>                 goto out;
>         }
>
> @@ -2515,14 +2516,19 @@ int do_ffu(int nargs, char **argv)
>                 goto out;
>         }
>
> +       /* calculate required fw blocks for CMD25 */
> +       blocks = fw_size / sect_size;
> +
>         /* set CMD ARG */
>         arg = ext_csd[EXT_CSD_FFU_ARG_0] |
>                 ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
>                 ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
>                 ext_csd[EXT_CSD_FFU_ARG_3] << 24;
>
> +       /* prepare multi_cmd for FFU based on cmd to be used */
> +
>         /* prepare multi_cmd to be sent */
> -       multi_cmd->num_of_cmds = 3;
> +       multi_cmd->num_of_cmds = 4;
>
>         /* put device into ffu mode */
>         multi_cmd->cmds[0].opcode = MMC_SWITCH;
> @@ -2533,37 +2539,42 @@ int do_ffu(int nargs, char **argv)
>         multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>         multi_cmd->cmds[0].write_flag = 1;
>
> +       /* send block count */
> +       multi_cmd->cmds[1].opcode = MMC_SET_BLOCK_COUNT;
> +       multi_cmd->cmds[1].arg = blocks;
> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +
>         /* send image chunk */
> -       multi_cmd->cmds[1].opcode = MMC_WRITE_BLOCK;
> -       multi_cmd->cmds[1].blksz = sect_size;
> -       multi_cmd->cmds[1].blocks = 1;
> -       multi_cmd->cmds[1].arg = arg;
> -       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> -       multi_cmd->cmds[1].write_flag = 1;
> -       mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
> +       multi_cmd->cmds[2].opcode = MMC_WRITE_MULTIPLE_BLOCK;
> +       multi_cmd->cmds[2].blksz = sect_size;
> +       multi_cmd->cmds[2].blocks = blocks;
> +       multi_cmd->cmds[2].arg = arg;
> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +       multi_cmd->cmds[2].write_flag = 1;
> +       mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
>
>         /* return device into normal mode */
> -       multi_cmd->cmds[2].opcode = MMC_SWITCH;
> -       multi_cmd->cmds[2].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +       multi_cmd->cmds[3].opcode = MMC_SWITCH;
> +       multi_cmd->cmds[3].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>                         (EXT_CSD_MODE_CONFIG << 16) |
>                         (EXT_CSD_NORMAL_MODE << 8) |
>                         EXT_CSD_CMD_SET_NORMAL;
> -       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> -       multi_cmd->cmds[2].write_flag = 1;
> +       multi_cmd->cmds[3].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +       multi_cmd->cmds[3].write_flag = 1;
>
>  do_retry:
>         /* read firmware chunk */
>         lseek(img_fd, 0, SEEK_SET);
> -       chunk_size = read(img_fd, buf, 512);
> +       chunk_size = read(img_fd, buf, fw_size);
>
> -       while (chunk_size > 0) {
> +       if (chunk_size > 0) {
>                 /* send ioctl with multi-cmd */
>                 ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>
>                 if (ret) {
>                         perror("Multi-cmd ioctl");
>                         /* In case multi-cmd ioctl failed before exiting from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> +                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
>                         goto out;
>                 }
>
> @@ -2590,9 +2601,6 @@ do_retry:
>                 } else {
>                         fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * sect_size, (intmax_t)fw_size);
>                 }
> -
> -               /* read the next firmware chunk (if any) */
> -               chunk_size = read(img_fd, buf, 512);
>         }
>
>         if ((sect_done * sect_size) == fw_size) {
> @@ -2629,7 +2637,7 @@ do_retry:
>                 if (ret) {
>                         perror("Multi-cmd ioctl failed setting install mode");
>                         /* In case multi-cmd ioctl failed before exiting from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> +                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
>                         goto out;
>                 }
>
> --
> 2.25.1
>
