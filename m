Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E361531F9
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684083; cv=none; b=dv28Bo3J/tvKxiHhPPqdTxVcS7a7ZFgkNkRqrJ2BcSxFdQZxSrGBUuu8PHP+5skfeEp9X5Bb0sO42AlO+Epmd66eLebJhkNnrVh8l52v7iE04t/6JZ02M0ipaMqwu/atJiD5b/bKnK06/XCdEQBNjRk1HRMSda4tJRvmExehxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684083; c=relaxed/simple;
	bh=LNKzymsgb/6Iwg40XhzmFUiClYs9OYnQ0dLnby/t7ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPTnVLwCH84fPPlh8/ZDzlUPDuCwu+BwhK8MTviu7BFbgsTWrF2ZxCWGSa72wM0D1uKe4a0mYjwt1wxPL/vXVYJwaizzw9kbB5xFunz3Dog85aUfQWHxWDpn38+5TzKDbMVqvWVG5awRpMbcZ60Ep64eN9Dgz70gM4f9iXNg480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTBiYciQ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTBiYciQ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea0150ee46dso1511237276.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684081; x=1758288881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ/K8q1HzdoHIMtTKXskdUrRNYCvrta7LlIcSp9TUsU=;
        b=RTBiYciQO3DsPhCq6bNle2T1xdIkKrALnQdabNbJ4hnl/BUqxrMQPRhoaVCotzHg7L
         F1YytPuJm6NHIGC8+je3LkGxDxAiZCQlB0BOc/eLxz+LJztP1B/cwgd1R2JGuCMG1+eY
         obiTq02l3MfolLpY6gumvqcSe5mqywMWHY3ywWiCkEMm0Epq3wiqDarFCwl4mhdNMy7n
         AoAwvwtVikEvwJ9Lglc4M5PjqtKsM5qHWw0I06q1+c0DUvWOuL+9iEUj7d3+VvNRcYam
         Ot0ffcJWh14kr0/naEVpaWensuzPYfJXcxrJr6y+WCvEY0kk/34fDk+p9p36RElTBT5a
         N8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684081; x=1758288881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ/K8q1HzdoHIMtTKXskdUrRNYCvrta7LlIcSp9TUsU=;
        b=qkF4d1lEULxBXtV49EcvKscvXhazDWWn/a6uv/zzjKOQod5tjG4INum68aKGTwUiow
         SsFujntZUJqyyBbYnyI+TsGF246rwYd38lq3tZUrUtABz9uCAAL2VMMliCYW09VK3YUx
         0N0tRgg+rzPZD0GLUh/r76g9XOkSpfvhUFOf3IZze+ZZiGBOwD5qHSUcgz51/Hy7IWR4
         epymh95DgPu4nfXCC2exiZJ2LiYrHi3ULocLAiczxkYzLRhsVpzC5s34CJ/6JvlBYdb0
         RUCrTCs4JiB1HWikycRL4LdqY1WBg87gOKONjk3QnYqfFVbW4sjX9IuvWdfsaB+8zzQ3
         s7cg==
X-Forwarded-Encrypted: i=1; AJvYcCUwOK7wC2mJD1yOhS9klpfpoE2LeV7/5IIVMcs33OghkuNn89WOFZgo4l7ZDBlnEqUvzspmtswRbok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7bafp/6uuqPTlHaBJjmnNqeEm1yzjG1J9WPA6H+oOEzUKUBQ
	Q67AIta8TPtnLQ+EZNcyWJmnM4qowZ7+d/odaJ6LRHvYa9a3KhZ8wHnTUgJSvAG0aKi/0MY48zO
	f8lrL3RkAqoXVyGtsnGbNfk0Nz8WPMUmWpIdL236tHw==
X-Gm-Gg: ASbGncuGGRUVDduayLBXCysYsQeFGMRPjRVhwtiNJQs1htacwccRugjaU9SBxTGdq9q
	Ci4YvQRm/t1DD0RIuiFmdpaLwuQeY8KCw63pWlVov/00DT5mpPZzjvYQ4ARMBTFq4ZikVrjj5O+
	V66nuQ8u0TCIWpPIW0lQ8BxHmfcBiZSjVfBMe+npwetLvVJrC4qv8EmVxKPajb/Z113cbGySXV9
	rdEtF5NmaLyW0JkC9s=
X-Google-Smtp-Source: AGHT+IFU/1m7pdVKE0NcSMn+u8VXuWyV25MtsVbS6YuHqP6NuVR7mVq1wHW3//d0OvD3Ag7uQcwmsaBXlaeICB6KF/w=
X-Received: by 2002:a05:6902:330c:b0:e96:c4f2:1f40 with SMTP id
 3f1490d57ef6-ea3d9af39e7mr2133916276.46.1757684080633; Fri, 12 Sep 2025
 06:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826075812.82305-2-fourier.thomas@gmail.com>
In-Reply-To: <20250826075812.82305-2-fourier.thomas@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:04 +0200
X-Gm-Features: AS18NWD70Za98HPo5BqoaFdKJPpqyjBZynLCy_vXOulb13mtCddOduOwnUrku8c
Message-ID: <CAPDyKFq=3RANVUpZEJMTLH2YewJN=_mV-kM7DBb4-hhHPFv4oA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mvsdio: Fix dma_unmap_sg() nents value
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Linus Walleij <linus.walleij@linaro.org>, Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 09:59, Thomas Fourier <fourier.thomas@gmail.com> wrote:
>
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
>
> Fixes: 236caa7cc351 ("mmc: SDIO driver for Marvell SoCs")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mvsdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index a9e6277789ba..79df2fa89a3f 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -292,7 +292,7 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>                 host->pio_ptr = NULL;
>                 host->pio_size = 0;
>         } else {
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>                              mmc_get_dma_dir(data));
>         }
>
> --
> 2.43.0
>
