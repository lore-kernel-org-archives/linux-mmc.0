Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42D2EF9C7
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634432; cv=none; b=VYsmf43+UhDSSy2XtK6/uPWNWS+rMuvodhIBFlItIq7lXSSh0vkVq5NkwKhAth8AU9B9GcDz6HgLuG9/cnh1VB0JG1cUqVLEEf3iRidFBwcdym5hSHiNI9nLPuq6Fc9VEHuWGUW5Yj1GitQ9IWBt5Q6laGcBtVr2PyzuRh2OyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634432; c=relaxed/simple;
	bh=nJm/JpQ5hKG28cvJdC+Vz8Bb6+JygvwJ/6EqwdB87eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRz5pWE2h7cjYlVGDE3AUPKJhAmsJoCHR4Z68F2N1N45QQtXiG20UN8O+VAUF5EULm+Ve7+lp3nV+dYbU/q8MNJNVwi+QfKwejzM2SH5S8/sOzJQHzBKyeLPqg68a4w7hvTrs0wEASS4cAxnqhuT4csgzI5sfPxFKGKyxrsx+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d51i8lu9; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d51i8lu9"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e5d953c0bso9591337b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jul 2025 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751634430; x=1752239230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BG7Ddm0bR/bFSHtYHIkPOCI2Tm2uR+6ypTPEQJ0cjd4=;
        b=d51i8lu9fsYnnZIiAwzejHgUSqYLGqYNxovh/tPfEdMDr9u2dTCNdF03JC6BO7+4ZN
         O7C50LprEOrjE+pZsWPTWQ57hrXZEK4ZRtqcw7H2818m6i5FYO6kbXOunzJOZ18CTkGF
         OIkY3Rgjj64tY7cbAw+eL3e6eSlKe4jEVscoHJ8WBd/1ldlnQFUC++7kFL24tNsIYSdx
         IX5605v7qT7BPPGlkbD0uNOrqE8df0RjEG5kRL4AP10uTLLZ8L2EaSylIbWvDdRImoFl
         VgqmxmF4K0Kgxzljnf7OR4SqxvOemNo1tMdMgGcsFsWAf0l37ntli8CyGmXPmf5WK+xg
         VSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634430; x=1752239230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BG7Ddm0bR/bFSHtYHIkPOCI2Tm2uR+6ypTPEQJ0cjd4=;
        b=Yojw4wAVDUL/L+PhCysOrYdcyYIeh43xbJV9RGdxwpG0gzS1fRSsTjvs9NoLDLhJ4K
         Ju39Lo80xy91uTeSR4FyoP+1CNkx8uSEt+T3XlOGW9YXjK91Ib4e/nYCmIUPbbfRuUei
         DMdWUeggXP1ZHekSKQAHqizGSpND4T5eGCHWbgtoBXgYbqgb838+Q5Q2mm7uPW/zV5lf
         e2aHLQjxxyaq1inPtYfVAXziq3bBHpZA9183F8ir9CDx3ysozcEPXfKiPZXynv2QDZQV
         VQ+dCyGPoV3y01WolGQQisd4CFBJjksb8dN57VxSWypVDlNwHcCeqw9imNLGSl7XlYpJ
         eX0w==
X-Forwarded-Encrypted: i=1; AJvYcCV0tnA8OnQ8vA+ATMikz6cOtJsP/YFtxc/49eFF5rkj5py+ISyKN/tI8ziFSyWElvVZy3PY32cjyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEiXvu7kNKuUuadwaspHGV4A6Pn2dTvGFnZ5c2OhkpYQ6yGt6
	tA9hijRdoOWhX1onqeIKXWDb6FVo5NrzOkLTf/LAvK21/JvMrAsMo422xq7BhlFQ1H2JI9xU4yk
	iQAs7HSOXHvpsUqCXBFkULn6AYvDaPgYTvwCkHRK8qw==
X-Gm-Gg: ASbGncvPYJb484Ja7vmoVFMkfo1oGBCKdfbCimKFi42Q7WqBmLFC4f0C2nCcnMSEdxe
	XDoOKmRE9vvk9UGvO/cPAbX/yuatIet4m+6IC615CiVT8VHR2Vh0NTKHhGX3qcxzf+RUDkrpjps
	zhI98dCuuH8RYTUwhuQPH9QAZlp+RyJuG+yKYsg6u3YDUbH5KJ9NlVsqc=
X-Google-Smtp-Source: AGHT+IHkK5WfjgtTvbpa7FiHK9LpczpbZEvDoq7LGvHzI0T4YifFQNw+iZp3OmqZXE4hZCZq2dpYRO3HjyYzWWHMR2Y=
X-Received: by 2002:a05:690c:4d09:b0:714:5eb:b589 with SMTP id
 00721157ae682-71668d3363cmr35142727b3.35.1751634429706; Fri, 04 Jul 2025
 06:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616102917.1677116-1-o.rempel@pengutronix.de> <20250616102917.1677116-4-o.rempel@pengutronix.de>
