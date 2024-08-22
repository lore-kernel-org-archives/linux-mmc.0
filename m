Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFB1C93C1
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327085; cv=none; b=SA/xXnyRF4GTd5uSvgGIOdE69jC4qi3sqyGGZ3CnrSxzeamRE5u1wCbCETfhVvZ992Aywsw4gribcEcEt45b7W6eWO/9N5jctEElg30YGmH/598OoT89L8KoMKwNPvzQMLpo7u8O3JT+vC2p15rnaYv9e1RZ1NwaHHIQyMz5yHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327085; c=relaxed/simple;
	bh=gTzod1NFDgavqdlrkNheVNWG0ROy4bOjgIXDZ7oBJBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXio+pw2zuGLaYcSq28o7vBhUFPHHBE/KtK9JXuRf5DlrtDAR2zHY+0yQAAq96if6vb8QF7UQ0Sz9Z0jS0RMky0gt/jkIaZLnvpN/T2lZ/MNPKE20FaPSnLglEkHA5tfJP1El+RxxuAy/gTLj7RdErRGCuspN+2DJnxc7DRwUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYnRRWg8; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYnRRWg8"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso779731276.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724327083; x=1724931883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQocSjxpUNNaR2zViL94qKHDra6Wy46rXDGl4DKLmwU=;
        b=QYnRRWg8gme8JIi5olXn/XrJhdE1eEx/1eyDGtL3stt53SlM31BtoAM3KtKysDiC2S
         v5J7uSoGDtoDaYOntrFdFilRe371ldZbRNWFsnFbQDDSqvY0jm6OaDIlyi3oQIJGAEOu
         QLvjWQYIyRt6SxvvN0tEXFQ+jRfxxk9GzUSGRDskMjTkaEo1nqu4lNbKB1QtNKJNHApn
         0//bVwatzhe7qGgeo5ldI0H1vjZVXa53E//MNk3NLrptlW3z2Annpz0lk8i5cZ/WXRuc
         mSfb/jaKLpe+k3+h6XfxX4X8MftwoKEQv37pWH/RUOPQQz40AZT8o3P6S9OIJOeCam3S
         1v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327083; x=1724931883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQocSjxpUNNaR2zViL94qKHDra6Wy46rXDGl4DKLmwU=;
        b=WZy5/Vq9BTsfopNhdjK7FibtnKYKUaoAPtWwFUJgIFW53k2yr0Ue9O6BwbQ7vgL3E+
         6T3D3BDkXvWuhewDkt1SaIPJfL9ncl8UTVApBcqO0vQRcJGQLnz3v5R2od0E1oLVGwL8
         +Ur2/ZhA+a0MmVm8RIOEprooJ5vHroPnKHvG0qu6y1iSp6PVIJE9CplHcImUX6mMB4za
         cAl8DKrAl3/mnhMNdsSQxjGfo4iza9ngi3e48Ww1MPpC7YRoznWuWbEhpylrWrAnyk/q
         m53psgeKExz5NmvuTa5fzdLCFhzKdQ3WgFW7FySfU1htJM3LrXV91e7sygBcVizPUXWh
         CIdw==
X-Gm-Message-State: AOJu0Yx/t0keGEKnYGHU9vedsh/XqnJ/Z6xDAv+xM4GTrEbHA84eTKdx
	HHJS4pozGaYzyn14mSaM7L0lcvO3SShnyI00BL4ErJvE0/wJTAuzt/naqFnIjjShxKn7vnFyZPJ
	T7yrwMmYZFMHjbB3T7pJ2xkgbYsuIXYiW5sQ1RAgMMfODysZRdSA=
X-Google-Smtp-Source: AGHT+IH+8xuuhtdKdznLs9LugO52fnVwQQcBbdxaWm/cXL+BuHeomvW9Dzi4UwoCw93FIdQDFJi8t4zI3R2EMqmFvY8=
X-Received: by 2002:a05:6902:1021:b0:e11:7ecc:3b1b with SMTP id
 3f1490d57ef6-e17902d48cfmr2155521276.14.1724327082645; Thu, 22 Aug 2024
 04:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-2-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-2-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 13:44:06 +0200
