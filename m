Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F92EA473
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545209; cv=none; b=TU5fHHvg7++huUwld7SmU8e50ONjXBLPsfLir2uUPF6lMq/9qm4GHV15AOvvzGtHSloqaZhjfRrU3C7bmOeNYV+4Bm1KZ78Uhb1AWeNo94jV3Xd8wd95klNTfZsFeD7g4xmdofyXQuyIj44GcDaTFZtS9S1FeuunQjfPtnWljlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545209; c=relaxed/simple;
	bh=DaaFv8arGlHGPm5oC87p+hTcAPvrGVmo/YtNa3ziKvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhanRdFpzO0F0LrepT/QL9NTYXXcVkJdCXW6u1cJjC1zkHnlycoz/xM/1D0UPTiojsr+lni7wbsmyHuTBhD0G4Vag+Xc22NjmVFyigiF8qFc0pCJjPOP7BAFWBPhIaVVFvOZdO+yH+QDVpZeug2eS9Zx7GQ8Bf8zSUwBzkWgLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Un7AHl6e; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Un7AHl6e"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710e344bbf9so55749687b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545207; x=1752150007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K9/FTLpn5NiRGQ3LTafRamigGNZeC4WBTSQgNEibO8s=;
        b=Un7AHl6eqgCaUfwyW4/OVKUK9Ikbn6YrsFbYhgTP3OPtA+3SmTYaKvaDH8W8IwZMH9
         mqiOit+vZXjb111CTMrr0PA13Z5NzrUfI/9mkRLUtrbmG9OwJTx7aD26pwpaR58hPh3a
         6bKL7TITeEY0ndbuP4UpVkjdgv9g21oM8t3d6WkhPPrqJ2huXgKEUJ6orVQmf5jlT3N2
         bQXr5QRcHnRSRuHoXlfbt2Zj5NbMoL615w0d7HjDFWmZYgRR9f/+gbJtb1zfTDZDK+cP
         emotrxgPv2k0faywXq6tEK1oNYN/8TnxQ7RGG+UwCjtY3qgmNkg2wdDld07nCkr6H2l4
         dSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545207; x=1752150007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9/FTLpn5NiRGQ3LTafRamigGNZeC4WBTSQgNEibO8s=;
        b=gcPyZ6gtbi8AzcF9izgkX7lBx9P24QjiJibS86kD0FbU6JdoLHd5OhEd+0CJGm03zH
         sPbIES6jqBHfGyVzex2KO1HsXwKjhyydCyJsEEjEieBhwWCRTT0KRXR2HEe0R9Vzpk4E
         0gSLxlROY1DJN/fnyCeUtgSBnOXoP7mNkjfzg7r32uYpCIZBPxuAl5e2sAZTQ5kMeaG5
         hto/NLFbbWsqQ+HsjNY3kdqqVQTdSOo0F5Ngsv7x/JfA3bQZuvbcVZkTRDBobuX4zAb8
         zRt7MHATfNR0ERw/t9iNoBEfWDJLfe5jOaDQKfMmYCScquz5GPk1widj+YpweyfVXX4G
         CXTw==
X-Forwarded-Encrypted: i=1; AJvYcCUOJ/tM+vxgtNrYCAAe1S1ikrwbZZ9hKxGxPuyAyRknxR9/QOBnZlFA2vhU/Mg/2QIWty5xf002aeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpXbNfiHQpjvjOZyYPWeUtdsxytc3VSmMWsmGm6dCiy2VxRo2
	Tm3FQrX6vWVItUWL0GbklHSXk8e6aUdYVduNbkQ6AjmoSRakm9LfZ+bHXYdqjJLwVU5T+qczggi
	Y5chqILIgZEzVDwYuNcQv9fwh2QexFACYU70F9cGmKw==
X-Gm-Gg: ASbGnctAL9McNGcts7AXMjUJi/oe9ymkj4fmB1gqbmUr/J/lZiKbImkmWD33/U+hr3T
	QpZgo5hWhgHK7m+85nb+3Wfn5NubiBpQEjQSJIfxumz9klfjr2HOliygvSGD/P+r2JVxdjlNKRG
	SaGOEDs/7Ne9SBqWh4TaSmMp/qfDzclS/3VFtRJYyDy5N/
X-Google-Smtp-Source: AGHT+IF56qUTFIuC/dd5f/t6kaXb8O7+9gtfhTDmhN3Qt6B+PI0BaNXhbDG9tZDXH1SGEvegSmXerSSSuu5lHUdXJw4=
X-Received: by 2002:a05:690c:61c1:b0:70e:7882:ea8e with SMTP id
 00721157ae682-7164d46bde5mr101768967b3.31.1751545206699; Thu, 03 Jul 2025
 05:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626231452.3460987-1-jm@ti.com>
In-Reply-To: <20250626231452.3460987-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:31 +0200
X-Gm-Features: Ac12FXzPltRJ63gnLQjiDWMDi7jPRlN5Dcc8lvlBEvIo0x3Wdbqeqg10YzXGJm8
Message-ID: <CAPDyKFrbHEPJJzo9Ysc4NFKCHVJwBumZMo6+dSE4OvoBn-+fRQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Workaround for Errata i2312
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 01:14, Judith Mendez <jm@ti.com> wrote:
>
> Errata i2312 [0] for K3 silicon mentions the maximum obtainable
> timeout through MMC host controller is 700ms. And for commands taking
> longer than 700ms, hardware timeout should be disabled and software
> timeout should be used.
>
> The workaround for Errata i2312 can be achieved by adding
> SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk in sdhci_am654.
>
> [0] https://www.ti.com/lit/pdf/sprz487
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a fixes and a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - Split series [v1] according to Vignesh's review comment in v1
> - Add Adrian's tag
>
> v1: https://lore.kernel.org/linux-mmc/20250624221230.1952291-1-jm@ti.com/
> ---
>  drivers/mmc/host/sdhci_am654.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index ea14d56558c4..86d87d8e0675 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -613,7 +613,8 @@ static const struct sdhci_ops sdhci_am654_ops = {
>  static const struct sdhci_pltfm_data sdhci_am654_pdata = {
>         .ops = &sdhci_am654_ops,
>         .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  };
>
>  static const struct sdhci_am654_driver_data sdhci_am654_sr1_drvdata = {
> @@ -643,7 +644,8 @@ static const struct sdhci_ops sdhci_j721e_8bit_ops = {
>  static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
>         .ops = &sdhci_j721e_8bit_ops,
>         .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  };
>
>  static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
> @@ -667,7 +669,8 @@ static const struct sdhci_ops sdhci_j721e_4bit_ops = {
>  static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
>         .ops = &sdhci_j721e_4bit_ops,
>         .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  };
>
>  static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
> --
> 2.49.0
>
