Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7917080C
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835332; cv=none; b=ucWu33+ez03jx29Jw6c6k7ZbqI4yriSCkTghhDvHYygdG20PAAz3foeZ4OV3XrQMtnNjqJkZOrYNq5HSCT2ZyGI62dfpWpAyF6DPMvHTObSy2D7enU3Q130tzMmI0ykxy/toPwYikceQJ8unMy7yceTsS4qJt803nUOznV0LbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835332; c=relaxed/simple;
	bh=W9g3nmkPBK3uDHq9xWBMwPYvqOEjSeo/SIuQ8/Oc/Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewlAchctAYh2PSnJ543Xnuene4X8xJeYH8K8leKRPeSiJGgXUYCjHonNZ1zErfTNuk3rs1I2dBpciSDydmX2/3n6xXbRvmUK6IkwGfqwYkd+InaI1hr48ocuUefac1o8kcAtoN82MikLEpR1YotjJvc1mM5DnEBcYiI8YkeoReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKhc759O; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKhc759O"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso6031438276.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747835328; x=1748440128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TfFZLIOuKnQvxfDeDOQOQ02mpTZZuOoeWl2CRrGL9p0=;
        b=FKhc759O6dRyruhCmkMOkba7TndIuese6y4rndHjskc35WtGOjgcLNcL06wbnw46Xd
         ZIWZz5M/pXQJmvvQ3j/8DOsGK941+QyaYsPD3PD2Q/761Nf5RgarQiWIDGfBmt2EC5TW
         oVYWWovsjid5ZDoFAFx/JJCb58VM0A2fSHX27CrAVHAZ/mSwe1kNvujVEGaUizNSvKDY
         olX+uOarwnL8eNhfGrtmkRj7MC2fHBmNoY/uSub3crMnjBoaQc0dc/RQk/IL0lXcfDLB
         Grj90PrkFUefUd02a6x6RHImNEiDgYxzJyKs0PmUJ2JTRzr7e9yi4Q/586BASD6/UQuh
         AtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835328; x=1748440128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfFZLIOuKnQvxfDeDOQOQ02mpTZZuOoeWl2CRrGL9p0=;
        b=LsVD9oRuJNAg7Q03l/JYT82uSHEnRp/v6XQEPoCDhpoXtXX8eIyI9VOZtLZ1yQoxfn
         FoFIo6rSLzf8XWRSP0MQU1I28i8pJiUULFKNrGUeKFkbooOkPAUsv3pIL+gyBI6sBaDm
         KkKMO5jAL2k+dZ09uInGo3zmfys0xdcoRHo3dsePzbKaEWy1jVZr0VN4ShORgjZDj9UL
         WS66vqyrSB1mFsgVl6WOZgN8tMiuSkJjztOxb9aT6oI++3AbpwYCuNK3qH+gTtlvLGmb
         MRnPkuEsR3PyijWNL0tAiB0usSIxYSjBIyERxhxaYMpqR5um0I5QVtka8KnwvxevqRf1
         +1Nw==
X-Gm-Message-State: AOJu0YwcJCDzJInONmdpJ8EW3/otNiypkzb+N7nuy2RJHoA8vfQRjJ9f
	OHEu+2yFPhcagq77Y/dvwMtuyrj94vYGqRgN5GVsRvHU9+WvZeObk4FQge/UQ1gI4dCpnB/KSlO
	ScSmcnvFma8KAhurv9j2kur8BQfe5AKsKOa7kMsJG9w==
X-Gm-Gg: ASbGncsDwubW87zeUCw5KPTeu3gH8PUMG+iBoZLkKAXzTkrj653hJo+tStZdaL4L4n8
	trGqXBsz7Lds26kcXZqOwrwtFEt96u2p60g6SmFbEW0LLnuRPshH6Zr1iwDDkNBIaaWOK/RWDN8
	dhwDyjlRtdiUe1nDWgKmDQknYCQbjRXSBEKjR1C+WySlmY
X-Google-Smtp-Source: AGHT+IHoCa5bmEKkj5D1n2jB7xPQ0ApHj7TGgYcEf8a9QreUaAZha2N0oJ8kgZa5fslYVkBS5lz9YlhGy+frYg4gtXE=
X-Received: by 2002:a05:6902:270a:b0:e7b:4e69:7008 with SMTP id
 3f1490d57ef6-e7b6a08d6d3mr28537450276.20.1747835328402; Wed, 21 May 2025
 06:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521124820.554493-1-avri.altman@sandisk.com>
In-Reply-To: <20250521124820.554493-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 May 2025 15:48:11 +0200
X-Gm-Features: AX0GCFsuVjwBfQvsJsNYRqPy3P3C1hlUAeaBdMvFOiJU1ViczUlz2unjHfKhW_8
Message-ID: <CAPDyKFr31jm8+DKLkmoQ_jfJ5q30x53t+SOmggjWtNsFLZdzQg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 14:53, Avri Altman <avri.altman@sandisk.com> wrote:
>
> Move the BROKEN_SD_DISCARD quirk for certain SanDisk SD cards from the
> `mmc_blk_fixups[]` to `mmc_sd_fixups[]`. This ensures the quirk is
> applied earlier in the device initialization process, aligning with the
> reasoning in [1]. Applying the quirk sooner prevents the kernel from
> incorrectly enabling discard support on affected cards during initial
> setup.
>
> [1] https://lore.kernel.org/all/20240820230631.GA436523@sony.com
>
> Fixes: 07d2872bf4c8 ("mmc: core: Add SD card quirk for broken discard")
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> Cc: stable@vger.kernel.org

This didn't apply to my fixes/next branch, can you please double check
and send a new version? I didn't have the time to resolve the
conflict, sorry.

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 7f893bafaa60..c417ed34c057 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -44,6 +44,12 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>                    0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
>                    MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
>
> +       /*
> +        * Some SD cards reports discard support while they don't
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> +                 MMC_QUIRK_BROKEN_SD_DISCARD),
> +
>         END_FIXUP
>  };
>
> @@ -147,12 +153,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> -       /*
> -        * Some SD cards reports discard support while they don't
> -        */
> -       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> -                 MMC_QUIRK_BROKEN_SD_DISCARD),
> -
>         END_FIXUP
>  };
>
> --
> 2.25.1
>
