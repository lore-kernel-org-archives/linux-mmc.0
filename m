Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98126C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 14:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A11A2467F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnkBmt7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLSOcw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:32:52 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44755 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLSOcw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 09:32:52 -0500
Received: by mail-vk1-f194.google.com with SMTP id y184so1670519vkc.11
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2019 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPrqmPawyC7QTitP+v5HFjQOiA2/JytHSGJGmUaJYSo=;
        b=HnkBmt7aQRcHDcMGiqeIVNQlFoTrNa80ZEsz/jq67ZFporQI48fPP1pB//sfII7cmp
         NV++BTuBM0fMSP3sCw40kxNz704Xs6z28/t22qeVeYvFWYC+LqiHRgil6I6MFdRSAmBI
         aiKeNDuitN1aHXmZP1AraJ/vV0PUVmt0AB7kOica+Pj4G8AZKnYYiG2UqReg6Y0H1JlL
         S9oofysNrjhnJ6OBygsD7XwR4WlPNbb2uGBSFPh1X5Xi0aueoG4hPNh9WK4gDgpooymS
         Hvl2e+WE78CehJerRxhHjb3qbsP/vtPoIvX0VXkzADx4nosf40jZ0Z5QJc7BRCSVZ5wE
         LOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPrqmPawyC7QTitP+v5HFjQOiA2/JytHSGJGmUaJYSo=;
        b=bdQuLdGdRWCp/IvNVUeP/NJs6JDbXLE1Z7G32Xin8/acQ6gKMnEM0iHGEXjHF1qkGG
         YCFhI7ddsdYHAH2/dBvXxks4gDY+shWL2Q2jqtltVJbHMgNpd+UATrQrGV53te7wXbPj
         G5Eqe6ZPv3L4OxNi+0mPXaDITZsnlt+FjF3ljlNR1RPIQS7kNy1u7ZQ2P2IVpAmhydPb
         /GNgmtgDZaqlGV+lSwo5luTGQ4uRqM3ds/y9prOh+USHL9jizzxB2EDGj/2d+rohYTc/
         wiUFBRnQOfJbsNnTsZ8CauJflHyp1IMOskXVpX44U7C8oYjzBSlMoiUSvZs0WxCJmWDN
         Qc7w==
X-Gm-Message-State: APjAAAX4Pemitsp4zDAK7kHDrtOJX247Lzi8PG9+7FA+pQL+PdtmS0cC
        3+KRMaDJ8n/jnBJKfYEY/Nz+wLkruB2HA0NnxxQXmQ==
X-Google-Smtp-Source: APXvYqyql89PtQng31jiu4OfIUWL4pxdszTl7Rb2Z0v5tsXV+OuRCLt9eYGrN14WQCjnYoJhY9CerE7OOqyoBGkSmMA=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr1596441vkd.101.1576765970818;
 Thu, 19 Dec 2019 06:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20191217122254.7103-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191217122254.7103-1-peter.ujfalusi@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 15:32:13 +0100
Message-ID: <CAPDyKFrsq6Kua8Nr7GCVmvEHgDT9MWV05Lue3Z3Ha-_Aa744Rg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Dec 2019 at 13:22, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
>
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied this one and the other related patches, thanks!

Kind regards
Uffe


> ---
> Hi,
>
> Changes since v1:
> - instead of returning jump to err: to free up resources
>
> Regards,
> Peter
>
>  drivers/mmc/host/bcm2835.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 99f61fd2a658..c3d949847cbd 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1393,7 +1393,17 @@ static int bcm2835_probe(struct platform_device *pdev)
>         host->dma_chan = NULL;
>         host->dma_desc = NULL;
>
> -       host->dma_chan_rxtx = dma_request_slave_channel(dev, "rx-tx");
> +       host->dma_chan_rxtx = dma_request_chan(dev, "rx-tx");
> +       if (IS_ERR(host->dma_chan_rxtx)) {
> +               ret = PTR_ERR(host->dma_chan_rxtx);
> +               host->dma_chan_rxtx = NULL;
> +
> +               if (ret == -EPROBE_DEFER)
> +                       goto err;
> +
> +               /* Ignore errors to fall back to PIO mode */
> +       }
> +
>
>         clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk)) {
> --
> Peter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
