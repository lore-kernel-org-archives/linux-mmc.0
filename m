Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCFC636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 22:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBMWrx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMWrw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 17:47:52 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484A6A46
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 14:47:51 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s8so9088872pgg.11
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 14:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWkc+3ChVmfx7B5d4LvaJlWTur0XgS8iVlkGiqgUCE0=;
        b=td2JRhiFeJoXsjndN/dPafvGVyEL6gBRhWsJNKjtbhwAnmRcoWGG35VRoQV5Nr2sI3
         1+AZNFpYe8Tqv5yIk/fGIppi6imcgHJqj0ZadoncBeWVCnGjFO/EpXt3QdQhts2REFTX
         +IHzs9oiFtNxPK+aHy9M+QDUqgu9KBv6Vc1D9JslZyPf/e2fUJhKrf9aihS+wbIRA4SZ
         04xc4vxnfNRq1ISNO/AXWH6dYwbe9FsdfZFH2i9tEWNBXAqzjTvwrMdEqWAmQDNnda7r
         G6YE6uu5PTLGquHAj8cnsrh0HN/Bqq3io+9aw4w9+rAqwnAm7XTZrrsgZfr38cU4N5rH
         2DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWkc+3ChVmfx7B5d4LvaJlWTur0XgS8iVlkGiqgUCE0=;
        b=JsvCioks8oTPH03SNxkMU4CV9BY16J1uxaS2qHGsArDBDdETOAeqLN2bpAOUmc7zua
         s4QUjOaZvyswE4RmQftS0k+s/RNTTQeHqQ62fb/FcmaMmvtHRWyOD1NhWdIqpSt7BQqZ
         2gcP6dqhHIbg2PibRSbcIzixAGJNadkcEMPLKCbgI0t9709k8WYNvzhyJ9bvORg8dztt
         6ukvGGEbhS7mgrYrsqEKt8w8P7vjibqhVCwgpCZ0i287He+yLDv56JFd8S+sZJoatNI0
         nBsVHaDuCQDRMlT4rZ0tg4VC0QJ9Xpcb9akE4EYzudBaAM2IbHiyUS4v3jWu2DMCF0k0
         kb+g==
X-Gm-Message-State: AO0yUKUCIxrr+1QTXiCZh1OVOHuLdpC9yZo3fGy979u7BRClvJanmhPz
        B4kVDJdKih0XUFnbdDUXVM/KtfBZ0CYoc1yBazd4EQ==
X-Google-Smtp-Source: AK7set9M9DX21oVyPpfP6vYHMjDKdu9V2oSymO6ikBQm02DAiTsAuWK69Nagz9Y6XVTOZBYr5qR4bRIYwJbS+2NEmIE=
X-Received: by 2002:a63:7054:0:b0:4fb:949d:72 with SMTP id a20-20020a637054000000b004fb949d0072mr1279285pgn.8.1676328471372;
 Mon, 13 Feb 2023 14:47:51 -0800 (PST)
MIME-Version: 1.0
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com> <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
In-Reply-To: <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Feb 2023 23:47:14 +0100
Message-ID: <CAPDyKFrsTMpguDp+0ZrKYkH5CYSk_OgKLxuZu4tFoGYaLpbJUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: support platform interrupt as card
 detect interrupt
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 30 Jan 2023 at 00:10, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Use a new mmc core feature and support specifying the card detect
> gpio interrupt in device tree.

Don't we need an update to the DT doc too?

Kind regards
Uffe

>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index be1a972c2..c87bc31d0 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1236,6 +1236,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto free_host;
>         }
>
> +       /* gpio card detect interrupt */
> +       mmc->cd_irq = platform_get_irq_optional(pdev, 1);
> +
>         host->pinctrl = devm_pinctrl_get(&pdev->dev);
>         if (IS_ERR(host->pinctrl)) {
>                 ret = PTR_ERR(host->pinctrl);
> --
> 2.39.1
>
>
