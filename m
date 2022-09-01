Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B596ECAAD3
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Sep 2022 10:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiIAKcj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIAKci (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2022 06:32:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C1122064
        for <linux-mmc@vger.kernel.org>; Thu,  1 Sep 2022 03:32:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z6so23755427lfu.9
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2022 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HXeJHCAXo+Xl23q56BVg26tN6HoFjavkkhsO/UPUSCA=;
        b=eWV9NJYuWmlhBNQjRqqJh21c9CuVTF8puoFd6FhvGU1FcWeHJwWakos45j1Ht7fc/O
         Z13gOUa1yogoHDNl23GvvdjaT02jEi/pzJbE2IbdTWJ601oyMdmuq92FYWXGMP+2Rfem
         1x5ZPTRNxtX52Ff6rNPZi+dnScPcqIEG28qfVSwqIKv5migHKqaepCVcAkYC5iCtzR0y
         /38kX9+s/r50kTv8Bab9SHE+wF0lC9vdchJIDXwjhIqIu13M3gxubRsFwmzrONxRRNsS
         npa4TiMaFzYEj2Qr8w8KEWoyE8VBzzllh1a92e2+GNBcnF3e3Su0t3PbxcVhHfN12InO
         AmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HXeJHCAXo+Xl23q56BVg26tN6HoFjavkkhsO/UPUSCA=;
        b=3Cn1Ot+jnODZzSNbKSiYM21GYa0slzFqYM63DU78Y+wkfoFoS4BZKmE+V1hKRnJqTi
         xNQ6HfoOSqihYSXnkcEeF72OSx3cXbl/fQdQjW3UzEa1+1uTicd8ROto/Jtv9XdLVD7s
         P+zRY4LTPYzytGiUF+EpRPRGMHMEhywWJK5T4AigBWXFNyr4x2c1tRZmguNS3+1zod92
         HgMgmRZld6A+wM4TKuzNkmiFObGRE8dOIL0l2DGL7VhG24DGd86xveWOHBphpvZ9G7/T
         /JN5J3Hr8Sm5uicNnUkbOxw1XDMU2vT/FE7w5O5/hijA+SEjSVioLLppoKnkw2BucPpR
         jieQ==
X-Gm-Message-State: ACgBeo1zi4w72l3sZKiZmQ6JsPXVaKNJ/Iu7R6j7c2rjAi65yK9DhwHN
        Pblg9IYy2T+vGFRZzWRZz+OsO+F3sBMSU7c3rPA7Ew==
X-Google-Smtp-Source: AA6agR6N5ywWgfouWR/JVPBzzKCE4dtOVAqUK96KtyUH5iS36msWajnh943hORgNKjzHwQ7pKxba9YlqO2wq3xL5t28=
X-Received: by 2002:ac2:5d26:0:b0:494:6d31:4c5b with SMTP id
 i6-20020ac25d26000000b004946d314c5bmr5836840lfb.358.1662028356081; Thu, 01
 Sep 2022 03:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Sep 2022 12:31:59 +0200
Message-ID: <CAPDyKFp_r3RNbeYHFC2ncezJHJkmPcNkZ17N-FDQqxpLq0b20w@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: sdhci_am654: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Aug 2022 at 10:33, <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value cqhci_init() directly instead of storing it in another
> redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e7ced1496a07..8f1023480e12 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -554,7 +554,6 @@ static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
>  static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>  {
>         struct cqhci_host *cq_host;
> -       int ret;
>
>         cq_host = devm_kzalloc(mmc_dev(host->mmc), sizeof(struct cqhci_host),
>                                GFP_KERNEL);
> @@ -568,9 +567,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>
>         host->mmc->caps2 |= MMC_CAP2_CQE;
>
> -       ret = cqhci_init(cq_host, host->mmc, 1);
> -
> -       return ret;
> +       return cqhci_init(cq_host, host->mmc, 1);
>  }
>
>  static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
> --
> 2.25.1
