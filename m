Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE888C4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiK2M4T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiK2Mz5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:55:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A721C61762
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:55:34 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so13599133pfx.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy83467U3H+rFGcrG1yDL7ih1Oqj7wh1LLSNdYTMBcU=;
        b=EiKvu64eC4DHQOcOHzxwMOqMowCIQqVSJAltDSBm2vZfQiVxgtIAjita4f/4fc9nBj
         hyg143hB0ZilxYPFKHSjI2VChiX9FrtSbL09/bkjBExq/gK8CvOGsdF36t1AyjpaxZGq
         WzbdEHzjL17HmI3w3nGbUCUe2XKcZifAm7fF5tTaA+kQDbBxrumEAzHUKhjx5fA8mgf+
         /4hijeV/euU8jDyrolSFU9Q3XbCpAyx7Rk3FrpYQGMz97jzgwYroJv7YqF8w8TJjXjgr
         70Pt+SWy6EHEAo97X1Ax3PN5V6tnHinYO8wOpAq3mQfzX9E51Xyvs8h6Ki/uLuv1qmwD
         eRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy83467U3H+rFGcrG1yDL7ih1Oqj7wh1LLSNdYTMBcU=;
        b=feIFCC0dBu230TOTIOz+JCXkR8h4KKTDpbnxcfVJ8rf3+Av7KTT4lhfYr6HdfBUQVt
         ylN+LuhR38dQyUVD/0jlB/du/Ug+fXvq3JCNnPgQMhPptq7n27U2SEcBsj1oxJK1uvQi
         f7+D4//17MIQRmZg6WEkpH053V8ir5OCqU/fk8Zmnw35xAaynPsIXk3SJDsbTY6mmOjJ
         dgc247NU9+d5s2fVl4eZTd8LKingzBhIw6YDIukumsbxWYI21isC8/OxFOWM145HLb4m
         pyv2XuRiQFopvUI02pMCiwVDuNYoRHkm+JbzxO2ur/MpjpSSPgkyHFbdgwt31pVqdnVj
         QQWw==
X-Gm-Message-State: ANoB5pmXxkzRiJQGyACLKlh0FNosdh5mleKBUPPz81CQBR5nrSFI7GjQ
        pWtAhrgoGHdmAIvLF6c+0AZwAVurzfYXj68F564HwwUoSF8=
X-Google-Smtp-Source: AA0mqf5sdoqiDXcTRSYvQNo3bLhe4FZXxHWETUy05AGd2lsnn1ZSSsG4KgM2ksUgpvXlj2KB91hAxORiqb0e+pNIj00=
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id
 s20-20020a632154000000b00477b650494bmr28701267pgm.434.1669726534164; Tue, 29
 Nov 2022 04:55:34 -0800 (PST)
MIME-Version: 1.0
References: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
In-Reply-To: <57d4aceb25254e448bd3e575bd99b0c2@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:58 +0100
Message-ID: <CAPDyKFpxUwX=79L1yZ=A7EOSM7WpKwQNPicYTUr+nZrBri7JUg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: block: remove non-data R1B ioctl workaround
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 27 Nov 2022 at 18:46, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> The workaround of pretending R1B non-data transfers are
> data transfers in order for the busy timeout to be respected
> by the host controller driver is removed. It wasn't useful
> in a long time.
>
> Initially the workaround ensured that R1B commands did not
> time out by setting the data timeout to be the command timeout
> in commit cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl").
> This was moved inside of an if clause with idata->buf_bytes being set
> in commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
> Since the workaround is now inside of the idata->buf_bytes clause
> and intended to fix R1B non-data transfers that do not have buf_bytes
> set we can also remove the workaround altogether.
> Since there are no data transfer invoking R1B commands this was dead
> code.
>
> Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Since the code that we now remove doesn't really break anything, I
don't think we need to use a fixes tag.

So, applied for next by removing the fixes tag, thanks!

Kind regards
Uffe



> ---
> -v2: clarified commit message, no code change
>  drivers/mmc/core/block.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index db6d8a099910..20da7ed43e6d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -514,19 +514,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card=
, struct mmc_blk_data *md,
>                 if (idata->ic.data_timeout_ns)
>                         data.timeout_ns =3D idata->ic.data_timeout_ns;
>
> -               if ((cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) {
> -                       /*
> -                        * Pretend this is a data transfer and rely on th=
e
> -                        * host driver to compute timeout.  When all host
> -                        * drivers support cmd.cmd_timeout for R1B, this
> -                        * can be changed to:
> -                        *
> -                        *     mrq.data =3D NULL;
> -                        *     cmd.cmd_timeout =3D idata->ic.cmd_timeout_=
ms;
> -                        */
> -                       data.timeout_ns =3D idata->ic.cmd_timeout_ms * 10=
00000;
> -               }
> -
>                 mrq.data =3D &data;
>         }
>
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
