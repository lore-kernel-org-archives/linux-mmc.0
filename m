Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294D3DB653
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604218; cv=pass; b=gzper8Gkoqbdeyl6PRiDbx4UTM/yzaG1m4aCfZRJYZT9575slcZ9N21roOf+TycOxFN4dwf2HVv7nAP6f2plHmMF5YhFEQ5HMU1ynspenqwX0+n2Qs2QyrN6jiuk1lIGB6jv1SXXjfpHgH4+YUmXkM+K51L8RNR0N7/LfbvW/8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604218; c=relaxed/simple;
	bh=9TTMzvKcrrjW61v7QMCwY6boY1CKTSHRC+i5h1knyrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5EfUjLj3Sa3uhY40PkPV09sNtTG9v9u6xIlmRYmq2xXXkfm/g2GTuRV27oUENls0nDFtL13tHMhGImxLFmb5bGxWhFoOkfChR49ityoJ7CBgk6Hdm1WE2Co5HoTC7gqv04US6TotkBNr4TAL43y+YIq4hbtKzcfzqxFbWz4KiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XkxdWF3H; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkxdWF3H"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so2228105e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 02:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774604216; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGTA08yRo4w2QuEzoGXgmV5XIKBdknVZrKFcDIuFTJPeop9JsRWaEfAS1y3iEq4UYj
         +CpN7Lwlgg81LV3wnrsQOALt0AL9eAr8rwj/acFKdoXWQSrtpy+OpRNePoMirWtP06UU
         yGOrMpOMizUN7M5+ILKKbrGu1OupAZtrCX/viH+G/M+ZvJwSt5RmFGaF/cau4DiUtyum
         u4umnKhK2JwZdnvnuA1eGO2NMdwLcukUJsbJN9uNYlLzo6JWJ9UTrDrDjkfYdB5bGjYG
         g/MVxbFY547Aw5mghtNV0vn7FQMkE1eCx2P3TQ70ScWkqjdf8e4f4Nbkng8qwkfkluml
         FYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5/986sRX2B7KJxEKpznXsnGQ2aht2oHm927HycZOL+c=;
        fh=F09gXjuBfAinjRGqtSdI7PBlpEv7aCugp05ZKB1d0tc=;
        b=gg4pZmdCVZSV6yKUJYIr5dIp2ii13npZFNtW6qCAUSVsZSSw3GzRMtZkCDfD7AjrNf
         gwGIYsTy4LSBdNA496PrVhgWzlsNZYuCEOd1Sui2GFXDwf9Xq5OJ6gzcYO9UnIz1emZs
         wRih7fS5GjWQSb48YYIavOHiZfiaPu/6ehI1qnXXjC5KLwTPUb7jz3ZQ2aCG4VXvkPDR
         f3uIFR4HARcTEIF8tQzZm/Hg+/i3us68t4F9QnDfMaRvdFL6unI4FMMhpokDCwU2vc2i
         NawSmfQNcuXczw0vJgtWwAK8D5K2rvx3Hz/WwYwQR8mnbf8k+uFN7F1jxXK6LdzRAp9c
         eFoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774604216; x=1775209016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/986sRX2B7KJxEKpznXsnGQ2aht2oHm927HycZOL+c=;
        b=XkxdWF3HQHk0Eu1S+wWZS8ZJih9Mlv8UGpdq/nuDiHmCTcf/eYI/+Q+zdQEB+BfoCh
         AduuPMdTSyJn1X4F4peT2FpoUNe4FB2/K+OL9V4mQ816lSimHKwXOryUsLtOQDssrkpA
         xxKQRtWpZcvCoB09kel8aseP1MCEvYclEEJkUHJQ8VDq4NE8P391Je/QNg/81FJfm8do
         EdMQV7Nh7LKRu+2LV6tdlQRGhCz4c+cIp33TU21JVYbyiTChxRclSTy8Ki3dzdzoKjD+
         13qqct6A3nP3VVGGpW0WYd6pjdmE19loSXMdTkwHuC9tfXq9SU6+y0p/zduKnSvtRv63
         96OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604216; x=1775209016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/986sRX2B7KJxEKpznXsnGQ2aht2oHm927HycZOL+c=;
        b=QPEEe8ET/C3PWB2/LVcsjjzUmzDVsb75bJcbI4+2gGTmy1HsyCIyPJStspMCIP0ju5
         kCCalfDuO8I8VUqhiggLqsNOiE1GB6TVeC8uCjzm4vNEe30URCxLGbIsNFxB7sriUfsA
         StrOgF5J5VkJzDm3ak+cm0pUvyFnpENV9T2GqBAs7Gm77gAIboT9ZSZjFHNlVAJxaCLf
         Iki4ZSpNX6eIS+/SCXYjptXvwu8y7KO4Z2O0ObXHHOIeIyk4ghSnVBlCCkItEZ+7jFy+
         bJyqfQiNuvbOoJO2Zgm/Hm5D+cSKM4752e2MD24Euak9OzepVvuoOEbzM59DVctVZpbk
         zXNA==
