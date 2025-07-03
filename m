Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFE2EF66B
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545219; cv=none; b=Y0IrRCvMHXnvTFdwYOh2p7oA2ejk08MNybooNe+w5HWUGQx8p7+RxVqdRSyPMqVnKUnd1tXzjxhcEnglmMU0ut3X3fURgXU9rDuETLybVraf8wQvW9AprjHwe5Ug/pSvwzIvWPJT17VfRfeyQfGADepHcgaFd52x3jGlp2srMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545219; c=relaxed/simple;
	bh=spbkEPGHSpl0+l+f9AayOzaKjCRMtOg0R7VoGfYTlpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3bga2MkGY3MyD3yN3ZnrrPRs6O1TXHFGS2N0cvLymE/NbgC0HCeKAX+dFDZHX3ZSTu7kd+yTCgvG5k5LmfBj3TO9u2xN72Ed+4Zd/XH3Mqa+CF1kNVxlpjas/OR8kHG27vDlJmLWHdVVOy/JxcQPECFxb3IGDxQV1FBLrsYDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WW4KuxQq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WW4KuxQq"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so840761276.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545216; x=1752150016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1W3w9MJ2ChcuTvKxi9ZMSSYzvPLc49TB/TDjBvpqAHg=;
        b=WW4KuxQqL6VgzhyGmAvInsT1Sx3xaRyj4ZnknIxUjKgb0F5WLzk/cdXXl9kCIyhbAA
         C1h+sONZkSrDGHwumDwmCxsi1JpV60kuWOmNh06rWpyrC8She1ozI9td8bklrKTSoHVZ
         HgeCzL68evioW4cPPocuq3OMpunI7DOoVuFYElwJN3y1LY8mOdA1cwDh+/bP+6kXf9Ew
         Wd06Adsp8oOLkNuQeePQMWIai9h6KQR7AnMSS8B83ox4RFiRPHUkc2emNcocMOBjtwbp
         ko1TFoDzHjEZY/ZXDembpLlclUawPKYo5GYKolJf36Ix2IYHA5BgdtXm/aMv2wI1ZmYD
         by8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545216; x=1752150016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W3w9MJ2ChcuTvKxi9ZMSSYzvPLc49TB/TDjBvpqAHg=;
        b=Sqv/nyq7wpAa+fXPyQ7cht/73cCcoM0/SsCvh8GDn4JdHuW/0bWjWbkigcM3jRyRPQ
         ap5/3QlXHEl8sqTGqa7SllANG8TivmZM6RIwG2stWlsJ/wWjnjkqNPrVQSN2tA8ECyHR
         KTHuyxbM6ZyKdybVMRQ75VFIEgq50SPWUI+WqYR4iY3I8/LWuctA3SxIppwALrwi97Fp
         dioWGkjF5PORrf8C6y2Kpe13qKoIIg875WRkksgK1jvIx/gyagXMPKKFCtyenETS+OTd
         mDQ7WqmtWwVcdxM2iAJDavfNTELXRaxnQAOt8gUL+3IJCz0UXxDPqlqbaVSHiLBFQEF6
         hlag==
X-Forwarded-Encrypted: i=1; AJvYcCWR5ur7Ncnw+aO/kljMDXC/YWVZ7p+DHYawKAJOGRcltGfzGnR07sJ1ysy75Bxob8J4QwgO1BRcbJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfubA6emCfKYs2o+MGD0oHLrBON9MiMr7YclNnG3aGJ/7+M+e4
	9EaSfIUka++MdezJ/qya4IFNstBSzv9gEMwl1nkM3Tf6OFjjPbvhx+5NdK6MLd/170x7DEwAEoK
	4Y30ASMzuzza90C5FohCaj6x/aeMfFNRUERIeelEHUg==
X-Gm-Gg: ASbGnct7GxqEtHr5KhwazM8MXj1R75aWcsr6a5Eng1+zyQUlfWTsU5+Fqy107+be+90
	BKjzkgG55io5tXqYkaPFOJHMNnLXNr/R6lT7Fw2oywzw0tNLVXwR5keSfz+YRbtSz2d0cNmOn6D
	NTf67Lw586Xj0K1bFedrVsc3YhBu1Yd0r69ZqFUlPCZthp
X-Google-Smtp-Source: AGHT+IEmhW8Ov0Y9jVrvHOwZj8H8nMIFymTr5BFDKBgbv/so+xhj7BgHcBqsC0qPpeL0TROZTppJMnK5zQ5xBecp9QQ=
X-Received: by 2002:a05:690c:1d:b0:70e:404f:6714 with SMTP id
 00721157ae682-7165cb464b8mr25745387b3.19.1751545215794; Thu, 03 Jul 2025
 05:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630093510.82871-2-fourier.thomas@gmail.com>
In-Reply-To: <20250630093510.82871-2-fourier.thomas@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:38 +0200
X-Gm-Features: Ac12FXy-fHCOkMVSjWEqOM8yM1ocTCdlPI1Mnhp584Yxu07D6HeH7gPis0rWzRo
Message-ID: <CAPDyKFpJagX2mUNmMrA1k2iogXgq_reXAf1NEeDyC96jMv807w@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: Fix dma_unmap_sg() nents value
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Yumeng Fang <fang.yumeng@zte.com.cn>, Eric Anholt <eric@anholt.net>, linux-mmc@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 11:35, Thomas Fourier <fourier.thomas@gmail.com> wrote:
>
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
>
> Fixes: 2f5da678351f ("mmc: bcm2835: Properly handle dmaengine_prep_slave_sg")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index def054ddd256..4fced9b36c80 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -503,7 +503,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
>                                        DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>
>         if (!desc) {
> -               dma_unmap_sg(dma_chan->device->dev, data->sg, sg_len, dir_data);
> +               dma_unmap_sg(dma_chan->device->dev, data->sg, data->sg_len,
> +                            dir_data);
>                 return;
>         }
>
> --
> 2.43.0
>
