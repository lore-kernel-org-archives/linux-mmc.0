Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506F1E0B86
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699309; cv=pass; b=kwuMYZ4NteO/ZFOR+2s+e27fGGrSgR4AafC1WXHyOvHIIuYW+zV71MycSEPn9IGI69kWvoDWJCw/75Ic6CYfPM4LU+jchP4GQADb4V7LmBNJ2BvocLZRuntno1qqMLRA3ckJUHJFoSzNGwxu3dQ+KrqveV1vGDn5ANzM6LNJ0Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699309; c=relaxed/simple;
	bh=icJfGEMZ/bEneEGHfyxw3xR/IsDT8xHGAmMQsYbh2mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvRI45L/mQEboQ/MDeYjJjXDh4bGCzcWBpl1t1wzuKDj3xHAUvzhzuPXTeOjzMu7rCgFW86ARglG//KS0jtw30xVhrsu5197cu+5r2kf+ZgYCsfaEGfUm9dTD8imkIu44lpJN8LKpts5958Z1JTMUEN49L06pgpkDA/ZKCYQj/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FB0iOL7C; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB0iOL7C"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso1251877e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 07:08:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699306; cv=none;
        d=google.com; s=arc-20240605;
        b=fI/5lDopbCkFhGwGIPY/w2kG/MF6nSrBfIYBinrguAscKn/USIHkQz6N0sTxbOt1DH
         x7ZnqkeTjkUI7zbOIz9D6KmUEM7VkQQ4GhQOybEQZU+sHyDUXsdMIxDt9N6dvEGZm/sR
         ANQN9dIECIto/H0Wp99NpKp93tV322+b98T+MJDNkIwAN+tdSOyS1uvKwsKRnDJmr7zh
         m+egkWCUo4NevLLEArzCwATjNoCEKpCjyPnNt4++puEGY2RahRZ/kwflrb/kVK5KzyEN
         MPPLYu1nX8rnOpSHHPm7//ZZ3Hv5jelgzPtmb8qaNlqMkQyaseKoyXIQrjSzknFifD4M
         /P4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mxIu4Zy59sS+vnAzfLOcX1hJejpcL3RkLwTgRMZy0rQ=;
        fh=Nk49H/Oxo6UJtPiJr5ed7/X4pd+1by4PmV+C4LG43yQ=;
        b=E1+lJFEFmDSgWFpNvxpNIbxwLAXYmXf8lM2RKOvSb/JGDvxyA8F1iI7bsjqqzKTWHD
         CVzeXMgD/MYEwHjOe7xMI1pf5UdO1z8Kg/2z+qa5Y90agRm0YwqKpby/OGyaSsT8bsv9
         JhTB5B9i/gdisYmRfg8Tk2++UhurnpgiAT1VrIEVwFut5G635lCDv3iD9koqeQI7GaS+
         rHPGUMTV3SuzVC0UNGvRRfj4L4QnRPKUMkOZQGSedIrgOr25eFpLlGQFDsshSD8q/+Oi
         hqjkJni8fgEKSDsp64J9aypBbmehgn41ptfsC74ZgtwkmqFbzLKm9coCTolBG6WVO5YY
         votQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769699306; x=1770304106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mxIu4Zy59sS+vnAzfLOcX1hJejpcL3RkLwTgRMZy0rQ=;
        b=FB0iOL7CEm0YWSvSkUcNEG3Whw6FcT6GSDUTTTDVh7+MzHEYLl8CtJJdQGJEyFwbbu
         OTuYGG6QQQnLfJn49JivslxH6L/e9qY5ixNL1PL/KcIvesrK/yocl3YBlllYTWnXpwZ0
         YihQrO5MqXy3B4caBHDCVMpD3cmyVeoKrzJpUOBBlz+Cenip5CEITjZq5LAWUqnHxgD/
         seml0C+2R5wsipNa7A6hfzi8iT05VH/xWZQCFhHz/Gl7NKNiwHGZZcu5lRUbMNFjby5o
         jElaBvpvzgehXZ2N7NxkGexsXzy8RyAWqDT2Jo5o51VSIypcKolzdb2wQi3SvwtRdYwS
         eP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699306; x=1770304106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxIu4Zy59sS+vnAzfLOcX1hJejpcL3RkLwTgRMZy0rQ=;
        b=chO1NPHknLofxqDyrLv7xMEuttpJZWh6WQa4UO12ak+Pu6jplch8HTtbAxcJ4nO7aX
         4LS/ntGqm8T9JOnbKr8knmUGStQeM3F4uEXo3HOxQV3CkR4XoQ3x6vJOieVNH7mZrcWO
         Tg8VYr2tzpK7OI6zfQmuu1tRwKgBNLHLddIzrDRyirKz/bAPqieDpk6zbNHQTvMxhTVN
         yrzr7R9QLL1KRoNZ8JTbTimzbqxEqjg5QXM+Zn7F3PFFtHyOfA5LWqk5Y9kuIfOBKMQo
         ShoSV5iBXeHscJmLF379KR2tb3yaAjz2VH7SyT/R+99VDC4gNkdRdQFoSsimK8HsEHZj
         n8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbFRvNzLJYSPsXhKrS33wi3EekUHlbvWPqbc3hcZp1U/r09cpmkIqiLO1ImP9ZenYPtDZ7gcxv0PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8G2fUyJOY0Q71dp8JRqsikgXgchQbL8cc3iwm6UsqCZvV5wbo
	pF/23dt1RwugCDyu85MJMq1Etbzo528Tdd6zkb/G7GvI0V7cvk9o9gctludaThLwkTfdqv5YXYO
	kwKOkx8MulSyMLlbDnG16t6iiZnYKe2rvZEQjkhyNgA==
