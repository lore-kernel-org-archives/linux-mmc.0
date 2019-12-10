Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811AC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484262077B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p84JhS3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfLJJwe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:52:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37937 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLJJwe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:52:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id z17so6944632uac.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 01:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXQm4XaShH7vDVUTEGAeMZToqWYQUJWAg/HCHyGvLf4=;
        b=p84JhS3g5a0JzgG2JpcG7Mi9FmZPk7bAxfwC/oyBWsMyvc/NjEA9A1otgiLYHelPEo
         54zDi70S8/58AFmo/e77Hji63uc8DeTyyCTff/2FesPTo15UUvrBubCuqLIxAHcu4yjS
         ZcSxvo8jyhhqFHyTTkdpuSasA6tjBRBzhcyocJrcdGgMwehSldXT8kPWECdJ4Zwcn045
         hJUKkkhTc8kiEMCflNvCBRm54pRnaIDri7AhAUHcpeiYh21PC7MnF8vj5bK+Rs2iP9fq
         mal1Rmi8tcbo9Zm92KrUFP39TBkep5BSnDQkhwoZvSasrnnJctVJhAviREFGe2PT6veu
         nKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXQm4XaShH7vDVUTEGAeMZToqWYQUJWAg/HCHyGvLf4=;
        b=iJfVSbGgwdEBJAIC4lFamPGuxZvg57yf87zMrqZR5bInaZ9l5O9g0B9pAc/oU8O5bX
         k8WpjynwzCjrqjQ0m0JBtw19QuWPjZTyORGtqPUNdhiQn3b8EQbXa/l9zu94F64VmiDL
         A1wB4ZuvcuHgF86OFtM5FZBKIfSF5vOex0tqruFwl56eze9oQ9REx9cRVkaWo9uHN91+
         WTOQewuDqducuLv4WHFDjDldLuFYbRvOE9zNoHtaoexmjIDzzQF2xa98jTvh9CePEf1g
         k7pelkjAjrnNv0Wq6FmYrrfYS6vi9ZtFLdcuxly9TbqS49bteIZpO9H0t3Ey2kDwTerZ
         sXCg==
X-Gm-Message-State: APjAAAXZZ3y1Tr+2hABUx5tbGJbHm9N++rVCqBiuahmqT4YrOOBfMmbJ
        X+GcSVH3+ycLz76k/CB02rbncO/FqfgKIcEJ39SN9s+5
X-Google-Smtp-Source: APXvYqza+Ix1SZeRmRyoVXMKSHvtZJGN0yTOCfS2WK4cCQlWwIzxi0J8vTLQd5ywpsBH0ewa5qs0zc1cPU73yJC2E0c=
X-Received: by 2002:ab0:6894:: with SMTP id t20mr29138175uar.100.1575971553656;
 Tue, 10 Dec 2019 01:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
In-Reply-To: <20191114111814.35199-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:51:57 +0100
Message-ID: <CAPDyKFqfMzv1hFzPzS7w5BVHyXybu--7p11wHYa8WTQAVB7r4g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 12:18, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The STOP command is disabled for multiple blocks r/w commands
> with auto CMD12, when start to send. However, if there is data
> error, software still needs to send CMD12 according to SD spec.
> This patch is to allow software CMD12 sending for this case.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Let's see how things go, then we can decide whether to add stable tag as well.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 09cdbe8..3041c39 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1326,12 +1326,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
>
>         /*
>          * Need to send CMD12 if -
> -        * a) open-ended multiblock transfer (no CMD23)
> +        * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
>          * b) error in multiblock transfer
>          */
>         if (data->stop &&
> -           (data->error ||
> -            !data->mrq->sbc)) {
> +           ((!data->mrq->sbc && !sdhci_auto_cmd12(host, data->mrq)) ||
> +            data->error)) {
>                 /*
>                  * 'cap_cmd_during_tfr' request must not use the command line
>                  * after mmc_command_done() has been called. It is upper layer's
> @@ -1825,17 +1825,6 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         sdhci_led_activate(host);
>
> -       /*
> -        * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
> -        * requests if Auto-CMD12 is enabled.
> -        */
> -       if (sdhci_auto_cmd12(host, mrq)) {
> -               if (mrq->stop) {
> -                       mrq->data->stop = NULL;
> -                       mrq->stop = NULL;
> -               }
> -       }
> -
>         if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>                 mrq->cmd->error = -ENOMEDIUM;
>                 sdhci_finish_mrq(host, mrq);
> --
> 2.7.4
>
