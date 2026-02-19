Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F5F2E7F3A
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496895; cv=pass; b=p0shSlfDEDRoXLtqqyCiMCJbdHDYiGb87cML8B6OGRi/S749kWQdqvqLrE726y6O3rppRxmcZuElHni2HfcY+P65OGvEJ2AhQa+JBm+GXIpnXAknbnki5it6FjD/3PaDiFwbaJordGjhvilDqzaU6mdi6kys+9jMZ+OfyAAScmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496895; c=relaxed/simple;
	bh=yeb/Dd5E4D0X31B91iyaLgNPgCIVv+7nFwkHl27wCJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmOgU3AY8ezEyb8kokWQPTPOxkMyZ+JYuO7qD+3tTuH1w7XfHAT9hfDfplYaUbbidpJfykL5s6MFr/hS8NnBAAidzbPaLK6Mnd+EbFjOUsI1GVpfmM2A6PCTcndWYVFmqoHEJMpOi6F1A4INHZ5xjkVoNWxQPAVBoQQJ8a/pD40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxvYAyOW; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxvYAyOW"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59f791a6e67so1576853e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 02:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771496892; cv=none;
        d=google.com; s=arc-20240605;
        b=jUyyGJnDY3y7rctBL/MfcFcVE6MgoEU66RxAf7B/JDGm55t1wi4VQrSKFwofR1vFhz
         b13mmaD6kKw72nZf7eMqFGBSh1ts7n8Bt9hiVMXwx8/P5Qgj40bJKxAuxmc7LQnSIRBc
         9nl6gk4S1LWGkpbOV5H/wxzG9edpBgdL6BGDCKL0vcBSYI2jp7PT1H2ySP4DASRPrnRa
         71UIk46qOXQ2xWvN0JyTLP+X+MLeRoSwHF/1BpX0mUaOCrN/zzgD5Y5sapecc7DOT+og
         4JFqzVN77QweYcUQIEki8LahSk6rCsa7VLfSzKUY+HF3SX9NnkKH5MxIIfxYwh/xw1U9
         M+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+iidJu0huUqKKe3pZdrr+tUIy4vm9ssv3UJXtJdVIbU=;
        fh=/fiC6kpKf9Q7owHiMzLmoiHJ7hY79pp6W1b1vrzh7gI=;
        b=Dmm9f3k8O4pdbeobIdXPvcCOe4de1uMjjROd/sbF//dnHVCPK/vGpCqME8xBw4P2iX
         ky0HQDg+YrP7PmNS3wHm8zuI2rnUAlW4rapFaWVP/Ju0CfI7zT5MLANy82Fwn6FU2uW1
         PZGXZ8Q86GjIMPrtuqNijydN9p0aiovf5aexXjeUGDJBcXyata9HzQZsEIAITavfRK4J
         bLMM/PuHPX+JebGu7n7CsVRMohlRpSCu7d6oFEEy+YZgID+Z0NfQ/7lTu30kJBFDkavA
         +memxK8IWhUCB40yGRV8wqoSw/RQZ++qY9fl/VKsP/w5fdvU8ZC6W9vNVBgQ4yhmlxZv
         brBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771496892; x=1772101692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+iidJu0huUqKKe3pZdrr+tUIy4vm9ssv3UJXtJdVIbU=;
        b=kxvYAyOW4F1yVwnZI7gRL1LAJL5lvjJFcXvt63g3vn6YQONjek8CluIgi5sJ6DKDV6
         kva5RWzmvr2EqclKS2De1r/96SHXH/UX+tTXOeAGy2jAKJ+aLodN42zjz3jjzUGEhA+Z
         9ykBZpmeS0hBHG+S+ChbPNuMFITVFcWbe3cxSTvvp2xAIWtopG0CehiRwkYxvnAeW0SW
         hJOtJ6haEUNIuFQgt6iejDgDp46KA7RF/+bJaPTf+9DrbKJz+qDToP0ocPV3vp5swYT2
         VQ5F7H6jWw4uSGPMzO+pGh04R23bLLgR24ue/7vzFCDU8DE85o1idsjrCTWHTnDOx+8u
         9ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771496892; x=1772101692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iidJu0huUqKKe3pZdrr+tUIy4vm9ssv3UJXtJdVIbU=;
        b=TgnNxeqHEmE/4wj8WQQMd6UpRfphy8DPZrBoZ3x0WUtFWcSX/aHjmUNmAojv2POUxw
         Z9TnenhKFiuuTWhGaQlNZzI/RWF5skSajTI4P6L3G3vXsSl0D2Itb6SgQej2ed6ont1m
         e+mcrR3awV5tuA8VJZ58vKIdeHze4Jq4Zl1R0yjxZimRYoO6mlUs8wtJg8Z/2a9hTJNA
         rzCFohtpa+F1cfAcU71UOOGQhOjIyWKGvcB1mFAJrkJn8qBwuanBYMT3q11Q2TmZiJD/
         UERyaBk5x6as2y4GR9vHG9uPU8Cg2LwoLGfs8qGbN91uCWrqBHbGR1YTb47nywmBI5fA
         +58Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz3yqFGNTQkItYszfJ9UNwhZtCg4Tt/UV96vq4ePWpRxUJiEwqRTWHVjpYn2ABPzeJAx7a8TC8Jr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XjPUVhjRF2Jp+Hh8ecPHyeVydcS3wsuXYunrgYlUTFoVOUAZ
	L21s3cDj0nLpgHCVrSNnqroSPYu+et7EkBmn6L9HHiHSOzuxFhcxbb9vZc9lBxFYyLX8gv2CGNp
	PO17ygluT/ve+J9HbYjx+u1fYyrCmLDL3Ty3Wxw7wZA==
