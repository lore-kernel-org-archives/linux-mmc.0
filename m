Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207C219C93
	for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437073; cv=none; b=l3Lw+NL1GEhAeLRY6nfiNK7v8i9D96UG6CuTsuwowFQC8g7Ox39dMWA9sJbGVaF3BmJcy3FZG80FCy+41qyxSNHNfuSmZnV64+iShH/UCPWoGC55NzCb1MhzERS3Cj3nO1E1XQvsQn4G+s0Eb0OE8UnVhDhAdKBIMl2GgCDTlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437073; c=relaxed/simple;
	bh=jnzdl+fbVVcTTbZj2P9A5xsyzaZA7Tie8/2XgiKueJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+jPGpvulqJZYxuI9IPRNoTpuKpZOM967QovYISuU9muuBq7IdYzlI3QFR2E2EnWdVEdbhfjL/TUYDznB+6ofvKwVKPXPjCHlGXyAjfNNb6MyV3U3lEjhBVIxbP3hEedWOj7XRvl6c7ICebPWDqNUfHB80FZNkKbGGmuO6/S28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h39XCgrR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h39XCgrR"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea339a41f1so51302427b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 10:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437071; x=1732041871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tr6REDhXVt1opvineUair86Kv+hNXCwWuTG4wc24Uvg=;
        b=h39XCgrRThI+G2VlCLMORW6c/AndWOX6SR5PdJ690jPeJ+kumPHQSA76Ev4Zigl8Dl
         WrnMjfQtZlVMd7SiThDO+MZo7ZbOVrMMgTrRLU33b299A5y0+sD5ksWVf3xFHJxwziBi
         j5OYBfsjqxPcbRw25zy6zLvdu7Qhak60dUKSF/RBALu7msPUGNqlWo3dDWrS4KgSkbE2
         MKPMzWaHwPY++dZi8N/eEz2tBZPgeURXlgt55HiA80MZFKXTZJE4SCBhSeuVADZ0t8uv
         9CPVSZodA+TO9GvXfO0DRVe1N5SmUXkhbBkQR9Qa79zVO6uKxQSH65kbbJvmRa1jtZ2e
         192g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437071; x=1732041871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr6REDhXVt1opvineUair86Kv+hNXCwWuTG4wc24Uvg=;
        b=joo0qcnPhc08BkUi6EY2rvgIDQH9UUQVjZUf4y8jnF1vRnbXjQz4qdHOZTjmixvsEF
         IxSHtSqGBnFPDYt6WDmLylEW/AqUwK3hd/dJFYBE4/KpHYY8eFZL9FJcmzqKoRCbbFTZ
         O93qjbRExXgAgsQYIU7MVW9k7A7avMU5kCix1BxgqvV5svOeJc16p6QvLzussa3+9P2Q
         vF25IqxluwbisqTaIcd+PSkSDbtnQQyK8nQ9E9WdND5MNK/qZj+OguYQXqynNj2Z/woh
         TZyyo+7Cn8v9Yf2bvlsMWUzIdfhmVCUVk3cmt3xJP/70yhnpHli8lGHPSXcbyNwlKLWo
         OVYg==
X-Forwarded-Encrypted: i=1; AJvYcCUvDHryxY7Y5zhInY8eRrCBi09fv+gq5m3EMMMt4ijAKO/XdOYy5o6IOS4/Fru1VSP0KNQaT1bESxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gJKVad5oIF6FZE4MxxjSPUjbSLe7U/G4OiFekUttHWmX+Ms4
	rj31eaxciGX+z6Z5REGBJLL+y67zQm4fBb0dRsrsIf+VQpCwQaG5QqcOE/o6SSffnAHArbQyMnj
	5J2J+ld/edQt5O911Ok4OlOxtU3CXDaq2e44x4Q==
X-Google-Smtp-Source: AGHT+IH44Q8MD0K4pqUKXUCjf2JqplnFw2dHro4nArL34sMNY7ms7UeoYKZIVy0yhJb2ir9HCSb3HgO2REJ9e9FblRM=
X-Received: by 2002:a05:690c:7090:b0:6ea:5da9:2f7c with SMTP id
 00721157ae682-6ecb32cb110mr719877b3.12.1731437071000; Tue, 12 Nov 2024
 10:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108130647.8281-1-wahrenst@gmx.net>
In-Reply-To: <20241108130647.8281-1-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:54 +0100
Message-ID: <CAPDyKFrKTw16mfmMcnaz08vPJsAsC6KJj_j8j6UcbQif9VK1cA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: pwrseq_simple: Handle !RESET_CONTROLLER properly
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	Catalin Popescu <catalin.popescu@leica-geosystems.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 14:06, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The recent introduction of reset control in pwrseq_simple introduced
> a regression for platforms without RESET_CONTROLLER support, because
> devm_reset_control_get_optional_shared() would return NULL and make all
> resets no-ops. Instead of enforcing this dependency, rely on this behavior
> to determine reset support. As a benefit we can get the rid of the
> use_reset flag.
>
> Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset control")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_simple.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> Changes in V2:
> - add explaining comment as suggested by Marco Felsch
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 24e4e63a5dc8..37cd858df0f4 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -32,7 +32,6 @@ struct mmc_pwrseq_simple {
>         struct clk *ext_clk;
>         struct gpio_descs *reset_gpios;
>         struct reset_control *reset_ctrl;
> -       bool use_reset;
>  };
>
>  #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
> @@ -71,7 +70,7 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>                 pwrseq->clk_enabled = true;
>         }
>
> -       if (pwrseq->use_reset) {
> +       if (pwrseq->reset_ctrl) {
>                 reset_control_deassert(pwrseq->reset_ctrl);
>                 reset_control_assert(pwrseq->reset_ctrl);
>         } else
> @@ -82,7 +81,7 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>
> -       if (pwrseq->use_reset)
> +       if (pwrseq->reset_ctrl)
>                 reset_control_deassert(pwrseq->reset_ctrl);
>         else
>                 mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
> @@ -95,7 +94,7 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>
> -       if (pwrseq->use_reset)
> +       if (pwrseq->reset_ctrl)
>                 reset_control_assert(pwrseq->reset_ctrl);
>         else
>                 mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
> @@ -137,15 +136,18 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>                 return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
>
>         ngpio = of_count_phandle_with_args(dev->of_node, "reset-gpios", "#gpio-cells");
> -       if (ngpio == 1)
> -               pwrseq->use_reset = true;
> -
> -       if (pwrseq->use_reset) {
> +       if (ngpio == 1) {
>                 pwrseq->reset_ctrl = devm_reset_control_get_optional_shared(dev, NULL);
>                 if (IS_ERR(pwrseq->reset_ctrl))
>                         return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
>                                              "reset control not ready\n");
> -       } else {
> +       }
> +
> +       /*
> +        * Fallback to GPIO based reset control in case of multiple reset lines
> +        * are specified or the platform doesn't have support for RESET at all.
> +        */
> +       if (!pwrseq->reset_ctrl) {
>                 pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
>                 if (IS_ERR(pwrseq->reset_gpios) &&
>                     PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
> --
> 2.34.1
>
