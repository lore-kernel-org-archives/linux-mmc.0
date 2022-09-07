Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656B0C6FA82
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Sep 2022 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIGNC4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Sep 2022 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIGNCz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2022 09:02:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1FB66A6D
        for <linux-mmc@vger.kernel.org>; Wed,  7 Sep 2022 06:02:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c10so6401220ljj.2
        for <linux-mmc@vger.kernel.org>; Wed, 07 Sep 2022 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TqN0Mq+04WavibgivkJrhi22Tfl3y7TgKQaXmtfpTAU=;
        b=JbsI4sSh3yOBC0wBrMTANHgPUOhVb/dzHfe+Z6AY92/FGvbX0i2Bsx9G7NZooXH8ly
         1fU7BgzerLkzutRyQ+ep+QD6qzAGyEOKcKk1suzDSKLQhD7N9BReT2S1B4KhO6lU62OI
         JrWZq/2eG7McfdfZyOchMq0K5Xw3i0DDsZLoY40xq3rHtTbXeWIjG/LK5viVvXton+tO
         5tKg+Q21EwR4bqrmpBL+GNi7HHHMa1fc0FS2IzIiNH5gLGNkAG21/gEONhhcth18dY1w
         C75U4Rzu4n6ZdZfclc7GHUaxvCRN6MJyi7ymD4GMKO6Mz01PvYsCKpXLg5twepUvVtRM
         RyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TqN0Mq+04WavibgivkJrhi22Tfl3y7TgKQaXmtfpTAU=;
        b=UwOznP0WfAsXRacz9ml7ks73hGXl9pSfnh6eqZnYbEIoNs4uvDb/8NqhdW6ycwRpcS
         iJaxi73kItuT5PuTkuZh3vyuXUl6tgfix522ZoHWOl+OCBmn3OlqvTCqYbvxOGq2rbq7
         WoumEKEQ1OZtF7eqnKbqNB18N6jfz1sn80AZoytz1Fp14WeA0hzmq6Ud9KUjzWUq3bGb
         YUTOVSXfU66du91ujw9FZbaSgR2j9yZzwdS3YzhnzkBamFHkuHSJrjDmXQ8/4Zn/GFEd
         Zqf3FJkIYj4v40na8IBXpgSyKKsfPVrF6TjQfjD7koIVput5EunScCaBg7Tg/B1fIj0g
         IGMQ==
X-Gm-Message-State: ACgBeo26bzWX8DNJJYrn0PaGH9Wfhvj93djOHFR3OqDnAW3Ne0xzXlSu
        B4qahHRpKlXHVoVibDwY4pyF8VXB+ma3L+XLXtmQvn6kYB0dhA==
X-Google-Smtp-Source: AA6agR6W6A7xwMPRFxWst4fu3Vt1fDZkcf0RuOjqXItosEE+7SRy4zVxfl1l+ahhkIFgZPPWwZ1x935+K2zcK/jaIDY=
X-Received: by 2002:a05:651c:214:b0:26a:b03b:9e0c with SMTP id
 y20-20020a05651c021400b0026ab03b9e0cmr915186ljn.463.1662555771570; Wed, 07
 Sep 2022 06:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR0701MB29649D655F1BB8F2156300E2EF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <CAPDyKFrZWi31sKVmeUs_xkyM1ZCo=suo-61Y_ccBvMb1hL3h2g@mail.gmail.com> <AM5PR0701MB296449F4FDC9D463A416D63FEF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB296449F4FDC9D463A416D63FEF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Sep 2022 15:02:15 +0200
Message-ID: <CAPDyKFq=ryD6Op7fOfojoXdORYcTCO6Uv=+wZBj=M+VCr5xAvQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: correct and clean up the file handling
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 6 Sept 2022 at 16:44, Matic, Bruno (Nokia - DE/Ulm)
<bruno.matic@nokia.com> wrote:
>
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>

Sorry, patchwork is still not accepting your patch - and I am unable
to download it manually too.

My guess is that the problem is that the email gets sent with
"Content-Transfer-Encoding: base64", so I guess you are still not
using git send-email.

Kind regards
Uffe

> ---
> Changes in v2:
>   - use perror to propagate the error on file read
>
>  mmc_cmds.c | 66 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..ef1d8c6 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2765,7 +2765,6 @@ int do_ffu(int nargs, char **argv)
>         __u8 *buf = NULL;
>         __u32 arg;
>         off_t fw_size;
> -       ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd = NULL;
>
> @@ -2879,45 +2878,44 @@ int do_ffu(int nargs, char **argv)
>         multi_cmd->cmds[3].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>         multi_cmd->cmds[3].write_flag = 1;
>
> -do_retry:
> -       /* read firmware chunk */
> +       /* read firmware */
>         lseek(img_fd, 0, SEEK_SET);
> -       chunk_size = read(img_fd, buf, fw_size);
> +       if (read(img_fd, buf, fw_size) != fw_size) {
> +               perror("Could not read the firmware file: ");
> +               ret = -ENOSPC;
> +               goto out;
> +       }
>
> -       if (chunk_size > 0) {
> -               /* send ioctl with multi-cmd */
> -               ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +do_retry:
> +       /* send ioctl with multi-cmd */
> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>
> -               if (ret) {
> -                       perror("Multi-cmd ioctl");
> -                       /* In case multi-cmd ioctl failed before exiting from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl");
> +               /* In case multi-cmd ioctl failed before exiting from ffu mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
>
> -               ret = read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> -                       goto out;
> -               }
> +       ret = read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> +               goto out;
> +       }
>
> -               /* Test if we need to restart the download */
> -               sect_done = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> -               /* By spec, host should re-start download from the first sector if sect_done is 0 */
> -               if (sect_done == 0) {
> -                       if (retry > 0) {
> -                               retry--;
> -                               fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
> -                               goto do_retry;
> -                       }
> -                       fprintf(stderr, "Programming failed! Aborting...\n");
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * sect_size, (intmax_t)fw_size);
> +       /* Test if we need to restart the download */
> +       sect_done = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> +       /* By spec, host should re-start download from the first sector if sect_done is 0 */
> +       if (sect_done == 0) {
> +               if (retry--) {
> +                       fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
> +                       goto do_retry;
>                 }
> +               fprintf(stderr, "Programming failed! Aborting...\n");
> +               goto out;
>         }
>
>         if ((sect_done * sect_size) == fw_size) {
> --
> 2.29.0
>
