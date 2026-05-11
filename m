Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB43FF8BC
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511283; cv=pass; b=aOXhbGgP3b8aQDasp69NnmeQTADEI0mHTOYjaK7WHzgytMjCOPjUHBJjxDxhoY2grhjDXff1EXtkjKqWRk1ofDQ7TzJjjAG08eOGjjocAwIUpbRXgojPwQvLqPI4nt2/8i06UX0D4tyyiSGbw2RAjFmBD425lL72A40WUtB0APk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511283; c=relaxed/simple;
	bh=I9qo4iu/lGpI3j9s93ypUJxrsS0jGrvIFGrhc5NQn6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiGHxm8Rn1pRNr7zhKFlfj6rTNgI7pctuR1TpBWr/+st1100tjlrB0A9UM1utFmHGAGxOo4artV8Js4AZFDGsorp1nWW9zYYP9Q1RREH4ZTtnxNFbT8SnJAMDsrEsEI+wKCMpw0kZqz8Ifocq8Mp8HqJ9TqOob8U+XlsKT5Jxpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+NxNDpB; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+NxNDpB"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bd87e5d8ffso57568287b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 07:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511280; cv=none;
        d=google.com; s=arc-20240605;
        b=Wc+T9uf0Z6W/WKMnadDn/UjeIvT0RsybGNeNJv9seQ4wbUeZZKiRbJhptaeGos6tFQ
         VO0k6Y1V5/nCOB93HhKPqz8Pquvt0rUAzf0ESCh2euHXM2BWaFvnboPFN+gHNdiDRITX
         18kSza4n7HyJt7r5gpe2VaH/woXID7Z+OEF7KhODAP5h8njAEhyURjBlppUvH3Zuak5t
         Yar0VoY+de3BjZwQhYzX4IRgCdMr566yMB+wz34BNrGL5WTRGWXe+gs9TZbk6qPpL1YH
         tGcJ0Ni0R8GfvcRZgydzuQfo/o/wMN1CLg5Wm9Yrm+kl/trqdncsK1dd6Tg7HpEiKSKx
         8vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A7NUC6AajstAM2rRNdd54pVilaJ3jXs4RoWAQN/sufw=;
        fh=JIJm4yffd8i/cU9iAFqdBIv0hy9AsiVQ44y3wOV3KAs=;
        b=Yr+RfOQJ29x16pR9cPwzYaNXWyzbHbdOQI230Bp10EfHe0z3VrUq8IM/IRx0aMprFC
         IMRD89i6JxPYbXcpZOROT9vEhz6U5YMGV1CPJHiA4PdVCoTC3xck8RKJ3XoMYIYwxvF1
         Uf4iSFURjq2IlTatU6xow5ySG/VOKZ/cpY2mswnJjoLbUS4u15MTode8lJMdOnl9XdMT
         QrFy/QJczKaHITorsRcfI0fawwwaH2LKXivUxxYPuX6jZWV70V5zMq8pT2ufQJOQDfY9
         Npdu0DuD6eQMTJTO1S86yGeFxgojw1MHjPsv2Sb1hOqJoKZi5QWMdqqWGSGQyZooKIeN
         EF3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778511280; x=1779116080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7NUC6AajstAM2rRNdd54pVilaJ3jXs4RoWAQN/sufw=;
        b=X+NxNDpBP2RsE6LuXUqUhBJSVRie851XqMsW1T/tqKFmOSHlBo2qw8ISW+NPFiAOh9
         2ZzFwUvW7fChsc05bqnBs7w9ivcY7BH4q1li7mIRvTb1vgH2lObmwdRrEMttjtfmojs2
         6Oc9tGvkpECLd6y8Rv/4LrSeB4GVWotfHDVOJemg37RwZuPzx0LH56g30GtTr5+EEooz
         Gtpcy5mQua7l9zOFI80HgYcTEln9R0ENcD2bIGhkvMxG/0Z1tQfWY6C4moCw63DgZq9l
         AF7LW3Vp4tv/Apjm0fJe5iRMVTFZR7aghME8vRkaidYtA+WJyYglnhNvGtb5PYe3TP8I
         luXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511280; x=1779116080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7NUC6AajstAM2rRNdd54pVilaJ3jXs4RoWAQN/sufw=;
        b=Sx03b66L8pmoZGqSXHKBPxWjtiPZuy5gJv96XiDKhttmc/lkh2Skw/2ZnTeqSKsrmQ
         CQgvSqw2kunNeeL0TgK0AW+g9i2aXAtVc523UEaz0UGFP17hYsB92pZKC40rawvwGerB
         oF2QeXt50hKu66nsDRNnEVJiFUHU+Akxp+9/rXrdJfeARzauwPALHqsWcIzsEGajb2PA
         /xsbu2HeG2Bb+EyXWSOnxS2TYVqDkQh0S69YdnPjfwVe7KjXiixPjhENuKxz+5V2lg9i
         +HB6gIktQd22FNGBOb9ULrf+wVmYshEsMn7MGOMohmdPrA+iPBRG74UXTKZJ5gTysQZq
         O1aA==