X-Gm-Message-State: AOJu0YwTkAW75my+W/bxjZX9ziw2bEIHee5lNoEU6YjWIRQ73koX2ezT
	MDLR5suy3Azy+jE2RmOfu8GVfgUJOjyxB3X+EFrKNQ9oLBc4/72eWLduHhHD1A4tP1pekB1UEOU
	ntwVDPTGlue1GgRdPv3tnpZhTeRIKRnxxURy099Iz7aibfPal9TmF
X-Gm-Gg: ATEYQzz7JSMtNpJ7DZSA0EOfHOKSQHRDRYIxJdy87HIGrUaoTs4FHHGobAc9J8i0u68
	kvv0xVWGmYM/PNqzzh9oG6CJpsJpC/k3rakvI+t7jLPtkDhdS9DPxoUfLYylJtpCBsfNPtnvn/D
	b9J3Q7pf9CrZcClxQn0lK2voDPcErjUGoJVbcgb/YLbWZfqjlYL/ay2YDnfsp1XA1huSEvQ0Qcy
	jHcImNHQy6rI8yLMAsBMLeKRfb1fv6lfovwTLvURJoGWYMR6yhv1b4FHnyACk0mU2V5D/8zwjzn
	VoepgoPy
X-Received: by 2002:a05:6512:12d4:b0:5a1:7524:7cbb with SMTP id
 2adb3069b0e04-5a2ab920fedmr705857e87.28.1774604215578; Fri, 27 Mar 2026
 02:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774584683-131402-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774584683-131402-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Mar 2026 10:36:19 +0100
X-Gm-Features: AQROBzClfE-JJDyfZeUW2CGXnD1_x-jUwjewTotBT1s8MO3HEKc3saadiBcpEjI
Message-ID: <CAPDyKFoKxrHzANm+TDvy4N31_UhUxSrU_SGAeDNCbEQPRseTvA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Switch to use pm_ptr() for mmc_host_class_dev_pm_ops
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 05:11, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Currently, the mmc_host_class_dev_pm_ops and its callback
> functions are wrapped in #ifdef CONFIG_PM_SLEEP to handle the
> conditional compilation when PM support is disabled.
>
> Replace this #ifdef usage with the standard pm_ptr() helpers. This
> allows the compiler to automatically optimize away the unused code
> paths when CONFIG_PM_SLEEP is not selected, resulting in cleaner and
> more maintainable code.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/host.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 4e1514b..b7ce313 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -33,7 +33,6 @@
>
>  static DEFINE_IDA(mmc_host_ida);
>
> -#ifdef CONFIG_PM_SLEEP
>  static int mmc_host_class_prepare(struct device *dev)
>  {
>         struct mmc_host *host = cls_dev_to_mmc_host(dev);
> @@ -60,15 +59,10 @@ static void mmc_host_class_complete(struct device *dev)
>  }
>
>  static const struct dev_pm_ops mmc_host_class_dev_pm_ops = {
> -       .prepare = mmc_host_class_prepare,
> -       .complete = mmc_host_class_complete,
> +       .prepare = pm_sleep_ptr(mmc_host_class_prepare),
> +       .complete = pm_sleep_ptr(mmc_host_class_complete),
>  };
>
> -#define MMC_HOST_CLASS_DEV_PM_OPS (&mmc_host_class_dev_pm_ops)
> -#else
> -#define MMC_HOST_CLASS_DEV_PM_OPS NULL
> -#endif
> -
>  static void mmc_host_classdev_release(struct device *dev)
>  {
>         struct mmc_host *host = cls_dev_to_mmc_host(dev);
> @@ -90,7 +84,7 @@ static const struct class mmc_host_class = {
>         .name           = "mmc_host",
>         .dev_release    = mmc_host_classdev_release,
>         .shutdown_pre   = mmc_host_classdev_shutdown,
> -       .pm             = MMC_HOST_CLASS_DEV_PM_OPS,
> +       .pm             = pm_ptr(&mmc_host_class_dev_pm_ops),
>  };
>
>  int mmc_register_host_class(void)
> --
> 2.7.4
>
