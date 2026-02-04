Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE51C84A6
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215481; cv=pass; b=GbCxg39E78cEFyL/CZc7N0GD72jJZCapx+7wCgGyBFZICcdG8Or7SEQocDijZMdzudncRHdUWvTaSsWQjutDnGHlM+4ZtiEwcDBAy5DKFwz5O1qRZnS/Mlj4GGv18HoBodc1sv9Rc0c6iJKxYj6d9oGREeAEOSC3aH/7fGkjmQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215481; c=relaxed/simple;
	bh=VeU1M/+PLjDRdSdinp+x/60VrhCRA3f0z0U08KL3du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMW9OlhgTej5hhWMxKw7k+0vASNZj4OWn31o/IZIICCVtKIRx/YP6m4dm6au2eh9c/aD384rDFh8pQNIm0E+Q4a590tkldDSu0cxHnjwB0J0ANpcDvzsdaCBp97TaPxe4JuXKkwE3DuiYSJNDrKpYF7KOHh2ScMxKiZipYvhMzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVGIRotZ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVGIRotZ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64969550a1aso6794025d50.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2026 06:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215480; cv=none;
        d=google.com; s=arc-20240605;
        b=RJGIw+n++e0aVUKfK3zW1tmyLiw4aqsJcO4qaRSXYH5/soxqCUUQMt0+vx2IwA7pxk
         QB+6yISr2hkrg+KB9zUVF92L04Z/dDUEYdiid2AlWgv4T51yfuAA16M9Xli5l8ei9cZg
         vlwAiVLzSbe7hc8GGSDetm5m6L1/8whXa84niFwZas2lH312lwDmo6y+G8C42oFNtGhx
         9MqNbS49ooYAWC3X8e0BSrj9XhsmmWdfV2dPhuD25aBJWN0lcanVUx/q7D4n+5N8+yKw
         GmDYC0T+9DrwxZT7j4B9OQAaefTKfd8ScM1CWtsDVHFXcU7tXVsPphG620NTNpjmQ+u4
         GZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dI+cml2Ore4hIHpIJvCr+cPhA0RJkwTrbCvVMmSJFk8=;
        fh=8ohcK9lxd7/fY/0C4P94FzSa5q9WoDY7lySrpXCN+kU=;
        b=Whi7D/t91Ca6o2KbUkuawts05iCKbJmOhGBdoFU5/UsLUp1Wv1HHlCDX4hf+rFuz52
         KLbveLMkNQU/enTFF+w18WuBzrsdJAc6GXIYuTsyhhOSNn9wYTGAF3kD2f8RBEJu+7Fl
         tECKaHCSY4bTvApr8tbaD9vBqhh8oyhvU+Fc7Maaxz+u2mzL2MWyC1cQnBWLOxbiqMcY
         9TXMbnN6IzqXHz5O4SlugoGnJXrEiFMX1hBpSS0AiB4j/s3mfUdnxgsUygtB5u6POm0J
         BDw6vxtxhQF8qY/P7ighhwTPXe1PuHlIDb2Q5d2fTIZ189d6On9bkYPkVBW6PkShQuGE
         virA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770215480; x=1770820280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dI+cml2Ore4hIHpIJvCr+cPhA0RJkwTrbCvVMmSJFk8=;
        b=cVGIRotZeWoXwteae1+pUw0PuU1R3gckrsrRbUmOHUs336JjKKecQj030iJTPuCKOz
         8mo813apBO0a1SadlbMFURGvxLIy7EwBQsK91/V64xx+hkZJRpk1YDBz5QkxDr4PEEJQ
         BaE9eBsZzrZbiq/RCnxe293Hw1jNXYW8eMmASyID8JcWIRTfCgfBju70TOFMvPx3/o1y
         rZmmcRnOV01pPAa/mIobR8RVsU/Do/nN80Qgs+OZpgZR2mBTDBYsLCn6V7a4EGDM+Rph
         xaiTAyVATTAho13twlb97EsTOwD67nXw3/NsqoTA3Lj+Csd7oHNgdQUgbSa6dxUl8w7z
         cjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215480; x=1770820280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI+cml2Ore4hIHpIJvCr+cPhA0RJkwTrbCvVMmSJFk8=;
        b=K7fRP7eS5BHMYkSYTrNmAtFhTB/VUYEdn6CRBrGgYPiBGCaB/iio3YXI/lR95wumGu
         Ujp+QJyGq+7g0cDm/mk5+qIiH/Z22ka/8XSxxVr6XEvpAo3yBvoewXdN6MUb4AWzpKia
         vDM0JqRZLaiiHNtnvEMFjBcR9WNeHWjJS3yqkAphry6KrnMzHH3yhPRaeP9sc7i2BDBN
         K1aXwdSgGLX/HL8egQWIl4xnPJ6Kktjrlw/vqoqcyg4StyZASyeo7zPAb/bowUQPSp6u
         d2Ei7hUkxHl8oqGsdUITz5yTi21Tuw/skimoJVjChLu2WxXo1/o591WSP39ukPNByR1o
         C0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAq9khxrpfo3QpeWPNFfHzwKVDZEOnHGkM88ujCrt4WGMKX5/pTPoWyftrinA/S9s+glsfkQZOQ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XntTINYBwjMfs3kV7nl7a/KeS7E2Tt19yCuq+9MNPbGbLak+
	2E9vguNrUbAcXy1rPxUfIjZn5aoiHJSPxa4UZhmEXDsnP4HDpsF6qav817K3yYpIzNIhlKBQxks
	C21yZidMOCEN4UXrTFdX27QAt7B2xw0+85M516IvqEQ==