X-Forwarded-Encrypted: i=1; AFNElJ+eeW7MIEWpcKjMAaBr4Mm6BHyKNpY4H/akWvcSPVDYEUZZXsV5nXwyKkHoS08JWGZNEscQAgPOJ/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvmko5J1+lX1IK9Fy3k2nUfmkRIC0w3i3vAQR84OzBqzvskLz
	lL1gzQ2nFVX6MiSCKTH4UhLBTCh1/uUD6Cd2kCcR9IpPOt0XEvqMwHnIxMdYEzjtFD7jI86XPGh
	tV6eVLRHf8BDw8X1d3z3QrefdgU8JBk94FoFBSjvkDw==
X-Gm-Gg: Acq92OHpSAYL6XghaqQLAKUaXL0wThu58yBflovtgLIPj8RNsFm+DQkWlcjbPGW5tcb
	RdnQ4Gm5Qr5AHBr2ohzm68qU3U75X5Gq4EIJCodJPXB8WQzUuWrLY/W11k6fj/0rJjgUWwPmru/
	6Dbl4/9eDWDuSYhvELiHN8YojFihreFvqxdu9tb5BKOD0xj3mP54nL4VfLOFHhTuXBD2Q/lpQ5h
	69TD1ef/bnkjkq41ZtqmB76VkeDlS657msMbyRtNUew/KJcZO4Dx6Py4MhDhFY/jNOtntBKspsl
	mqWJCNmu
X-Received: by 2002:a05:690c:f06:b0:7ba:fd82:9121 with SMTP id
 00721157ae682-7bf04c314ddmr148104837b3.12.1778511280347; Mon, 11 May 2026
 07:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com> <20260430045615.334669-22-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260430045615.334669-22-lachlan.hodges@morsemicro.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:54:01 +0200
X-Gm-Features: AVHnY4JWfsrKbkqzJ2r2MSmWzNdF30HH3zv6ON9KnU6Yl_xtARtc44QtPLgfbDU
Message-ID: <CAPDyKFrBdFxkGjj=y2Qz6Jx5A_HQbxh=nnwWHEtWK+NrADD-uQ@mail.gmail.com>
Subject: Re: [PATCH wireless-next v2 21/31] mmc: sdio: add Morse Micro vendor ids
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, Ulf Hansson <ulfh@kernel.org>, arien.judge@morsemicro.com, 
	dan.callaghan@morsemicro.com, ayman.grais@morsemicro.com, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 06:58, Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add the Morse Micro mm81x series vendor ids.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> v1 -> v2:
>
> - Use a single VENDOR_ID
> - Drop B2 chip which is not needed
>
> Ulf, a mistake was made in v1 [1] listing multiple vendor IDs instead
> of a single vendor ID and the subsequent device IDs. As for why
> the series is structured as a series of singular patches is due to
> how wireless driver submissions are as per [2] to simplify review
> due to the size. The final submission will be sent as a pull request
> with all driver files as a single commit and this SDIO commit
> beforehand going through the wireless tree once you have acked.
>
> [1] https://lore.kernel.org/linux-wireless/CAPDyKFp6dhmpkMCs=ejYTpR9oNbNz0urtFD2HTvRwOp2Y7H3DA@mail.gmail.com/
> [2] https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#new-driver
>
> ---
>  include/linux/mmc/sdio_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 0685dd717e85..111cb1758830 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -117,6 +117,9 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_MORSEMICRO              0x325b
> +#define SDIO_DEVICE_ID_MORSEMICRO_MM81XB2      0x0809
> +
>  #define SDIO_VENDOR_ID_NXP                     0x0471
>  #define SDIO_DEVICE_ID_NXP_IW61X               0x0205
>
> --
> 2.43.0
>
