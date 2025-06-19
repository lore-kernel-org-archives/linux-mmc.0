Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E502264DD
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332043; cv=none; b=tkB7xjN+0PRuQvW9F02z48GHT/z53VlBbwcJehRqKOLRv7gLUfcGJPID6oNiCLBWR6sdXxL5pmv41HCqPrKSf+NVsmB+jW/aqztVeP2ySxrhRI7ysQsG+U5OhlKtStMSqXD4iL4ElnSIaqeFsQm/63sj5cPYPn1aialH3m6yGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332043; c=relaxed/simple;
	bh=O+XNjCmlDXihqADqENw5pWg6qV3ofpRAPyv2srI2rzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inO4Drt1eJ5tZRgRcyM1yWNnw1AeCxDQ4bAKKR1/mPp/T+We8+IyFzituA3Wb5d+jMatRRfmzwkL2G6wTvHRLQGo0yGMr8U1k4G1Yvow7AU9NcdQ0R+0DV9rXeiQahbK9uEA50cYeWtPaT0a9+fjx3/lpgGml1GdVIoiMXVe5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K5FoFsdY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5FoFsdY"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8276224c65so768555276.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332040; x=1750936840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWgEaprib2ngdJMswM6mSlktEJRmOmj1deE2c5/L+N4=;
        b=K5FoFsdYzHLqe6xZfEmVTcibFK+F5gozyXYpTLPa9hXHI0hW4VzLZdIR0UBSWgJKD7
         azFhVyCM7aOfYUmhorT3SJ30tm0XrVBf8f7h1DF3Gv2k3joMBI3PJnkYAFNi23Rzxw2P
         MDSmt7iXqM9MP7pm5PakQOoJrWEhJzyWntZ47g0xoGQgCOpp/IZY/9O85o6UArgLNplj
         Gb7OpYHO5oYsIdM10s86CzGkLQV80lpCpQ/fFcg+bUL4CDCEAwfgfZiN3zuveXSEr+Lk
         GwOqzlg9OhpjR1rOCBio629kL6BujCAnoAXmzMYJJfIGOV/PwXjXHWxB3WW7t/OiwogW
         Rd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332040; x=1750936840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWgEaprib2ngdJMswM6mSlktEJRmOmj1deE2c5/L+N4=;
        b=vtN+4uD5fsIVuMbmpX1cauHo6xsHfE1VjJZsP2W9+f2rT3dDARmbaA/S4rRwK0z/PK
         Pjk4dizGdglB0+iburZMeJMBOtaFvWP6XoQEPOWe4sHg8sndx/PiLCdqzDOiHoGHoZEa
         H4mHyDPJ5Aam3QASaKeg2tKCvoZ2Ehngeexl3L6zJRQtcT0soE1nJg+4F2dHzNYM9iSe
         /WRtHYOnsOwpHqqFHX1fYqkNcOjwoLEeMCb5NZTPt6KVSE+TTy0IWH/spRlYZlIzA0uE
         FwhMrylydjN8zJVDJN/V0pAvYyJ3pU1DRg982FEe2TMmgULaNPNLZtYKnyIC7eWVu8+5
         pSwg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2UVdlomHb6fD3F8wQKdaypPDLwfJag+FQWVJ8r3ICp7Nq+o43D4bAYZQXZeAtDJCJ5YPfXRFmqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MwwUjZmP0SEM9p+QC/jpjk1l5RfM2kWoeM33a7UWu2XymCEl
	DxDtLr1+Wu5z7LYDBR0kxGf/mBwTzv4NWLYP+IYnNY2hX+yRrtoB+2QYxSb1aDY3lD3W53vKLia
	LfLXdWhQtqOF5TG4Cqg2gW8MYEaK+PLXxBKF7zCUhmw==
X-Gm-Gg: ASbGncsSityO1gfJqvqMOQVLxZoCVjOZ6JkEuFAH7XqHSIKZ2ynt5jEwrqNwAw8gMkT
	HMiEADgvNK/MIL7l9xNa/DHDKn1/6lc0TSY7OKWFa9fmnI4AtsZbA576adlvvzjIJdYJiDVNDCY
	EEYaZlQPu0lm5z3uQwQ9LVrSGBQGoT9FuLzG47dRkJPOTH
X-Google-Smtp-Source: AGHT+IEPkpr0+5BVumXPKx0B3sIllzhbwtcsQ7AJ+9mahgV0JMJVyguw+KorDSmuqs0VwQCB4fOt5nosIJmzHlowEtY=
X-Received: by 2002:a05:6902:2688:b0:e7d:ca03:4474 with SMTP id
 3f1490d57ef6-e822ac9a663mr26416499276.36.1750332040375; Thu, 19 Jun 2025
 04:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616064956.1846258-1-ricky_wu@realtek.com>
In-Reply-To: <20250616064956.1846258-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:20:04 +0200
X-Gm-Features: AX0GCFuWTZyuzccfgPiguTKdquQMKsSjOlC9ApLRpO9xv5mchdivJQtIPuUPJSk
Message-ID: <CAPDyKFpnpFyRLVyMBus=wbDVtnuz92uXo2KYv1jkDuAH83WydA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: rtsx: usb add 74 clocks in poweron flow
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 08:52, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> SD spec definition:
> "Host provides at least 74 Clocks before issuing first command"
>
> add issue the clocks when power_mode is POWER_UP
> and stop the signal when power_mode is POWER_ON
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: remove delay 100ms in power_on
> v3: Use switch-case instead of if statements
> v4: re-base on the patches
> https://lore.kernel.org/all/20250610111633.504366-1-ulf.hansson@linaro.org/
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index c1fdcc334c8f..239eb9acf7a7 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1014,6 +1014,7 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
>                 unsigned char power_mode)
>  {
>         int err;
> +       struct rtsx_ucr *ucr = host->ucr;
>
>         if (power_mode == host->power_mode)
>                 return;
> @@ -1031,9 +1032,13 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
>                 err = sd_power_on(host);
>                 if (err)
>                         dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
> +               /* issue the clock signals to card at least 74 clocks */
> +               rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
>                 break;
>
>         case MMC_POWER_ON:
> +               /* stop to send the clock signals */
> +               rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
>         case MMC_POWER_UNDEFINED:
>                 break;
>
> --
> 2.25.1
>
