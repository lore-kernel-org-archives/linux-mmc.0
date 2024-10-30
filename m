Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664551E47BD
	for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286492; cv=none; b=gXsAb+hzbKTcMPsa9q9d+Djw7n27L7m4chm2wF2JrosKNkqLX4RBSeLQpvKb99rwnFKEkKBmoSUlI/UBbMA6F0QeDOTVwrScaUWDWxUdcoBrq0Hnm/auRZoUc5D45SbVI4Og9LukTXDRWNxQMacteCRE3yyE6lbHl+Q+89hp2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286492; c=relaxed/simple;
	bh=NeqLWBz6qg8oOqZLTrWwyjH9LMlDgb69Q7kw38IIbLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ7QbucJqIcaHjuEA9wOLHzTq5X1WmuceMfIFJveULyDIpEpJvwt+TV9qfFzIXlIlipNJrEW2cvtZ/ETlbZT/vHrPGkKa0LNYiHq+HjcSEO6PUSH93cE7FXJLrk0SA4eCH5KxMxtkGTE3SuuSUUpLxBl5yGnGgCMc6ydXXcqfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKHp/ETf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKHp/ETf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so7569712a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286489; x=1730891289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hux8xDu8drsJs7jPgUr47r1XBiB9zuvhH2IWWI7RGAg=;
        b=SKHp/ETfgwWh2wtPdzmh8cFXuvX/QppobBygiklbgutoEoSDlnMKEmj89L61JF5dch
         rvoAzaT8lkmmNbEcV5XjJd/0tRyf0YEXZoJAno4ZpXd6qWGyXBLxQn6ycMS55kO6lNFZ
         WaXcruXv/iP1mmmPi0xnMQCF8g73xBzhqksaw1+epYmPoMMhjMBAjsMk+lswZRYuxOYm
         tLXAPolt2Kt2VG0l1FOXWnZha7Xwmbw9zykxDvD83tRvVOwni4eMUBrwojYFKlJZ407/
         MG1IcURBkajvqR9vcmR3AoBQ14ZklUtQdR550XXLu9iOZyZNjFMwSPzWEqmd1Tp2tP7r
         AqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286489; x=1730891289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hux8xDu8drsJs7jPgUr47r1XBiB9zuvhH2IWWI7RGAg=;
        b=upSPtIf9JAIQrOuEQ4ov+lyq2ZubeA7v1Av73jR1D+YgiEKnRZ5WZNeIx2LmPjER7t
         CaLtszgPzWIoBPG56ZrShGeYkxPDB/swjSIPexmX2uZZRw9YVGpbxixioxTCgp6G6Kkt
         ODLUhcHug4KDCdPUXzYL9Jh+BtICWhFL3CkhXlxpBwkEXulT1WtWreRX9RRIXV3CZR4k
         qhphmdhjBgGboY/T2gHSUNPctlSjKLlHhyGbesgJCP3AqfHmCsroUog0kwh5yhyQcRI0
         DhdcZooCmS6Vt2urVC+VKTjqTiV0MZi9weivRAdK5BoX3mcAiyjrewRJyEI69YMNPzJe
         4giA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Tj04X3l5L2FoxQNDK+H+c3Geo5+DcoOYmJ4HsnrsqtdwCqfXbX0pbrS7W9laPMmdMCicYeeURpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5W3Oib/jD1W6pq47HBL6sFrN3btXAsoNk8elfVObSVneWeAvE
	/HME1fPRtIVgyqf8cyTs/KWUVUyXZy+6HRLxy3EC4K7L0zU7RzaAx+vCOOV1966VSgzzeuTEoEA
	/14F4ooh6prj0Gwk9llJYNxnH2gePSJOVSWLQPQ==
X-Google-Smtp-Source: AGHT+IE/BtsyAKoxfLMhMZHnJEk3BCx9KVt7LDdEa4ZR+bwi1yOft1wtXDc/N7yP2ietwnWO7Kh3F8WXcdvhvW8VySw=
X-Received: by 2002:a05:6402:2786:b0:5cb:85f6:186d with SMTP id
 4fb4d7f45d1cf-5cbbfac4c5fmr12574334a12.36.1730286488705; Wed, 30 Oct 2024
 04:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <079f2b7473d34895843ad278d79930c681385b2e.1730282633.git.geert+renesas@glider.be>
In-Reply-To: <079f2b7473d34895843ad278d79930c681385b2e.1730282633.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Oct 2024 12:07:31 +0100
Message-ID: <CAPDyKFoqjNZRu7KrY2HrsT+RYrfZWJCn0uP7_rAj+QOHEydsGw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Make MMC_SDHCI_UHS2 config symbol invisible
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 11:07, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There is no need to ask the user about enabling UHS-II support, as all
> drivers that support UHS2-capable devices already select MMC_SDHCI_UHS2.
> Hence make the symbol invisible, unless when compile-testing.
>
> Fixes: 2af7dd8b64f2fd6a ("mmc: sdhci: add UHS-II module and add a kernel configuration")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index fec47022558443fe..6824131b69b188ca 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -99,7 +99,7 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>           This is the case for the Nintendo Wii SDHCI.
>
>  config MMC_SDHCI_UHS2
> -       tristate "UHS2 support on SDHCI controller"
> +       tristate "UHS2 support on SDHCI controller" if COMPILE_TEST
>         depends on MMC_SDHCI
>         help
>           This option is selected by SDHCI controller drivers that want to
> --
> 2.34.1
>
