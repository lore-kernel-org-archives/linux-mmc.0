Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05564D8A9
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jul 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441467; cv=none; b=oQLyzg6GwJRaWzIArgo6oVCn4yyqTIcquBSszLrLO4qy+JpE/NGiZS+VunJhl3RkkCx14nf7VSyo0SK6DFVVRv8VuRVwik+NQw+IguUt92tjR1vUvLPzZlZvkfC7lNtwPr7eGzzEVasP6/29PgvxHQdsjDfCUOIlR5QsLyWuUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441467; c=relaxed/simple;
	bh=1xFKym8dQ8FXh+MVHNBwonqkHzr6DWBX3Kyt4hlGpiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpJgSOpxg9PXe4ivRGb//m6reYPUraSf49ddwuRkCEvTti8i3ULBvHxIKShpb/1rBSfUHDL1OX6BIWsQjw0uvIgHi5XlBn8lXyn0voL7i4o8p0Ewr0au/ZL8eDlLUZY4OhIIKlB5q7ZR/H//CVfCd35L2k38QBd7MtK+NZD/oZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9xppOHJ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9xppOHJ"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e036eabc97dso3759555276.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2024 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441464; x=1721046264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ1ByCKJaiGZVgPD6N72f5VJmXfUYBIFakOZFv4yIy0=;
        b=F9xppOHJUTtFfwYR2vkSSUUtFLT0aDSMVrMlmyCvxkf0N8dvIr4DMX9iG9aR75u4mL
         xyvsAJVSCWideKl+KqWhlOo9sJsoEoYJJl9/6GBJ3DL00lSDy+gbIZCxxryyh14oLSe0
         RKapUUq3WRMDHyecfqaG61nctwni2B0nokowRk80Bl/U6eKbc8eAi19IYXAQ5XUS+5Q0
         wyz/yaQck4o79raKw3k3VxF5/cXsvBQc5KoAvqP/xygcqmgHjsh28yDLKIEdd6g/61d5
         7KoX6tsEDKp93cXrM6jXoQIrRSyEycyGo6mt/3NlJnGfG+B8sFR/RpIGhIetbW6EmFIg
         B+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441464; x=1721046264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ1ByCKJaiGZVgPD6N72f5VJmXfUYBIFakOZFv4yIy0=;
        b=a7P0VoeB+EoapXlDDGxungkd8GWNauEO6iqFzD1XDwMk96Sd/nOdS83K7jV6AVW8rp
         IcXSNn8PqvTfyqtpoHEVl/aHQfOPqOwdH33WQUIfXl4+5Opzs2tVDo7AkgHNYbVrmZu9
         B+XxN3j+L79RMXKzoBR8JtTXe7xYjr4N6ScFbp0ng+9yZQhIXnVPF/fpObnQ3jra848Q
         ISbSNnE2Y6WeFzbRLd2cWy2qjc34LYIKeRf24DgsBIlZSx1Uq3750yBpdScG+43Z5roC
         1WO3bETM8A35Fwn8Zd+/Ye8GYoTfR6l422ThqSTeHguQ6ChSLxYv1kMOGHqCJN+bWcJY
         ZhDA==
X-Forwarded-Encrypted: i=1; AJvYcCVegX8sjWRZp4SBE20Op41FGiFBvP8ZqoJxT1fQ77k5t4Sw95s1i/xE18XqYLhi2Bgsi4RLyoBc64bicic9BFRNOFJMx8gjJLW0
X-Gm-Message-State: AOJu0Yz+2mHtMUcwhIwJvEY75+hG36uDf/yS4yZjqTCNmvwhgSd1jRMS
	gTTl2ouEC1vmP0V17fql7X2oavibSsK5QTne71JoMgNXHrwHE/gyiKjnGP1BhNH89NAY5J1D366
	Kl2xJwpIbVe4coVb2QVqNwS+ilsC7k6pRYyhogQ==
X-Google-Smtp-Source: AGHT+IHXRCpDO5w5I6A8pgDd0kHVsaSbPwgXD0RiAPY/CcfQGVwHI08Dh7BT8l+lLl1/7EtPVj7YMrFfreV6YKbUjqo=
X-Received: by 2002:a25:dc01:0:b0:e03:6544:1678 with SMTP id
 3f1490d57ef6-e03c1a006bemr12917519276.56.1720441463735; Mon, 08 Jul 2024
 05:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-gigantic-frown-1ef4afa3e6fa@wendy>
In-Reply-To: <20240625-gigantic-frown-1ef4afa3e6fa@wendy>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 14:23:47 +0200
Message-ID: <CAPDyKFoswLvgopz+cXCsxjZs4VRg-mrA66HTmfux57eY=--JMw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-kernel@vger.kernel.org, conor@kernel.org, 
	Cyril Jean <cyril.jean@microchip.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 14:34, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> Some controllers may not be able to reach a bus clock as low as 400 KHz
> due to a lack of sufficient divisors. In these cases, the SD card slot
> becomes non-functional as Linux continuously attempts to set the bus
> clock to 400 KHz. If the controller is incapable of getting that low,
> set its minimum frequency instead. While this may eliminate some SD
> cards, it allows those capable of operating at the controller's minimum
> frequency to be used.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Without the RFC tag, but otherwise unchanged.
>
> rfc/v1: https://lore.kernel.org/all/20240612-dense-resample-563f07c30185@spud/
>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Cyril Jean <cyril.jean@microchip.com>
> CC: linux-mmc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/mmc_spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 09d7a6a0dc1aa..c9caa1ece7ef9 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1208,7 +1208,10 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * that's the only reason not to use a few MHz for f_min (until
>          * the upper layer reads the target frequency from the CSD).
>          */
> -       mmc->f_min = 400000;
> +       if (spi->controller->min_speed_hz > 400000)
> +               dev_warn(&spi->dev,"Controller unable to reduce bus clock to 400 KHz\n");
> +
> +       mmc->f_min = max(spi->controller->min_speed_hz, 400000);
>         mmc->f_max = spi->max_speed_hz;
>
>         host = mmc_priv(mmc);
> --
> 2.43.2
>