X-Gm-Gg: AZuq6aJHZp5cpIqaLM373gAL5qO21TvHWzyaYQ5MwvPrhfCyeuyBOaDtxkwLUZDkzTy
	2rSsTYBK8zUGiX/KRw0XWDNvKqXxZkqNUnAFtvef1nA/g25spW4F9ZXfMI5t37HlK76xwiEqW1l
	yznzJxKz52avE3IHemZ2aoQfS3tFL82n8FBAZdIgwtRT1sBnWYGelmnqmjsyZ7P4mcrt/S1X58K
	Ee32xQ+ndzb/+gJL1eEu5mUyrpDKWgcUZyCMa8GBZBU//ufA/tQVQyRldFRo9RRlhctkycE
X-Received: by 2002:ac2:4e08:0:b0:59d:cb35:44ab with SMTP id
 2adb3069b0e04-59e04017b54mr3697288e87.14.1769699305914; Thu, 29 Jan 2026
 07:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com> <20251215102010.608421-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20251215102010.608421-3-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 16:07:49 +0100
X-Gm-Features: AZwV_QicTnxYZa9_aQJZVlGxEGtVj569eS16RX-pa4PTkAgIzD_uM0U5gBRdqC8
Message-ID: <CAPDyKFp0mDkLXOCh8gDzHt4KkCreYOFk7-Hzsfb9ySy14nezXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: add quirk to optimize certain Kingston eMMC
 secure erase/trim performance
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 11:18, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Kingston eMMC IY2964 and IB2932 takes a fixed ~2 seconds for each secure
> erase/trim operation regardless of size - that is, a single secure
> erase/trim operation of 1MB takes the same time as 1GB. With default
> calculated 3.5MB max discard size, secure erase 1GB requires ~300 separate
> operations taking ~10 minutes total.
>
> Add MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME quirk to set maximum secure
> erase size for those devices. This allows 1GB secure erase to complete
> in a single operation, reducing time from 10 minutes to just 2 seconds.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

FYI, this looks good to me, but I am awaiting a new version of the
series due to Christoph's comment on patch1.

Kind regards
Uffe

> ---
>  drivers/mmc/core/card.h   | 5 +++++
>  drivers/mmc/core/queue.c  | 9 +++++++--
>  drivers/mmc/core/quirks.h | 9 +++++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 1200951bab08..0a198a2c2616 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -305,4 +305,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
>  }
>
> +static inline int mmc_card_fixed_secure_erase_trim_time(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..eb1053d8cae7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -184,8 +184,13 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
>                 return;
>
>         lim->max_hw_discard_sectors = max_discard;
> -       if (mmc_card_can_secure_erase_trim(card))
> -               lim->max_secure_erase_sectors = max_discard;
> +       if (mmc_card_can_secure_erase_trim(card)) {
> +               if (mmc_card_fixed_secure_erase_trim_time(card))
> +                       lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
> +               else
> +                       lim->max_secure_erase_sectors = max_discard;
> +       }
> +
>         if (mmc_card_can_trim(card) && card->erased_byte == 0)
>                 lim->max_write_zeroes_sectors = max_discard;
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c057..1f7406c0ab03 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -153,6 +153,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * On Some Kingston eMMCs, secure erase/trim time is independent
> +        * of erase size, fixed at approximately 2 seconds.
> +        */
> +       MMC_FIXUP("IY2964", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
> +       MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e9e964c20e53..1882267ef201 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -329,6 +329,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
>  #define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning */
> +#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<19) /* Secure erase/trim time is fixed regardless of size */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.34.1
>
