Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063735504B
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047372; cv=none; b=phRfxz/A++MMNNEs+8V3+M/oOaOzMTYTLKFIxxZwaf3BnzFaMY5xb7DJqAmYY8DwqGGJlzldtMtZVbsT4NeefQNHf+OFEymTqSmOV3iFCGJp5FD9ILIiVxe8BK+Dy2dZ92cl2avwD6eAvhsOcy6n+wN1ugOh/SYuIkg36Fd3vXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047372; c=relaxed/simple;
	bh=LDchOofmyAyCe0IJhGnwj68f427MSYzlnLLRgYWuj94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0KWHywh5k2nhl6Sqt+3SVS5Nr/pRXSSdObt8PlnU0WJzBgc01TH3IwLnvjnGO/nAyEGo1/WXoMqg6asCGGinrD+k6xD3FbU8G58bjI3yYNud9ycmKME+IbvVZwyaveL3vbEFS4+/AUK7rE5dgWFnGZhQw2SB2gnkQt3DQ6YZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw+p9UuG; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw+p9UuG"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e0fa0571fso5218543d50.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761047369; x=1761652169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fubOwqEF5m4iTEgESAo4RAy9nm9IW5bMGuJtgWmpc2A=;
        b=Iw+p9UuGc3kTJdz3isJNexsx4bL5gVvznj3IyFgkliSFpgyYjwUlCrPem8fsaKDND4
         9bQgCyVp0mWFjxpLGnlD0QzNtzSdlX+gY8NPhsG2NX2RJFTLpkaVRbMHGJgJFGoLCU+8
         mqPnb7f7Di9ydB0IkzSCBvJuhYMHuMsFgFuFkoTz1hmR1Y6gX+NOo8oGk6RcLkFs8P9i
         T6h8NQJq5Azv1YL/jkXUbJFA9M+4T2K20m6koHfHKRNHR3UZO2GRkVEVlMKi3gznahFO
         ciSfMIdCy9XHp/2fwsaDcEOz9Yz+SxBtKj9jEYYeo5isfY7IR2ETvmHTO9Zx7ICKyMJm
         yCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047369; x=1761652169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fubOwqEF5m4iTEgESAo4RAy9nm9IW5bMGuJtgWmpc2A=;
        b=Af1TA6r+NSGmAq4Z6dWTn+q6xV3ZEF1pwTDaPIzCr2goSV/Vn9hg8tclbzpen17xTd
         uQRRmxwcYMOIEqyba1NU02TVCfGoOdlMHwUR6W4UH58eYgJhcF/38uIm7Qz/y/7mCiX0
         HXPK1npnPm1Cs7DPz7c19eJvXcMaRq83ZQuCx306hzmLovCNBwAHq3Wfl5Seu6+VhImT
         yOAvfzYEvTlKQ04/wZMU5YIvs8Pj3+gLbgCLcOQWvhbkozWqxdnDtxyH8pwJU2Jn+mIH
         Sy2Waz56MiU3vkGJHferNP5J5VLp8fTnScEv26BbbhIeaixZDXFKwfEEdbWTkQShnpjs
         vxiw==
X-Gm-Message-State: AOJu0YwwTZbH2ATE13bttZY9vtQoatAhNKjomwg1HuWG4Nx0y3qKYdms
	nLMUQ3wuNyeUWdGVjW/iU1bHF3BDtgfxoQekFt0o4Nc66zTeBr81hXYfe6vUekTCLdW7jgrOYan
	8V7cFSfQ68AeTGItrl0QXVefg366H+4+Q/w1iifD1eQ==
X-Gm-Gg: ASbGnculUFfohzJVXyXUcf8FHTly5nemXkkDn3mKCEDH4SxsrzfhsdePQ9wBYSbddte
	lZJJYr8LmqRqkTqgdsRQWklRxhb0IP+zxcsrQzbaH4l+FzPsP159Z5W1S9LDcsiHRtqV4tnJtf2
	fdRQP1uRqV8OjhxN72/MgghD8ujvcTf1IZG2vYzezrjBAvwmjfqwHq7Hs2YKACCo36ubchUEE4/
	UA+rMp27znHE6/+JI4h3V+A0OEtdZAgU0P+7EjVkuNg1DoEMW4VDa5aM4M1zM7qA5zu6hI7
X-Google-Smtp-Source: AGHT+IEX5EIQW00Uhs2bIpyFF0ijaBeRJMzLKujj9MqrtO2tueAMtW7djGBXmY2z8UScupISr1c9QvatdHv47ULSwbw=
X-Received: by 2002:a05:690e:429a:20b0:63c:f5a6:f30d with SMTP id
 956f58d0204a3-63e1625d3a2mr11019453d50.55.1761047369000; Tue, 21 Oct 2025
 04:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
In-Reply-To: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 13:48:52 +0200
X-Gm-Features: AS18NWDTVlWL2LNpyLMYdbOrlY3koMXJk_7WrqzsLLVdbjx3f9u6XYsg7juwU3E
Message-ID: <CAPDyKForizdooge04ez+cDhLW6XFHwhDPSE9fR-2ueXej=J3pQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Omit a variable reassignment in sdhci_arasan_probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Michal Simek <michal.simek@amd.com>, 
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Anand Moon <linux.amoon@gmail.com>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 15:22, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 15:15:07 +0200
>
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c6f09b53325d..b97d042897ad 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1991,7 +1991,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +               dev_err_probe(dev, ret, "parsing dt failed.\n");
>                 goto unreg_clk;
>         }
>
> --
> 2.51.1
>
>