Message-ID: <CAPDyKFqafoeiBSAbU30d0jMUJPHvED3Z7khz6rqpn_NAgYurDw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mmc: sd: SDUC Support Recognition
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
>
> ACMD41 was extended to support the host-card handshake during
> initialization.  The card expects that the HCS & HO2T bits to be set in
> the command argument, and sets the applicable bits in the R3 returned
> response.  On the contrary, if a SDUC card is inserted to a
> non-supporting host, it will never respond to this ACMD41 until
> eventually, the host will timed out and give up.
>
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd_ops.c | 19 +++++++++++++++----
>  include/linux/mmc/host.h  |  6 ++++++
>  include/linux/mmc/sd.h    |  1 +
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 8b9b34286ef3..7f6963dac873 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -168,12 +168,16 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>                 .cmd = &cmd
>         };
>         int err;
> +       u32 sduc_arg = SD_OCR_CCS | SD_OCR_2T;
>
>         cmd.opcode = SD_APP_OP_COND;
> +       cmd.arg = ocr;
> +
>         if (mmc_host_is_spi(host))
> -               cmd.arg = ocr & (1 << 30); /* SPI only defines one bit */
> +               cmd.arg &= (1 << 30); /* SPI only defines one bit */
>         else
> -               cmd.arg = ocr;
> +               cmd.arg |= sduc_arg;
> +

This code doesn't belong in mmc_send_app_op_cond(), but rather in
mmc_sd_get_cid(), which is where we add one various OCR bits before we
call mmc_send_app_op_cond() with it.

For example, if the response of the SD_SEND_IF_COND commands indicates
an SD 2.0 compliant card, we tag on the SD_OCR_CCS bit. It looks like
that needs to be extended to the SD_OCR_2T bit too.

>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>
>         err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
> @@ -182,8 +186,15 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         if (err)
>                 return err;
>
> -       if (rocr && !mmc_host_is_spi(host))
> -               *rocr = cmd.resp[0];
> +       if (!mmc_host_is_spi(host)) {
> +               if (rocr)
> +                       *rocr = cmd.resp[0];
> +
> +               if ((cmd.resp[0] & sduc_arg) == sduc_arg)
> +                       host->caps2 |= MMC_CAP2_SD_SDUC;
> +               else
> +                       host->caps2 &= ~MMC_CAP2_SD_SDUC;

Please don't abuse the host->caps2 for this purpose.

Instead let's keep using the card->state to keep track of what type of
card this is. You may have a look at how the MMC_CARD_SDXC bit is
being used and just follow that behaviour for the SDUC cards too.

Moreover, rather than assigning card->state at this point, let's do
that from mmc_decode_csd() instead, when we realize that the card
supports the new CSD structure version 3.

> +       }
>
>         return 0;
>  }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 88c6a76042ee..a9c36a3e1a10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -427,6 +427,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
> +#define MMC_CAP2_SD_SDUC       (1 << 29)       /* SD over 2TB */
>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
>
> @@ -638,6 +639,11 @@ static inline int mmc_card_uhs(struct mmc_card *card)
>                 card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
>  }
>
> +static inline int mmc_card_is_sduc(struct mmc_host *host)
> +{
> +       return host->caps2 & MMC_CAP2_SD_SDUC;
> +}
> +
>  void mmc_retune_timer_stop(struct mmc_host *host);
>
>  static inline void mmc_retune_needed(struct mmc_host *host)
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 6727576a8755..865cc0ca8543 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -36,6 +36,7 @@
>  /* OCR bit definitions */
>  #define SD_OCR_S18R            (1 << 24)    /* 1.8V switching request */
>  #define SD_ROCR_S18A           SD_OCR_S18R  /* 1.8V switching accepted by card */
> +#define SD_OCR_2T              (1 << 27)    /* HO2T/CO2T - SDUC support */
>  #define SD_OCR_XPC             (1 << 28)    /* SDXC power control */
>  #define SD_OCR_CCS             (1 << 30)    /* Card Capacity Status */
>
> --
> 2.25.1
>

Kind regards
Uffe