X-Gm-Gg: AZuq6aJKkWMmu9dLAsp7xWqBHj5UtPEDdEKz45GtEOtBAcUocjqNFSFG4TTQ0SK+u45
	b5tYT+HT0kGkQbLl67X4iCGFb6bNPOC6EVpkubOyCs8GuOi1XGtxqUc5iPkzFB6k5VygsxdweYT
	d9ZcFhrDHJrk2yoy58Yr0VY4H+1M03CAu+ef9Yw7to7iF2ZMc35fpSFQLPFVaQhIihIgAnuqjip
	q0stTKxKq1tWwUef2YSyHgFyFIpIX+Y0unwmUqtD6RqYZinHgYvxyALpxMckvxRx6BoE7QwPtl9
	fpKJPUPt
X-Received: by 2002:ac2:4bc8:0:b0:59e:6bbd:1ab7 with SMTP id
 2adb3069b0e04-59f8b41f3aamr479369e87.2.1771496891642; Thu, 19 Feb 2026
 02:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219020422.1539798-1-sashal@kernel.org> <20260219020422.1539798-17-sashal@kernel.org>
In-Reply-To: <20260219020422.1539798-17-sashal@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Feb 2026 11:27:35 +0100
X-Gm-Features: AaiRm525_UCzJlSuHNcErGCp6LRaRr1GEnHg4lhcONksOk-A7hoEj7ZvFLCDJx4
Message-ID: <CAPDyKFoPehkeOD1-U2CGd_1Owt2Ai6+28Epabz6wGnYVq6k=YA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-6.1] mmc: rtsx: reset power state on suspend
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Feb 2026 at 03:04, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Matthew Schwartz <matthew.schwartz@linux.dev>
>
> [ Upstream commit eac85fbd0867c25ac517f58fae401d65c627edff ]
>
> When rtsx_pci suspends, the card reader hardware powers off but the sdmmc
> driver's prev_power_state remains as MMC_POWER_ON. This causes sd_power_on
> to skip reinitialization on the next I/O request, leading to DMA transfer
> timeouts and errors on resume 20% of the time.
>
> Add a power_off slot callback so the PCR can notify the sdmmc driver
> during suspend. The sdmmc driver resets prev_power_state, and sd_request
> checks this to reinitialize the card before the next I/O.
>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Link: https://patch.msgid.link/20260105060236.400366-2-matthew.schwartz@linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

NAK.

This patch is reverted in mainline, as it's not the proper fix.

See commit c23f0550c05d40762b141808709667759291c938

Kind regards
Uffe

