Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920FEC33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669A520684
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXEtdQ7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgAPOkm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:42 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46999 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPOkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id t12so12778478vso.13
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVhtaTZCnCfNAKfqW6Z96W5OFC2Pq+R/wFI5kI7mdb4=;
        b=gXEtdQ7PCw+gTlTwk1m8oaajlGEKXgyLcnQ9O/Q3xrgixx5T22kdhtzB2RxINoEeYz
         7eY9jpwmUVVR32V/YGB1Hf5+pC9LvE1fyWYBuaBY84d8VnJWSVlhLtU3vo2ngr3NSQ8u
         s0h28cTMPi+qhCHTXZoZD1FkXjkwgb9xQlrqIyhqMaLPoc1P0m3JoASsyLh/bngQWlkh
         g2aOkk3mZO1/tMmjtt6fe9B+4LvgPIzfYQMYbZqXe2BaoVLlx4EXvtbl0tWzEXpwTyFH
         Ajj1kCy4Sa1iR4cs5ps/nMGuJimSypSXdHgDhJfvgDJKzeBRbHbE19yw6SxqQTQ0tUck
         6rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVhtaTZCnCfNAKfqW6Z96W5OFC2Pq+R/wFI5kI7mdb4=;
        b=mwhFXHRtnKE/5/yxC1zZbKR8KT/IcWyUpG836fQ/iJ84mhdVCrdIbk+YII5JCsB68I
         0o2rqFoCKwRNu0M+TxJH+GvorxYg91U2JTwER36nSIOTo3zSn8DXte8MX63LG2DhIz2R
         EYGv56gpFcZBykpa07X//vqHsU823DjDW/9XaXlpzb5Vf2stMOBtus60i7JBil8/qb2t
         simaR11mYfglLLv0b9RFQSFNbrlwD0HiFRRkSFI0SIS3g5ehlqyUbVRgbih0GGHLKU3N
         cYynB9oe441s5zy9a1qdd1JV6WCO3Ka8epNv3sND7iBqtSDnATnwjSDHbYdA8RWrH4bD
         V91Q==
X-Gm-Message-State: APjAAAXdCQLNqpxbt8BZGDGDTUUnLTNNuA/iB6UgahlsolpECuNZGWpN
        ute/ByW12b+yK4J0LyJFVFza3F3xkY3WGCjQxmj26w==
X-Google-Smtp-Source: APXvYqxdGqQVZL1Cp2YXroa6T/66ubc1o8e1OjNbTTh0kzG7LTpsQVMQx7USP1Q+2n2bYrFlgiT+1QU5tEx365YNJ9U=
X-Received: by 2002:a67:cd96:: with SMTP id r22mr1631688vsl.165.1579185640833;
 Thu, 16 Jan 2020 06:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20200107104040.14500-1-peter.ujfalusi@ti.com>
In-Reply-To: <20200107104040.14500-1-peter.ujfalusi@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:40:04 +0100
Message-ID: <CAPDyKFqjiwqP-QzHQT4r-YXzLD2rdjNZK5Vb9=KC1SDTuhwtOw@mail.gmail.com>
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

On Tue, 7 Jan 2020 at 11:40, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
>
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I thought I had already applied this, but maybe I didn't publish my
branch back then.

Oh well, please double check so the code has been included in my next branch.

Kind regards
Uffe


> ---
> Hi,
>
> Changes since v1:
> - jump to err: instead of returning in case of EPROBE_DEFER
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
