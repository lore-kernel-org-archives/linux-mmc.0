Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A28E7544A
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Oct 2023 11:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjJCLUU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Oct 2023 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbjJCLUT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2023 07:20:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0416BA7
        for <linux-mmc@vger.kernel.org>; Tue,  3 Oct 2023 04:20:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81afd5273eso808803276.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2023 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696332015; x=1696936815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SV7XmIxzktZdavHHX3szB4DEQlE77NYAzIBoxF50w1k=;
        b=uTdveJqnim0fLi87b1Gi9uGY1+s9mhLcsRL/hApzzLq3qbbAoBDFOP8QtRxRk4lH4Q
         smctIic3onjKnipUet3Zhl4m4C5cmDFAf1FwARhAFirnCjXwpwWe/7vBjUBd/chZXQ+n
         qza8+KuCcKzpFVvTGMDHlmqbHW3Bt217xCDn7NAVZwTKdKEQhaejmZ3VSW0XIZwjy1nM
         2+IOU+gocmBPr4o9kXjeqEi1dDaiMeGGmfi/QPzifHetqYlTqD6BB+VNx7WCmGEJd+NT
         ixwlLVnEGKboJzo87xhGGJ21mY+VVRPkB4Fz+gsx2DrGwCq9iLcV/Fpfy9KggyCEIjaV
         AeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696332015; x=1696936815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV7XmIxzktZdavHHX3szB4DEQlE77NYAzIBoxF50w1k=;
        b=q1ps2L4JRacQLn4ySjnyAKBhHz8Q4aZAcAjMxwhDUVMESPHnDtTdUOLZLBCY9kmSTz
         tVsA86tbG8Hd39w0EfsohQjCL+6p/ADZfWSlSNQqbkqbIiprkrOqgMQIhLjanxwLJsnz
         2sXALH6l9vo8KePOcR5wlk4DmAFI34nfhOIbUdOzPOdhLkNuGvKGJX4Uxm5k48uuFMdi
         Ek/5nHkBZKGNVZmYToksU/gQZMXdri/uqYk1M1dUeEVcczY4THJsYB64Xdx7PnsVj8yw
         zmqfbQ/Mb5uiRrwWvlN/RJrnzhA7TdxxPa5xQJR+EocDugImfw7kCQIfql5fp4cjqaqZ
         TcMA==
X-Gm-Message-State: AOJu0YwYVduxTjvaT7mrjlMhhoFCV/eT2EAsbINEO++0XtfygKZSVLfP
        0c5Dyi3Gn8BAy7c18kvKehxQtwx7ceiq1wIOAKcUCA==
X-Google-Smtp-Source: AGHT+IEzJGmLvmLvuA6XEaLFU/wA4m1BCEpX+e9zMo4eIbVm1bF9Jtdktrn4hN8UYD0CAi5dkSiZEFSdfIgx2PSpSVA=
X-Received: by 2002:a25:6fc1:0:b0:d81:c412:183c with SMTP id
 k184-20020a256fc1000000b00d81c412183cmr13131966ybc.17.1696332015108; Tue, 03
 Oct 2023 04:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-18-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-18-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 13:19:39 +0200
Message-ID: <CAPDyKFoQY=y-aZQa3GBGayE6=Ei=hw_Nu=1_tmQ-ckv94ujf4A@mail.gmail.com>
Subject: Re: [PATCH V12 17/23] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a sdhci version of mmc's uhs2_set_reg operation.
> UHS-II interface (related registers) will be initialised here.

Please clarify this. It's not entirely easy to understand what goes on
by reading the commit message above.

Again, the similar comments as I provided for patch15 applies to
$subject patch too.

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Updates in V8:
>  - Reorder the definitions and lose the parentheses in
>    sdhci_uhs2_set_config().
>  - read_poll_timeout() to instead of read_poll_timeout_atomic()
>    in sdhci_uhs2_check_dormant().
>
> Updates in V7:
>  - Remove unnecessary function.
>
> Updates in V6:
>  - Remove unnecessary function.
>  - Remove unnecessary parameter when call the DBG().
>  - Cancel export state of some functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 88 +++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index af1b0c5e48fd..09b86fec9f7b 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -278,6 +278,48 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         sdhci_set_clock(host, host->clock);
>  }
>
> +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> +{
> +       u32 value;
> +       u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
> +       u16 sdhci_uhs2_gen_set_reg      = sdhci_uhs2_set_ptr;
> +       u16 sdhci_uhs2_phy_set_reg      = sdhci_uhs2_set_ptr + 4;
> +       u16 sdhci_uhs2_tran_set_reg     = sdhci_uhs2_set_ptr + 8;
> +       u16 sdhci_uhs2_tran_set_1_reg   = sdhci_uhs2_set_ptr + 12;
> +
> +       /* Set Gen Settings */
> +       value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
> +       sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
> +
> +       /* Set PHY Settings */
> +       value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
> +               FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
> +       if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +           host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD)
> +               value |= SDHCI_UHS2_PHY_SET_SPEED_B;
> +       sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> +
> +       /* Set LINK-TRAN Settings */
> +       value = FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->uhs2_caps.max_retry_set) |
> +               FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_caps.n_fcu_set);
> +       sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> +       sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs2_tran_set_1_reg);
> +}
> +
> +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> +{
> +       int timeout = 100000; /* 100ms */

Define.

> +       u32 val;
> +
> +       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
> +                             100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> +               pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +               return -EIO;
> +       }
> +       return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> @@ -359,6 +401,51 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
>         return 0;
>  }
>
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);

Please re-order the code so this declaration isn't needed. And make it
part of the patch that introduced the function, not in the $subject
patch.

> +
> +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct mmc_ios *ios = &mmc->ios;
> +       int err = 0;
> +
> +       DBG("Begin uhs2 control, act %d.\n", op);
> +
> +       switch (op) {
> +       case UHS2_PHY_INIT:
> +               err = sdhci_uhs2_do_detect_init(mmc);
> +               break;
> +       case UHS2_SET_CONFIG:
> +               sdhci_uhs2_set_config(host);
> +               break;
> +       case UHS2_ENABLE_INT:
> +               sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> +               break;
> +       case UHS2_DISABLE_INT:
> +               sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> +               break;
> +       case UHS2_CHECK_DORMANT:
> +               err = sdhci_uhs2_check_dormant(host);
> +               break;
> +       case UHS2_DISABLE_CLK:
> +               err = sdhci_uhs2_disable_clk(mmc);
> +               break;
> +       case UHS2_ENABLE_CLK:
> +               err = sdhci_uhs2_enable_clk(mmc);
> +               break;
> +       case UHS2_SET_IOS:
> +               err = sdhci_uhs2_set_ios(mmc, ios);
> +               break;
> +       default:
> +               pr_err("%s: input sd uhs2 operation %d is wrong!\n",
> +                      mmc_hostname(host->mmc), op);
> +               err = -EIO;
> +               break;
> +       }
> +
> +       return err;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -481,6 +568,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>         host->mmc_host_ops.start_signal_voltage_switch =
>                 sdhci_uhs2_start_signal_voltage_switch;
> +       host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
>
>         return 0;
>  }

Kind regards
Uffe
