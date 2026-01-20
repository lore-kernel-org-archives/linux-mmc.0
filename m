Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A67348880
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912955; cv=pass; b=h4hK2tZEqhXS97/W+nB0MW5Cwa/GxYxmiNkm4NOqWQgd/kNDNXaVMHd3mLKIjnmBKdm3YlL2iIIYRA0STsG9ENRyiAA4Ls9qfSUCA8PautA2OXtGPEVYPwuj2Wr7jw/jxTjHbJ1AXpkrIzUHLv4VNEC/o92vWzYK+6k5cDmzLnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912955; c=relaxed/simple;
	bh=clkBESV4MDeKOLLbwNvkp78gIZ6ybwWljESRVAiNDR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzVnwiXXobbwrlahc1FxTDHzgFxuqjAREaiGXa36Dnw8XAMhz6MULH2MVmALYqajUw5htAT9llLWnU5oFdIn+mWjUBXgYAmeZbN8zHL26ZId3Cuu877txn9GIf2kijpUA5jmr5UUp266RLZrBP6Wl2+N3lHFeKwqOVX0lCcZS+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3G2/DH+; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3G2/DH+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b6f52eea8so4561112e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 04:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768912952; cv=none;
        d=google.com; s=arc-20240605;
        b=IqTc1SVEtHNlKvElP7PYdvzUWxnZWKrQRnT65sEsZpmOk5XskaFZi2YLmuKzy2HeE4
         r7wZiZvVhTCdooAEa8xheQiKvTPG/54C4nS6mzbHFNLYGO9x0ySU/tU8ETeY/CDRLvDw
         63niq024317JVBngmhsmtzhW1NvcFJ99Psr6OdnNaxrlEgrc0LrVS+VwAG9RMW9GdaGz
         6xxPJFfSlSy20iXud43bsi3qP/gS22k31tRKM7Kk75E+fHpHQLOf+fhtbHkhzP04brbs
         Hz70b1c5vBHba71QH07AKo/akXOyDL5nFeLNxIURrLaUbr5uF+gx/aedZuAYR9LiYmC7
         OzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6VtH/t2SHJW6ad92CXFBwlf8bDn+JkPfYF6ZcZddAoQ=;
        fh=ffSzmYZb9M+RcHlLdFwoxjyFg+pDfLKcl2zeM6cdL10=;
        b=c1Dzv4CiU9xgKZIbiWX8Wwpn8ltfFR2wZFLjFlurXZ1cETHafqTFiLca+DJkNRH200
         hn1wHnmL0KDcJsU4gaWp0lOUlv7V8sArG3nWZi5BMNLvfJl0DhBaYR0zflk9q1wkID2O
         1aACAsB0xT7cO9LgdzLtuk641iRSEEFerGr6iiKI8n81JwB55kxVrHrU6WP0AOHzbrUM
         sA/iM/bMisHIy1EllYtu4ru7z0gm4H0p/35BUXVpTs5qi27Jur70TVZcTX87o98pX3Bm
         12F0Qei9eCBZt1ZUGTTm7CqCRSHl9rCfhEkU5wzFO7PRRboROp5IqkyxoivN2jZ3bKGK
         Xy2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768912952; x=1769517752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6VtH/t2SHJW6ad92CXFBwlf8bDn+JkPfYF6ZcZddAoQ=;
        b=C3G2/DH+2CQ1BflVBqbpmxsy+RnWDNdItq9R+9kFiT3QRlQ8RC+nApLiJ8Wvd/kwJL
         y7Ob5logoL5SCm4A4QjXaedcRTpL2z4DmXDtQuazvzAfDaf5Q0STKkn+aK3krDoEpJw5
         up7Qspd+UwrbXKEvBcU7ENEtPdaj6xiHuaPGzHTkUybru0lwudRVQrZ+alT3fJ0P275+
         uXTxKkqNhvALygskTr9Gt3L9cXTZQz9GvSIrjW2caHVqzNcZWP6+Nf9f6UcOxPaO3Fei
         VUNk+DWKJ/jcvYgASyO52DIb2d+Va9bs551CKgyKJ3hU9xfWpCmSpaVdGOQc0gpLUZ4o
         zoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912952; x=1769517752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VtH/t2SHJW6ad92CXFBwlf8bDn+JkPfYF6ZcZddAoQ=;
        b=LN9V4B/xAhdfPdXH2NMRJ9rZxN0kGUvgVVGydCHzRpwsELXBtVG7ZpcpVnq4GdauWH
         fxF/CgKLK11xM6JQItBQDsjNy7z4UopdBRW9oxwWDh9d7ZbsXxVCJ0hsz45Jilkep1JY
         KGeGZaiD0aG1KKZhPRCdC0/5K6R08xn16wlSo0x46hv6OCEArJ6MoqKmlLGOTVDdYdHc
         pzx1FN3+ubvErkny46qBhhZTvZJjkdVI8AXEZVGULFRsbEUslda2m5b4o8fLDvhY7mb/
         1TpH9WSROMO3nX8Unmb2zgCTn866vygsqAmuvf8IkCvGA0Kh7/GWlGZ7c/yXuKMX960Y
         Ss3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX03AKOQoa6kttrj423VYqUm44hyI9bFnBUu/Uazi1YZr5rHYqcBcdesHq0MswP5PdynTjuErOTjmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKgw0BbyVHp6XbdXk4hQ+5wPWIxr/IxM6bDN8OG1hxtij4yXK
	4h+dRntvFMD5vWQeUYBzLvfdiKNtpEuadABYXDOxrky3OUdxqxTCE3/DbdsKHpeuHFt66daenqB
	+ud7sLVnASja2Ool4i3/zCWW+jmhAUNtenbZfwi2rZA==
