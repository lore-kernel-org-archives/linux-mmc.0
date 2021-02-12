Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F4FC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 12:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C5864E2D
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBLMXB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Feb 2021 07:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhBLMVC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2021 07:21:02 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404DC06178B
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 04:20:46 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id q23so4692310vsg.4
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIB+VGSdD9YcsSCVUYBjeDlexutXyfRr+CUFNS7fmCM=;
        b=k+sBVjGyEc+DW0L+e1JJS+4pKlo2Sx5pn0dQ+r5aXueSE4tkEJDt1VSpjyCPXoi1Os
         CUsfQb6uUac3bxNQQki+hZAk+SQNR9QWjzl/e4mDW/d8LWd4tuyOLtSX2YhSXR6dcKhr
         mCeVBAhdsbklDH8bWYIgKtHQDEFsbsIK6QrcDPyBXmRPNRFQ4WSHkxEa46Cr64GybEmK
         84hAzfGvv/XZim7KCOPCY6aeujRj/bycx04qxrtCPitEHp/I6bHTOVaQrjNmjbpeKFaU
         ax9+CC0fYFkIGsaQ4HFHuRQnWLyZbR5PiOwMiSEAc9OS372CXzFnyen9P1LzV+l/IqwX
         LHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIB+VGSdD9YcsSCVUYBjeDlexutXyfRr+CUFNS7fmCM=;
        b=JvoawIE7JAK75S0Sv4pR703rcAqEVZyAUcIc+sv37FOy8P2FVJalx92JrzTutEOP4O
         ChKnRQb7C22Hx4md41ViOt1A/3vYqZbIWdKRN8AWwOu5Tjbi87Gvw2g3cKf3hhwbolN0
         knLMA00262JcyJ9aCh9iUWAP+Y050QaWG6M1PNYg/Lhr7Fi9Y/LvinSiQAS7mQ48j4Yg
         URrzU7H7XnM57iddvYuO0S9wA44WcUhHO4LUAS3tHS9TNoJ5rWIfd3f8wLNvbmhWcNtd
         FfLEOmp4nh69vqWVSGtW012PjXvUw0t4I919sZFHDMoLMeXE6vFTwDmBqkOjs3gPZvH3
         ezcQ==
X-Gm-Message-State: AOAM533wceOlq5yckx89g7U4lSC00hemys/EgMlojIEmAkVaRPJS4bqg
        kIyUHuyuvl6cCoJExURiXIPGSvT+NKc9sHV+UUWc2Q==
X-Google-Smtp-Source: ABdhPJwugF9nB4p2Ckla1hXyjm4O8jjX65retjJkhBc7IDqL2uvTxwtjriqS5gcdsynu44/YknLnMG8VBBUf1Q118EM=
X-Received: by 2002:a67:7d54:: with SMTP id y81mr1141836vsc.42.1613132445607;
 Fri, 12 Feb 2021 04:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20210206014051.3418-1-shirley.her@bayhubtech.com>
In-Reply-To: <20210206014051.3418-1-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Feb 2021 13:20:09 +0100
Message-ID: <CAPDyKFrMqkebCdH8ucOZOaMH0UPRxedkHr_Q6L=rqkFckGpZSQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Bug fix for SDR104 HW
 tuning failure
To:     Shirley Her <shirley.her@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 6 Feb 2021 at 02:40, Shirley Her <shirley.her@bayhubtech.com> wrote:
>
> Force chip enter L0 power state during SDR104 HW tuning to avoid tuning failure
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>

Applied for next, thanks!

Please tell, if you'd like me to tag this for stable?

Kind regards
Uffe


> ---
> change in V1:
> 1. Force chip enter L0 power mode before HW tuning
> 2. Cancel force chip enter L0 power mode after HW tuning
> ---
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index fa76748d8929..94e3f72f6405 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -33,6 +33,8 @@
>  #define O2_SD_ADMA2            0xE7
>  #define O2_SD_INF_MOD          0xF1
>  #define O2_SD_MISC_CTRL4       0xFC
> +#define O2_SD_MISC_CTRL                0x1C0
> +#define O2_SD_PWR_FORCE_L0     0x0002
>  #define O2_SD_TUNING_CTRL      0x300
>  #define O2_SD_PLL_SETTING      0x304
>  #define O2_SD_MISC_SETTING     0x308
> @@ -300,6 +302,8 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>         int current_bus_width = 0;
> +       u32 scratch32 = 0;
> +       u16 scratch = 0;
>
>         /*
>          * This handler only implements the eMMC tuning that is specific to
> @@ -312,6 +316,17 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
>                         (opcode != MMC_SEND_TUNING_BLOCK)))
>                 return -EINVAL;
> +
> +       /* Force power mode enter L0 */
> +       scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
> +       scratch |= O2_SD_PWR_FORCE_L0;
> +       sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
> +
> +       /* wait DLL lock, timeout value 5ms */
> +       if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
> +               scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
> +               pr_warn("%s: DLL can't lock in 5ms after force L0 during tuning.\n",
> +                               mmc_hostname(host->mmc));
>         /*
>          * Judge the tuning reason, whether caused by dll shift
>          * If cause by dll shift, should call sdhci_o2_dll_recovery
> @@ -344,6 +359,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 sdhci_set_bus_width(host, current_bus_width);
>         }
>
> +       /* Cancel force power mode enter L0 */
> +       scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
> +       scratch &= ~(O2_SD_PWR_FORCE_L0);
> +       sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
> +
>         sdhci_reset(host, SDHCI_RESET_CMD);
>         sdhci_reset(host, SDHCI_RESET_DATA);
>
> --
> 2.17.1
>
