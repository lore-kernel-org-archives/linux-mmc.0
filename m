Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1815957E
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713854; cv=none; b=r/6zky7B5uZMkjR4KPvkmYzf0vL1cZY23DWGEApTEenmIO6CdkOEc3VxUkKTxZXN+puAGLrWyJXFJmCCn3NwgYLz9W72pYEepgtP6bNZ/7OAcv+XygQK3Bp+VQv2TzuOmwtg0F240O6uTMP5ywnoDAlzmGUo8hTuq7bY00Y6UQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713854; c=relaxed/simple;
	bh=UlomuCi2jufaKAgRER7mFTLXjMfqKIuCEo1u/GmUxXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCW3EUOOJrtaWLjc/dAzdRfasrphUG0KgBRIHfSD3evG4S3oKWuBoKyolZ4lSNnJJI3YW2cyL0NU1U29umFXpT9ylQncIJV3cVjTYFP0zCafpDzIhMKxC0E0mC1Vr9a9hHn74rqEhN08USCeSsN0AdGWuKjrPnL+VhfMsC6bLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTrhPskK; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTrhPskK"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c44ec4f2dbso537894eaf.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713852; x=1721318652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJRhE3D3xf0203P+ET/Sk8dDphxVA1D2zZsW0yadFHg=;
        b=YTrhPskKSSzbEcmULdSbVD7301IETT7/a2O7cpB4J+LEu75veXBb3eR9Wyir1nlfLk
         XC3SPDhsTXl2zxX1cdAhdfex6J5CmJcB0vSv2Y309yIYLeuV5ozUmmTt5yKLQgMr9HdN
         r7xkQg9u4UIlbuQzIuh6yrH3sB1arBzd2rSBCe4bHmLPeb8x/3egyF+nwnUGY5bP2seA
         PhrUmyOdGgMc9F6OnUiGH+Xpq0m3YdLhx6Gz4VRQnNt0L9JSZCGcWMiklKiBKHagpTxZ
         z2hkoon+BVh3sYPAwhwzGVhQgnPrxGrhC88pHKtS2+iQ4wLofH6unjXmS5ea6cXpyHoc
         op5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713852; x=1721318652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJRhE3D3xf0203P+ET/Sk8dDphxVA1D2zZsW0yadFHg=;
        b=DHc4zgli71SOULeqekL0yoX+hfoAfzca8sVwYZ1hZE8hr3DLRHkfaKhjiLra/CeJE6
         8Py1f+a/K7nk31Pak3FWS2GCwCfkvLsEI7yNwl1NM0cvsnAPt7tzS8LfHl8Db116u8le
         XBxSTUn7j5egBby6R67SaUSujGLLfppAJx5tNaLbkSZgbY78om6XXt+pQqk3s70sl/rZ
         KkMCSx1KqzEYUr5U5DsRFB3nsK1NAnKpcmr+f8MzB2SPuJT9Kj0yGn2GwkOpdUIDDEnM
         mWQpR9+gdejbDq9ufLpgRzxD5w02WpeHRXHVCLl+smV0nwqfhWvP1pmJVl4RDlLIVnak
         XIGg==
X-Forwarded-Encrypted: i=1; AJvYcCW1EuPQDtIcRl22nF64/+qaZ9MZEFtjwBPP+lVGDadzmvmjaEhp9+1DQngX4dyhiBxqw0Oc4Zm/v+bpH7fiaLJ7LpjDM+g9DoqG
X-Gm-Message-State: AOJu0Yxpn5J78QtPqzcHbPab3zsRtctmJ6+MwD0oas27ge2Qku71Mb94
	0RK33nnPMNNj3A9EYpHtNc0LVrsQvIbosKjY0bpD2u45gYMTzKNsFvAVlc/zoGr6b8N9GYTsDdi
	hksBcyZwCVmvj+FE2ajB7XiM4PS+YAQgQdEFOfA==
X-Google-Smtp-Source: AGHT+IHuIlKldLtTOQoLFnrewN3z8O8n69aqt+rXEcv+GsAIFjWQw6LCkcziQCx6eaN3xVdkr1up+9hn6/jeaKsoh+A=
X-Received: by 2002:a05:6870:9727:b0:25e:1817:e4ac with SMTP id
 586e51a60fabf-25eaec16f18mr7346929fac.42.1720713852312; Thu, 11 Jul 2024
 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com> <20240711081838.47256-2-bastien.curutchet@bootlin.com>
In-Reply-To: <20240711081838.47256-2-bastien.curutchet@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:36 +0200
Message-ID: <CAPDyKFqzR4VJUHW5EHf7-vzZ=TNPDAngFYQfksduqgcx1qEAkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: davinci_mmc: Prevent transmitted data size from
 exceeding sgm's length
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Christopher Cordahi <christophercordahi@nanometrics.ca>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:18, Bastien Curutchet
<bastien.curutchet@bootlin.com> wrote:
>
> No check is done on the size of the data to be transmiited. This causes
> a kernel panic when this size exceeds the sg_miter's length.
>
> Limit the number of transmitted bytes to sgm->length.
>
> Cc: stable@vger.kernel.org
> Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index d7427894e0bc..c302eb380e42 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -224,6 +224,9 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>         }
>         p = sgm->addr;
>
> +       if (n > sgm->length)
> +               n = sgm->length;
> +
>         /* NOTE:  we never transfer more than rw_threshold bytes
>          * to/from the fifo here; there's no I/O overlap.
>          * This also assumes that access width( i.e. ACCWD) is 4 bytes
> --
> 2.45.0
>
