Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38FBC43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31952176D
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+j2Q3gM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLROBr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:01:47 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38695 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfLROBr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:01:47 -0500
Received: by mail-ua1-f67.google.com with SMTP id z17so659977uac.5
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0JG9FsmPpOoD5GBiRIPhJrj1c4tEf6Dk1qUflCL1l8=;
        b=d+j2Q3gMVEtDTZjx1PNLgfsbE6Px+yOzGhY1xmsvXfcSM6QKcgkr2gXBoMNBcDMz7w
         OzsoFt6Gp647NxbZU7y0+wMgrGuU5fLA08daq08/VS5L/KwKS6a32BFmscI3WhomjQ4A
         RzUZJwp0kUOAMobVS6mQZNG/dAk1Z9UOVOGlXul7tP2u9saMls+iXSfeIM251sRQUffl
         EgN0ErbWqJ4YFlfl/2Sub+Bmtcs/U0DbGMV030EHMNqetRXno8uTGZpxRvSMb3voA10m
         3Mnn8YvCisimpKMIaZe9I57gTUQ2ZKwomfL2oSKfVTi2r3G9oa5KAsIzYdM1JA5uR9rT
         +MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0JG9FsmPpOoD5GBiRIPhJrj1c4tEf6Dk1qUflCL1l8=;
        b=qCbMld6OJUh+f6pbzJ0KJ0Pb9RtjZk1jFxjsxwNjRMjTbHaZFQm8MC4UsBAYhesB7D
         n4AtF4e+9dMH4TlVaJIWhk7P+RERuCc1+bJuL3evNjETOqSIMhF0T7DxhtIZjIhm0ZdX
         f/uRcbI9RJHyH0lidmebMdleXFyQf6p6zH3LwSHIOBaN7CpQUkeq5oFappHFAIIu3bTs
         R6rzdvg70lGrgT6IbxQZRDnNf2LCw/ynaoi2FSHQNpuMhvAFZMshKtaEwQom/nhBJTKk
         XV1yZzWHNm/iXA/ztv/+8SPtbuwz84/7GBgYSzlF90yd4EI4Pr4XLrhj7TFnxYHMuE7p
         30KA==
X-Gm-Message-State: APjAAAVFTaMzsOXpHD/rcCN6vKijzrzteFRi9OWL4PyQHf+miEWNJUmJ
        W5hon6tpdzbYJcxteY4dyEZQethh3AgwbqYPcnNWXA==
X-Google-Smtp-Source: APXvYqz9r2dN0C3+Bqwu22rtfMOoZJ3AuiEMR41kI//837m0N3aIJdrC3qBt5RrNMLJKSN7EjFvCzPXStXBx/AV2eUQ=
X-Received: by 2002:ab0:2759:: with SMTP id c25mr1395424uap.104.1576677705884;
 Wed, 18 Dec 2019 06:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20191206075408.18355-1-hslester96@gmail.com>
In-Reply-To: <20191206075408.18355-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:09 +0100
Message-ID: <CAPDyKFqsNpgGiDEH42Mo_fJ3jGjSO+y3tP45DpJA7vH-696yYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Add missed pci_release_regions
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Dec 2019 at 08:54, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> The driver forgets to call pci_release_regions() in probe failure
> and remove.
> Add the missed calls to fix it.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index eee08d81b242..76013bbbcff3 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -76,8 +76,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                 return ret;
>
>         host->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
> -       if (!host->base)
> -               return -EINVAL;
> +       if (!host->base) {
> +               ret = -EINVAL;
> +               goto error;
> +       }
>
>         /* On ThunderX these are identical */
>         host->dma_base = host->base;
> @@ -86,12 +88,14 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>         host->reg_off_dma = 0x160;
>
>         host->clk = devm_clk_get(dev, NULL);
> -       if (IS_ERR(host->clk))
> -               return PTR_ERR(host->clk);
> +       if (IS_ERR(host->clk)) {
> +               ret = PTR_ERR(host->clk);
> +               goto error;
> +       }
>
>         ret = clk_prepare_enable(host->clk);
>         if (ret)
> -               return ret;
> +               goto error;
>         host->sys_freq = clk_get_rate(host->clk);
>
>         spin_lock_init(&host->irq_handler_lock);
> @@ -157,6 +161,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                 }
>         }
>         clk_disable_unprepare(host->clk);
> +       pci_release_regions(pdev);
>         return ret;
>  }
>
> @@ -175,6 +180,7 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
>         writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
>
>         clk_disable_unprepare(host->clk);
> +       pci_release_regions(pdev);
>  }
>
>  static const struct pci_device_id thunder_mmc_id_table[] = {
> --
> 2.24.0
>