X-Gm-Gg: AZuq6aK1dtXKAdq2ex5ArgpiPDccTC/DbCeFcuKNfambxU+SS56LbV1JFpqL4VaDZ7X
	41a8M4QBQCrcU7k4+eyR790tkF0SaWD2Efx1nnZH7mKF+73+JrlU0k8Rh5ZurraQgDFpzrKKEDm
	mI9KhTRDN3mLHZ67UN9BayRJqxW9bBTeBeKJ4uoyQ4Jzl0Yzjd9J8xuTHDHgsMan/cyOVOVqprF
	ioMH37YV+mNWBad3Mjqbm/BQNnjSlHFKnxbJk+4YJQWumRhSLDeIKzWFOH9Uyb6REok38KTX9GL
	EmLRPlw=
X-Received: by 2002:a05:690e:11ce:b0:649:64d4:8127 with SMTP id
 956f58d0204a3-649db33311emr2635192d50.4.1770215479555; Wed, 04 Feb 2026
 06:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com> <20260204034003.2961402-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20260204034003.2961402-3-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:30:41 +0100
X-Gm-Features: AZwV_QgI7Imdfxcsknmh62CBzZI03NFl9MPDU-nwW2BMZCSmMmoB66KvDFFoZiw
Message-ID: <CAPDyKFr1UhsDakJaP-W39=n-DhM4F0KTWTaEwXZRmLpnKa+y=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: add quirk to optimize certain Kingston eMMC
 secure erase/trim performance
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 04:38, <ziniu.wang_1@nxp.com> wrote:
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

Even if the optimized performance requires patch1, I decided to apply
$subject patch as is for next as it doesn't make anything worse as a
standalone patch. I also added a stable-tag to it.

Patch1, is better merged via Jens' block tee.

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
> index a9619dd45270..a7c364d0030a 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -311,4 +311,9 @@ static inline int mmc_card_broken_mdt(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_MDT;
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
> index f5e8a0f6d11b..6f727b4a60a5 100644
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
> index 4722dd7e46ce..9dc4750296af 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -330,6 +330,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
>  #define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning */
>  #define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
> +#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<20) /* Secure erase/trim time is fixed regardless of size */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.34.1
>
