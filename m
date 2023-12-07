Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmxbajQB"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46310C2
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 05:38:34 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso1066847276.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Dec 2023 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701956314; x=1702561114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAVV2qiEK5RCktShx/Q1QMv0e5n63Am5gtpRCSYF1Yc=;
        b=xmxbajQBGxbyTM3tMWXpxibo5+FikWAk/fYAheLrvMrR15nZJNIrT5h7n2qqHGtRHb
         cGosfGpm8r8rkttxq3Wa0ZnyXsIJHCHoGtIWz/x278e3XIkOQyRyHPrSw91lAGolZnyF
         BLOO/EZjHYjq32wQda1WzaJwYhcd8HVCkoRh6z/TVJAzo34XGI8sA6c+VN0DaSvRwAmJ
         d9kmF1sVMQKpNTe3CsSMUZj9HBChqvacPHA/OH2XqcWdOPN7gXkA8jdvckymKiOSPqgg
         xYZ057XBzgrGPvuSBMaWhsnJBB1PTCNJEaTbtF9UJo0Ojz6vFQfasLOSn9hGb/kuoYXw
         2qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956314; x=1702561114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAVV2qiEK5RCktShx/Q1QMv0e5n63Am5gtpRCSYF1Yc=;
        b=GA5ML/2pzvPcnOQBpGIc1pl/CdXQFtlXngTKuqPnMoVVvj6F17CP1yg77wTfqUoIBt
         CAJpkecao+eCC75yy09FVHqP2YhKvKl3InElXBSV+0KyOZaIpeDDcIA97GQMs/+2CWgn
         OWlR0islk9lX24OA7WADouuM7pxxy/uP/UE/sxTDTRM51q3LNLzYn+RoalxaaNtkydcA
         98lIC/3yAJLClCmt/a+AXHmxtQZUzq6FgNejwFeC3rexipsN50cogCXySdR7zP89SwbD
         ztMJXA3hFxVVmnsRKOpLyDfdtwsox5nTcM9cGj29EB70RsXOYiOIvMrCkg04D3k3Yr0c
         119w==
X-Gm-Message-State: AOJu0YwWbDyAeBBqBEfBzfxbYA7vJh2NPpMXstMe7yVO2azOfTpEqNxz
	ZRNfk9CjL2n5sYLaRzibGD9xRWOTHoVBKzhQtF0gQw==
X-Google-Smtp-Source: AGHT+IEJUzzF+mqKM2cMqlMkgSJjy8gNx2I3xz0+xRFeMN9n4FIMMoQJYpoutX6EOtTJPaW4EAm6phj5PJecY/TvrDE=
X-Received: by 2002:a25:bc84:0:b0:db5:43e7:47b7 with SMTP id
 e4-20020a25bc84000000b00db543e747b7mr2249653ybk.48.1701956314164; Thu, 07 Dec
 2023 05:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201030547.11553-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20231201030547.11553-1-mengqi.zhang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 14:37:57 +0100
Message-ID: <CAPDyKFqhGULWp3P2EpxUMLvdiijqu7qxPrY40GU2m3FM7XVCVQ@mail.gmail.com>
Subject: Re: [v1,1/1] mmc: core: Add HS400es support in retune and
 initialization flow
To: Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, yangyingliang@huawei.com, adrian.hunter@intel.com, 
	avri.altman@wdc.com, vincent.whitchurch@axis.com, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 04:06, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> In HS400es mode, when we enter mmc_retune(), we will be forced to
> the HS400 mode instead of HS400es mode. So we decided to add support
> for HS400es in the mmc_retune() process.

Hmm, I was under the impression that we really don't need to do
re-tuning at all, when using HS400es mode.

Are we calling mmc_retune_enable() from a place that we shouldn't?

>
> Additionally, during the initialization to the HS400es stage, add
> hs400 tuning as an optional process.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 11 ++++++++++-
>  drivers/mmc/core/mmc.c  | 10 +++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..4bddbbb3d539 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -179,7 +179,7 @@ EXPORT_SYMBOL(mmc_retune_release);
>  int mmc_retune(struct mmc_host *host)
>  {
>         bool return_to_hs400 = false;
> -       int err;
> +       int err = 0;
>
>         if (host->retune_now)
>                 host->retune_now = 0;
> @@ -194,6 +194,15 @@ int mmc_retune(struct mmc_host *host)
>         host->doing_retune = 1;
>
>         if (host->ios.timing == MMC_TIMING_MMC_HS400) {
> +               if (host->ios.enhanced_strobe) {
> +                       if (host->ops->execute_hs400_tuning) {
> +                               mmc_retune_disable(host);
> +                               err = host->ops->execute_hs400_tuning(host, host->card);
> +                               mmc_retune_enable(host);
> +                       }
> +                       goto out;
> +               }
> +
>                 err = mmc_hs400_to_hs200(host->card);
>                 if (err)
>                         goto out;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 705942edacc6..9760eea2c104 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1823,7 +1823,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 if (err)
>                         goto free_card;
>
> -       } else if (!mmc_card_hs400es(card)) {
> +       } else if (mmc_card_hs400es(card)) {
> +               if (host->ops->execute_hs400_tuning) {
> +                       mmc_retune_disable(host);
> +                       err = host->ops->execute_hs400_tuning(host, card);
> +                       mmc_retune_enable(host);
> +                       if (err)
> +                               goto free_card;
> +               }
> +       } else {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
>                 if (err > 0 && mmc_card_hs(card)) {
> --
> 2.25.1
>
