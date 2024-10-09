Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6721917D0
	for <linux-mmc@vger.kernel.org>; Wed,  9 Oct 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470301; cv=none; b=gf6bVku4iom1Yu6Teny4rK8nVe3ar4SQZfoWN2D76LQUc979vLF43Mf4XeQk60fryZScgBQVvGRJEmUGRgR7LAn8+d97RGIvl0m60nH6F3dfGg5GYbroe9qg/xAiyIu8xqSKOSXfQujqsQwn+ULohErN+fRsFEH3eOIm/N4yVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470301; c=relaxed/simple;
	bh=nB0qJf315S0Z2/pGNasKouhjG0Xme3kreiC0BS2FG1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwC7+TaG3ChvgHONz70p5w9VY98209Y8Hf4eMEKjolCOOvmsAUuyp0BeeoewA4wwo8mgwh+DmOQe0u+AEhPltgj7RCo4DoRGQHFwDXTQYu6em6Ssw+DeHZQsLFTme3SnDnPIZWVj3XH+iVzutO5XmCxEa8OMT3oBi2fBUlj1EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiCgrORU; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiCgrORU"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso708125276.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2024 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728470299; x=1729075099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4S9RR3K6QnDDxjEOls4CSG3KtERGY2SF0IBRo/ZWYE=;
        b=JiCgrORUJaneIN4tqpe4Bxc+0GDL7IACs6wDS34VQnn5gcYJ0ofb8On+wfA/FvvHFK
         h5gDUwrKpeUFIy9Ort7NclbEDuGN8x8Ck+qHuGdexN7vMyPVplEbjEhwyMVmhZSvQQEd
         nNgsXm1Ox2VwNnso4tM7fajE3qjCwo3ukM+82TpUFxqpgWwVyyFIc+pflOEQhmD9M+al
         CFRL6mnn3AiwehukNDjnypTZ9RByqZFY4YyZblPIpR+VHn3Jg0U+xP0ZWZma/OdMAATe
         srh/DEQQBkiCC4tQX32t5mupWutZBgwutx3O8vl4Sn2OLhaWfNtjTLBh1OrIjr4WfSPP
         Ejww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470299; x=1729075099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4S9RR3K6QnDDxjEOls4CSG3KtERGY2SF0IBRo/ZWYE=;
        b=QDk9B5kxMwkN+BpdE9BOeCS3Y3FJAbL1R+PlD7XJG9N0KfI2Ra4HywK1qoJgIGf3kW
         d4cDn0sWrSfPsOCUYi/DkONMy/NbQoNoVZJOKkK6fpUunkNnSYLtwwj1N5mfBKtVp6sc
         jgqBZSsVK7ooGyt/ZL0D/Cb2RNvQLVM/RrH2+DNm80wfPPhMubTTbq914HIZIPKG4lUv
         zJpspWRu8vEv0m1FdUKX3z9qSFw5R7q+BcdTi1AYJSvWBG+bhAKHpZqA0uHBBKJM7D4O
         nSoq8eA3+lD3V8u0825b141iX5DNVXaJu0oe00q8RLN/EuXDoVs3h/0iorqNDwjIW+wn
         /vDg==
X-Gm-Message-State: AOJu0Yya/KorZIGXJyxzvErwhL7HCG5ew4VByQ2JxTVlBz8Yp81N2Foa
	KYq/WdsjahG1kKkCg8TKugOFmgR7nAcc4uHPUc2ztAfjZOmvw05uS+rrRcKctOUDBUyheuS7YJk
	PS67aQiK3kB6aG1tEi3D0sGo/qoxL4+ng0FrSnw==
X-Google-Smtp-Source: AGHT+IF6wNDrtR2FR+iF3ORNX+EA7mJBmScQFeE/O1idJ5pgxpXmH+PgvKvohSwwMIQTiTd83HO2gsvdOY/p+lw2vhE=
X-Received: by 2002:a05:6902:1444:b0:e28:f132:3fae with SMTP id
 3f1490d57ef6-e28fe50c250mr1668617276.48.1728470299271; Wed, 09 Oct 2024
 03:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008160134.69934-1-brgl@bgdev.pl>
In-Reply-To: <20241008160134.69934-1-brgl@bgdev.pl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:37:43 +0200
Message-ID: <CAPDyKFqvpSJCpG00NtDwpuxp51T8t9JGMm6Ssxvzpg4fNGSGBQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: drop buggy snprintf()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 18:01, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> GCC 13 complains about the truncated output of snprintf():
>
> drivers/mmc/host/mmc_spi.c: In function =E2=80=98mmc_spi_response_get=E2=
=80=99:
> drivers/mmc/host/mmc_spi.c:227:64: error: =E2=80=98snprintf=E2=80=99 outp=
ut may be truncated before the last format character [-Werror=3Dformat-trun=
cation=3D]
>   227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>       |                                                                ^
> drivers/mmc/host/mmc_spi.c:227:9: note: =E2=80=98snprintf=E2=80=99 output=
 between 26 and 43 bytes into a destination of size 32
>   227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   228 |                 cmd->opcode, maptype(cmd));
>
> Drop it and fold the string it generates into the only place where it's
> emitted - the dev_dbg() call at the end of the function.
>
> Fixes: 15a0580ced08 ("mmc_spi host driver")
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> - instead of fixing the buffer size, just drop the snprintf() call
>   altogether
>
>  drivers/mmc/host/mmc_spi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 8fee7052f2ef..47443fb5eb33 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -222,10 +222,6 @@ static int mmc_spi_response_get(struct mmc_spi_host =
*host,
>         u8      leftover =3D 0;
>         unsigned short rotator;
>         int     i;
> -       char    tag[32];
> -
> -       snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
> -               cmd->opcode, maptype(cmd));
>
>         /* Except for data block reads, the whole response will already
>          * be stored in the scratch buffer.  It's somewhere after the
> @@ -378,8 +374,9 @@ static int mmc_spi_response_get(struct mmc_spi_host *=
host,
>         }
>
>         if (value < 0)
> -               dev_dbg(&host->spi->dev, "%s: resp %04x %08x\n",
> -                       tag, cmd->resp[0], cmd->resp[1]);
> +               dev_dbg(&host->spi->dev,
> +                       "  ... CMD%d response SPI_%s: resp %04x %08x\n",
> +                       cmd->opcode, maptype(cmd), cmd->resp[0], cmd->res=
p[1]);
>
>         /* disable chipselect on errors and some success cases */
>         if (value >=3D 0 && cs_on)
> --
> 2.43.0
>
