Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06391AC78C
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887855; cv=none; b=V44baKO8uPyKspxtu2G8KwQIHmS1WDc4YSPrr11JrNKCYtQaiMw5AGeqypFFjHJWMp10hVtzOOS7Sd37/BTvgz+Vl0Z48O9AsaWELic/IKnnHSurbnYe2KNemalpe9OBkJiwMiE4Zzs3fjS+SItk4n+X61+sxawOth8KR0D83Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887855; c=relaxed/simple;
	bh=2HmyC/8aoZ2nPJoKWEKLwCfkQSZpd1ixf1AoMQ48fKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEqd3GNss6CGZve4DVkPEYpiWdDZ6aFLvDryKLPcd0yKT8itmcrOTxqvG4kG2EZMG2L04UuWrcmu/jXkbYpXPxm0A6KXKUk40KFALvnaDBUjL7QipNooJt3TyXXBgfHgtqPzPged8UsHJuZH8DZUYqXeCtSP0+gePhcqZZvicRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VA1Nm0sg; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA1Nm0sg"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfef5980a69so824916276.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718887852; x=1719492652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7Ui2B3eiuQfY6kcWseFEWEENplZ5Qoq4XUDUnDKk3A=;
        b=VA1Nm0sg5UJAsKD6JV6BkbBZ5eCWivY8rCu8G5tU3I07UHRKOBMejLNz5Fq0Hsc0ZU
         CiiCC1bKRnIbRZ0tiFie+ov6PhsWVAhr/oEcUNQ1crM9vT068Wg1W4F0ZjBv8ilqb/Kn
         PS5QSWnd8/uhqydzS+J0rFpE8AhErg6QozuQf776qnWhkCc1vNKuzuvqJn95YgPAMJjm
         AY+3je9Y+6vCdVh9z/OM53FH3PEPPaFcLK3MT0cD+Fk90htAUTn9NXNTbZjhYukmx1ni
         aG537yNuavJ8wKetDfo+d3iG0/S8ckBm2Uxnjpx3Ean9djNdFyaS0MDnCcG8N5k/Gt5d
         G+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718887852; x=1719492652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7Ui2B3eiuQfY6kcWseFEWEENplZ5Qoq4XUDUnDKk3A=;
        b=dq2ylbXM7SyhTpWbseLQFTC96G+fx6271/sV2nSQuI7n3TPjKufzhrL5T3mtcVq0NK
         thj8GSooSvwmR5/F+toDvQJBG/M1q/aFhBZab+vZy5LsI8T4xCX6RNmeCpIz4H+JncPa
         f5kSWF1SSFUcvzsO0Xc1bA7jZIMTJD0igILwDJUmWfIlsSwcIkhCd04a2/tDyQNCMMsv
         +x1io47hA/0D3MXW7iVyv67J5BjPJpopAcsX634ZvFEgDDfK5fMsnrYxSW69xMoWp4Sw
         02O4XrhgkktaBL+iqGctCxF8IxQcDQrDocPbZFjzyPZZylfdammUYXU5z8AiCizkIsFL
         NNmA==
X-Gm-Message-State: AOJu0YznadCyKFRMf13O5uvsQTgfe2qzxoYk/OfZ5nzwP6k4i6U6dwWw
	jbWPTB3JqrarTuusm5KH3Eoxu8fcTxIE35DQ7uMHzcQRUAwR1XMTuOnjGLULlVkaeJCzFe7jjPV
	ptcTjp4ReDSKDfe3L9OR4X+8ywnwyjdkeV9taPg==
X-Google-Smtp-Source: AGHT+IFzwmTlSm83S3zIQ/NDj8ijWnvuzYb+Ls9TCG0adu2HJouriCBzHm65cuenwHGzeYmKw4gbmsjLNgVHCs5ygNw=
X-Received: by 2002:a25:81c6:0:b0:e02:b580:d0b with SMTP id
 3f1490d57ef6-e02be203e4dmr5411315276.40.1718887852518; Thu, 20 Jun 2024
 05:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-brigade-shell-1f626e7e592f@spud> <20240612-dense-resample-563f07c30185@spud>
In-Reply-To: <20240612-dense-resample-563f07c30185@spud>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 14:50:15 +0200
Message-ID: <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com>
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Some controllers may not be able to reach a bus clock as low as 400 KHz
> due to a lack of sufficient divisors. In these cases, the SD card slot
> becomes non-functional as Linux continuously attempts to set the bus
> clock to 400 KHz. If the controller is incapable of getting that low,
> set its minimum frequency instead. While this may eliminate some SD
> cards, it allows those capable of operating at the controller's minimum
> frequency to be used.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks reasonable to me. I assume you intend to send a non-RFC for
this, that I can pick up?

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 09d7a6a0dc1a..c9caa1ece7ef 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1208,7 +1208,10 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * that's the only reason not to use a few MHz for f_min (until
>          * the upper layer reads the target frequency from the CSD).
>          */
> -       mmc->f_min = 400000;
> +       if (spi->controller->min_speed_hz > 400000)
> +               dev_warn(&spi->dev,"Controller unable to reduce bus clock to 400 KHz\n");
> +
> +       mmc->f_min = max(spi->controller->min_speed_hz, 400000);
>         mmc->f_max = spi->max_speed_hz;
>
>         host = mmc_priv(mmc);
> --
> 2.43.0
>
