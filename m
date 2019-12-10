Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF4EC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93C121556
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QayVJLfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLJMbT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:31:19 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38342 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfLJMbS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 07:31:18 -0500
Received: by mail-ua1-f66.google.com with SMTP id z17so7125152uac.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cu4xcLC6fx43ALyB2PH7P6iHLVvlsMlK6QGD81ONfJA=;
        b=QayVJLfzwhxAFLgXNRzLMZdJ0IvLzxp4+fLYkgsafsn6S05wJNPxe1W2fAZYyUBGR8
         BcCeWqYv6slEWraMiYfCcPv4pF0tfY9IyHA+7AWdiyjqH31IZzLc5y/xNthjj+0mqejq
         /gjucQhq10JYIm5v0/LMFDew4Ilc+OXTn08xJPNEu664cWU63FxtQ7yCvrJrZZa8xDGP
         W9EiAP+c5SMOv4CIfQw/j0wZDvKbWs+qtoigdrFb6GjKOwnzrUG6gxYkrj4TJEB4DeJS
         YgnZ+BySLGuychJ02elTMZf7LBTg/2mNw+VpOcdbROX8BTpOTFbTDzDl1jY4Q1isKofp
         L0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cu4xcLC6fx43ALyB2PH7P6iHLVvlsMlK6QGD81ONfJA=;
        b=KJFy5Q6u+URat1u/9JGQ+qz0HvW7AppwbYxyylSFjL2/PqD3WHArCNkuIqliwMoPsF
         0cXw48IBl8GEUjSfymdhUFmsL7fT9GhqK2FH+FpvC69voi61cFPzHE3WtorgRf6GMgS6
         AiLVlqoUcJNWEQ1CVKVWLjXe8VJbTGjXnuMOfN5BcmThpv87Ri4zkYHPWUB8zvHmfdC+
         TXT6bvuaketFUA0LFtiqKoQhqYUVHoa34vH05hJZGzQybXB5sjuDhccVAWAAB1+7OH1M
         SrBprXHuUA1NWNz65r+Xg+TPBuXju78VkesMuFkmUb9mhpcEbV4GYH4Hu3FR12cAnV3X
         1iHw==
X-Gm-Message-State: APjAAAUGNFbdzV/U/U75tiAo+0yz3gowzjt/QnQ7rGfF1ht11V7X9dq2
        rGVt2IelsP6alT+rP/62nJGISt27vcy2iwybK1mkqg==
X-Google-Smtp-Source: APXvYqyrTM1DC8Fmp+/CAB2noSeEwqc06KeL4uYpQ1xlDaNR2EbcD+cNIjYR1xbMle/tNoYu8/S+qEj9nJ91/lu54KE=
X-Received: by 2002:ab0:2759:: with SMTP id c25mr3460125uap.104.1575981077116;
 Tue, 10 Dec 2019 04:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20191113172514.19052-1-ludovic.Barre@st.com>
In-Reply-To: <20191113172514.19052-1-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 13:30:41 +0100
Message-ID: <CAPDyKFrZxOCkw9U05UZPRSGz2CqmhOq944z8MEVox8Y_UEYC4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: mmci: add threaded irq to abort DPSM of
 non-functional state
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 18:25, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> If datatimeout occurs on R1B request, the Data Path State Machine stays
> in busy and is non-functional. Only a reset aborts the DPSM.
>
> Like a reset must be outside of critical section, this patch adds
> threaded irq function to release state machine. In this case,
> the mmc_request_done is called at the end of threaded irq and
> skipped into irq handler.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/mmci.h |  1 +
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 40e72c30ea84..ec6e249c87ca 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -556,6 +556,9 @@ static void mmci_dma_error(struct mmci_host *host)
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> +       if (host->irq_action == IRQ_WAKE_THREAD)
> +               return;
> +

It seems a bit unnecessary to check this every time mmci_request_end()
is called.

How about avoiding to call mmci_request_end() for the one specific
condition instead? See more below.

>         writel(0, host->base + MMCICOMMAND);
>
>         BUG_ON(host->data);
> @@ -1321,6 +1324,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         } else if (host->variant->busy_timeout && busy_resp &&
>                    status & MCI_DATATIMEOUT) {
>                 cmd->error = -ETIMEDOUT;
> +               host->irq_action = IRQ_WAKE_THREAD;

You could check this flag a few lines below and if it's set to
IRQ_WAKE_THREAD, avoid to call mmci_request_end().

>         } else {
>                 cmd->resp[0] = readl(base + MMCIRESPONSE0);
>                 cmd->resp[1] = readl(base + MMCIRESPONSE1);
> @@ -1532,9 +1536,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>  {
>         struct mmci_host *host = dev_id;
>         u32 status;
> -       int ret = 0;
>
>         spin_lock(&host->lock);
> +       host->irq_action = IRQ_HANDLED;
>
>         do {
>                 status = readl(host->base + MMCISTATUS);
> @@ -1574,12 +1578,41 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                 if (host->variant->busy_detect_flag)
>                         status &= ~host->variant->busy_detect_flag;
>
> -               ret = 1;
>         } while (status);
>
>         spin_unlock(&host->lock);
>
> -       return IRQ_RETVAL(ret);
> +       return host->irq_action;
> +}
> +
> +/*
> + * mmci_irq_threaded is call if the mmci host need to release state machines
> + * before to terminate the request.
> + * If datatimeout occurs on R1B request, the Data Path State Machine stays
> + * in busy and is non-functional. Only a reset can to abort the DPSM.
> + */
> +static irqreturn_t mmci_irq_threaded(int irq, void *dev_id)
> +{
> +       struct mmci_host *host = dev_id;
> +       unsigned long flags;
> +
> +       if (host->rst) {
> +               reset_control_assert(host->rst);
> +               udelay(2);
> +               reset_control_deassert(host->rst);
> +       }
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       writel(host->clk_reg, host->base + MMCICLOCK);
> +       writel(host->pwr_reg, host->base + MMCIPOWER);
> +       writel(MCI_IRQENABLE | host->variant->start_err,
> +              host->base + MMCIMASK0);
> +
> +       host->irq_action = IRQ_HANDLED;
> +       mmci_request_end(host, host->mrq);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       return host->irq_action;
>  }
>
>  static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> @@ -2071,8 +2104,9 @@ static int mmci_probe(struct amba_device *dev,
>                         goto clk_disable;
>         }
>
> -       ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
> -                       DRIVER_NAME " (cmd)", host);
> +       ret = devm_request_threaded_irq(&dev->dev, dev->irq[0], mmci_irq,
> +                                       mmci_irq_threaded, IRQF_SHARED,
> +                                       DRIVER_NAME " (cmd)", host);
>         if (ret)
>                 goto clk_disable;
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 158e1231aa23..5e63c0596364 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -412,6 +412,7 @@ struct mmci_host {
>
>         struct timer_list       timer;
>         unsigned int            oldstat;
> +       u32                     irq_action;
>
>         /* pio stuff */
>         struct sg_mapping_iter  sg_miter;
> --
> 2.17.1
>

Otherwise this looks good, besides my other earlier comments, of course.

Kind regards
Uffe
