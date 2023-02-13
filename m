Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C13C636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 13:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBMNin (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 08:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBMNim (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 08:38:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F25193D4
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 05:38:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id x31so8117612pgl.6
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 05:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF1P5TfBIPKJ6WFS9mQOcribHkWp6/vWF2K7YLacH5c=;
        b=nk2Lg55U9ZLgq8RFWdX82Nth7uZ9ret2VEvDT0H8OBXxROiHcNYQjOlUXpnUbjtnhF
         IDU6XtOn5tOdK+m2w31riTEh22/cGOgzZreofdnHuyx1bsOwFRtEkv99+F2BdRn0Y+lG
         qDNnD9UlHu3sObbt0Ieh/r+7yeeo4LsNzQmZ7z06YTkLu9TEXym821N7vYeHmBzjyhOe
         5iLUhrUUEfi5dwi5jih66vvO7BDoR/S7Gb/yg+qqyTWUePcfR+RcANkQh2EycPRG6h1g
         Z7chA9qjOdGGDKoBL00d2RPbO3VXqRqHVJ7hpGsL1MeRdiNSMZRTEfJFUgx/yRGx5Z18
         uzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF1P5TfBIPKJ6WFS9mQOcribHkWp6/vWF2K7YLacH5c=;
        b=jj11YKKCeI/oFA9LmBruX5ym8d1+93pfrhTSycRdiCnMslgSTSsnhPgHHZPcFItxcS
         Uzn0UEAW3m29Rmjy3YF9Ay6CXPn7z7H/NWrBX3HnSuthHN8zUsnESOcp276Mlo6phHIr
         CC2WjPSfnecytV/erXq9sczkXt+BCFVN/jaKv9LZuH9k/XmQemCOQhIUJo3EwYGn4zNS
         a4aDnc/KgXN68dxoSTBmwhKKXbsOdQa28JvDSqy9nYbdWMSnXcLg7fvTD5/VGsK5NULW
         u40AqFdZSDqj7obnIwgP56JeLKFQ/Fdp6FwqkWmdOQsllXwXVJnKHx4SRTjB3WgzF9Ao
         TIqQ==
X-Gm-Message-State: AO0yUKVGQ6zGSGAfocNIgE2cWDlPD71nwLAJl0LZPhkIqYajTQFtQrjV
        a+H/RwCrnTn2aRiL3bI33IQROZzkazHXMTxsI2bR/g==
X-Google-Smtp-Source: AK7set89uIuHycKuwV9oCG1G6vsIgA+92KlIBOAt5JdpAhjlhJzvtgLGPgckmHFpDdRpXHaiP/qNKEJi5uaurolZYlo=
X-Received: by 2002:a62:154c:0:b0:5a8:925b:f68e with SMTP id
 73-20020a62154c000000b005a8925bf68emr1174634pfv.28.1676295518622; Mon, 13 Feb
 2023 05:38:38 -0800 (PST)
MIME-Version: 1.0
References: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
In-Reply-To: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Feb 2023 14:38:02 +0100
Message-ID: <CAPDyKFoUUoHVjCzhDeeSiQFa2s1ewYN20QcbhpQfL50jOSdxwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: workaround long ioctl busy timeout
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Jan 2023 at 15:38, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> The ioctl interface allowed to set cmd_timeout_ms when polling for
> busy on R1B commands. This was often limited by the max hw timeout
> so work around it like for the sanitize command.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 20da7ed43e6d..ba3bc9014179 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -472,6 +472,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,=
 struct mmc_blk_data *md,
>         struct scatterlist sg;
>         int err;
>         unsigned int target_part;
> +       unsigned int busy_timeout =3D MMC_BLK_TIMEOUT_MS;
> +       int poll_prog =3D false;
>
>         if (!card || !md || !idata)
>                 return -EINVAL;
> @@ -493,6 +495,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card=
, struct mmc_blk_data *md,
>         cmd.opcode =3D idata->ic.opcode;
>         cmd.arg =3D idata->ic.arg;
>         cmd.flags =3D idata->ic.flags;
> +       /* R1B flag might be removed here to work around hw, so save it *=
/
> +       poll_prog =3D (idata->rpmb || (cmd.flags & MMC_RSP_R1B) =3D=3D MM=
C_RSP_R1B);
> +       busy_timeout =3D idata->ic.cmd_timeout_ms ? :
> +               MMC_BLK_TIMEOUT_MS;
> +       if (poll_prog)
> +               mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);

This may end up using R1B for rpmb commands, we don't want that.

>
>         if (idata->buf_bytes) {
>                 data.sg =3D &sg;
> @@ -596,7 +604,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,=
 struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsl=
eep_max_us);
>
> -       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) =
{
> +       if (poll_prog) {

If we end up using R1B and the host supports HW busy detection, we
should skip polling.

>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13=
 "Send Status". Here we
>                  * allow to override the default timeout value if a custo=
m timeout is specified.

I believe I understand the problem you are trying to address in the
$subject patch. Let me try to help out, by sending a re-worked patch
to try to cover the things I pointed out above in a more consistent
way.

Kind regards
Uffe
