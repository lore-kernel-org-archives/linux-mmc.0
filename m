Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1B295524
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539177; cv=none; b=G90IfJ5Q30jr+DehDXhlISQ5s9rxg1ag+41oA7pTxNAricZdkzG7j6Gr6m3p/KNGok8gFY6nTf94TmTH9pJxZzryY/DqXkDWdbLzSxazNyEAPMCIwTL/5aDkqWD1mustImCfopWMncm5blnB7nvnoayz4ubVZf+pYVL1a29Z5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539177; c=relaxed/simple;
	bh=bGwLvvH+krpxqZJW/aKT+tTKat2sdRhbvziWM56lIss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh6Iy4spU9tWCsfPsfx4lnIxF7OCKFk8UggDoF8z0/je12CAhjTkajdhUEWUekw9Rqo1AIhvFu0EcqG+twnhfUVvFLLVJoOyYE1AV/diHqQ1MdDc7w9w+l8vuAR4s9F6us3HSNT20KaTvuICkyuUuXO3In8P57Vy5ZnngNPsmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SpLjYFsI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpLjYFsI"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7115e32802bso53043077b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751539175; x=1752143975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbccPWOLMeO5ZiCDV22jEjK7nQ6LCiFcg1Ikp2bgtaE=;
        b=SpLjYFsIeaeLZNe5zWyXHUZeaqfukoxmfm+giFclTMNef1wfyx+KGc4LAlVh9gk5qw
         v52I4la6BBWsmJHTLQRh6UT4ETguXXRj5A0S43LiELwbD9Iz6+AqRH52ifPupBpvzY+r
         XSiN7bmZaCgOsvHGi83o7ZbQuvxi52/Ivn66Tokg4z751pPfhibpiLoiSGfSAHw1ilDf
         zSwtEyveHXKEuFbxe4rCV1JLh1G9JnyOiN6eGxVfqLecRkI90sD2LdbH+4Sac4bT/jLV
         bNqPI+7XbFxrxEVCjBgDMS0EhxUzGIpSlOWG5GIVPcUuqM6tCyZEDsoqk2CEjbsBPmcL
         oDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751539175; x=1752143975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbccPWOLMeO5ZiCDV22jEjK7nQ6LCiFcg1Ikp2bgtaE=;
        b=MnlpQlThGwm3o50CuRf+foUGxu3lVNruLicvqkxGDapP47f4gsBXrggz6S6G4edZTG
         PYo87mx+QrnfN5OIE4cIWYdvemRizyLqFiN5RBj2cSv7ZfTR8BFxB7/ndPDuwubaxHTZ
         fYIhLKeuHgh3TV8B2lteTirvbyuCKHw+Qiz4FJlT4f5N/UBaygA38rdU+gn5C1sHnu92
         wxGEqvP6H8TTj26YQ1EM78F69M0dNI8R+lCo5CBZrSGmQc11HbgdjyKFJ0Pr9t1HtlbC
         lB6HAfH5o9LBBvAC2VKmIX8F/T0f2l/6kXE2A6DYzzC7v1VioNbBQXIVK5nGwQkmL67K
         Xtwg==
X-Forwarded-Encrypted: i=1; AJvYcCUXLzMRbj/pVMt3KmXAzUId+wBKGRztvG0M+/Wi+S6xEEgc1qnd0BFNlHWEdky5G2wLnNLWKfbJGdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQh6CdRGl6jzKMA9WWDLheyLek7l4U64iA4GielqNLySwiqNsD
	G2/8kJrH4Aa6sjmlgvY4qjHEFUUNpv5Ab9CGULXSv0VS4mg/Tjf13dCwfMFIZZYYC3lkv+6777+
	1HmXNKV1X32fo9KH6qA09EI9l6aMf27NP1N0POW5rLC77yo8NYCnV
X-Gm-Gg: ASbGncuC35xXjTGa6KWLjwKBs6u7QYTPFK1iZ+22Yfb9OobmKZCKP9SLRpHfKZMV3c2
	e7Z4qzuhDalpKOpS7sdSc0ZcfDjEeXHxg7hZouzUgtw0HKoa296AXfGeMWrhuu/g0jCDuKUwuw0
	A1mV46cuapII1lk0sR8PfKbnBYHFFmuyx1VOdnEMY8bTHDrvNUWvRVmQE=
X-Google-Smtp-Source: AGHT+IF9eVk0FlIbMoHs5RgnCTviyum9RB4oGuI3RQdRmxuzWPhnfbE8XXHvyI2bhvdId129RaE1973qQU974VuN4FY=
X-Received: by 2002:a05:690c:39c:b0:70e:29d2:fb96 with SMTP id
 00721157ae682-7164d4d235emr83418887b3.36.1751539174826; Thu, 03 Jul 2025
 03:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620033018.87920-1-lidong@vivo.com>
In-Reply-To: <20250620033018.87920-1-lidong@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 12:38:58 +0200
X-Gm-Features: Ac12FXwr34opsEKBKvjMq0YQRpajMerqzhzzFcEylaOwubo_bokLxMggyMS1_jE
Message-ID: <CAPDyKFrkjuwU5b2-26LLWJ9gWduvXa9SOZ5j1+ndk1n5grXHVA@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: Convert ternary operator to str_write_read() helper
To: Li Dong <lidong@vivo.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com, luhongfei@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 05:30, Li Dong <lidong@vivo.com> wrote:
>
> Replace direct ternary condition check with existing helper function
> str_write_read() to improve code readability and maintain consistency.

The below tells me there are more cases than mmc_spi. Please re-spin
and take care of all in one patch for the mmc subsystem.

git grep "\"write\"" drivers/mmc

Kind regards
Uffe

>
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---
>  drivers/mmc/host/mmc_spi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 47443fb5eb33..0a1098140dc0 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -27,6 +27,7 @@
>  #include <linux/spi/mmc_spi.h>
>
>  #include <linux/unaligned.h>
> +#include <linux/string_choices.h>
>
>
>  /* NOTES:
> @@ -774,7 +775,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         unsigned                n_sg;
>         bool                    multiple = (data->blocks > 1);
>         bool                    write = (data->flags & MMC_DATA_WRITE);
> -       const char              *write_or_read = write ? "write" : "read";
> +       const char              *write_or_read = str_write_read(write);
>         u32                     clock_rate;
>         unsigned long           timeout;
>
> --
> 2.34.1
>
