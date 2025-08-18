Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2630F534
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514515; cv=none; b=HMcGqXowzEZ26bAkU1Z8xjTca3VJuQaUNFlwEfBnHiowyovrNoHCkp4sBNX4ysKg4s7vD8S8r/wTOQctup2+6XUnPhas4wJYCZ1WuXu2Fasa27+Wrm2AvYMb86LXD+9S0CflW62WqhIXozdzNwCfNTK3+9SimxGPKVzTnoQn6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514515; c=relaxed/simple;
	bh=HpNccza3p8v2vE6GFzePxRiQVMDCc6soH+W3WfHy8pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPXcfYJC0VOXle21UGW31nbDAzlrjakFs6n/oYI6lgPE4l/L2nL5woF2F5YjJi5A+u5Yymg3YgO0/ptLfJjeunYrqOQvQxYlsti5BChCIpHH9ucFZAEI4Lqs7n7C6QGFmRRTBOeplrvbIPKxT4vyrQfoKKj4/A18Mq1Hm/8W9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZ5hEvgq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ5hEvgq"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e934a3fa4f1so984693276.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514511; x=1756119311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zy1IorWNS34FecdFEvi5FhAZbBdTEKAgjIL+i6/fu6Q=;
        b=WZ5hEvgqwdU+7GGP2AldpIwPArLri3vLOzYfIfHn4nHgCRK625R7V9d0QVr2qGAYLP
         EXlfDQBOgQdRO992/3Oyua7dZKVoU3rV6Z1zQDjC9xjaId/kWNRJB0hjUB15QJr7dP5u
         5YliamSRNtU2KeKTYjL7rRDv/CC9Tvs1sqwDN43b/VwfDb1CHyy8M4Wf2qA8Gzp2BblG
         fCQy6lLr7iJaiW6rQofm+zF8ef2smP8SkS8L7cbGoEJUQEc2i1Ztn6m9IvJ1zANrqhs/
         VL4xkacR2dyH6rXBWWIeLa4GC+2N39+B0XryaxRRcYLRBnqRzVSJ+YOGZynnO9dolD7Y
         0PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514511; x=1756119311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zy1IorWNS34FecdFEvi5FhAZbBdTEKAgjIL+i6/fu6Q=;
        b=sAsfzVhX2sXQYRAOUM3+8KlnCf32s2sR4ifFgiJQOexuBO3wHvdiUYjQmxl/cKaEFG
         lVMOxxvNPynM/gpol4kYN8ww1CSTGSWpDMuyc4f/xOuFq1u77c0hDDMmW2oNVzFu/4eh
         Lt0MkaNw4nBBaEnBM01U0av0QfyaQifZ/hExJFvQJflv+RzIPMsQI0v8APVroV8C/zvw
         hcOekb8D+94ahzE+ZOPxNAmm0lFwkK7nanhAm4eXIp7Qly2+1WxxF6lHule9Xevz8Nxj
         KMtgu5yOMVDIQQIHfSQ7zzei9OfcFSRmSxnPl85RzOGYi2V8VIoQ3HCaSYST8APM7+rK
         Ttug==
X-Forwarded-Encrypted: i=1; AJvYcCUGW9EipXBvtfypbsDvEtdJzArGr5XusH130vqb51gxhos0WYd5uslsF2FuV5khwf73tWHZaW84hsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/LGwrGo8ccD1bTwbclPdZ5IfVMyH9gqMSF1D9klA7k6ZdkDb
	2rdAuTqNwMHqjFWUS2iDGDyEudKNP49wQ8KkvY9KiR2z01jXcfjFxV5pLIvGj6H9hsddcekV/cH
	U7rL4Lm1ucV+H16U9Sx/NP2akZNJ4P/Uv7XnvJjBT6PZ2LsKK14AC
X-Gm-Gg: ASbGncseaqfHP6sq5DsIQk+kX+iQldU9gDVa+71EKvIxpYHOe35ckCrY/82Z8Kg0RF1
	7EGwjdiyOcF0KzTgRpMie6LoQmU9tjAYrV7tpv2RWnCjaRDbkvrrgtUg1oScvF5aKceFHP4iXE5
	62HDQoWI2H6d2wL9Dn4r+0daHbbgS7oFAJXtVXLI9rssKxAOcatEwQDb5CnA6sI+u8nMg9155GB
	8TKpQkK
X-Google-Smtp-Source: AGHT+IEboBf6c0njtMAWRhLMOeerkvYUC/RpB+BHwi3FJenNwXNu8sDBXzeAxKFWYduZF9LOAJuj4ffV/2Ux+0YYIgU=
X-Received: by 2002:a05:690c:23c4:b0:71c:4152:82f9 with SMTP id
 00721157ae682-71e6d9f11a3mr132543537b3.8.1755514511272; Mon, 18 Aug 2025
 03:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724112817.142784-1-colin.i.king@gmail.com>
In-Reply-To: <20250724112817.142784-1-colin.i.king@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:35 +0200
X-Gm-Features: Ac12FXzzABoPhZpmLWeQec_PNYAHBcPqx-MkWfT1zRFWCwObMMPA2QDob8U7l2w
Message-ID: <CAPDyKFqQJsBjaVotzRmL=pHWLmJnOiXUaQN5yo0oheiKyw8T+w@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: Kconfig: Fix spelling mistake "referrered" -> "referred"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 13:28, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There are two spelling mistakes in the config. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7232de1c0688..4afa0130779d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -359,7 +359,7 @@ config MMC_SDHCI_S3C
>         depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> -         often referrered to as the HSMMC block in some of the Samsung
> +         often referred to as the HSMMC block in some of the Samsung
>           S3C6410, S5Pv210 and Exynos (Exynso4210, Exynos4412) SoCs.
>
>           If you have a controller with this interface (thereforeyou build for
> @@ -401,7 +401,7 @@ config MMC_SDHCI_SPEAR
>         depends on OF
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> -         often referrered to as the HSMMC block in some of the ST SPEAR range
> +         often referred to as the HSMMC block in some of the ST SPEAR range
>           of SoC
>
>           If you have a controller with this interface, say Y or M here.
> --
> 2.50.0
>
