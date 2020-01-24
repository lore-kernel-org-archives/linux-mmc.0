Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E6C32771
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 13:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763B208C4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9RWc7TA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbgAXNRM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:17:12 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41238 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgAXNRM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 08:17:12 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so1155707vsc.8
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CY7ltUl+oKffieFB5UMThEtSPwanbFsXqyW/QH4Ukh0=;
        b=e9RWc7TAC74AHptTQcr8hXxfjxpt3Z0iET5zEidjYPqHYng8MtDugSWQvHKeBShScB
         l6F6DVcE6itNBO5dTXEyCYIfAVhN1GUphQxrbM+HQQ1AZM9Ux6fIPYPoEm8cno+PCdHM
         ywFYIdhzHaHkJb1RvQ21xmiMRinXHLswPI1c5LPyYNEEeq9qdLhEjGE2VnozomaoTw4w
         /N+NeLRtuOvmaAAWa2oqq5efgDFjwsh7yeAgIFg3BF/bfUF9AkwLqx1s/b9ao84vQphT
         H3SzbTiol/MbELYfxNcjJx5ZBft9+XrklMQ07BCznmvRb2ufC1wZSC8dY9hurMidqeZ+
         p6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CY7ltUl+oKffieFB5UMThEtSPwanbFsXqyW/QH4Ukh0=;
        b=F8Na9PbbyqGb8XIEv3kUToO7u/tESP09f+HindcHTYOHlnqPgHrfBfGVSmQ1EKUb0L
         ly6u/0+B4kDR3oJC8oFkL+G+c2Oiruxk8EB0wT71hOC0CqR3sRPwHiT70waiWVwDOo9M
         S/icgKT5UIFknV2aOozKRCeP/kmNq4wmPPi9qQdZ0ftJm/f+ZJoDl3H73qbnDL3F9TsD
         mqL3GllPzALtgbW5u5J7lMc4PL/JVMuUngtA0fT1YCWiD8wdla6mejS77CHltQHr8UdG
         SqIm+Z4HnmWTrpBYkeyRt46l74lZ02+ugiPpyW8/v4hwykiWI676YNf7p3dqPDE+m0D2
         rnxA==
X-Gm-Message-State: APjAAAU5Kwb05loKf2qJuQFzoi/WHngfgtMYFAnQiA8jxmTYKxzvm+Yb
        257dD7qWxgf75CO93fZiHKLxgZT6t61cJQIHwf2WpA==
X-Google-Smtp-Source: APXvYqxuazxpyOLmT7wp2Bb5Qs3z0UkG3lAUPzIzMHC3yzutOc4zmH0KV20Nsdhmyiq1SYfbmAs1J3r1bPtSYgQDFEE=
X-Received: by 2002:a67:314e:: with SMTP id x75mr1897330vsx.35.1579871830131;
 Fri, 24 Jan 2020 05:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20200110134823.14882-1-ludovic.barre@st.com> <20200110134823.14882-9-ludovic.barre@st.com>
In-Reply-To: <20200110134823.14882-9-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 14:16:34 +0100
Message-ID: <CAPDyKFp1Qsb3yCoTJevHF+SEt5thVVriLfL-4UZSYsNTc0rdMQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] mmc: mmci: sdmmc: add voltage switch functions
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
> To prepare the voltage switch procedure, the VSWITCHEN bit must be
> set before sending the cmd11.
> To confirm completion of voltage switch, the VSWEND flag must be
> checked.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.h             |  4 +++
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 40 ++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index c04a144259a2..3634f98ad2d8 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -165,6 +165,7 @@
>  /* Extended status bits for the STM32 variants */
>  #define MCI_STM32_BUSYD0       BIT(20)
>  #define MCI_STM32_BUSYD0END    BIT(21)
> +#define MCI_STM32_VSWEND       BIT(25)
>
>  #define MMCICLEAR              0x038
>  #define MCI_CMDCRCFAILCLR      (1 << 0)
> @@ -182,6 +183,9 @@
>  #define MCI_ST_SDIOITC         (1 << 22)
>  #define MCI_ST_CEATAENDC       (1 << 23)
>  #define MCI_ST_BUSYENDC                (1 << 24)
> +/* Extended clear bits for the STM32 variants */
> +#define MCI_STM32_VSWENDC      BIT(25)
> +#define MCI_STM32_CKSTOPC      BIT(26)
>
>  #define MMCIMASK0              0x03c
>  #define MCI_CMDCRCFAILMASK     (1 << 0)
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 10059fa19f4a..9f43cf947c5f 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -263,7 +263,9 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
>         struct mmc_ios ios = host->mmc->ios;
>         struct sdmmc_dlyb *dlyb = host->variant_priv;
>
> -       pwr = host->pwr_reg_add;
> +       /* adds OF options and preserves voltage switch bits */
> +       pwr = host->pwr_reg_add |
> +               (host->pwr_reg & (MCI_STM32_VSWITCHEN | MCI_STM32_VSWITCH));
>
>         sdmmc_dlyb_input_ck(dlyb);
>
> @@ -454,6 +456,40 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return sdmmc_dlyb_phase_tuning(host, opcode);
>  }
>
> +static void sdmmc_prep_vswitch(struct mmci_host *host)
> +{
> +       /* clear the voltage switch completion flag */
> +       writel_relaxed(MCI_STM32_VSWENDC, host->base + MMCICLEAR);
> +       /* enable Voltage switch procedure */
> +       mmci_write_pwrreg(host, host->pwr_reg | MCI_STM32_VSWITCHEN);
> +}
> +
> +static int sdmmc_vswitch(struct mmci_host *host, struct mmc_ios *ios)
> +{
> +       unsigned long flags;
> +       u32 status;
> +       int ret = 0;
> +
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +               spin_lock_irqsave(&host->lock, flags);
> +               mmci_write_pwrreg(host, host->pwr_reg | MCI_STM32_VSWITCH);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +
> +               /* wait voltage switch completion while 10ms */
> +               ret = readl_relaxed_poll_timeout(host->base + MMCISTATUS,
> +                                                status,
> +                                                (status & MCI_STM32_VSWEND),
> +                                                10, 10000);
> +
> +               writel_relaxed(MCI_STM32_VSWENDC | MCI_STM32_CKSTOPC,
> +                              host->base + MMCICLEAR);
> +               mmci_write_pwrreg(host, host->pwr_reg &
> +                                 ~(MCI_STM32_VSWITCHEN | MCI_STM32_VSWITCH));
> +       }

Don't you need to manage things when resetting to
MMC_SIGNAL_VOLTAGE_330, which for example happens during a card
removal or at system suspend/resume?

> +
> +       return ret;
> +}
> +
>  static struct mmci_host_ops sdmmc_variant_ops = {
>         .validate_data = sdmmc_idma_validate_data,
>         .prep_data = sdmmc_idma_prep_data,
> @@ -465,6 +501,8 @@ static struct mmci_host_ops sdmmc_variant_ops = {
>         .set_clkreg = mmci_sdmmc_set_clkreg,
>         .set_pwrreg = mmci_sdmmc_set_pwrreg,
>         .busy_complete = sdmmc_busy_complete,
> +       .prep_volt_switch = sdmmc_prep_vswitch,
> +       .volt_switch = sdmmc_vswitch,
>  };
>
>  void sdmmc_variant_init(struct mmci_host *host)
> --
> 2.17.1
>

Kind regards
Uffe
