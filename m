Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444F402426
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514032; cv=pass; b=q9Me8vFnX4vkS1ynkUhYLXqqf80okWyYvw5SMArC9Id5AQ2NMmwNUqFLlch9KOINz1MguXOdofh6u97eXtUSkiRZvGRh6zMqGfO/vSA3RamueJElzhUB45mPyUfoHfYxKv8Gda8r/caWNdSEYoc2gySSKZCc1zFwYSq1F7COvkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514032; c=relaxed/simple;
	bh=vzPsyCU68Dhhv7LQTfOuati2QdkTeiv8VHreYp/3AJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSgxbP3oS5D+iEb+zKD8dQ3fEPg76ZfD9Kp1bbXnLojhHfyMf0I9VdudhwY7uOVjiTQV0JxHHLgRPS4JQpjPIq8BhtFgvcJm0cPZyRUvSDR4Gktdwgx0bL/uTkzySZg7iYYQdRdPtIgCTCjZTrdWVa7RGPseYIhC/HJcDoYPjAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLJjhQvT; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLJjhQvT"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so4555730e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514029; cv=none;
        d=google.com; s=arc-20240605;
        b=WLaiT/X98UJc4Sbr2uxoW2WtWW/1GBM4mM2aI/d1SmjPno7sbN58IeoXPDq6yeOjFy
         bWy2rpj62xfObojH8vUkTxKAk8kWJnb/1yAkW/waOuVLHXDvFpz1SG0w7/nSvdtowAZt
         5zJrJQHJswdFHkkMhJlpgSjztXcQgKpE/AcB/IWksxBQpJlaK+HIPwBUes28JqbZoTho
         MNeJJxcZfVQqMJy2s68vau/VnOuVjOQKtp2K2V2iDVKgLx49oceV0ndXD3DSgoML4dOT
         QFU/8adpbLhIKjTjoQf7V1ijJ3+44C9RYkoAzXbxXoc41L7ZdoJSk5ihNCsj6XAokldq
         PLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=maWaaDBF4FSKv3fhW5sPeSoRefEh76XbbWIlRsXK+yM=;
        fh=cgGTmbZUXf6zITVtB+RHtdLtSIf0dNza/Bps/ks3I8k=;
        b=JnbI8Bx1npAz73PoN2BvEIWyAzRRAjT2wf1OBWP0kBELz58kNvfmiNt/vH9HKAOxCl
         DR6cdZaEgwR9J8MrBubYQ9xHXbSwM7OR1xU0RBLgJAw3DrZnQRtPKLGb/poee/EEr4Cz
         yrjFVmlk1jyFzxi6yZB8TKIdUbIBWIU/DD/ACx7YrpHNi70NjzlAhiUVvskFw0T84Mn5
         JCaituACcgZVzKljQoXRIMl2QiDjOHQYvlczjkD0taPI36DguKzC9ikcxvEatNoZay/m
         m6BtxTXYLyzX3D+A3iIvm9cuAAE3hV5qr8ECWVFic3NpLBcklPjpX3FiCg16hIQBKUH4
         tgVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514029; x=1779118829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=maWaaDBF4FSKv3fhW5sPeSoRefEh76XbbWIlRsXK+yM=;
        b=YLJjhQvTZfkueKHLJEqJzwz9QI5Pc2kVyfgvNhQSmmTl/QqkxZrFRnW4UmxccaYhUR
         fO8N7tuUxRFHCH9NVbhgQGGBDwxTqzbzMjnav1R2a+vmCG7CkcrHgKzLPZBuvEX2UYK1
         NP+r09Uu8oOSoQZWD4JuRj6UImWdIjFQexGgbT5PoA7mqGuEzf/DeJC3kzRVghp2+4Kx
         Zg5JdWDtF4ThdRVuCCznT0gebYIvU0OPOTCdr9v8qaBpCnlhZGw+Q6o6o1n9s/mSvs/x
         /p2ySWEHpw95WrguCO7mQ3FhJ53qZr6QCs9836peuA+ZGzuAlDmSJuVCfJukc1RLKe2E
         ptFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514029; x=1779118829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maWaaDBF4FSKv3fhW5sPeSoRefEh76XbbWIlRsXK+yM=;
        b=IKAfndVNq7OcZU4MKIc/2DGJtwNmLV3xQfgaThGeb9XE96XkqpuwtcKdLQ4bpMpAAj
         zeJy2+rqCuDSxyd76VLx76R0dAir5WFOiS+BN/qMV010m5nFhfCxtIfzMx+SqcPKSby6
         IJT//XXGNbV1YXHAqpJ098uVQx+i+5W2ooh6T8YVTWVt+J85wZFPGEWjFXaBOkNjzcsf
         o2QUyJtG4o4G3MamOYX1Euapn7cG0H3RSMwHqUbt3D7YG4Z02t4zO+MTdXtWDkMlAB0Q
         f0LjjdI7h5wLOGB6fRf9HQdiXLS84EgPTGyE0We0plSvCmSE7pQt1BsB0dKUCuqW3toR
         GcWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lGYYAB2Qef9G5RonKbwhhk76tQL4Z/hf4mqdm3a5B1/2JJGE8x3xuAZ02IjBf2QZqPOc7kPI8LGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42Aq3KVS/CUYT9q5UWH2NBAETkytO7aFTPsYR74ZWqpR4nP5j
	p0wINJy/1cpFoqN1APQvWICTOnCTBeKa210A+k1rHkMJXOCYJGIMkTRUwzOC6w/6mX77Z/W9v9k
	wh8pHeQ4pd8UnNQDOEx+j9uCxAXrFoFzQwidpW4QmmQ==
