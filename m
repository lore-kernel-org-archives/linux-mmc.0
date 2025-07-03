Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE722E6139
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545194; cv=none; b=i+5Nev34j+ehxaMVdwfW/HoYBemrDitgvmUPde/GxS13VcOYuj5XwkgWegEZ38kx2cGaLRRs2DuVGXiXoj4scBp5ysgZuoWPCiDZ5lgsQ/xMrDx0VHpFO06l3lOz/FthGc6n8WDHIxZeCZ4ptnFuE10WCCWO5w5k+00nLOJ/tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545194; c=relaxed/simple;
	bh=TMekI+ePGLb2dVGIQvd4eMWoX3DAqPDpxNlAHJXJ7ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gcp4jDfoIj+Oku88T5gmiBvX7/cX3w3K+e0Ew1GHzBInmcPx93O3k3B/BUSg9f1dZI8wG+MYxukAypEdlzTUbdr5saTurkMWXE65ASuybJvQl6tnbqibeRbV3tK5BQawEIUHGFvnOjUcMQ59IYXz+m5YknAQasLdyWV8veD2Nzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsFG6m01; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsFG6m01"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e3c6b88dbso58852617b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545192; x=1752149992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qTC597t48bncltdn47anMKlxgf1mIXgbQUWYTJlSUZI=;
        b=FsFG6m01aZ51iejphuFwUpt31/T+xR9uKywCpw7cm9ywNpd/LLHUjszKwZk5zye1B+
         t7bSgTzx00+un7s3RYZxjTOoYSxGB40D/zJ5bam2G/MtEH1eAMtHItdeFaVfrEpYt/4O
         6yTBRO2CPWGXi2W9VfvDEOTsi4ylB9QmH2g+MBaWF3h8/fB+P55CX2VCaivTyIc91xeX
         xjf+pTYigO5mru1+M0D+0zq8TRkV0O7cT5wJi9It0DHiAGwcvBbvEOg++3jvGJsNcDs+
         ObazsHRB5pHCOARh3IzqbaKTzVnllYMTFZLhycZAN2YqvEWqhk6VMFDKhm01xcsL50XD
         ZQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545192; x=1752149992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTC597t48bncltdn47anMKlxgf1mIXgbQUWYTJlSUZI=;
        b=mTfU0rlKexZmnA1nLAOHzGF9YRu19IYJjKVQDnkh1ZpWp0CwynBG+gH3t2ufexq1Ay
         KMYoLfb0HQ79+hibAwguTSGrF9VVkssrdA3gqjqjlel477jxka3UYES03vWvzvi4Ki9X
         hieSLRfbKZ596i2cTBrvm4OUE+ZCV0GkeUVboMHIYY47VN9cSyNlwmWxdgxMgswhBzDr
         sRAk4ByYPQaGKY1AcplvqFbDWk1sqRg1VL4VA1JdKtMY3acxWFwl5GZUsXSqrh2VP5tJ
         YtCjaXuKOJH7zY0uyRWLDrm3mfTuAnmI/hrIiHdA85qXlHpGLGp7vXIL2liIwSA3jHB9
         Mlrw==
X-Forwarded-Encrypted: i=1; AJvYcCWvQs11USW34lJacznVltXz4aSocj9Cp6/gtqk+dE6EtMvbnr3IKeq7k6kIBunzBGhxCjlGrYeDwDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6527NgtmAq7m+I9UAB5JmKJlgT9ozDCMt5Eb9IobhlZ16Obq
	+thUGfoG4rQ1Y+9b8tXjTDwkUMG74pbT33Sw2UaKcGMyFcWPhVyL1GRTkpSpAWvR/AWBm4SDyO3
	qee1VnxswnzYlgmcpnDIgFSTIrTQoOcXhUDwKP12c1A==
X-Gm-Gg: ASbGncubdgFF1VQHxOA/Mc1bOymyYq5Ejv9CytfS1c0WPB8nq+CuG/gK2w7iT4NQGif
	O+V/4J46I8kp5HbwUiS/R9RfPcmlyDEjuAF6nhJxs2c4BQU2A29dvXjV8/KRRAa+YXFzS8QFkRn
	hJU9zDJ3oujWjcz6/57xbZhVQKDN72jPxrRMij41UJYyn2
X-Google-Smtp-Source: AGHT+IEwi+jGBSSdoJm9iL9oKLTvyrTQHOBeWUAEM9l7fKOqqBksvPOst1zV7M7DzNv8oipsKvDD/lmQ+H+HLHXKg+Q=
X-Received: by 2002:a05:690c:61ca:b0:710:edf9:d940 with SMTP id
 00721157ae682-7164d5755b7mr87945397b3.36.1751545191877; Thu, 03 Jul 2025
 05:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620043517.172705-1-lidong@vivo.com>
In-Reply-To: <20250620043517.172705-1-lidong@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:15 +0200
X-Gm-Features: Ac12FXzM1OH6jEp4Aj99iKPDBaVLgh5QaSjxOO1gOJ_img1HJBSw-vdI_UPPTnc
Message-ID: <CAPDyKFp+w5UvpGKPtehqUrZHsAJ+tivLKtBcn8vJgOm1ZxWJrQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: Convert ternary operator to str_true_false() helper
To: Li Dong <lidong@vivo.com>
Cc: Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, 
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com, 
	rongqianfeng@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 06:35, Li Dong <lidong@vivo.com> wrote:
>
> Replace direct ternary condition check with existing helper function
> str_true_false() to improve code readability and maintain consistency.
>
> Signed-off-by: Li Dong <lidong@vivo.com>

Applied for next, thanks!

Note that I am applying this since $subject patch takes care of *all*
possible conversions (it just happens to one in this case) to
str_true_false() for the mmc subsystem.

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 0e0666c0bb6e..1f11626c8f47 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -38,6 +38,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/io.h>
>  #include <linux/unaligned.h>
> +#include <linux/string_choices.h>
>
>  #define ATMCI_MAX_NR_SLOTS     2
>
> @@ -2264,7 +2265,7 @@ static int atmci_init_slot(struct atmel_mci *host,
>                 "slot[%u]: bus_width=%u, detect_pin=%d, "
>                 "detect_is_active_high=%s, wp_pin=%d\n",
>                 id, slot_data->bus_width, desc_to_gpio(slot_data->detect_pin),
> -               !gpiod_is_active_low(slot_data->detect_pin) ? "true" : "false",
> +               str_true_false(!gpiod_is_active_low(slot_data->detect_pin)),
>                 desc_to_gpio(slot_data->wp_pin));
>
>         mmc->ops = &atmci_ops;
> --
> 2.34.1
>
