Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B396DC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 12:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F65820724
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mz5FSaNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgHUMlB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHUMk5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 08:40:57 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A6C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 05:40:57 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id k1so372952vkb.7
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMe3GaCz74koTbzFXaGd+SXTXVqboKvgKZjJYCLAU5A=;
        b=mz5FSaNTjPUXLLXInAjZto1moLn/xGg/SwvxAdoj1J9YJtacjyqHWlUqxnv4L8Kvxt
         2cVVOFjh71kkC/eWpeIcxhKbivTxc5UT9wD8Zh09zbueNGgHVFPZkKtyplgw6Z39Mzqf
         zS4afzL7cDWMXmAF82vjQSu5dbWRQ/af6v08cxPyjDz5ibqmnh+Gz3Y5VIejt7D7/6ZI
         zEnZRQLjGJV+ELzqc8NL9NIz+swTPhpsFMomg7VB+1zVGLxxb7Jh7ag8IpNrfhy2sRh5
         LeIoMhN5rtZoHrh47X0ZJmv4m2JHhCX+QkYYb1mhFGol15GFxJEsgjT0KnOJ1y+giJs3
         TdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMe3GaCz74koTbzFXaGd+SXTXVqboKvgKZjJYCLAU5A=;
        b=Oi+ljDhaYBCT/+wsvAVLicZJ3R3cJXtsdTeU6zqEUCMfJOMdlwRAXjH3tvdufljP4/
         /JSOs3FTXJqrJL73rZFuE0nB5et8pYhsw1EI5po7j4Q1UIa2i7X+9G44cju+L8jZDZeK
         wPIuwTSiTfts2exfqrw4lU4P/vrNBx0hmAah+x9L+kJZXK8BrzTbPYY2rJWLlKrtyDKN
         RgivgBKT0xDMwNtJ2gdB3XGpYiaD/LT4B04uzbQz12w7Mf9rrQbTe7/LWy4v2yfqAwNc
         L/BUjybfwOT3PvjWBhkeZ1IqlCFdT72HbEP2qzFml6zpwqCvXlcsj6IDTkxfMnuNmN5f
         T5rw==
X-Gm-Message-State: AOAM533Q1nt5kLe4MBkayNdxDdHLs9XgxMf/h8ypDFWvWjbOXtfVNTCU
        s5+3xXUumqsUwAU03VcYjxFZbY5ZaROTH2er09fjgg==
X-Google-Smtp-Source: ABdhPJya7hF4BL83DBN15TXEO+qSOP1h3rpNJKwSa65uFIcWj0oJSzS7IQYtcbuJ64PBuSx6H2inSlXDdmh6XAmhczQ=
X-Received: by 2002:a1f:7c45:: with SMTP id x66mr1436137vkc.53.1598013656506;
 Fri, 21 Aug 2020 05:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
In-Reply-To: <20200716141534.30241-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 14:40:19 +0200
Message-ID: <CAPDyKFr5WQ1kpFguDe2e8G7t7p_99CFbqwRQFZPCSuMV2eYsMQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To:     Rui Feng <rui_feng@realsil.com.cn>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-nvme@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rui,

On Thu, 16 Jul 2020 at 16:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the SD specification v7.10 the SD express card has been added. This new
> type of removable SD card, can be managed via a PCIe/NVMe based interface,
> while also allowing backwards compatibility towards the legacy SD
> interface.
>
> To keep the backwards compatibility, it's required to start the
> initialization through the legacy SD interface. If it turns out that the
> mmc host and the SD card, both supports the PCIe/NVMe interface, then a
> switch should be allowed.
>
> Therefore, let's introduce some basic support for this type of SD cards to
> the mmc core. The mmc host, should set MMC_CAP2_SD_EXP if it supports this
> interface and MMC_CAP2_SD_EXP_1_2V, if also 1.2V is supported, as to inform
> the core about it.
>
> To deal with the switch to the PCIe/NVMe interface, the mmc host is
> required to implement a new host ops, ->init_sd_express(). Based on the
> initial communication between the host and the card, host->ios.timing is
> set to either MMC_TIMING_SD_EXP or MMC_TIMING_SD_EXP_1_2V, depending on if
> 1.2V is supported or not. In this way, the mmc host can check these values
> in its ->init_sd_express() ops, to know how to proceed with the handover.
>
> Note that, to manage card insert/removal, the mmc core sticks with using
> the ->get_cd() callback, which means it's the host's responsibility to make
> sure it provides valid data, even if the card may be managed by PCIe/NVMe
> at the moment. As long as the card seems to be present, the mmc core keeps
> the card powered on.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rui Feng <rui_feng@realsil.com.cn>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Rui, did you manage to get some time to look at $subject patch?

If you need some help to understand what's needed to implement the
corresponding support in drivers/mmc/host/rtsx_pci_sdmmc.c, then
please just ask.

