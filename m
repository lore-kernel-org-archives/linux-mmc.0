Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EFC636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjBMXt7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjBMXt5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:49:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAFB199E8
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so12521078pjk.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjpigBZ+7StVK30H4lglpC2IQ3U8TcpPStf/NkAJNTs=;
        b=HTxikJySjxsrIwOTIrhCEE37P1tFGRWp2ShddDJdCdEMPN9oziQ69cp+6/4Hm0sosX
         qA1ecV5NebLTt3HncntG4oYzrGpcvSTN8XCb6d7MtmhvFAm1RfdlhXZajvJdXlulp757
         jXtgeDwS6uvkCLcDvZO/lO5ZpKkgHASL8he8xWFtvFnoQXHlF8cTerwTqUyhDIhGoG1k
         oCO/mkhIMmy2q3LOKOahcZAShz9AsEi/Gv/5GkR2WjZyJeLrGIciQeiODQtsoffnFqXl
         Lifs2/s5Be1lEve63X74x1pKzP/5UhpxtLq1gMa44HcFccuemjNKAWaniRVlbKbV4G5D
         FbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjpigBZ+7StVK30H4lglpC2IQ3U8TcpPStf/NkAJNTs=;
        b=4P/zLC87XK0F1avjvvp8Mui56NO3aCeAMnP+00xyAxYb33jGM6Csk88Bu2Nn/VrM15
         tl0OJ7xMWFEEd/gz6h6zTS1uJA1l1iEUljiun9YyBzezbLZ8UcAcR2TDzNg84btFxgwi
         zCV+0yvMAiPueDRFhzLyU49yZI+9cFF8MmdPNsyLNeQ+4/uZpcOMpNSQbwlGdfwCaWXe
         wb3dwoAC/6W4CAKYF16cG2Y39j2vZIKy2pvjrrGdjPdrbrgp4ucL2dfeBbTBxM6WlvID
         IFwaA2UC34fzI3Q4/JeC4Aj++/CJBJk3W1clHt2jGDqqn7FKNAM2LcZyudAxVCE4SBAF
         3wsQ==
X-Gm-Message-State: AO0yUKUaE1gcjc0wICeJFAMy7GO9e/qSspXokxfGOBeNoSjr3tbTGxXE
        8DaWP9iTV7EGdaP3NNuzxI1cfGCH/GBBWEipyUb8VO/nbu46dg==
X-Google-Smtp-Source: AK7set9AV0Gj8a4XFl7/Eq7aJCZnc4MFHKoXFgS8jXLVFiKB+iCYHolhoryAtpLWqaLtQKC/115/swy97JjZw3NdYTg=
X-Received: by 2002:a17:903:230e:b0:199:49fc:8669 with SMTP id
 d14-20020a170903230e00b0019949fc8669mr204310plh.6.1676332163113; Mon, 13 Feb
 2023 15:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20230131210229.68129-1-paul@crapouillou.net> <20230131210229.68129-2-paul@crapouillou.net>
In-Reply-To: <20230131210229.68129-2-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:47 +0100
Message-ID: <CAPDyKFoaJMsEuJsbjkD6rtCmoYdQ+uKaWohca2WDsfdGarWBUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: jz4740: Add support for vqmmc power supply
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Jan 2023 at 22:02, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Support enabling / disabling the vqmmc power supply if it was provided
> by the firmware.
>
> Provide the .start_signal_voltage_switch callback to change the voltage
> of the external vqmmc power supply.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 38 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index eb8e9607b086..ccd2c3aed0f0 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/rwsem.h>
>  #include <linux/scatterlist.h>
>
> @@ -162,6 +163,8 @@ struct jz4740_mmc_host {
>         struct mmc_request *req;
>         struct mmc_command *cmd;
>
> +       bool vqmmc_enabled;
> +
>         unsigned long waiting;
>
>         uint32_t cmdat;
> @@ -943,6 +946,8 @@ static void jz4740_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
>  static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct jz4740_mmc_host *host = mmc_priv(mmc);
> +       int ret;
> +
>         if (ios->clock)
>                 jz4740_mmc_set_clock_rate(host, ios->clock);
>
> @@ -955,12 +960,25 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 clk_prepare_enable(host->clk);
>                 break;
>         case MMC_POWER_ON:
> +               if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
> +                       ret = regulator_enable(mmc->supply.vqmmc);
> +                       if (ret)
> +                               dev_err(&host->pdev->dev, "Failed to set vqmmc power!\n");
> +                       else
> +                               host->vqmmc_enabled = true;
> +               }
>                 break;
> -       default:
> +       case MMC_POWER_OFF:
>                 if (!IS_ERR(mmc->supply.vmmc))
>                         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
> +                       regulator_disable(mmc->supply.vqmmc);
> +                       host->vqmmc_enabled = false;
> +               }
>                 clk_disable_unprepare(host->clk);
>                 break;
> +       default:
> +               break;
>         }
>
>         switch (ios->bus_width) {
> @@ -986,6 +1004,23 @@ static void jz4740_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         jz4740_mmc_set_irq_enabled(host, JZ_MMC_IRQ_SDIO, enable);
>  }
>
> +static int jz4740_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       int ret;
> +
> +       /* vqmmc regulator is available */
> +       if (!IS_ERR(mmc->supply.vqmmc)) {
> +               ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               return ret < 0 ? ret : 0;
> +       }
> +
> +       /* no vqmmc regulator, assume fixed regulator at 3/3.3V */
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> +               return 0;
> +
> +       return -EINVAL;
> +}
> +
>  static const struct mmc_host_ops jz4740_mmc_ops = {
>         .request        = jz4740_mmc_request,
>         .pre_req        = jz4740_mmc_pre_request,
> @@ -994,6 +1029,7 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
>         .get_ro         = mmc_gpio_get_ro,
>         .get_cd         = mmc_gpio_get_cd,
>         .enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
> +       .start_signal_voltage_switch = jz4740_voltage_switch,
>  };
>
>  static inline struct jz4740_mmc_host *
> --
> 2.39.1
>
