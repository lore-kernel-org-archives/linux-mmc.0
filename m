Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844A209663
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041938; cv=none; b=YarwrDNnHEbyTQy1p3mNj/k1eCBCPaEYBSEHxyeMJEg+Y6rKA2RRolcc1dS5IX66V27KGBAS/5dug5Fs4/HjQX+LcV64qDgM6ZFc0Ee2z4tPVaNR8t4mTnQ59yNz0RW+eomWI79mjjpgKLE8KIGE4LHR9sv4Sw+XjdhYeOjFTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041938; c=relaxed/simple;
	bh=ZWK4F5pkiuvCsD2a+W7pEbXy54LrutSpignndw+AF3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8bn2V/1HzuFRK7MZ7t05uqktwoy5IRY/cDn6ju3NYgsTf+PEkAk/APw8OfECSsnc6qVJVqgxhpl0BftnCNUi/+eY8+L67TYGkOT8D3c8WMU0vZfw0jACjRHGRQjl6ijD8UhS73vKMQvOOpcf8N6PDeJ3YfJUjHYBThS7LCVWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mR/eUC+Q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mR/eUC+Q"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-702628e34f2so37938687b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744041936; x=1744646736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUJomVxK9lUe1I+H3yOlCnm1A1CRl+UuxJsXdwrQjHg=;
        b=mR/eUC+Q3FX2t3epG5Ji5tglS0MMkiNm2vdz6275vexf04lYnGHyAwcB+ytYZ1dQQJ
         QgC4xt5OQnCgBa4nOkhSeV4vHyL0IsU5OLbg8lynXH/rueVA2eh/F1CJlTjyQ2SFtSTS
         ZOrM6Ba2cvKQEWl1sry7P+puYt5WAfcph6Oe1S/a/uw9S8Pb8ABjFQCMyWO5Spf+UGeb
         mkQ6r3hjQOh1o6L9diTLhSbF4LJLMHOfDY5lXKd8B32n3Vxp/aUCfI4AaiPrYT2FdgIS
         4TJxIKP8qd2OXSp/gGmUMa+AzoJwnBys/tmqAhNNoZK9PBWXJotnRbv18uf9Ab3my2xr
         xB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041936; x=1744646736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUJomVxK9lUe1I+H3yOlCnm1A1CRl+UuxJsXdwrQjHg=;
        b=YK7pyr/aipabrSvjmfjR8+fz63RZD9rBbP/kqmJOHJOBCx35tEYAGM9LBtkP6b+AFD
         W+FEwGbsweE2wZSqDHW7Kl6HNPwdPHO0QVTNFZy/8bfpfHHsqnU9E6jXa6yEfl2N/Vgi
         twPkbjV6jKuMGbk7qg12NCFaIDZljhpUFrt99cb+BpMBVa0em1U1fiV3qIK5g8z8Xs9R
         geIByFHRwJV+MkDv0BQTZSn9Uq4W9yEBC6sb2Z6wP0lAJp1gFU7ra3geeq5z2ijJ4eY3
         oFhfneXAr4kMGvgQkUSJZH/CjGnxZLWfBnRuXXvFg1hUascX5Zn+ca+U+J74yeo8rf5t
         Ghzg==
X-Forwarded-Encrypted: i=1; AJvYcCXMYGeqLQrH1bsr9tQvdYqxJ9KzIc5CwtTOjF8H+r2NpQ1HajGwu+3xHtxZhQijhnU2rczbQ+iT6/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc67VKG0xTqs/ah/dVUyxqbsZSI9Wm3gYFmDWa5aJ0FS9z3CfA
	vrkmBUmf8M1hExjjUxoQAt2aUpu+JfJhGaedEacsrqiYOIlqOCs71SkvqOYJV82sKfJCtbcj3OE
	TIfaGSjyobXaGgecSk07O5IktAbpw4CqrayJ4XaNfdumqfd4N
X-Gm-Gg: ASbGncuDFSflHm88kpaZvd8QjtKIjnP2H4uXSkcn2dJXzLAEtH0oG3F5nOCgvtF2DIq
	1OuY2l41QpOYhuwhPczYLJUKSPosUikPE9SDSDBs9PFcWvXx011mkRDsQgaWSdM4qmiAOt7pACx
	TgPiOn4JisKVh5+X37r6EtVMhcCaQ=
X-Google-Smtp-Source: AGHT+IE5IIpGhJ3lxaYQndkRiN7XRvbQi05HhF3dU3/Cu76gPC7qI1JSQCWf2xHlhqowdnt6+Q28QG9tfwYBGNmeHZg=
X-Received: by 2002:a05:690c:6f11:b0:702:66cd:10be with SMTP id
 00721157ae682-7042d57dc3bmr327997b3.14.1744041936276; Mon, 07 Apr 2025
 09:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331064400.16677-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250331064400.16677-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:04:59 +0200
X-Gm-Features: ATxdqUHgvmOJJ1NJLmLUKmjL5ZYT7OOW4ygQlvFHRtO9JYlUwIXiz-e05ukyeTE
Message-ID: <CAPDyKFoQTRO1Ax8wa2HZqngG_0gk7rJ4x5aNE1fcDS-Ln_YGRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: improve registering irqs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 08:44, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The probe() function is convoluted enough, so merge sanity checks for
> number of irqs into one place. Also, change the error code for 'no irq'
> because ENXIO will not print a warning from the driver core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Tested on a Renesas Spider board (R-Car S4)
>
>  drivers/mmc/host/renesas_sdhi_core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 8c83e203c516..4642fdb8bf65 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1240,15 +1240,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>
>         sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
>
> -       num_irqs = platform_irq_count(pdev);
> -       if (num_irqs < 0) {
> -               ret = num_irqs;
> -               goto edisclk;
> -       }
> -
>         /* There must be at least one IRQ source */
> -       if (!num_irqs) {
> -               ret = -ENXIO;
> +       num_irqs = platform_irq_count(pdev);
> +       if (num_irqs <= 0) {
> +               ret = num_irqs ?: -ENOENT;
>                 goto edisclk;
>         }
>
> --
> 2.47.2
>
