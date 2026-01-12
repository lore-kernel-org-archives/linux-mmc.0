Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A737B409
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238709; cv=none; b=BUgl5jiuhVgzTEykWt3qp9RJFO3uuveAXQ+uhAkxEZXkbfYWUuycfBkPkfP4liJ7wdZkD2qiwpuooRoCefV2oqx1QYEkHQHr38BSgoFVyraUMq9iVDtUxzLgs7+oe4AKka4NZO44eVNamj3+VTT9uAxz3J5980rWwO7W1/WZvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238709; c=relaxed/simple;
	bh=X6KWebVUMzPqWS0oCx8vwMsl6nARPud68K/fbtyq0BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haMyxIsAo0t1DiTLBBuSu0RvLmfGetu7plG+xMV+mDVtXh2WFIYSZUd02/xCC/iYx92Hcb1U7uDip4am+mAqHq/CJy/fOBf9YM5IxaSCnM4D345agSnl+oiSKKJQqmWkM7WOPQ5EcFYq/5FTzcLoGVJ912J9zBvcbPDyewKiqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0TwIw1B; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0TwIw1B"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6f52eea8so4774805e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 09:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768238706; x=1768843506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fk9cmvNOIeAfliFvuXh3wfBKNNDjshxmhYpmqT6PvOU=;
        b=o0TwIw1BAfIhQ7M6QtR1WM7tgG6WyvoX7ebY8EUqtbEMuMYpRyPWoJncwjc74lztfD
         WHA6M+SK5ABQFWpYUuy9ei9s34EBvqWQos7Oapu4Ofk52He4Kv+bugfAasNg4slZ7xwX
         uvxHXLrUcSejTZufnAtMyXoE7f3MtnBI8FhMB0eumTFKrA5Srg7i43uktVIhQeH2tBF1
         fLD3Z0TPcSNpa9LWZOlWirfTcYNfcmxnBZC68xzEy6m9Jx6S7TTn59QRVhzMIcxeQAZo
         Wi3tEAHUiJExwpeAKI2HdB95ddAR1i0WgzQ9tjY9b7xdOwGMkD2YXUdYD7aNGIFbH2/k
         LaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238706; x=1768843506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk9cmvNOIeAfliFvuXh3wfBKNNDjshxmhYpmqT6PvOU=;
        b=LRzP4WxlXe7RwzNfDDKmcp9CTjqF4EZBNZ9r8UfJA3GCZD/qtcgnQUIvSAtISWycqx
         vllwQnL6xHKn8POXNTN1GR5dbjOb1O9MIWx3ljM85uE2DwpKs3q5Z4s434HMfRHnJngw
         WQ74eLDM5Jm7JdB8F4EM5jQGV3drSg3hXjsHYnprLL7/o1ywojpMke8+hIrjAbdN/rp8
         /wIM0rX+gTsMC4seGEdzjlcVz65Y9I7c9PNdfiIP58JIYKpR2vSRTNM5ssj05mPSU2oc
         MHRBaDMRvcRfKdu+XfmREFEE631NIUwyAD58J9bdL05n8pKLnQFBAvlW1QpCk1DWdO43
         mSSw==
X-Forwarded-Encrypted: i=1; AJvYcCWE8LmjqIS1u72M/I5xh6FKp82oxErxHOT5cqLiswD5u4XSoT2Rh1rBN+i5lSOgTrQHSYZM1Ww1R9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWGO0fiDfwnru/KGoZgix0UJ4eG4bI5mXYELnHXua5LmjR+feq
	IBNdPenNMui5BRHLAyh72tMh7ePtEkjdjuSFezOui25JrrsUS8RZ+hQERcVUhfHZybsUDWG3v4Z
	A88bMhraiJlcAc5aoPOl2GMIpg1i7Y8+/V+SpUEsMkAVnQx4yBg56
