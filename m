Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355FDC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 11:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiGMLEc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiGMLE2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 07:04:28 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B80E04
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 04:04:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z132so603671iof.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qf4bx34812dq2Qlf+xyCR18bQ+jQ+hCDA70H/QLDIZ8=;
        b=bcmrD8xvBXcCyYG/Zm0THsTkhQo8XfVs4+5Xc/mr2GYpGB1fA243+ZGqMlICVDGiDs
         jxM3uYPekPjczaY+K4EUB2xM04IDL5f9n/3WvpSAeo3/0JGG1T6ikr1WfBMrZaaFEiDu
         sTPyEC7KeY1BgOBY1DrH0udeGg1morbrGCyG7+E1yXziPyKhwQIjbvrqoNOldhQJLD2j
         FUX1wUI+GZdFYNpo/koBoxv7xjkIZbkUPJwjPCwbKlASMgVlXEpUWmQEeG2ZtqwVbAwv
         Rwf0tuGsrEFgpjYc1dzIYmGwISynv8t+oU1rGbYeHJ9WNzb1wzplPFtcu2jzEMkQEMIQ
         KsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qf4bx34812dq2Qlf+xyCR18bQ+jQ+hCDA70H/QLDIZ8=;
        b=mDs717UjIuaQR7ymgIX1SY0HUWo7PGJ2qO9VtfmWqpL1expvbIeWoDAOZyP+XhQcb5
         RyV3wGmOXkxFzbatHZSRaF262sPxBDLj8xtyY4E75MljaGz1ZSSmaxyIiMgBXOZRA9Lb
         agQVMl0Jm4/qOleCVbykdYdmdwMQph9JyHGp8oHUOHEMHZAeplMxp3tyVmaDIN+hRTkq
         0NdyLT9Zv1T5vjP7/1Fq4F5AcYXeR7IeIZknJfxrAu3hgFNiKgNWuMQP6oWwuy6wVVVR
         NAO/uEAT4zGEUQZYcF7f/NXdqIMzqGyHdjqEkUZfyQ2rOfmSYX5ZCiKXeYorpMStQJq2
         mk2w==
X-Gm-Message-State: AJIora+TddVpXkEvLyJXAiWjNxRUI+7bLOXPDv5/wdkgdsAHFMbPnMbv
        eRw7y9zQ/ilnwe1rdtl7p2b/0WCybQkPjp+nyG6NfA==
X-Google-Smtp-Source: AGRyM1sLJIQLTY0b2o9HXw4oNtvwzMXUwiQkvxoTh/s+ujPokP1zMtTt7VSx0nW0Ea5lw7jD3qL/a57Dlc4kNTHoEH0=
X-Received: by 2002:a05:6602:2e03:b0:67b:9f61:e328 with SMTP id
 o3-20020a0566022e0300b0067b9f61e328mr1429104iow.93.1657710265217; Wed, 13 Jul
 2022 04:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <54477cf05b9148109996dd85c9afc30f@hyperstone.com>
In-Reply-To: <54477cf05b9148109996dd85c9afc30f@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 13:03:48 +0200
Message-ID: <CAPDyKFqwBNKE9t7Z4Rx5CPn8EEKJTTDSt+=qy=y4CfZmNz73vA@mail.gmail.com>
Subject: Re: [PATCHv2] mmc-utils: Fix 4k sector size block count in FFU
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Jun 2022 at 15:18, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> FFU used the wrong assumption, that CMD23 work in
> 4k sector chunks when setting the block count.
> Instead the CMD23 block count argument just needs
> to be a multiple of 8, which the fw_size is anyway.
>
> Fixes: 89cd01ed865a (mmc_utils: add ffu support)
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index bb0f022..12b7802 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2768,7 +2768,6 @@ int do_ffu(int nargs, char **argv)
>         ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> -       __u32 blocks =3D 1;
>
>         if (nargs !=3D 3) {
>                 fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblk=
X> \n");
> @@ -2826,15 +2825,13 @@ int do_ffu(int nargs, char **argv)
>                 goto out;
>         }
>
> +       /* ensure fw is multiple of native sector size */
>         sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 =
: 4096;
>         if (fw_size % sect_size) {
>                 fprintf(stderr, "Firmware data size (%jd) is not aligned!=
\n", (intmax_t)fw_size);
>                 goto out;
>         }
>
> -       /* calculate required fw blocks for CMD25 */
> -       blocks =3D fw_size / sect_size;
> -
>         /* set CMD ARG */
>         arg =3D ext_csd[EXT_CSD_FFU_ARG_0] |
>                 ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
> @@ -2857,13 +2854,17 @@ int do_ffu(int nargs, char **argv)
>
>         /* send block count */
>         multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
> -       multi_cmd->cmds[1].arg =3D blocks;
> +       multi_cmd->cmds[1].arg =3D fw_size / 512;
>         multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CM=
D_AC;
>
>         /* send image chunk */
>         multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> -       multi_cmd->cmds[2].blksz =3D sect_size;
> -       multi_cmd->cmds[2].blocks =3D blocks;
> +       /*
> +        * blksz and blocks essentially do not matter, as long as the pro=
duct
> +        * is fw_size, but some hosts don't handle larger blksz well.
> +        */
> +       multi_cmd->cmds[2].blksz =3D 512;
> +       multi_cmd->cmds[2].blocks =3D fw_size / 512;
>         multi_cmd->cmds[2].arg =3D arg;
>         multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CM=
D_ADTC;
>         multi_cmd->cmds[2].write_flag =3D 1;
> --
> 2.36.1
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
