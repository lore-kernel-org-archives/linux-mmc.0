Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42815357D
	for <linux-mmc@vger.kernel.org>; Fri,  3 May 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742124; cv=none; b=spx6rIK1BcJ3TWV36EKTt224W0I9j9I76ZJEfKUbxVDWPvNmh5E8jl7PjdyZ1iOqIDnEyf18PtHxbNdEMIXnWl5lms0ejozvCaX+EKZ/dMjj+LuYxMIz2nlxPFasC1ggw7Gws5ghrbN3R3XxSTLaxP+B8WThn5u/QpW0SouB3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742124; c=relaxed/simple;
	bh=iOsoxJjOUV7778a5f+v5Gk9wJ7+VI5jK7IIFUCRQf68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQZloqEplctpQ9jOtvKga3nERYZcWfHqWh+NTVs1bbyMBHbTfTVU7oagJcs+Fj99PUM9eJZDaPSafExiP485VhNKb3/Cz3KodMN3xM0B+1mVemDeRFEk8npTZgKIWSVqb5qlHDkR5vn8PRbtnu86/xPzB0TERrEDPuEfVY1JGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhynzYvy; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhynzYvy"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed0710c74so8441500276.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2024 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714742122; x=1715346922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLq+3ldTFmkC/ZLu9E0Ms8z2c/x8AMkKD/7KlY5TGAg=;
        b=XhynzYvyXZTiigZ1WcLsfHSZHiimpQDtWviVesEChURRaYmGdebrwxHHBHDgj1MJ6w
         IsI3Ep+K2JPVl+ymC5030iNsHGp+FbWiF2fODMnWmq4QOcYMS+rydiY0OfR4EyJrQCrl
         jBuWmmvy9pEaWw+FOJExTi82u6aOhnAeI2wpXpzDBrRi5xeia8n6UqOrHUmIWgzz6FvD
         H+0URfQsZPhewG1/gLKQ7o6j0Ip7CGNZch0tcZDWYEdpts6Ff6pdGZFq1Xh4lhly1D2H
         Kg7ZIugQPGgTVZTTJ9Usd3N2/BRJNS9ZmRiwCJSydRsUcv3G08+9AINYDZd80SS6RE0l
         yXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742122; x=1715346922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLq+3ldTFmkC/ZLu9E0Ms8z2c/x8AMkKD/7KlY5TGAg=;
        b=N0SbiPIrqLWQpVKLL/PxQTjGbivHceVLuBJFrpDOF4KAW6mdYX2S0wwxLfFqwEd9+X
         /dcRZ+FblVFaXMdovNwmEjviEh5CflBYh7ONAtUhTwbIZ8xnEz7pl1DsXQ1zQhPY0XwK
         bVUOygVMPp5wva+Vgc2QyzNSckVqLzabjVTtYVAj7fmBccqjskLnubC7HpsaXpKRRdbz
         DRF9tRgFVUFYs3q1fvKmxemWheVqDNark5iXPDKrI8zf4qOrXBjThN4cfyA0zdmangnh
         Ca8r3pTVNLpWvxYLK0JkZcfN3xg81xv79gWbjDVyqIBHb7gMbDEwyo+1SI+NVhP7Iiuk
         uFmg==
X-Gm-Message-State: AOJu0YzqcAYFVKrK3fbYUE5AXBfmduoE2WqTabZK9rG/a4u1TeFaGeJ2
	GbqN92IcLPu83NXFFoRjWG80o7z4KBkz85Yb4bT8BirvvhYmBbduxlYSPK+K8hczEr+Mne5sYwL
	vAPBkSXysrq//jnIJEXHEGTYCcgo/7gURLFnh645mKXsp1x0S
X-Google-Smtp-Source: AGHT+IGb2+3lzmUDIu32sJE9s96Mq/oVCyms3HOiZZGclgmK2xXpqqWZPwz7VuQ+PY4z2lTCP+2+0KjnTRHp+UKwOLk=
X-Received: by 2002:a05:6902:200c:b0:dc7:3265:37a9 with SMTP id
 dh12-20020a056902200c00b00dc7326537a9mr3025209ybb.37.1714742121933; Fri, 03
 May 2024 06:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429071955.163282-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240429071955.163282-1-xiaokeqinhealth@126.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:14:46 +0200
Message-ID: <CAPDyKFrqFt-fLtub1GrLugymQ+BQ=XK_XudZeGNopohw4+o4JQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 09:20, Felix Qin <xiaokeqinhealth@126.com> wrote:
>
> Extensive testing has shown that some specific SD cards require an
> increased command timeout to be successfully initialized.
>
> More info:
> Platform: Rockchip SoC + DW Multimedia host Controller
> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
> Note: The SD card is custom-made by the customer in collaboration
> with the wafer foundry.
>
> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> v2: Add more info
> v3: Based on the __mmc_poll_for_busy API for modification
> ---
>  drivers/mmc/core/sd_ops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 3ce1ff336826..a1c028303ba7 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -19,8 +19,13 @@
>  #include "sd_ops.h"
>  #include "mmc_ops.h"
>
> +/*
> + * Extensive testing has shown that some specific SD cards
> + * require an increased command timeout to be successfully
> + * initialized.
> + */
>  #define SD_APP_OP_COND_PERIOD_US       (10 * 1000) /* 10ms */
> -#define SD_APP_OP_COND_TIMEOUT_MS      1000 /* 1s */
> +#define SD_APP_OP_COND_TIMEOUT_MS      2000 /* 2s */
>
>  struct sd_app_op_cond_busy_data {
>         struct mmc_host *host;
> --
> 2.34.1
>
