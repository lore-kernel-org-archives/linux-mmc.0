Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0204ECAAD5
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Sep 2022 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiIFNRo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Sep 2022 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiIFNRo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2022 09:17:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B34F1A2
        for <linux-mmc@vger.kernel.org>; Tue,  6 Sep 2022 06:17:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn9so12263387ljb.6
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2022 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=NjjiMWYTfCWH2yJ3WnECLPMruZQskJDNuTBvvpsronc=;
        b=s6tvtVUk8QyJRLKxgEYIWdX5pnoTQWFuQrawWSgyB5P8USxkjRH8B4utaS1QjK5P5U
         50QhWxf+fkydi9dDzq+tnYSrwHaDajqFoZpoUXzq3AD+ZKyuap1z/ChQcV2Nij4fTUOw
         Zr0d+pa8AljKKQjgLo41+etzSjdOJRGKL2rEw/1YeqUO2RCt2W5hhDW4OevRXwU6veLv
         M1j7Ged49EYg+ccmOcIwxVUKMhNuFHzZddSjpxlW3yKAG3V+2GQsx+gdgZXOw1onzt+3
         6c9/OSwxJjf676u7YtttT2eLJ9b4eDpE3KSeZTHw+cQRFmgiGAxVZwcCgQvXH0VkdGKb
         3Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NjjiMWYTfCWH2yJ3WnECLPMruZQskJDNuTBvvpsronc=;
        b=0IFb9I0atSwagv596pvMIUWgcnpgsDvURxCaMxK3hycvse+0O1cUUFCRItmxTN/AgC
         jTA7yFfl9YxoL4b92LQZFxvS9LbFTkVluXjoG8WW4qZcELLGGm+Ga6LFcQWjk3ibh/AI
         Ozz98vfcIcVQOOR+FuNGAGJOUQ+J75k5t+GgqqSGCSyfBnxPLAUmmy/h9ku1S/wHdCFo
         tI04ChR5Jdd4ACb/gzy0Ufs+RuAsypGnYa675/TneFSKx3UyyaXqhde/SRoRpBfUAc9W
         /TUv9OLvIhOko4afPgL6uxT0ZqMo9jw6Zqodr+Mhd564Qlnz45xf5yg05/8lInghYozC
         jx5A==
X-Gm-Message-State: ACgBeo3nMSPImdr8yzk+RL7p02hLulrnzAsiAhWlfhnPExqUa1k/jsAb
        EoTIXyfv+C6EvoQbTJgROG6uHaIuRfdgJESjQG24aoaNXdHutQ==
X-Google-Smtp-Source: AA6agR6I2TYIQpjb4sWc+ZSWANU3mAivNIO38xwnf3sEaEIU/74TyyzPBbvrW/8kzvd6nm+pFbpHr7Ffkq2MRxliwpw=
X-Received: by 2002:a2e:bf0a:0:b0:26a:b64a:7b84 with SMTP id
 c10-20020a2ebf0a000000b0026ab64a7b84mr702573ljr.367.1662470259058; Tue, 06
 Sep 2022 06:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR0701MB29649D655F1BB8F2156300E2EF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB29649D655F1BB8F2156300E2EF7E9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Sep 2022 15:17:03 +0200
Message-ID: <CAPDyKFrZWi31sKVmeUs_xkyM1ZCo=suo-61Y_ccBvMb1hL3h2g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: correct and clean up the file handling
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 6 Sept 2022 at 12:14, Matic, Bruno (Nokia - DE/Ulm)
<bruno.matic@nokia.com> wrote:
>
> Hi everyone,
>
> Previous patch did pass the checks and applied to the repository, but sin=
ce I use yocto as my development environment
> the warnings about hunk offsets were ignored.
> I have now re-rolled patch on top of a clean mmc-utils repository - chang=
es are the same.
> Hopefully this will be ok now.

Sorry, but no this isn't much better it seems. From the guide [1],
there are a couple of important steps that you need to follow. Please
have a closer look.

1) Format the patch according to the "canonical patch format" with
"git format-patch".
2. Run ./scripts/checkpatch.pl (the script is available in kernel code
tree) on the formatted patch - and fix the potential warnings/errors.
3) Submit your patch as plain text with git send-email.

Hope this helps!

Kind regards
Uffe

