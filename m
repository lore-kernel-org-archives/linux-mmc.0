Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F743C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Jan 2022 14:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiAXOli (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiAXOli (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2022 09:41:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B3C06173B
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u14so18942897lfo.11
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wg0ttvOmNzUCKMJpAQZugVwCO5/3smshq/aGj4egwOg=;
        b=Wp0LxdiOrl+wg2qT9oFIKDtA5gMtHLDTOJMOVUgX1bEunFSnzbRKoI9qmqvt67Mkwb
         yHd14RiKMyRMmXdY4y38nneFkTwe+F1vn6yEtHyB0Qq5884EoCob1pNanPPKQMQGoMNu
         ZyReVOXyitgoHzwd1bQUHyj7ijc6EYcOgyIC9aq2gFDXoEDSQ4abHkqMlXlV+RtzCt+F
         qg9PViWziHY6wpkZ6jsm12kmHtYyYXeUFxwExVuLfmS4ZtyQYS6h0COdeXgooSVPWuqc
         JH1PsfudN+sBpJJnXDEXj8+PMTNoq7jIduoeMAcB3dEoW6IGj7ZIEN70taKzBRCR8tOg
         OMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wg0ttvOmNzUCKMJpAQZugVwCO5/3smshq/aGj4egwOg=;
        b=U2mOJuxqcuATnL+Ky53h4kzHDOeVWtWoqmQXkkO3YFohIPsIqDFKgI0eNcaTA3vqjB
         Tw1zN7YI/kWOzyZreHM3ufmDTeBitQwTGEpqjr7fKQQh+czTuxovPYALMJhXmNFM4Zap
         5gaLqAKlM5JADgazEKI9qylJY62yQ/dR+/94anf4HR3SNnQYVaFF4wwIUSwKyRx4ul2i
         lDTEV4s0hqiJGlROWISZXe3CiHyceQwebUDQ4Gf4iSaP4b8jBGU9BXreQnE0ULumfXZr
         aWFjAI+Suiw34P0Pi7YqDsgwiYIOqe3VLv5BBTtafrMrA5yw194liEKFv0GROwMG+O3h
         zHpw==
X-Gm-Message-State: AOAM530NAlMqwdSYokCv09ZiVFpIR7ppQyieMt/wK7VLtgdGOgMTFKHb
        vZ0R6pSJ/QX3BXLIMiooAwpwxl5XGxmDcKPYKV92TA==
X-Google-Smtp-Source: ABdhPJxE76Lsos/B2pPpQIXHVEITCQqEVHfC7Zn5R2ND1w7O2NoHm/yF0L3WSyKH+SsdxpOTiczmbhM5lvQeiJztFIU=
X-Received: by 2002:a05:6512:1293:: with SMTP id u19mr13141789lfs.373.1643035296045;
 Mon, 24 Jan 2022 06:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20211229023814.53372-1-wenzhiwei@kylinos.cn>
In-Reply-To: <20211229023814.53372-1-wenzhiwei@kylinos.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:40:59 +0100
Message-ID: <CAPDyKFo_c2vNf+p4pYubeu0OLCUbAQD=5aAHeVMq5eXEqr20Nw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
To:     Wen Zhiwei <wenzhiwei@kylinos.cn>
Cc:     jh80.chung@samsung.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Dec 2021 at 03:38, Wen Zhiwei <wenzhiwei@kylinos.cn> wrote:
>
> we previously assumed 'host->slot' could be null,
> null pointer judgment should be added
>
> Signed-off-by: Wen Zhiwei <wenzhiwei@kylinos.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d977f34f6b55..c9dc8c168efb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3518,7 +3518,7 @@ int dw_mci_runtime_resume(struct device *dev)
>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>
>
> -       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> +       if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>                 dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
>
>         /* Force setup bus to guarantee available clock output */
> --
> 2.30.0
>