In-Reply-To: <20250616102917.1677116-4-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Jul 2025 15:06:33 +0200
X-Gm-Features: Ac12FXzv7Pd-8fWA59Oqv8197-6dQGgVmGYpCLugpkdpMpUcPsrs0HUnWmT5i44
Message-ID: <CAPDyKFqczOb2i6XHCmTyLr-AOm89zdnP8Ti-xNMEJxCrR6zOjw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] mmc: core: add undervoltage handler for MMC/eMMC devices
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 12:29, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Introduce `_mmc_handle_undervoltage()` to handle undervoltage events for
> MMC/eMMC devices. The handler performs a controlled emergency suspend and
> then marks the card as removed to prevent further I/O.
>
> This is achieved by calling a new internal helper, `__mmc_suspend()`,
> with `MMC_POWEROFF_UNDERVOLTAGE`. This ensures a fast power-down sequence
> by using the short power-off notification and skipping the cache flush.
> If power-off notify is not supported, it falls back to sleep or deselect.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v6:
> - Refactor suspend logic: move cache flush skipping during undervoltage
>   to a separate, preceding commit.
> - update commit message
> changes v5:
> - Rebased on top of patch introducing enum mmc_poweroff_type
> - Updated call to __mmc_suspend() to use MMC_POWEROFF_UNDERVOLTAGE
> - Dropped __mmc_resume() helper, as it is no longer needed
> - Updated commit message to reflect API change and code removal
> changes v4:
> - Drop HPI step.
> changes v3:
> - reword commit message.
> - add comments in the code
> - do not try to resume sleeping device
> ---
>  drivers/mmc/core/mmc.c | 76 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6812df679ba9..fe4fc2ad261e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2120,7 +2120,7 @@ static int _mmc_flush_cache(struct mmc_host *host)
>         return err;
>  }
>
> -static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
> +static int __mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
>  {
>         unsigned int notify_type = EXT_CSD_POWER_OFF_SHORT;
>         int err = 0;
> @@ -2128,8 +2128,6 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
>         if (pm_type == MMC_POWEROFF_SHUTDOWN)
>                 notify_type = EXT_CSD_POWER_OFF_LONG;
>
> -       mmc_claim_host(host);
> -
>         if (mmc_card_suspended(host->card))
>                 goto out;
>
> @@ -2156,7 +2154,17 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
>                 mmc_card_set_suspended(host->card);
>         }
>  out:
> +       return err;
> +}
> +
> +static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
> +{
> +       int err;
> +
> +       mmc_claim_host(host);
> +       err = __mmc_suspend(host, pm_type);
>         mmc_release_host(host);
> +
>         return err;
>  }
>
> @@ -2219,6 +2227,13 @@ static int mmc_shutdown(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       /*
> +        * In case of undervoltage, the card will be powered off by
> +        * _mmc_handle_undervoltage()
> +        */
> +       if (host->undervoltage)
> +               return 0;

Maybe use mmc_card_removed() instead?

BTW, I wonder if there are any other places where we need to add more
bailout points... Let me think a bit more about this...

> +
>         /*
>          * If the card remains suspended at this point and it was done by using
>          * the sleep-cmd (CMD5), we may need to re-initialize it first, to allow
> @@ -2309,6 +2324,60 @@ static int _mmc_hw_reset(struct mmc_host *host)
>         return mmc_init_card(host, card->ocr, card);
>  }
>
> +/**
> + * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
> + * @host: MMC host structure
> + *
> + * This function is triggered when an undervoltage condition is detected.
> + * It attempts to transition the device into a low-power or safe state to
> + * prevent data corruption.
> + *
> + * Steps performed:
> + * 1. If no card is present, return immediately.
> + * 2. Perform an emergency suspend using EXT_CSD_POWER_OFF_SHORT if possible.
> + *    - If power-off notify is not supported, fallback mechanisms like sleep or
> + *      deselecting the card are attempted.
> + *    - Cache flushing is skipped to reduce execution time.
> + * 3. Mark the card as removed to prevent further interactions after
> + *    undervoltage.
> + *
> + * Note: This function does not handle host claiming or releasing. The caller
> + *      must ensure that the host is properly claimed before calling this
> + *      function and released afterward.
> + *
> + * Returns: 0 on success, or a negative error code if any step fails.
> + */
> +static int _mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +       struct mmc_card *card = host->card;
> +       int err;
> +
> +       /* If there is no card attached, nothing to do */
> +       if (!card)
> +               return 0;

This check should not be needed. Refer to my comments on patch1 for
more information.

> +
> +       /*
> +        * Perform an emergency suspend to power off the eMMC quickly.
> +        * This ensures the device enters a safe state before power is lost.
> +        * We first attempt EXT_CSD_POWER_OFF_SHORT, but if power-off notify
> +        * is not supported, we fall back to sleep mode or deselecting the card.
> +        * Cache flushing is skipped to minimize delay.
> +        */
> +       err = __mmc_suspend(host, MMC_POWEROFF_UNDERVOLTAGE);
> +       if (err)
> +               pr_err("%s: undervoltage suspend failed: %pe\n",
> +                      mmc_hostname(host), ERR_PTR(err));
> +
> +       /*
> +        * Mark the card as removed to prevent further operations.
> +        * This ensures the system does not attempt to access the device
> +        * after an undervoltage event, avoiding potential corruption.
> +        */
> +       mmc_card_set_removed(card);
> +
> +       return err;
> +}
> +
>  static const struct mmc_bus_ops mmc_ops = {
>         .remove = mmc_remove,
>         .detect = mmc_detect,
> @@ -2321,6 +2390,7 @@ static const struct mmc_bus_ops mmc_ops = {
>         .hw_reset = _mmc_hw_reset,
>         .cache_enabled = _mmc_cache_enabled,
>         .flush_cache = _mmc_flush_cache,
> +       .handle_undervoltage = _mmc_handle_undervoltage,
>  };
>
>  /*
> --
> 2.39.5
>

Kind regards
Uffe