> ---
>
> LLM Generated explanations, may be completely bogus:
>
> Good - `sd_power_on` has been part of this file since initial creation.
> The forward declaration added in the patch is just to allow the function
> (defined later in the file) to be called from `sd_request` (defined
> earlier).
>
> ### Analysis Summary
>
> **What problem the commit solves:**
>
> This commit fixes a suspend/resume regression in Realtek PCI-E SD card
> readers where, after suspend, 20% of resume attempts fail with DMA
> transfer timeouts because:
>
> 1. During suspend, `rtsx_pci_power_off()` powers down the card reader
>    hardware
> 2. But the sdmmc driver's `prev_power_state` remains `MMC_POWER_ON`
> 3. On resume, when `sd_power_on()` is called, it sees `prev_power_state
>    == MMC_POWER_ON` at line 912 and returns immediately without
>    reinitializing the hardware
> 4. The first I/O attempt then fails with DMA timeout because the
>    hardware was never re-powered
>
> **The fix has three parts:**
> 1. Adds a `power_off` callback to `struct rtsx_slot` (1 line in header)
> 2. In the PCR suspend paths (both system and runtime), calls
>    `slot->power_off()` to notify the sdmmc driver before powering off
>    hardware
> 3. In the sdmmc driver: implements `rtsx_pci_sdmmc_power_off()` to reset
>    `prev_power_state = MMC_POWER_OFF`, and adds a check in
>    `sd_request()` to call `sd_power_on()` if `prev_power_state ==
>    MMC_POWER_OFF`
>
> **Stable kernel criteria assessment:**
> - **Fixes a real bug:** Yes - 20% failure rate on resume with SD card
>   operations
> - **Obviously correct:** Yes - the logic is straightforward: notify the
>   driver that hardware was powered off so it reinitializes properly
> - **Small and contained:** Yes - 32 lines of insertion across 3 files,
>   all within the rtsx subsystem
> - **No new features:** Correct - this adds only internal plumbing to fix
>   power state tracking
> - **Tested:** Author tested 300+ s2idle cycles
> - **Impact:** Users with Realtek card readers experience I/O errors,
>   filesystem journal failures, and card detection loss after
>   suspend/resume
>
> **Risk assessment:**
> - Low risk - the changes are confined to the rtsx card reader subsystem
> - The `power_off` callback is properly guarded with NULL checks (`if
>   (slot->p_dev && slot->power_off)`)
> - The `sd_request` power-on check has proper error handling
> - The drv_remove function properly clears the callback
> - No impact on other subsystems
>
> **Dependencies:**
> - Self-contained - no dependencies on other commits
> - The companion delay patch (aced969e9bf37) has already been selected
>   for stable and is independent
> - The code being modified (`rtsx_slot`, `rtsx_pci_suspend`,
>   `sd_request`) exists in all recent stable trees
>
> ### Verification
>
> - **Verified** that `sd_power_on()` at line 912 returns early when
>   `prev_power_state == MMC_POWER_ON`, confirming the bug mechanism
> - **Verified** via `git show aced969e9bf37` that the companion patch
>   (delay increase) has a Fixes: tag and was independently picked for
>   stable
> - **Verified** via `git show ed0d7f8559dbd` (stable branch version) that
>   the delay patch was already applied to stable with `[Upstream commit
>   ...]` marker
> - **Verified** via lore.kernel.org that this is a 2-patch series (0/2
>   cover letter), both fixing suspend/resume failures, with testing
>   showing patch 1 reduces failures from 20% to 4%
> - **Verified** that `struct rtsx_slot` currently only has `p_dev` and
>   `card_event` fields by reading `include/linux/rtsx_common.h`
> - **Verified** that the suspend paths properly hold `pcr->pcr_mutex`
>   when calling the callback
> - **Verified** the NULL check guards (`slot->p_dev && slot->power_off`)
>   in both suspend functions
> - **Verified** that `sd_power_on()` has existed since the driver was
>   created (`ff984e57d36e8`) - the forward declaration is just for
>   compilation order
> - **Verified** that `rtsx_pci_sdmmc_drv_remove` properly clears
>   `power_off = NULL` to prevent stale callbacks
>
> This is a clear, well-tested bug fix for a user-impactful suspend/resume
> issue. It's small, contained, properly guarded, and fixes a 20% failure
> rate. It meets all stable kernel criteria.
>
> **YES**
>
>  drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 22 ++++++++++++++++++++++
>  include/linux/rtsx_common.h        |  1 +
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index f9952d76d6ed7..f1f4d8ed544d6 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1654,6 +1654,7 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
>         struct pci_dev *pcidev = to_pci_dev(dev_d);
>         struct pcr_handle *handle = pci_get_drvdata(pcidev);
>         struct rtsx_pcr *pcr = handle->pcr;
> +       struct rtsx_slot *slot = &pcr->slots[RTSX_SD_CARD];
>
>         dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
>
> @@ -1661,6 +1662,9 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
>
>         mutex_lock(&pcr->pcr_mutex);
>
> +       if (slot->p_dev && slot->power_off)
> +               slot->power_off(slot->p_dev);
> +
>         rtsx_pci_power_off(pcr, HOST_ENTER_S3, false);
>
>         mutex_unlock(&pcr->pcr_mutex);
> @@ -1772,12 +1776,17 @@ static int rtsx_pci_runtime_suspend(struct device *device)
>         struct pci_dev *pcidev = to_pci_dev(device);
>         struct pcr_handle *handle = pci_get_drvdata(pcidev);
>         struct rtsx_pcr *pcr = handle->pcr;
> +       struct rtsx_slot *slot = &pcr->slots[RTSX_SD_CARD];
>
>         dev_dbg(device, "--> %s\n", __func__);
>
>         cancel_delayed_work_sync(&pcr->carddet_work);
>
>         mutex_lock(&pcr->pcr_mutex);
> +
> +       if (slot->p_dev && slot->power_off)
> +               slot->power_off(slot->p_dev);
> +
>         rtsx_pci_power_off(pcr, HOST_ENTER_S3, true);
>
>         mutex_unlock(&pcr->pcr_mutex);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 8df60000b5b41..34343b5d5823d 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -47,6 +47,7 @@ struct realtek_pci_sdmmc {
>  };
>
>  static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios);
> +static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode);
>
>  static inline struct device *sdmmc_dev(struct realtek_pci_sdmmc *host)
>  {
> @@ -821,6 +822,15 @@ static void sd_request(struct work_struct *work)
>
>         rtsx_pci_start_run(pcr);
>
> +       if (host->prev_power_state == MMC_POWER_OFF) {
> +               err = sd_power_on(host, MMC_POWER_ON);
> +               if (err) {
> +                       cmd->error = err;
> +                       mutex_unlock(&pcr->pcr_mutex);
> +                       goto finish;
> +               }
> +       }
> +
>         rtsx_pci_switch_clock(pcr, host->clock, host->ssc_depth,
>                         host->initial_mode, host->double_clk, host->vpclk);
>         rtsx_pci_write_register(pcr, CARD_SELECT, 0x07, SD_MOD_SEL);
> @@ -1522,6 +1532,16 @@ static void rtsx_pci_sdmmc_card_event(struct platform_device *pdev)
>         mmc_detect_change(host->mmc, 0);
>  }
>
> +static void rtsx_pci_sdmmc_power_off(struct platform_device *pdev)
> +{
> +       struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
> +
> +       if (!host)
> +               return;
> +
> +       host->prev_power_state = MMC_POWER_OFF;
> +}
> +
>  static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
> @@ -1554,6 +1574,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, host);
>         pcr->slots[RTSX_SD_CARD].p_dev = pdev;
>         pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
> +       pcr->slots[RTSX_SD_CARD].power_off = rtsx_pci_sdmmc_power_off;
>
>         mutex_init(&host->host_mutex);
>
> @@ -1585,6 +1606,7 @@ static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
>         pcr = host->pcr;
>         pcr->slots[RTSX_SD_CARD].p_dev = NULL;
>         pcr->slots[RTSX_SD_CARD].card_event = NULL;
> +       pcr->slots[RTSX_SD_CARD].power_off = NULL;
>         mmc = host->mmc;
>
>         cancel_work_sync(&host->work);
> diff --git a/include/linux/rtsx_common.h b/include/linux/rtsx_common.h
> index da9c8c6b5d50f..f294f478f0c0e 100644
> --- a/include/linux/rtsx_common.h
> +++ b/include/linux/rtsx_common.h
> @@ -32,6 +32,7 @@ struct platform_device;
>  struct rtsx_slot {
>         struct platform_device  *p_dev;
>         void                    (*card_event)(struct platform_device *p_dev);
> +       void                    (*power_off)(struct platform_device *p_dev);
>  };
>
>  #endif
> --
> 2.51.0
>
