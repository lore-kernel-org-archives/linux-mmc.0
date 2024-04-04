Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBD79955
	for <linux-mmc@vger.kernel.org>; Thu,  4 Apr 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223100; cv=none; b=ukKqitQ1jwwnPC60DUBDZqMupr+ts81fvbHQqnz7ZqDo8Nke6vCp1FU7aCP00zpNdRM3XQgP2dnqDMsRn+5+lUZLmGJlCr/ftGP6Nrh0t47P3mY2oOLOirfsvUPy96ZA7psoL6xt2FIlG3ARL3GYRVuwEL782qoHvklOjEOmBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223100; c=relaxed/simple;
	bh=w5umMME5XeGEOz99SzYrMx+dj2pL8cBzPjsa+F50+Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf/zOFxtK0y6hkHgVtTXkqczB8/h9bYt/6YqSFUzMyTIwquaGxSWhvflGXNaUVIKrJ29DVTPOxGX6v3dbMhMy8q1nA1Vz901XkFVsr8xMZfguphx7GIMNIV5WFKOsQp9F8dQptmN1xnvwDbJJZH40rf4oCBaL4WKzkP7ZQFB1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZT/jAwa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZT/jAwa"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6154a1812ffso8167667b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2024 02:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712223098; x=1712827898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HO/dDAUuh8KUawj8ZZNT4wZzfYA+tW547HrSsmqTFKM=;
        b=xZT/jAwagTO0oqknp82OdBzpTJ7+TkZPySgC4rtgE35qbxJoPP7EDq7ILxS+Y/d68X
         vUIN21lszyAZFOIZSUD2qjpTMsE/Hd/dOsbKsSJ+ivNKal6z9MPl/S8QdMcz710maDZ1
         hOTKC6K725k+oJ1OIFSX7R96IopX7f0pdhNMBbYSaxW8OTABKFlainYgiHRLdAqSC/K6
         S2MCjhTOyV9ZTolU/bNqy+bUddmoa+Z+MasXslV5m0TFXx69WW3v2vZuZ3O52/OrfA+W
         D6n5xkl7NqzH9q+8VEQqrOte0YyXEcBVNqfKZDULjnKhuhO4wufuBb5aEdkSWzWnUNXY
         YGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223098; x=1712827898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO/dDAUuh8KUawj8ZZNT4wZzfYA+tW547HrSsmqTFKM=;
        b=SzU6Q6FlFFRWCMj3Ckqa49RYjZcq5kzqOf1UcqKpXNhi+d4gBkG5VafLHMOLW0fFdO
         MRNRQqDVlrc1qJIuU8a7cB6BauzJFbs6kRyXUUAg3/N6YGYzPAxNS9DtF3vmjCDZUtU4
         8WDNqIUyFHDc/05Nm4Ih55PJtdO+NNnYPwj9AzLyC3Nu1HyYgFM1NA5vxr977BSbXDgy
         FeEGpnpxzLp5gpqtTBc1ZzTbfnkHEn/2LiA6yNFQPBDGBg0G5jqUadzdI7EFUfYpeODB
         4lVCQT+dPQMzKr4/wDkvCfmdvcupo4o76aZAPUaG2umxwQI5wFH990qFhNYkM6gJ94IO
         04tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkgprjYsQA8FKvHpOS3Et1x9fncVV5vdtGRX4Mq0ZvTNqGIdbNTKEpvMkKyA1bYYeAg15ukgzghdCOSWwkSXkZ8czyNj93no6a
X-Gm-Message-State: AOJu0Yxi+7dnrEphNZVylrOZcV/Rwvuytr++PBcrfjP9BdhMBYKydqEI
	IIt0ePaT5nt1lxHWzJvoYGinQXUQlJHvQLcmdmomojPOj+0boPwFTBIDcxkdSoEszYfGlk7h0Hx
	oZwQ7+kzkAHVoqnJ1Jw2chDAgoY7V2a6V5kGz5w==
X-Google-Smtp-Source: AGHT+IGV7+SoNV7hAltq2kWxN5B9pSc9H3SFwGtYvRztCJ4O4vtio6g4ApJgPo+O8DTpfmZx/Mn1Nj7PGyMl3yKeMW4=
X-Received: by 2002:a25:8405:0:b0:dc6:c2b2:c039 with SMTP id
 u5-20020a258405000000b00dc6c2b2c039mr1947696ybk.41.1712223098167; Thu, 04 Apr
 2024 02:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402093539.184287-1-bigunclemax@gmail.com>
In-Reply-To: <20240402093539.184287-1-bigunclemax@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 11:31:01 +0200
Message-ID: <CAPDyKFqat_wAa1zCH+VAebs4R3LodvDJ13Af5CU9xvzX6rzKTw@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop
 count to 128
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Drew Fustini <drew@pdp7.com>, Xi Ruoyao <xry111@xry111.site>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 11:36, Maksim Kiselev <bigunclemax@gmail.com> wrote:
>
> Fix SD card tuning error by increasing tuning loop count
> from 40(MAX_TUNING_LOOP) to 128.
>
> For some reason the tuning algorithm requires to move through all the taps
> of delay line even if the THRESHOLD_MODE (bit 2 in AT_CTRL_R) is used
> instead of the LARGEST_WIN_MODE.
>
> Tested-by: Drew Fustini <drew@pdp7.com>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Applied for fixes and by adding a fixes+stable tag, thanks!

Kind regards
Uffe



> ---
> Previous discussion was here:
> https://lore.kernel.org/lkml/CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com/
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8d6cfb648096..1001b6ea1a89 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
>
>         /* perform tuning */
>         sdhci_start_tuning(host);
> +       host->tuning_loop_count = 128;
>         host->tuning_err = __sdhci_execute_tuning(host, opcode);
>         if (host->tuning_err) {
>                 /* disable auto-tuning upon tuning error */
> --
> 2.40.1
>