[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>
> Best regards,
> Bruno Mati=C4=87
>
> -------------------------------------------------------------------------=
----------------------
>
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> ---
>  mmc_cmds.c | 66 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..ef1d8c6 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2765,7 +2765,6 @@ int do_ffu(int nargs, char **argv)
>         __u8 *buf =3D NULL;
>         __u32 arg;
>         off_t fw_size;
> -       ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>
> @@ -2879,45 +2878,44 @@ int do_ffu(int nargs, char **argv)
>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_=
CMD_AC;
>         multi_cmd->cmds[3].write_flag =3D 1;
>
> -do_retry:
> -       /* read firmware chunk */
> +       /* read firmware */
>         lseek(img_fd, 0, SEEK_SET);
> -       chunk_size =3D read(img_fd, buf, fw_size);
> +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> +               perror("Could not read the firmware file: ");
> +               ret =3D -ENOSPC;
> +               goto out;
> +       }
>
> -       if (chunk_size > 0) {
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +do_retry:
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>
> -               if (ret) {
> -                       perror("Multi-cmd ioctl");
> -                       /* In case multi-cmd ioctl failed before exiting =
from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl");
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
>
> -               ret =3D read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> -                       goto out;
> -               }
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
>
> -               /* Test if we need to restart the download */
> -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << =
8 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << =
16 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << =
24;
> -               /* By spec, host should re-start download from the first =
sector if sect_done is 0 */
> -               if (sect_done =3D=3D 0) {
> -                       if (retry > 0) {
> -                               retry--;
> -                               fprintf(stderr, "Programming failed. Retr=
ying... (%d)\n", retry);
> -                               goto do_retry;
> -                       }
> -                       fprintf(stderr, "Programming failed! Aborting...\=
n");
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", sect=
_done * sect_size, (intmax_t)fw_size);
> +       /* Test if we need to restart the download */
> +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> +       /* By spec, host should re-start download from the first sector i=
f sect_done is 0 */
> +       if (sect_done =3D=3D 0) {
> +               if (retry--) {
> +                       fprintf(stderr, "Programming failed. Retrying... =
(%d)\n", retry);
> +                       goto do_retry;
>                 }
> +               fprintf(stderr, "Programming failed! Aborting...\n");
> +               goto out;
>         }
>
>         if ((sect_done * sect_size) =3D=3D fw_size) {
> --
> 2.29.0
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Tuesday, September 6, 2022 10:29 AM
> To: Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@nokia.com>
> Cc: Avri Altman <Avri.Altman@wdc.com>; linux-mmc@vger.kernel.org; Christi=
an L=C3=B6hle <CLoehle@hyperstone.com>; Rossler, Jakob (Nokia - DE/Ulm) <ja=
kob.rossler@nokia.com>; Heinonen, Aarne (Nokia - FI/Espoo) <aarne.heinonen@=
nokia.com>
> Subject: Re: [PATCH] mmc-utils: correct and clean up the file handling
>
> On Mon, 15 Aug 2022 at 15:11, Matic, Bruno (Nokia - DE/Ulm) <bruno.matic@=
nokia.com> wrote:
> >
> > Hi everyone,
> > As said, here is the reworked patch.
> >
> >
> > Add the check if the whole firmware was loaded.
> > Cleaned up the leftovers of handling the file in chunks.
> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
>
> Hi Bruno,
>
> Unfortunately, I was not able to apply this patch.
>
> $subject patch was not accepted by the mmc patchwork [1], which I am usin=
g to manage the patches. Please make sure to conform to the process of subm=
itting patches [2] and run scripts/checkpatch.pl before re-submitting.
>
> Kind regards
> Uffe
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/
> [2]
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> > ---
> >  mmc_cmds.c | 66
> > ++++++++++++++++++++++++++----------------------------
> >  1 file changed, 32 insertions(+), 34 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 70480df..7d37e93 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
> >         __u8 *buf =3D NULL;
> >         __u32 arg;
> >         off_t fw_size;
> > -       ssize_t chunk_size;
> >         char *device;
> >         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> >         __u32 blocks =3D 1;
> > @@ -2925,45 +2924,44 @@ int do_ffu(int nargs, char **argv)
> >         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MM=
C_CMD_AC;
> >         multi_cmd->cmds[3].write_flag =3D 1;
> >
> > -do_retry:
> > -       /* read firmware chunk */
> > +       /* read firmware */
> >         lseek(img_fd, 0, SEEK_SET);
> > -       chunk_size =3D read(img_fd, buf, fw_size);
> > +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> > +               perror("Could not read the firmware file: ");
> > +               ret =3D -ENOSPC;
> > +               goto out;
> > +       }
> >
> > -       if (chunk_size > 0) {
> > -               /* send ioctl with multi-cmd */
> > -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > +do_retry:
> > +       /* send ioctl with multi-cmd */
> > +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> >
> > -               if (ret) {
> > -                       perror("Multi-cmd ioctl");
> > -                       /* In case multi-cmd ioctl failed before exitin=
g from ffu mode */
> > -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3])=
;
> > -                       goto out;
> > -               }
> > +       if (ret) {
> > +               perror("Multi-cmd ioctl");
> > +               /* In case multi-cmd ioctl failed before exiting from f=
fu mode */
> > +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > +               goto out;
> > +       }
> >
> > -               ret =3D read_extcsd(dev_fd, ext_csd);
> > -               if (ret) {
> > -                       fprintf(stderr, "Could not read EXT_CSD from %s=
\n", device);
> > -                       goto out;
> > -               }
> > +       ret =3D read_extcsd(dev_fd, ext_csd);
> > +       if (ret) {
> > +               fprintf(stderr, "Could not read EXT_CSD from %s\n", dev=
ice);
> > +               goto out;
> > +       }
> >
> > -               /* Test if we need to restart the download */
> > -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] <=
< 8 |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] <=
< 16 |
> > -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] <=
< 24;
> > -               /* By spec, host should re-start download from the firs=
t sector if sect_done is 0 */
> > -               if (sect_done =3D=3D 0) {
> > -                       if (retry > 0) {
> > -                               retry--;
> > -                               fprintf(stderr, "Programming failed. Re=
trying... (%d)\n", retry);
> > -                               goto do_retry;
> > -                       }
> > -                       fprintf(stderr, "Programming failed! Aborting..=
.\n");
> > -                       goto out;
> > -               } else {
> > -                       fprintf(stderr, "Programmed %d/%jd bytes\r", se=
ct_done * sect_size, (intmax_t)fw_size);
> > +       /* Test if we need to restart the download */
> > +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> > +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> > +       /* By spec, host should re-start download from the first sector=
 if sect_done is 0 */
> > +       if (sect_done =3D=3D 0) {
> > +               if (retry--) {
> > +                       fprintf(stderr, "Programming failed. Retrying..=
. (%d)\n", retry);
> > +                       goto do_retry;
> >                 }
> > +               fprintf(stderr, "Programming failed! Aborting...\n");
> > +               goto out;
> >         }
> >
> >         if ((sect_done * sect_size) =3D=3D fw_size) {
> > --
> > 2.29.0
> >
