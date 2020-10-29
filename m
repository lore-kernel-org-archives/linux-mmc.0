Return-Path: <SRS0=xPu9=EE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0A2C55179
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 12:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F9620809
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Oct 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxIEECwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgJ2MJU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgJ2MJO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2020 08:09:14 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC3C0613D2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2020 05:09:14 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d125so632667vkh.10
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2020 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eS2BXPw70XBEKBJsqiRVwwS6rphRSjKG0ma3prq9/98=;
        b=IxIEECwgfbstf5hiHMhHUDhjaZkjDj2ur60IeX43QSF+C250daWwy2uOzvmhvf+9yH
         LVq1gAq7GwsvQjOpjC7Ha+nmU4NyTuokmDg10GcR4F2V1/to4QTqyEJ+vBT2HiYxcY+8
         9w0mJ5MmQpDLxniBRN9nGSAzbzJzsJS5WCLddf1H6n9cTlmnFVwtr1ZlQ8uis/v/guGu
         Wm9hD64KmyTQVEUQpcI/4lBJbopHG1mvArH9Wb4mW8H/jy2guJzmHL+p2rhe/S0nP+RV
         Jq/7lXYrkk1VdYflSQevLzsNmL6AO6GS0n+5Kds4U8yrIy/cJjW4rrC7KuFZCICLxqtT
         saAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eS2BXPw70XBEKBJsqiRVwwS6rphRSjKG0ma3prq9/98=;
        b=LwsFgEJb03CKSgBz/rgLR7ErtWDnvM7zwWJ9G1nql+Rka/jf7vfanidULEJmwKyFRo
         s0pFDKDsoH/KCLxzPJ853k0+NHVKAFe0vOPL/3dkYOHpGDFjfsIEpDuDcuoAKxuHHoI5
         Un7utXfIOcsZqB5C9TFbZHOFo+Fkmch9zJM5zcRwjALeltTH+DWYNKN8xCOFjsNH3GHK
         bM6QbQb9OC2JWSj8KJCuNHee9ZzPBLC4CeoSQDRev28G9HPAaIhJTCwZM8Jn56uop/RS
         g3z2jwFz8sO6c435OwwrGxc/mh4JFvzELAlRvt1rXg4O37Kn/ULJOgd8CisvGNzSJsKc
         huaQ==
X-Gm-Message-State: AOAM532VbA2hp0nduNDpkz3V2FKgM7L7nhGZIsilaAXoU7xzkBDNVdN1
        9r5QKX3Ss2TOJe6XUw/q46IJoZhxSygBuGgcv4Telw==
X-Google-Smtp-Source: ABdhPJwaet/7qh7P3/cOGkOSBU0hIIXn8bMXPi20tUK8LqcqnM9j7G+8VUNmDwoMOxA7S2FGsv5OFuXxIrc0KkKNK70=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr2796449vkk.6.1603973353739;
 Thu, 29 Oct 2020 05:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <1603936703-3403-1-git-send-email-rui_feng@realsil.com.cn>
In-Reply-To: <1603936703-3403-1-git-send-email-rui_feng@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Oct 2020 13:08:36 +0100
Message-ID: <CAPDyKFpRE8MgvffgVSKWnDMvT8k92Qxq28r8_BmryS9=J=vq=g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
To:     Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Oct 2020 at 02:58, <rui_feng@realsil.com.cn> wrote:
>
> From: Rui Feng <rui_feng@realsil.com.cn>
>
> RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follows.
> 1.RTS5261 work in SD mode and set MMC_CAPS2_SD_EXP flag.
> 2.If card is plugged in, Host send CMD8 to ask card's PCIe availability.
> 3.If the card has PCIe availability and WP is not set, init_sd_express() will be invoked,
> RTS5261 switch to PCIe/NVMe mode.
> 4.Mmc driver handover it to NVMe driver.
> 5.If card is unplugged, RTS5261 will switch to SD mode.
>
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>

I have applied the series for next, thanks!

Kind regards
Uffe


> ---
> v2:
> 1.re-enable mmc caps in sd_power_on()
> 2.don't check write protect bit in init_sd_express()
> v3:
> 1.add comment write protect switch is needed
> 2.add host->eject = true in the end of init_sd_express()
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 58 +++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2763a376b054..3b6474cce703 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -895,7 +895,9 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
>  static int sd_power_on(struct realtek_pci_sdmmc *host)
>  {
>         struct rtsx_pcr *pcr = host->pcr;
> +       struct mmc_host *mmc = host->mmc;
>         int err;
> +       u32 val;
>
>         if (host->power_state == SDMMC_POWER_ON)
>                 return 0;
> @@ -922,6 +924,21 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (err < 0)
>                 return err;
>
> +       if (PCI_PID(pcr) == PID_5261) {
> +               if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> +                       mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
> +               /*
> +                * HW read wp status when resuming from S3/S4,
> +                * and then picks SD legacy interface if it's set
> +                * in read-only mode.
> +                */
> +               val = rtsx_pci_readl(pcr, RTSX_BIPR);
> +               if (val & SD_WRITE_PROTECT) {
> +                       pcr->extra_caps &= ~EXTRA_CAPS_SD_EXPRESS;
> +                       mmc->caps2 &= ~(MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V);
> +               }
> +       }
> +
>         host->power_state = SDMMC_POWER_ON;
>         return 0;
>  }
> @@ -1308,6 +1325,44 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return err;
>  }
>
> +static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       u32 relink_time;
> +       struct realtek_pci_sdmmc *host = mmc_priv(mmc);
> +       struct rtsx_pcr *pcr = host->pcr;
> +
> +       /* Set relink_time for changing to PCIe card */
> +       relink_time = 0x8FFF;
> +
> +       rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
> +       rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >> 8);
> +       rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >> 16);
> +
> +       rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
> +       rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
> +               RTS5261_LDO1_OCP_THD_MASK,
> +               pcr->option.sd_800mA_ocp_thd);
> +
> +       if (pcr->ops->disable_auto_blink)
> +               pcr->ops->disable_auto_blink(pcr);
> +
> +       /* For PCIe/NVMe mode can't enter delink issue */
> +       pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
> +       rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
> +
> +       rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
> +               RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
> +       rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
> +               RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
> +       rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
> +               RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
> +               | RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
> +               RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
> +               | RTS5261_DRIVER_ENABLE_FW);
> +       host->eject = true;
> +       return 0;
> +}
> +
>  static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
>         .pre_req = sdmmc_pre_req,
>         .post_req = sdmmc_post_req,
> @@ -1317,6 +1372,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
>         .get_cd = sdmmc_get_cd,
>         .start_signal_voltage_switch = sdmmc_switch_voltage,
>         .execute_tuning = sdmmc_execute_tuning,
> +       .init_sd_express = sdmmc_init_sd_express,
>  };
>
>  static void init_extra_caps(struct realtek_pci_sdmmc *host)
> @@ -1338,6 +1394,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
>                 mmc->caps |= MMC_CAP_8_BIT_DATA;
>         if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
>                 mmc->caps2 |= MMC_CAP2_NO_MMC;
> +       if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> +               mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
>  }
>
>  static void realtek_init_host(struct realtek_pci_sdmmc *host)
> --
> 2.17.1
>