I think it would make sense to queue changes for rtsx_pci at the same
point as the mmc core changes. That's because I don't want to maintain
code in the mmc core that's left unused.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c   | 15 ++++++++++--
>  drivers/mmc/core/host.h   |  6 +++++
>  drivers/mmc/core/sd_ops.c | 49 +++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/sd_ops.h |  1 +
>  include/linux/mmc/host.h  |  7 ++++++
>  5 files changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8ccae6452b9c..6673c0f33cc7 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2137,8 +2137,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>
>         mmc_go_idle(host);
>
> -       if (!(host->caps2 & MMC_CAP2_NO_SD))
> -               mmc_send_if_cond(host, host->ocr_avail);
> +       if (!(host->caps2 & MMC_CAP2_NO_SD)) {
> +               if (mmc_send_if_cond_pcie(host, host->ocr_avail))
> +                       goto out;
> +               if (mmc_card_sd_express(host))
> +                       return 0;
> +       }
>
>         /* Order's important: probe SDIO, then SD, then MMC */
>         if (!(host->caps2 & MMC_CAP2_NO_SDIO))
> @@ -2153,6 +2157,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>                 if (!mmc_attach_mmc(host))
>                         return 0;
>
> +out:
>         mmc_power_off(host);
>         return -EIO;
>  }
> @@ -2280,6 +2285,12 @@ void mmc_rescan(struct work_struct *work)
>                 goto out;
>         }
>
> +       /* If an SD express card is present, then leave it as is. */
> +       if (mmc_card_sd_express(host)) {
> +               mmc_release_host(host);
> +               goto out;
> +       }
> +
>         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
>                 unsigned int freq = freqs[i];
>                 if (freq > host->f_max) {
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 5e3b9534ffb2..ba407617ed23 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -77,5 +77,11 @@ static inline bool mmc_card_hs400es(struct mmc_card *card)
>         return card->host->ios.enhanced_strobe;
>  }
>
> +static inline bool mmc_card_sd_express(struct mmc_host *host)
> +{
> +       return host->ios.timing == MMC_TIMING_SD_EXP ||
> +               host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
> +}
> +
>  #endif
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 22bf528294b9..d61ff811218c 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -158,7 +158,8 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         return err;
>  }
>
> -int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
> +static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
> +                             u32 *resp)
>  {
>         struct mmc_command cmd = {};
>         int err;
> @@ -171,7 +172,7 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
>          * SD 1.0 cards.
>          */
>         cmd.opcode = SD_SEND_IF_COND;
> -       cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
> +       cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | pcie_bits << 8 | test_pattern;
>         cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 | MMC_CMD_BCR;
>
>         err = mmc_wait_for_cmd(host, &cmd, 0);
> @@ -186,6 +187,50 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
>         if (result_pattern != test_pattern)
>                 return -EIO;
>
> +       if (resp)
> +               *resp = cmd.resp[0];
> +
> +       return 0;
> +}
> +
> +int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
> +{
> +       return __mmc_send_if_cond(host, ocr, 0, NULL);
> +}
> +
> +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr)
> +{
> +       u32 resp = 0;
> +       u8 pcie_bits = 0;
> +       int ret;
> +
> +       if (host->caps2 & MMC_CAP2_SD_EXP) {
> +               /* Probe card for SD express support via PCIe. */
> +               pcie_bits = 0x10;
> +               if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> +                       /* Probe also for 1.2V support. */
> +                       pcie_bits = 0x30;
> +       }
> +
> +       ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> +       if (ret)
> +               return 0;
> +
> +       /* Continue with the SD express init, if the card supports it. */
> +       resp &= 0x3000;
> +       if (pcie_bits && resp) {
> +               if (resp == 0x3000)
> +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> +               else
> +                       host->ios.timing = MMC_TIMING_SD_EXP;
> +
> +               /*
> +                * According to the spec the clock shall also be gated, but
> +                * let's leave this to the host driver for more flexibility.
> +                */
> +               return host->ops->init_sd_express(host, &host->ios);
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 2194cabfcfc5..3ba7b3cf4652 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -16,6 +16,7 @@ struct mmc_host;
>  int mmc_app_set_bus_width(struct mmc_card *card, int width);
>  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
>  int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
> +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
>  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
>  int mmc_app_send_scr(struct mmc_card *card);
>  int mmc_sd_switch(struct mmc_card *card, int mode, int group,
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c5b6e97cb21a..905cddc5e6f3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -60,6 +60,8 @@ struct mmc_ios {
>  #define MMC_TIMING_MMC_DDR52   8
>  #define MMC_TIMING_MMC_HS200   9
>  #define MMC_TIMING_MMC_HS400   10
> +#define MMC_TIMING_SD_EXP      11
> +#define MMC_TIMING_SD_EXP_1_2V 12
>
>         unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
>
> @@ -172,6 +174,9 @@ struct mmc_host_ops {
>          */
>         int     (*multi_io_quirk)(struct mmc_card *card,
>                                   unsigned int direction, int blk_size);
> +
> +       /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
> +       int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
>  };
>
>  struct mmc_cqe_ops {
> @@ -357,6 +362,8 @@ struct mmc_host {
>  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can support */
>  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
>                                  MMC_CAP2_HS200_1_2V_SDR)
> +#define MMC_CAP2_SD_EXP                (1 << 7)        /* SD express via PCIe */
> +#define MMC_CAP2_SD_EXP_1_2V   (1 << 8)        /* SD express 1.2V */
>  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /* Card-detect signal active high */
>  #define MMC_CAP2_RO_ACTIVE_HIGH        (1 << 11)       /* Write-protect signal active high */
>  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power up before scan */
> --
> 2.20.1
>
