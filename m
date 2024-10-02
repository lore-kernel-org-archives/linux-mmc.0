Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4519F49C
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912197; cv=none; b=WKXKwtQloZnqG0dKrlZQnpEm8gqAup1mR0zieTNpyt3HGDj/a1akzuR0DyebnfhgIfNURLmNuANBWvZVOU4Bq41y0jigjpON2yVjm1cmh0tCe7SlwjxSao1F3LGu5whiVDF1N8BkfjhR294UaqxcEUGG4dylGtZODgDwvUqhRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912197; c=relaxed/simple;
	bh=A+qFnPt9D/9gVc/JF2nEvVquuZPa62SSA+JrYrIOKhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOFQtxxUnUYoTjqgrf46iRqP6bDpWPer6WkHnZ5iNakDCAaIUD62H4cUpGGKsjA03lqkHEsGda1Qo2+NtFbflDafnQXvUv0lfeXFcBbt0sUB+u61QxpiCVJXZDKFR1+5Z4T/1A68lE0JI5Hf0kTbfgMSzpDQ4muiNGqIX46CZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYmSacAN; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYmSacAN"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e04196b7603so323449276.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912194; x=1728516994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWOS2bD95bK1T8Q/YyC4ORqcYOXARw/FqRSAbvGy4IE=;
        b=lYmSacANCVwTZd7sy2yXY5n+o8McOFVJ1F0WZWOc3XhXTYNC4AlBrr8FHBXnPu7KtB
         N89QY3mhVKlSHkJUG5StOKMce/WDVT46pygOCU+zN5dmFmPThiVU8zIwf+5f5YCQuF/F
         HFlE73TivV2GW/5TVLGcmKZuZyh8h8kxhGmQfoArzrqewB02DXg9bNCOHtmDS7p+yGKI
         /rQ79Xngjbk9BlGY6AoFEKwmP83Mr1RBoAyL96cO/SuMBpC7Z0OYVmaV+yPgJtfn9hb2
         lbj9HWrUjYuk3qIl0nkm6YtOaTlsNKXcvPRHfPUnuKAwIG0sEhQ7sDE7anuCGXAC5FeK
         U3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912194; x=1728516994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWOS2bD95bK1T8Q/YyC4ORqcYOXARw/FqRSAbvGy4IE=;
        b=RnZ68KhqVjeDb4Gkre+KE0NhUNlhcFJhqL3vN0ow/F+THku7x7T+HW8L5ytNT+jV0K
         Ad7zX02Wj8uJL5dykixSFSOasBaRqaGMZys2zm374MFuETeo0Krwsd/4IoXZo/p4x6Z8
         Bwy8QKFNQimwrAIptC5jzZZuh0RVpwss0JkusIiTEbmredgDE6PtZkqb9bhilYKb2qSX
         X+k7Uhtp1URn7eCXMZ/x4QNxagNPt/tA4zHPj4MOE9YkBLRJN5ZKRRPKQSAMSu70iGvg
         i0eHDhfojKkGib1iJZoQdyCh5S1VfaT3KTiYoUhtQp60OLuhQCtgM0maIFNgTysFbImH
         pv5A==
X-Forwarded-Encrypted: i=1; AJvYcCVh1klSQy0CtDimbZx0kSbxG2e4M5q6ti+h5riPcgaJVUAifj5jBGkrv1IwKsnwRkwDjhrpukNHqPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvitdwazVpkMWnyfLsrODWYz2cNEtaSve0deuf7IS6ra62ZHLn
	l31Uf3C/9FpXVpedGFwL+uBcB7II09VQHzE5686fBYldobuv/BtNFXp2NERrqNDDwGABAKhOh9y
	/Qx6mx80eLvXo1yyFB9Aw7XGP2e2U7DfRi2kiEA==
X-Google-Smtp-Source: AGHT+IH5DbK8t4u+fqY69or4ZhoLaKJTJeX4dseIXd3rMYim2wNDkeW+gHu6OsD+10Y9dgp4xQjmkza7EshwtneEVUc=
X-Received: by 2002:a05:6902:2289:b0:e25:cdc2:ed93 with SMTP id
 3f1490d57ef6-e26383da70cmr3862834276.30.1727912193971; Wed, 02 Oct 2024
 16:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913094417.GA4191647@sony.com>
In-Reply-To: <20240913094417.GA4191647@sony.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:35:57 +0200
Message-ID: <CAPDyKFpiM5O06YEjyE22jFY2vV3RDPnR=uHmUPUEvRF7AQhxQw@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Add SD card quirk for broken poweroff notification
To: Keita Aihara <keita.aihara@sony.com>
Cc: Shingo.Takeuchi@sony.com, Masaya.Takahashi@sony.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 11:44, Keita Aihara <keita.aihara@sony.com> wrote:
>
> GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 report that
> they support poweroff notification and cache, but they are not working
> correctly.
>
> Flush Cache bit never gets cleared in sd_flush_cache() and Poweroff
> Notification Ready bit also never gets set to 1 within 1 second from the
> end of busy of CMD49 in sd_poweroff_notify().
>
> This leads to I/O error and runtime PM error state.
>
> I observed that the same card manufactured on 01/2024 works as expected.
>
> This problem seems similar to the Kingston cards fixed with
> commit c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston
> Canvas Go Plus from 11/2019") and should be handled using quirks.
>
> CID for the problematic card is here.
> 12345641535443002000000145016200
>
> Manufacturer ID is 0x12 and defined as CID_MANFID_GIGASTONE as of now,
> but would like comments on what naming is appropriate because MID list
> is not public and not sure it's right.
>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>

Since the MI list isn't public and there is nobody using 0x12 for now,
we might as well use it. At least I don't have a better suggestion.

That said, I have applied this for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/card.h   | 7 +++++++
>  drivers/mmc/core/quirks.h | 9 +++++++++
>  drivers/mmc/core/sd.c     | 2 +-
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index b7754a1b8d97..8476754b1b17 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -82,6 +82,7 @@ struct mmc_fixup {
>  #define CID_MANFID_SANDISK_SD   0x3
>  #define CID_MANFID_ATP          0x9
>  #define CID_MANFID_TOSHIBA      0x11
> +#define CID_MANFID_GIGASTONE    0x12
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
>  #define CID_MANFID_APACER       0x27
> @@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
>  {
>         return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
>  }
> +
> +static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 92905fc46436..89b512905be1 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -25,6 +25,15 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>                    0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
>                    MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
>
> +       /*
> +        * GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 never
> +        * clear Flush Cache bit and set Poweroff Notification Ready bit.
> +        */
> +       _FIXUP_EXT("ASTC", CID_MANFID_GIGASTONE, 0x3456, 2022, 2,
> +                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +                  MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
> +                  EXT_CSD_REV_ANY),
> +
>         END_FIXUP
>  };
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ee37ad14e79e..0ec550ad5651 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1118,7 +1118,7 @@ static int sd_parse_ext_reg_power(struct mmc_card *card, u8 fno, u8 page,
>         card->ext_power.rev = reg_buf[0] & 0xf;
>
>         /* Power Off Notification support at bit 4. */
> -       if (reg_buf[1] & BIT(4))
> +       if ((reg_buf[1] & BIT(4)) && !mmc_card_broken_sd_poweroff_notify(card))
>                 card->ext_power.feature_support |= SD_EXT_POWER_OFF_NOTIFY;
>
>         /* Power Sustenance support at bit 5. */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f34407cc2788..543446392776 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -294,6 +294,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
> +#define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.46.0
>
