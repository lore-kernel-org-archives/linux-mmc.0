Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCFBC35242
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2250420838
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6IMwHE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgAXNNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:13:14 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35638 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbgAXNNO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 08:13:14 -0500
Received: by mail-vk1-f194.google.com with SMTP id o187so593160vka.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 05:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pCJ51fgs/0G4N/AkTYuiiJRhKjkqBJy/ABL+0E/bFk=;
        b=P6IMwHE8uT8RMdr1P8rDQpRrJ5PNR4L4H7E0i7DQXVdviFO6LD475vzz1mjKOK1iuK
         aJERxWGDezcMiHDHs58NUqcgXYF2j4dEMNFJtigubdbAwW7CH95WNAXL9vXEb13GgBPs
         00sCtxzu+hBjYlqlOLeDYcXG887pbfo1S0Nmjo47abdHXdfRBJQ/2HfQeO8R2jInTfPp
         fARl9XjAr32zEKJOQtTZBpNlkVYlB+yb7xrkmvb0YRgdOKav0ImuGbK0XGBLOcZ9YXF/
         2YtVULLz2da5RU43io9ze0nwFBk/FX2ubwO8cG0aRikoB5nDS5N0LxFQvbKWHNVJ+8xr
         e31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pCJ51fgs/0G4N/AkTYuiiJRhKjkqBJy/ABL+0E/bFk=;
        b=FtXM2nBm4MC9mzygstGdY+6uS1nnR+THbK6k3/3bPzuB3zkaMVdg8bzF3kTpwUwiqB
         hKeJ8SImslGm2BMm/q483ESPbNi9qZP5cm5dHKSMAv7ppaq17zZFXq0x0lrF9ZBcwr76
         N5aIQ/rd5nydD0tEGjQl2cJ+rbrCBVV4YpJBNTkgcLXNMlPGKnzq8YLWGHA2WAVcENWQ
         RzZw6jA7vhKIB5vxXLyZg40rQpZSYWR9wOvBFhSz25KMPm4x9lt/C7AvqTYnZgX4Ch80
         nAQzZkiBWZu5If9nhxDqH/R1rWuLxbqBnVyVClACMkb48oJ6IEIrvt6z6CUaNNKKvp8u
         4cqQ==
X-Gm-Message-State: APjAAAV5SnglRvk9oInHPTnmrdj8ZeMBQ3Wzngk+v+zMkxapCFkzHbBT
        rtDunIEX26bF2UfCLGKoMOd8DackLuAHnW8J9EPHbg==
X-Google-Smtp-Source: APXvYqwvweHW+//fi2a64HFcGs84CB60rRh0VyQGFxeZ6xd6bTwXqvSw/Zs/SJ/+x6Yw0TF8Gdlx6/fNzadVplvj68g=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr1847120vkd.101.1579871593005;
 Fri, 24 Jan 2020 05:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20200110134823.14882-1-ludovic.barre@st.com> <20200110134823.14882-8-ludovic.barre@st.com>
In-Reply-To: <20200110134823.14882-8-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 14:12:36 +0100
Message-ID: <CAPDyKFqt6SuQh8V1_2-2HzBixR2HTKM+1FKgYuNA1zytc22W7g@mail.gmail.com>
Subject: Re: [PATCH 7/9] mmc: mmci: add volt_switch callbacks
To:     Ludovic Barre <ludovic.barre@st.com>
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

On Fri, 10 Jan 2020 at 14:49, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> This patch adds 2 voltage switch callbacks in mmci_host_ops:
> -prep_volt_switch allows to prepare voltage switch before to
>  sent the SD_SWITCH_VOLTAGE command (cmd11).
> -volt_switch callback allows to define specific action after
>  regulator set voltage.

I am fine with adding these callbacks, however I strongly suggest to
have a reference to "signal voltage" in the name of the callbacks. As
to avoid confusion for what there are used for.

Perhaps ->post_sig_volt_switch() and ->pre_sig_volt_switch() can work?

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 8 ++++++++
>  drivers/mmc/host/mmci.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 00b473f57047..d76a59c06cb0 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -22,6 +22,7 @@
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/sd.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/amba/bus.h>
>  #include <linux/clk.h>
> @@ -1207,6 +1208,9 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 writel_relaxed(clks, host->base + MMCIDATATIMER);
>         }
>
> +       if (host->ops->prep_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)
> +               host->ops->prep_volt_switch(host);
> +
>         if (/*interrupt*/0)
>                 c |= MCI_CPSM_INTERRUPT;
>
> @@ -1820,6 +1824,7 @@ static int mmci_get_cd(struct mmc_host *mmc)
>
>  static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> +       struct mmci_host *host = mmc_priv(mmc);
>         int ret = 0;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> @@ -1839,6 +1844,9 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>                         break;
>                 }
>
> +               if (!ret && host->ops && host->ops->volt_switch)
> +                       ret = host->ops->volt_switch(host, ios);
> +
>                 if (ret)
>                         dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
>         }
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index ddcdfb827996..c04a144259a2 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -377,6 +377,8 @@ struct mmci_host_ops {
>         void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
>         void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
>         bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
> +       void (*prep_volt_switch)(struct mmci_host *host);
> +       int (*volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
>  };
>
>  struct mmci_host {
> --
> 2.17.1
>

Kind regards
Uffe
