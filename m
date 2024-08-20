Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4A18E370
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153650; cv=none; b=SkrRu7LOTendvgipWoID31uw1tUESgBbHIjQkFaWO4OlqFcsCYGf3aO2lgcFTuK8m0KnYzoGYSsB0HjrSpn0piGfSHvNLos7baNKDnOQzXwuagyROobAVNVINoH9UpcvXt7vL55xLgjQbgUraYjlmkzCOeGHN3NlmqOJpkxLoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153650; c=relaxed/simple;
	bh=V8yPuizcIylxeDCeOzPGi07mQj2+6phX/qbJUs3DZfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVggTa/y0zbp/u2gxYrqAgF0Ek0SuULhMC0dnaAJHEyWJgR2RzqprlTrNG0wk2XAVZxBz9xPKgCzxzIQ5sZewW+wcyj+8b5Ze6r/uhV/vfYmwQ6aKuqDUhWiAvM3/jPu0sD2prlcYiUhg1qyNupP7aQiQo+NKpXHa2+AHTu6j6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsPjizOU; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsPjizOU"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso5310310276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724153647; x=1724758447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tfzk9n1IikXnAiqdG2H8JF5Wb4UFD6B8FqPf43l4vMQ=;
        b=rsPjizOU8V0sK7xcG380IBpDZaD+0Xk9tYLz3PrhdZbO0vO/iyTmRkcBd5NDPAdjiN
         DJpeRNHryZ1Xq/ernYzYtT39KJFEUMs+z9VXGp1SaC6nX1wEoXm10QpHwED+EyfK/bED
         qt/si6uiH2TwWc9v0idtmjq5uPyfbxAFtxMIKwxbddcF+3KXI0NGbn0nVMLG+RMopLgT
         Vaj3yIsOpaK/5k2FFNBct8ne6qAym7xmtpvpOVsMHj5Y3uz+3I36aWcs13dQ6VW2XeRX
         rSlPHY9QAm8JjMdI38ZOA6J53qo6J0CY+nvmdUYg0b7/fKKeSCDl/OOxH6uaHVbCwb0P
         lSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153647; x=1724758447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfzk9n1IikXnAiqdG2H8JF5Wb4UFD6B8FqPf43l4vMQ=;
        b=QUq7np0FHE39ib5LsL2ivMKiypXogu6VAUM+TL24CpEvbHuI+dVZTBnw5ld6IjpPG7
         BVULeMnhucUU/t+/vnFRiOPxn1YF/e7eZmF2qDOc2yT7OIs9UL5e2HP4eq4VP0pbn8UA
         IheaI/GPAfQpkQEwltW1e7OUf527qbWRu/HKqxqWmzlUm8ZBcxKQvRCQ55c/TdWMZ6+u
         wsyl13OK53I5Yi2KinBSe1o0wr80szVNYmjlI3cnCsyvsTelEqIKcVej9/LFtCQFrbkz
         YuO3J6AosgeBs4RcMGkQyFLBWVAXzwYiebgvaZaVuqUatEm6CCv7RaPtq0kDHe4dnkQ5
         5dKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgbqsF8F/M20GL6IjntoYw4yJPo94ceotfuTP7fI+dEYYVcA7Is/Wyl6S5WSaqadNiZTjcRKc17UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeJlDG/RkrrX5zyEwPqbJAV/fiatok/iea9KLSI2dfqRRslUQ
	P6U+d2KL3Fk8OyuWSDR0llLLIYZ+kMwUb4SRicUvAWpa6Hhok6Y8PoEwaOZCfVh9nWh/jEA/0So
	oWYBqQar+ZBeKWnhD1Y/7QobK5hANnXF0QvRL8w0Lye5vLsbz
X-Google-Smtp-Source: AGHT+IHkfw0AJu8RuBQC2kePHD2sJITUraJr5xbXPvkPjc37kfnNc0eDyFECKEmVdGoyjdSG8ua0Yxk2HpjOA8QIHzg=
X-Received: by 2002:a05:6902:2b13:b0:e0e:8319:c6e4 with SMTP id
 3f1490d57ef6-e1180e9967fmr15935198276.8.1724153647422; Tue, 20 Aug 2024
 04:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815201542.421653-1-jm@ti.com> <20240815201542.421653-3-jm@ti.com>
In-Reply-To: <20240815201542.421653-3-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:33:31 +0200
Message-ID: <CAPDyKFpb0o2w9=nRp98XnqoLKtFOCDssJzy+53mg1bW8y0UmUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Add tuning debug prints
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 22:15, Judith Mendez <jm@ti.com> wrote:
>
> Add debug prints to tuning algorithm for debugging.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index c3d485bd4d553..a909f8de0eabe 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>
>         if (!num_fails) {
>                 /* Retry tuning */
> +               dev_err(dev, "No failing region found, retry tuning\n");

A dev_err seems to be too heavy, but I am not sure at what frequency
this could occur?

Why isn't a dev_dbg sufficient?

>                 return -1;
>         }
>
>         if (fail_window->length == ITAPDLY_LENGTH) {
>                 /* Retry tuning */
> +               dev_err(dev, "No passing ITAPDLY, retry tuning\n");

Ditto.

>                 return -1;
>         }
>
> @@ -505,6 +507,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>         struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>         unsigned char timing = host->mmc->ios.timing;
>         struct window fail_window[ITAPDLY_LENGTH];
> +       struct device *dev = mmc_dev(host->mmc);
>         u8 curr_pass, itap;
>         u8 fail_index = 0;
>         u8 prev_pass = 1;
> @@ -542,12 +545,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>
>         if (ret >= 0) {
>                 itap = ret;
> +               dev_dbg(dev, "Final ITAPDLY=%d\n", itap);
>                 sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>         } else {
>                 if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
>                         sdhci_am654->tuning_loop++;
>                         sdhci_am654_platform_execute_tuning(host, opcode);
>                 } else {
> +                       dev_err(dev, "Failed to find ITAPDLY, fail tuning\n");

The commit message only talks about debug messages, but this is an
error message. Perhaps update the commit message a bit?

>                         return -1;
>                 }
>         }
> --
> 2.46.0
>

Kind regards
Uffe