X-Gm-Gg: Acq92OGbsPHS/qtb5qyHXMlYMZ9IsC1MzykCUt7kkct/F7pCx/OQYYkcqqoojiPsvRT
	Uz1WmWY4p5IJ7IhW1ATiUNjPTzbUWsF5rd3un/Z6XzIcu6Yw4opdnswvjFMoScV04F6uBVBxY/l
	hgkh+7fW/9A0jUTzGztrLVW91GNPWXVbfsYrUaMLiYYqCxfsv3ei8JucfHwvYFawXJKWlROvKeW
	8tjrjRpo9CbdqBjs+cP8ySUUx2xubHmDfyvqSE8qJFeOGy2wEuwFr5NDAcIyNZ7TSBQP38Qjpvn
	BkDjjv+y5h0+P0BJCBQ=
X-Received: by 2002:a05:6512:4008:b0:5a8:80ce:ba55 with SMTP id
 2adb3069b0e04-5a887ae1e90mr8207073e87.11.1778514029155; Mon, 11 May 2026
 08:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423191853.1053936-1-kamal.dasu@broadcom.com>
In-Reply-To: <20260423191853.1053936-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:46 +0200
X-Gm-Features: AVHnY4L8xqR-afLFR_hQtpgLS5BT6FyA28bJr2Ss8nlaeUn6QeIjeQRwDq29oKI
Message-ID: <CAPDyKFr_6WQDJpPM4dH6sZf4eK691r4K0fVJK3b4oi423A=6ug@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: fix host controller programming for fixed
 driver type
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Avri Altman <avri.altman@sandisk.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Apr 2026 at 21:21, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> When using the fixed-emmc-driver-type device tree property, the MMC core
> correctly selects the driver strength for the card but fails to program
> the host controller accordingly. This causes a mismatch where the card
> uses the specified driver type while the host controller defaults to
> Type B (since ios->drv_type remains zero).
>
> Split the driver type programming logic to handle both fixed and dynamic
> driver type selection paths. For fixed driver types, program the host
> controller with the selected drive_strength value. For dynamic selection,
> use the existing drv_type as before.
>
> This ensures both the eMMC device and host controller use matching driver
> strengths, preventing potential signal integrity issues.
>
> Fixes: 6186d06c519e ("mmc: parse new binding for eMMC fixed driver type")
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8846550a8892..05444ecf3909 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1371,7 +1371,9 @@ static void mmc_select_driver_type(struct mmc_card *card)
>
>         card->drive_strength = drive_strength;
>
> -       if (drv_type)
> +       if (fixed_drv_type >= 0 && drive_strength)
> +               mmc_set_driver_type(card->host, drive_strength);
> +       else if (drv_type)
>                 mmc_set_driver_type(card->host, drv_type);
>  }
>
> --
> 2.34.1
>
