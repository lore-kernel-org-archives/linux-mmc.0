Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6FDC61DA4
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Feb 2023 14:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBIOUL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjBIOUK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2023 09:20:10 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11B75ACDC
        for <linux-mmc@vger.kernel.org>; Thu,  9 Feb 2023 06:20:09 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n2so1664770pgb.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2023 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5Cg/lmjMoR1Bh05RNj1sjn9gKQ3dTkNDGznwp8dtsQ=;
        b=IR4OWa+ohCdJhw1G/eNBcq8HzcWl9NQRxQ7w+H5MUp8IUDMfxFm1xZFgR03O1gJtYl
         6+N+Ar7XMhUM/LMTs89/4psaa2NquTWHs178hzlKE584R/ohzJ1wTc6iItitNsg1ycc7
         khTqwl6I3Lk9G27twJG4NvgZIkL7SoZXYNbiJUvActaVNm9PVYfFVTjl3d2+89Px3lwk
         HRoUg3ejCFZVSvO1gh7CgUSi+Wb4r2JpTVzIGPySBKmAgFXdT7XrkKa/ZQ87umJif9JN
         cv+fchXenAD0b7B1U387eLx2mlHdcDye2v0Ir6jbhPWeFEP6IUYQ1e3FDXY1iSmuVPaP
         /T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5Cg/lmjMoR1Bh05RNj1sjn9gKQ3dTkNDGznwp8dtsQ=;
        b=pkxZmIjvAF9NB8PUY0MOclqmQlWed1ZoNjCSWAB+ORkhwqX6eKOk7HDr4V8VaTJyku
         /g0ZVEYeXRcKZ0We75zMvDM19b4K7dqL3dpfSK09xoVERUR3o3pjDbKoEZ/EKVviFtSc
         QmsSLIkB6drWXPQNPPJWM03GR1adY9RITYHrsKKS60NjZnFSJrC4JYdfUHJ2/+zI43Dw
         CzKjy4JQKN4MOMOR8lcHhlfpu3PrayH7s2Ch1LeGOVLLhRlmgamVMXCp732w8qdf1eRI
         ukEyruQSs1Y//kLM48F+q1Izj1PkHOMsolg81tdCakEV54qAH9Yx0i7SHJXhfjNI+LjS
         NPnA==
X-Gm-Message-State: AO0yUKUBg6LWH1EemELNyLgudzmqBt9XpoO8dKHux3HeDHtz2aDfq/HA
        dEM6oktux/R8flXKmRVET5QNdv9b2QgnIEAByTLf45vm0Ep/+g==
X-Google-Smtp-Source: AK7set8ZScQvFdvlHd4mustUI571YHGnSz/EArT+H/zHz2bn1eWmIG1QsSnx8t8GGWHZ7u2YEDLBYJ4ODDEXJ9nFQeI=
X-Received: by 2002:a62:1901:0:b0:5a8:51bd:e0f0 with SMTP id
 1-20020a621901000000b005a851bde0f0mr620477pfz.52.1675952409164; Thu, 09 Feb
 2023 06:20:09 -0800 (PST)
MIME-Version: 1.0
References: <c91cdde6288d4db6aad45f5d50d129c8@hyperstone.com>
In-Reply-To: <c91cdde6288d4db6aad45f5d50d129c8@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Feb 2023 15:19:33 +0100
Message-ID: <CAPDyKFohmDM07zqda7y5nAZBq5FqdydYSTCfYn27cdOEYA6U+w@mail.gmail.com>
Subject: Re: [PATCHv3] mmc-utils: Add basic erase error check
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Jan 2023 at 12:19, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Check for erase specific R1 errors so e.g. an OOR erase is not
> reported as successful when it never executed.
>
> There could be checks for more error bits but R1_ERASE_SEQ_ERROR
> on CMD38 should catch all that are reported by hardware anyway.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> -v3: Check for ERASE_PARAM on CMD36
> -v2: Remove unneeded error bit checking
>  mmc_cmds.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index e6d3273..6c50bbe 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -54,7 +54,6 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>
> -
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret =3D 0;
> @@ -2668,6 +2667,18 @@ static int erase(int dev_fd, __u32 argin, __u32 st=
art, __u32 end)
>         if (ret)
>                 perror("Erase multi-cmd ioctl");
>
> +       /* Does not work for SPI cards */
> +       if (multi_cmd->cmds[1].response[0] & R1_ERASE_PARAM) {
> +               fprintf(stderr, "Erase start response: 0x%08x\n",
> +                               multi_cmd->cmds[0].response[0]);
> +               ret =3D -EIO;
> +       }
> +       if (multi_cmd->cmds[2].response[0] & R1_ERASE_SEQ_ERROR) {
> +               fprintf(stderr, "Erase response: 0x%08x\n",
> +                               multi_cmd->cmds[2].response[0]);
> +               ret =3D -EIO;
> +       }
> +
>         free(multi_cmd);
>         return ret;
>  }
> --
> 2.37.3
>
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
