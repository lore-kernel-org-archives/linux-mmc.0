Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244ACC54EE9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 14:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiISOBs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiISOBr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 10:01:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE45EE16
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 07:01:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y14so3513309ljn.7
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PmuQj8D46CPybFSblZ+T6XWqnbROIZluEedqhpL1ms4=;
        b=jin97fOPLD4og5vrS8Ecjkrbjr70cUwrlSnxzC73k+2z+9ZmKvXxx2SGDR8TglGNIi
         cOHfWK946ibT/5+jDETESKcSF4DQyvI7UvoRE40Y+Gh+ZMbgNI5rmtmCurYVPl740J2I
         dzc/UfYfxO1sZPTP6YVLJN+FMbxnGtJaeTRJsB0SwoyCd/xyMxX6Nne+vJQbTC2oI0Gu
         USwRqS8o7PYWMUv0QevwAinyNI2mJJtXnnTFA1M3hUp/m5cQ2nTnnr2MIibkjO6GrTZo
         aPoM5shUmPnPIElv4ASIJFayqwY24sdVyXvy2USl7I7y+/N4Ryl6qpjDT7b10UqHKclI
         Iicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PmuQj8D46CPybFSblZ+T6XWqnbROIZluEedqhpL1ms4=;
        b=8AsBrzPgX1yTQD3ulRy3Nnw6r1ZXVPx838ep7N2cQns5es39I5VrZtMus21XVH7sgi
         CpMBNGe2vFjcca/WnJw3wH0BecYpgYo+b3miEHULyRekHHusTpGDKhYSYXkmVPNXONqJ
         WcYloJ44qJAv/hoQJhs682aBWQRWf5+cOCKcnrMbDnUGVGALEzJeetq5gmAM3kLDn5pO
         dEV4p3twDCm1P5CR3iqDEjEMImvJNytD7sERahQasrmkTsz2VhVw3TWbDy2MB4FEsAYW
         Pvwl4MizyxQlasPI/zVHCRtoXplqo3Il2gfu9dA633RmVP8QjcmExUIyXBRyLuBsGQWd
         HM1w==
X-Gm-Message-State: ACrzQf1c6tpwW08/yspvRkP6NbDo7FzpUpc+aJcVZwuZvcTzVhGzRpne
        loiIqG2J3HSrmDDty47AZZr88PqSdk4raw96cMLM5YA+Rh62fA==
X-Google-Smtp-Source: AMsMyM7hfONaFk8w8HIW6xwn3L/Jwu+MH+I+LlX5IMHYEKRIsLuRPgIAWk71I6Ue707zwFVsjfJs2/XD9UkTHzrr7sQ=
X-Received: by 2002:a05:651c:1110:b0:26c:31e3:4c92 with SMTP id
 e16-20020a05651c111000b0026c31e34c92mr5541214ljo.4.1663596104328; Mon, 19 Sep
 2022 07:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220909110322.25141-1-bruno.matic@nokia.com>
In-Reply-To: <20220909110322.25141-1-bruno.matic@nokia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Sep 2022 16:01:07 +0200
Message-ID: <CAPDyKFqqQYMvWCpd8kLv+qWo71zbz0UgxuzrVEfxev9migsSxQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc-utils: correct and clean up the file handling
To:     Bruno Matic <bruno.matic@nokia.com>
Cc:     avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        CLoehle@hyperstone.com, jakob.rossler@nokia.com,
        aarne.heinonen@nokia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Sept 2022 at 13:03, Bruno Matic <bruno.matic@nokia.com> wrote:
>
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>
> Changes in v3:
>   - checked and formated the patch
> Changes in v2:
>   - use perror to propagate the error on file read
>
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
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
