Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC72C2D0CD
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BC9218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQV2Pwjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLROB5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:01:57 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34958 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLROB5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:01:57 -0500
Received: by mail-vk1-f193.google.com with SMTP id o187so661319vka.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDDXhiVTyjttx83CIWs0F1XonSq49Z4FwKDL4AKSMZ0=;
        b=BQV2PwjmbtuoWSC6pu036LkQ2z7jmrFW6qlzts/aZDJynU93TGkLUhBp1tK0JsTFaT
         S2b+dwMSp+ypQMOMXdOs9LFVYT7fgaSnIF6v4Fdpd6rCw36hFZjNVJQq/ePUT36d7n1n
         D1ffm2D1fhMhbjnIctBnD8i0BiNqyl8E/ruo7fbsOjIVAw+HRNjyOX3tha/u9SsSNIk6
         IB11YGyhc9yROsqDogYMqWIf3e3tv6zde8cexBNY7mOtar629cjEidMYs9B3ROwqzBLd
         /nM+061/J2VcBtRQ7dKOpHAiXKfXghjHS7RiWirp6/pETZAB1yRLXPv0Fhv0nw2+IMsu
         UnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDDXhiVTyjttx83CIWs0F1XonSq49Z4FwKDL4AKSMZ0=;
        b=D9r6j26rvCUohTtNacc7iAN4/0jLaT3DC1o835RCZnB8tTnG0NrLuKRT/hcMS3LRTz
         f3HpE//rcmnIbXkwydGh+eq6u/6++ubL2ejGuZiJHeyCCxnXpScClrdvtZd+EaDb+ucW
         7P/leK9Okfsak5bpuN6r+4ZHFqWwiDt4Lt3SR0dkLzZWuANPXTWoonul15xuwdyCQRks
         QWirIH7xOZiLlBvqteJlkMJd5dyvHf6VyiBsgrhJXlgwm3gSpseSVHXio5PQyVmG0b35
         zY7Pb6MDSBUKDdlIuBGU5oEnMxfdwntiy1utZal3fc97sDRiW8WiNueg8knpzkut3P0K
         c9NQ==
X-Gm-Message-State: APjAAAWiUiHYF0NKDUPW9nkIderxFRQd86cewObs71s08nwrJg3Ptjs0
        nH3KvfcYylDowZvI8oy4+QPGqM17GrNZ5Nf2xzBuw2Ju
X-Google-Smtp-Source: APXvYqwKppPVSkF/tgQZTFhbMXTfr2S4Ix4tS00kAV6zskzWPozXs1ppIIQpeKIDB7d8k+f5RedW4PwJL7fcueb9+8I=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr1807754vka.59.1576677716241;
 Wed, 18 Dec 2019 06:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20191211133934.16932-1-ludovic.Barre@st.com>
In-Reply-To: <20191211133934.16932-1-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:20 +0100
Message-ID: <CAPDyKFpoqEXO1JvjF=0hX97PiwP=2c1eWORsacb8QvZM=1Tvjw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: mmci: add threaded irq to abort DPSM of
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

On Wed, 11 Dec 2019 at 14:40, Ludovic Barre <ludovic.Barre@st.com> wrote:
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

Applied for next, thanks!

I took the liberty of doing some minor updates (changelog/comment),
please have a look and let me know if there is something you want me
to change.

And again, apologize for the delays!

Kind regards
Uffe


> ---
> change V2:
>  -check IRQ_WAKE_THREAD only in mmci_cmd_irq error part,
>   to avoid this test in mmci_request_end.
>
> ---
>  drivers/mmc/host/mmci.c | 46 +++++++++++++++++++++++++++++++++++------
>  drivers/mmc/host/mmci.h |  1 +
>  2 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 40e72c30ea84..2b91757e3e84 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1321,6 +1321,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         } else if (host->variant->busy_timeout && busy_resp &&
>                    status & MCI_DATATIMEOUT) {
>                 cmd->error = -ETIMEDOUT;
> +               host->irq_action = IRQ_WAKE_THREAD;
>         } else {
>                 cmd->resp[0] = readl(base + MMCIRESPONSE0);
>                 cmd->resp[1] = readl(base + MMCIRESPONSE1);
> @@ -1339,7 +1340,10 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                                 return;
>                         }
>                 }
> -               mmci_request_end(host, host->mrq);
> +
> +               if (host->irq_action != IRQ_WAKE_THREAD)
> +                       mmci_request_end(host, host->mrq);
> +
>         } else if (sbc) {
>                 mmci_start_command(host, host->mrq->cmd, 0);
>         } else if (!host->variant->datactrl_first &&
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