X-Gm-Gg: AY/fxX45wIp0uOpwTnglt4GlKRpo8fZfJTLmTQgr797aQ64Wf794Mj4977mGRk4OfnD
	YF3AedoMQUTy0ikqyfQk12JXBK2a3OUDj7MXVua/NWSLumpSiy5CPhZIxg1QOs3gYQtjyyRlFwi
	1EBIBcWrnCN84+HevM4iFO+9p+OpN5xg6MkyG8BghmsgjsVw/eZ0KvuP1EEvO/98V18+/TVh7du
	lL37tbhtbjh+KE4R+xEHPGT39HQll3XE7sy1+EcKYSqjHZ++tM8LjczOGtkXies1HONY0lu
X-Google-Smtp-Source: AGHT+IGizbiXsJz9jmzpUETK1lPi15hPJXZIifcreFFSHTDP1y8wkuOOklWcjTESXtYZfMHNtqs6b9rXwJuWOVxytHY=
X-Received: by 2002:a05:6512:2247:b0:59b:6d9b:a990 with SMTP id
 2adb3069b0e04-59b6ef06817mr5178496e87.8.1768238706131; Mon, 12 Jan 2026
 09:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>
In-Reply-To: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 12 Jan 2026 18:24:30 +0100
X-Gm-Features: AZwV_Qi2ZLORoyR8MVAoIkq-RuSlRVIjMemhNpVIfvSgYqsjmsTtyGlP2VFJ0D4
Message-ID: <CAPDyKFr3u0voSXKDi-9sEPA4Pe5x91Y6c4ZQHrRqq0OHuu5yEw@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Add support for "mmc-pwrseq"
To: Francesco Valla <francesco@valla.it>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Jan 2026 at 16:28, Francesco Valla <francesco@valla.it> wrote:
>
> Add support for parsing MMC power sequencing (pwrseq) binding so that
> fw_devlink can enforce the dependency.
>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Resending this patch as it slipped through the cracks (of my attention,
> at least).
>
> Original submission is at [0]; there it appears as a v2 because it was
> the first time I used b4. It was also part of [1], which wasn't really
> a patchset but a follow-up to the boot time SIG meeting.
>
> I added Ulf and CC'd the mmc list, hoping they can (more
> authoritatively than me) reply to Saravan's question:
>
> """
> I took a quick look at the documentation. It's not clear to me that
> mmc-pwrseq always points to a supplier. Can someone with more
> experience on this confirm that is what it's supposed to point at?
>
> Meaning if A lists B as pwrseq, is it always the case that B needs to
> be powered on? The binding documentation doesn't say anything about B
> needs to be powered on first. It's just saying A and B have an
> ordering requirement.
>
> If the meaning of the binding is _ALWAYS_ B needs to be powered on
> first, then yes, this patch is correct and I can give a reviewed-by.
> """
>
> [0] https://lore.kernel.org/all/20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it/
> [1] https://lore.kernel.org/linux-embedded/20251126-beagleplay-probes-v1-0-c833defd4c9b@valla.it/T/
>
> Thank you!
>
> Regards,
> Francesco
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 4e3524227720a596b0f12976f83357851e9b94f3..05ae33a58b5aec0a8f4d3b7237ce88066d86dc9d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1410,6 +1410,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
>  DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
>  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> +DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1557,6 +1558,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_msi_parent, },
>         { .parse_prop = parse_pses, },
>         { .parse_prop = parse_power_supplies, },
> +       { .parse_prop = parse_mmc_pwrseq, },
>         { .parse_prop = parse_gpio_compat, },
>         { .parse_prop = parse_interrupts, },
>         { .parse_prop = parse_interrupt_map, },
>
> ---
> base-commit: b6151c4e60e5f695fac8b5c3e011cfcfd6e27cba
> change-id: 20260110-mmc-pwrseq-e885e677ca2b
>
> Best regards,
> --
> Francesco Valla <francesco@valla.it>
>
