Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD8C38145
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Sep 2022 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiIFIbQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiIFIad (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2022 04:30:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE32D4E84E
        for <linux-mmc@vger.kernel.org>; Tue,  6 Sep 2022 01:30:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so3926760lfo.8
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2022 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oKuV1j4fyAgT5aEnAR/khcbXYRxiiyBOx/vshyhZ1B0=;
        b=MJftAfpuhlqRz4y4Q7MgtQ3UywNtbsbWOnhztW897HSR0PO6Q0SY5GRNnNDtr6ruQ/
         4xPFLkdbWVPT3a7EjTkeCV/wWdWoNOrrZd2revfRwUYIsCAW6t7mzxH0Q0I2ut2ny3Zr
         LefRq7jD6WDK2q3TPgi/jfXSdxI8h8bxjmEQ/EVWXaP6l71klhExl7iGMIESnivxKwFN
         lTJpv/KWF+iN7SVIDgWKkrTVy6RboT9g+VzqSubHkUB71s5zP2q/NkKI9MSXtcJvmIBV
         np3eIn0hx9VgsKN0W0NkTWwYC+K4RFWW3TBt4gVix3F78KhgtifcHotPAIJOK8Fjy7cM
         W1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oKuV1j4fyAgT5aEnAR/khcbXYRxiiyBOx/vshyhZ1B0=;
        b=vcAfbmR/qvybEIN2qsDQO2s7airsPMO3Inx1hRQeYB+kncB4+Iuv3aC7k3Mh0rvRZh
         tkgn89mqYszimj+NhDbXXaPVYaQYt24saeuY40B4J+SXx/T4JL0RKMDY9KJ9nHDskCXU
         vlrzC+wZYjR2/bb7FJKTvSUMNWAF86m3PNoibRMQdLCcY/q3f/Kn907N6XPfjmpI+DvI
         NWo0GD+XAY1/VqoWS4Yuh8xmbBQOaFTceTCONOKDvZ6hZ7dmVs/eZ5Gk/YZCzNkHUGCe
         pH0U4Ioo3H5BgCaH3fJibTo0YjgY3opzVZfEDHMjvqLAPxRb6fFF10lTmbQ/soV8+qT9
         A8Hw==
X-Gm-Message-State: ACgBeo0QuDhI7x01ZYsEnaKQxY4WXK+8Pb/2wMT+JZ7oWyLtJlkXC8kJ
        rKK6POilKgYayqWuahCeLGQh9I7M/+/kA7g6j+6jWg==
X-Google-Smtp-Source: AA6agR63pn4hzyg3P1QwQiHN+nAGB+FoX4KUN4m/usY9GH02qeOjK7JT8I8d7b9Rxxwsay7BdI/1gQRMCIf3nYJfPjs=
X-Received: by 2002:ac2:4c42:0:b0:497:9dfe:e870 with SMTP id
 o2-20020ac24c42000000b004979dfee870mr243382lfk.184.1662453004139; Tue, 06 Sep
 2022 01:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65756EA45A10629F2EA8A870FC689@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964D0B47A64F62402ECC43BEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2964D0B47A64F62402ECC43BEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Sep 2022 10:29:27 +0200
Message-ID: <CAPDyKFokwxG6qQv2N9BrRFBvTMNSPSraStm_LurtjDANXAXvXQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: correct and clean up the file handling
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

On Mon, 15 Aug 2022 at 15:11, Matic, Bruno (Nokia - DE/Ulm)
<bruno.matic@nokia.com> wrote:
>
> Hi everyone,
> As said, here is the reworked patch.
>
>
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>

Hi Bruno,

Unfortunately, I was not able to apply this patch.

$subject patch was not accepted by the mmc patchwork [1], which I am
using to manage the patches. Please make sure to conform to the
process of submitting patches [2] and run scripts/checkpatch.pl before
re-submitting.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/list/
[2]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> ---
>  mmc_cmds.c | 66 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 70480df..7d37e93 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
>         __u8 *buf = NULL;
>         __u32 arg;
>         off_t fw_size;
> -       ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd = NULL;
>         __u32 blocks = 1;
> @@ -2925,45 +2924,44 @@ int do_ffu(int nargs, char **argv)
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
