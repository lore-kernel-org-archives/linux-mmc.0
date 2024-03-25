Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FD1741C6
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372772; cv=none; b=cdj7ZyHwL++CAWVP70IkYooe+9kfU6H9cFgr1MFjCDtDi0VAHu6+uFiR/6q0f5CK0A8LX9NxG5pDxgW+P8NCXcG1jHO3WbS/IkSfZ0pQ9NHR5tcrKwLi0orW+BDtq/6clnPABST93NAHlnsifgFLJ5fqpna1bMfDFO6TpaLmw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372772; c=relaxed/simple;
	bh=S3ztrWHVVK9UHcsRBhMut8Zbxy+B9Pd1ajbC1PF1CI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr5mGcw9WKASn0H9kEkFCUochJmG71/yo/vnmy5bhSeow3B866T+pOxJXkjq98/F3zi24S2Gt4ult6DmG5miOn+smJpWZy6fAdXii+f/Jn+FCWvkK54TNX3/5qNhhn1NRu5eXlHWm8zMAwVZzJFtkzkoJbhDzlU11m/GKZtetjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ud1uag50; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ud1uag50"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd161eb03afso3606531276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372769; x=1711977569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zaHJM1cQ4tk4RAJvAvOT50AuQfeiLRm02aKBJ6onQM8=;
        b=Ud1uag50VCxwTFw+mzAl/L62GNxJYJA4YCKjenCYXG2LqOibS4QZpn8jbCUh4WfryE
         64FOZZ1JGLeh8ecKjaCe2zMzafqXJZTuylo7T5EczLJAkQV0EUwyK4bfItz+QA+qq5Kz
         8y5vAoOhxgkShuOstzHIe1XTxeb4XPcDZFHfhJjZ8JLYRRFGfa6lq7AYHViskhv1ONAF
         kN9RnGa1TDGFrn5yEtOx1RIR/hTVTI9IxkWd4m8q3VXmp0m+jP3ngTgcJr8ar5anwe0r
         3bNbtsw3Arf2fi2gLy3XRvV6DeMm6EZ3HEfUaFycEe05S8viLEnPA3AarXrC4+8oYn5t
         bmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372769; x=1711977569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaHJM1cQ4tk4RAJvAvOT50AuQfeiLRm02aKBJ6onQM8=;
        b=pD008P1r8S1NxW71pmX6qffVoXmDHB4EZJj4URhk0nIPM1NID980GPytTsKYq0FNWj
         rP4bNtOd8A08rZZUllOPW0i404VHj9Z/ugaZc5KMDFdnHZdUAZzr9V9npKZXbi232Sjz
         BCLP5SxsX1e8B8v5uzOF49fXIqu6Le/ymEtsrUL2AD83BJ1MO3OVpfzxl8HR0AgdHmxO
         vi0vkNe0z8hcL9nkPUXJ5AujaQ6Et8lh8JTctGWWGN9boMcB2HmIMIfQWTpqaLZVgJuL
         ISv1VANTiBEl++gjzYXtwxwWvRaG7sr+rAXanS2YYkc7pQPIsheXTEXSMXXC3jC7kV5/
         jdlg==
X-Forwarded-Encrypted: i=1; AJvYcCXITqBA6K7WNyfgF1ZmILkcO7zsrKajhbJuO6kAbJC1cAhiPUCMGxSRupW6kYrCin0M98FePU5hpV6ykxDwT0096Rs8qkRRlUM3
X-Gm-Message-State: AOJu0Ywhvm4hNzb548AUGUrewb+vCnIicfKo6CrjBrkGtI4vHVu+q4Ew
	31+eK64rs5dOnHjGgUbT+M21IZp86opZBUgEXJrju6ZLJV9wsrO6+ZX9z8DFBdLwTAAJj4JoSpY
	HNU6HJ0aTrvkuqwZSNS/bwhXIY/vF6BDAMWCWcA==
X-Google-Smtp-Source: AGHT+IEwL1Fzz+y6yDYUEA+s73WQ4xdBgsBLV+YWEgiHPVayo2OyLpJbCdfSahU/DqAW5XvVE7dU1KLGKxOSlg6MF6Q=
X-Received: by 2002:a25:ef07:0:b0:dcd:40fa:7bd0 with SMTP id
 g7-20020a25ef07000000b00dcd40fa7bd0mr5024611ybd.3.1711372769640; Mon, 25 Mar
 2024 06:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315234444.816978-1-romain.naour@smile.fr>
In-Reply-To: <20240315234444.816978-1-romain.naour@smile.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:53 +0100
Message-ID: <CAPDyKFqzCwTJzRniLNMRPs_rSvrsCTMOdDXC=APfKg7Zpnz4YA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: re-tuning is needed after a pm
 transition to support emmc HS200 mode
To: Romain Naour <romain.naour@smile.fr>
Cc: linux-omap@vger.kernel.org, vigneshr@ti.com, adrian.hunter@intel.com, 
	linux-mmc@vger.kernel.org, tony@atomide.com, 
	Romain Naour <romain.naour@skf.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 00:44, Romain Naour <romain.naour@smile.fr> wrote:
>
> From: Romain Naour <romain.naour@skf.com>
>
> "PM runtime functions" has been added in sdhci-omap driver in 5.16
> f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions") along
> with "card power off and enable aggressive PM" 3edf588e7fe0
> ("mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM").
>
> Since then, the sdhci-omap driver doesn't work using mmc-hs200 mode
> due to the tuning values being lost during a pm transition.
> See the report on the linux-omap mailing list [1].
>
> As for the sdhci_am654 driver, request a new tuning sequence before
> suspend (sdhci_omap_runtime_suspend()), othwerwise the device will
> thigger cache flush errors:
>
>   mmc1: cache flush error -110 (ETIMEDOUT)
>   mmc1: error -110 doing aggressive suspend
>
> followed by I/O errors produced by fdisk -l /dev/mmcblk1boot1:
>
>   I/O error, dev mmcblk1boot0, sector 64384 op 0x0:(READ) flags 0x80700 phys_seg 1
>   prio class 2
>   I/O error, dev mmcblk1boot1, sector 64384 op 0x0:(READ) flags 0x80700 phys_seg 1
>   prio class 2
>   I/O error, dev mmcblk1boot1, sector 64384 op 0x0:(READ) flags 0x0 phys_seg 1
>   prio class 2
>   Buffer I/O error on dev mmcblk1boot1, logical block 8048, async page read
>   I/O error, dev mmcblk1boot0, sector 64384 op 0x0:(READ) flags 0x0 phys_seg 1
>   prio class 2
>   Buffer I/O error on dev mmcblk1boot0, logical block 8048, async page read
>
> Don't re-tune if auto retuning is supported in HW (when SDHCI_TUNING_MODE_3
> is available).
>
> [1] https://lore.kernel.org/all/2e5f1997-564c-44e4-b357-6343e0dae7ab@smile.fr
>
> Fixes: f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions")
> Signed-off-by: Romain Naour <romain.naour@skf.com>

Applied for fixes and by fixing the comments Adrian pointed out in his
reply, thanks!

Note that, I have also tagged this for stable kernels.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index e78faef67d7a..94076b095571 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1439,6 +1439,9 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>
> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +               mmc_retune_needed(host->mmc);
> +
>         if (omap_host->con != -EINVAL)
>                 sdhci_runtime_suspend_host(host);
>
> --
> 2.43.2
>
