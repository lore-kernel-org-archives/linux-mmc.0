Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15F2472B5
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679625; cv=none; b=o7p6Moj8ntlhnuXXDRrKJk4Yn9i1BNt7y6dYo7R3ngFFZUB/4REtouDcMHaoCdaC5/r2i3Koj475A3x4hkBHlJzQbmxPoOJHwIp+JjappeoL80Gp+0hH6JEkNZJpodNrb7G6uxjnv4RTG4Yxcg9ntI5VPCFmQy3l/Z2WedeRJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679625; c=relaxed/simple;
	bh=dLO58gER4/9we8S0TLinFsUMTSqy1jSiQM5gDQyH4uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqVgdKoeU0juxq3kbTdRRKw0xeJUlyQyFKBRSKYSXOd59gr6aomcjizpfC3A5P2X2Ee5TySr9Sxe6PxNnL2AZaCckV+3KcczAmvI898MfLLvw2UF3Y1/BscMOUu8yTEqEAs3jO/HU/xybDUGOW+hKl/aq2LLMDQXpKpjcfOW+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMMH/mnk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMMH/mnk"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e82596e88c4so3407497276.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750679623; x=1751284423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B805XrZKRxPEF7q0TmzBdS99aJNQ99+WDQeiV+moFIY=;
        b=qMMH/mnkUeyRHqxkNp1K1hnB3JEOE+WAGGMAWz4CPnwcKNULYBoPlD+USSvWEeN1Oa
         mhvbk6MXOsTeoiUhxH4Ed6CUrYGhzCoteTebAlDB6o6Vg3CE3QELs4hnI5+La0j9XCXo
         qnrWX0vucYEaAtZjfRaG5ceCGogj1alnC52HQXUGVwwK0RxuP8JBr64lT8Fu/gvzLlBU
         j+FEvez3/OZ2saoQUFJds1MJKRN95yWtl+zMo1FggijcfG1VxKAmfPLytTUFNTMEwScC
         O7z49SdF9eh1xBrafuIWbFBTvqvQv9t34sUG7jwwJYJRx1WSLCkA6yrLzzyKbZXpEI1D
         ovZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679623; x=1751284423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B805XrZKRxPEF7q0TmzBdS99aJNQ99+WDQeiV+moFIY=;
        b=if49KyFXTkrt+GTORCqfUaM0Ko5tr1tVjc/dgKaINk3VBpxzHU6Zhk+A+UgF2K7Tu4
         OshGfIfikuM6CzA6RTdtnfOXAeFKP4gVj4t7mLyHtr7hLYt9ckasC/ftB+OOuGOoj5qZ
         BodMKDGaF/CPXTyYRijr/X+5haLU1nRSZrltbzXrB2q0oaOjFsEMvFhnjlTFHLWvDBTI
         X7qcHX356eO6sk64ac3SSaiQ+hm5LCjstgTe9tjJPXlh+hXEtBq3/xxnYMuCuFuGUqL+
         UwZMsrq/Pza7uJm2O88sCit7kOpFuqbMCE/yxAldNRvU0XenXF5FL2KyOKVkbwojdqc9
         EUyA==
X-Forwarded-Encrypted: i=1; AJvYcCWrPawU/l4vMrNFDRtUmift7G5TRsKNmE7tID59P7YXM8gcIgCnpfO5xJ04KFuiNIRSH/fhp+Lo66w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuokNrLZDjad3r+kk910LQJsa7mdEU82UIIe5pE6XtM1wxnN+o
	aN3CZKCnPY8+3r5pl3OfZl3x4PENUuN9EkJ8LWWbgiDMD8FRwori/tCI8mqfaqTaUg6eqcABb7E
	cy93MI9jfDuohbyzcJCER9BTzbplQ/2lwsRu//VXz5Q==
X-Gm-Gg: ASbGncvXIJfPslhWCXTZICnDCqjOa1A/Hc5YKEGmK2bY//l75DAYi3x/D/PSQ4BC4OY
	U9oozb+yluV+GQE/6pufhmWf3eXdnfVbpsau5b9xEfWs9Rn0zUHMJH9QeM5nRQMV8PugNC/ThCA
	7OqOMe7/RBySH5ivI2At5wK0Ad1f41gjybBfkXL+YGU0EsbLcYMG7GTaI=
X-Google-Smtp-Source: AGHT+IELqiLxPqxfP1B6M+PoD9dckt5ie65k3DRMyhajXGBqAf5XZnld8i7QkaUB7/s6v+6stoYuis0ocxT18YOr0D8=
X-Received: by 2002:a05:6902:1612:b0:e7f:6815:ce6e with SMTP id
 3f1490d57ef6-e842bca3da2mr14607843276.20.1750679622828; Mon, 23 Jun 2025
 04:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620-mmc-rtsx-usb-sdmmc-fix-clang-implicit-fallthrough-v1-1-4031d11159c0@kernel.org>
In-Reply-To: <20250620-mmc-rtsx-usb-sdmmc-fix-clang-implicit-fallthrough-v1-1-4031d11159c0@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Jun 2025 13:53:06 +0200
X-Gm-Features: AX0GCFsecqypaGAnLbHfqAW49LWdYlrsXNE5tE8Z_-FA8P0SbCCQ99PmaGdH8eM
Message-ID: <CAPDyKFpavS8o8X6zYzJXuS=N_3ya7f5gWH_xQDbxbZstSAuaRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Fix clang -Wimplicit-fallthrough in sd_set_power_mode()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 20:25, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=y):
>
>   drivers/mmc/host/rtsx_usb_sdmmc.c:1042:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>    1042 |         case MMC_POWER_UNDEFINED:
>         |         ^
>   drivers/mmc/host/rtsx_usb_sdmmc.c:1042:2: note: insert 'break;' to avoid fall-through
>    1042 |         case MMC_POWER_UNDEFINED:
>         |         ^
>         |         break;
>
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
>
> Fixes: 2c3809bd6f65 ("mmc: rtsx_usb_sdmmc: Add 74 clocks in poweron flow")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 591d37206654..c5f6b9df066b 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1039,6 +1039,8 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
>         case MMC_POWER_ON:
>                 /* stop to send the clock signals */
>                 rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
> +               break;
> +
>         case MMC_POWER_UNDEFINED:
>                 break;
>
>
> ---
> base-commit: f5c755ef810009b85350884c483705bd04365370
> change-id: 20250620-mmc-rtsx-usb-sdmmc-fix-clang-implicit-fallthrough-732a574554b0
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