X-Gm-Gg: AZuq6aIfT3c/W/pUzGXxW/0ChVGs9zS9AVm402yW2Zk9ztaOnsn56dlkcnu7AUtwTus
	VLOAccNyDr6LotKGT9o0NZjuQioT/3Z+6EVDKM2kSVhsTVZ/71RpwEt0HUyQnD5iV7/SQ8ERWLp
	XuTeK0OWomQzLklyk+0/HMm7kDupJggCVoBqLwXToUsMJVd1iCmeB97I33Xi/3IAVdcR5VZBrEE
	Tuc1WPzPaA37V2cBddhbeb3cVx8DsvRCZ3/YfxwBQIz7SIdO5fL9LFETD8ARSqdqIOC4SQ=
X-Received: by 2002:a05:6512:33ca:b0:59b:b0ca:67d9 with SMTP id
 2adb3069b0e04-59bb0ca67eamr4779900e87.33.1768912951746; Tue, 20 Jan 2026
 04:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105060236.400366-1-matthew.schwartz@linux.dev> <20260105060236.400366-2-matthew.schwartz@linux.dev>
In-Reply-To: <20260105060236.400366-2-matthew.schwartz@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2026 13:41:55 +0100
X-Gm-Features: AZwV_QgEaxCjddYws5YuT_xZWjSe1SFVe9Q3YEAJT8k06bPtD1FXOWjROtl_XsQ
Message-ID: <CAPDyKFo-2TcU6MPZpeEU7kPx4tOLG4ekEFyZnzy1qeH09MTNfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rtsx: reset power state on suspend
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 07:02, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> When rtsx_pci suspends, the card reader hardware powers off but the sdmmc
> driver's prev_power_state remains as MMC_POWER_ON. This causes sd_power_on
> to skip reinitialization on the next I/O request, leading to DMA transfer
> timeouts and errors on resume 20% of the time.

The mmc core should power-off the card, via the ->set_ios() callback
before the rtsx_pci suspends. In other words, the mmc core should have
set MMC_POWER_OFF.

That said, there seems to be something wrong in
drivers/mmc/host/rtsx_pci_sdmmc.c's ->set_ios(), if that isn't tracked
correctly. The parent device/driver, rtsx_pci should not need to
inform that the power to the card is removed, as that should be known
already by the rtsx_pci_sdmmc driver.

>
> Add a power_off slot callback so the PCR can notify the sdmmc driver
> during suspend. The sdmmc driver resets prev_power_state, and sd_request
> checks this to reinitialize the card before the next I/O.
>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 22 ++++++++++++++++++++++
>  include/linux/rtsx_common.h        |  1 +
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index f9952d76d6ed..f1f4d8ed544d 100644
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
> index 792ebae46697..74ee8623ad4e 100644
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
> @@ -1524,6 +1534,16 @@ static void rtsx_pci_sdmmc_card_event(struct platform_device *pdev)
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
> @@ -1556,6 +1576,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, host);
>         pcr->slots[RTSX_SD_CARD].p_dev = pdev;
>         pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
> +       pcr->slots[RTSX_SD_CARD].power_off = rtsx_pci_sdmmc_power_off;
>
>         mutex_init(&host->host_mutex);
>
> @@ -1587,6 +1608,7 @@ static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
>         pcr = host->pcr;
>         pcr->slots[RTSX_SD_CARD].p_dev = NULL;
>         pcr->slots[RTSX_SD_CARD].card_event = NULL;
> +       pcr->slots[RTSX_SD_CARD].power_off = NULL;
>         mmc = host->mmc;
>
>         cancel_work_sync(&host->work);
> diff --git a/include/linux/rtsx_common.h b/include/linux/rtsx_common.h
> index da9c8c6b5d50..f294f478f0c0 100644
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
> 2.52.0
>

Kind regards
Uffe
