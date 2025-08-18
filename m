Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7218261B99
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514569; cv=none; b=lAdzbn9y18FNvRym8hQYQjoeJDT3gyp8rHTndmOtmLxDnX8/NcPSCxPp1DogGIgHHlKiSBEfdsqqgNdkKvNZHmoGERlVJIaowokGul7oCYbK7stLzNY0wS92yEc5bA/mVcLXuCOJVeyhowYJSRzXeSlHnaxTac89uwjdOjPLBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514569; c=relaxed/simple;
	bh=jxnu/FEhDIb+0x6qULMoBWUNLjUiRBXs0W3MtieNfUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4PyFtqcf5GlgYssN/iR+K8ZUyxbmgccTRDulxGtB+gw3uygnLNUC1Xe6GTy/ACclVmgOb/J7tKAbEAJ/BJgVdURiBcnOEiMNdtsRbWzwqIDQsK9ASkfoUvIJ04JDntN3KJOH4E6/p0yDCxWvJ26GL6zun3G78ySigJkoiOIGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZiegpXC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZiegpXC"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e94cfaa274fso658247276.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514566; x=1756119366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1b8N64MqBxtdg6Md3INHXM2YASwrOfNIX/lKR/8J+KM=;
        b=YZiegpXCulLsU4XmcakeiwDIx9ChQntdLnJBhl/mS6H7G+RsM7marWno4jHEj+ZK1d
         9+GHUX9jj3xpcAPFTCstwwuKj3Gw5YsZJ4vvg5cX2P9h3pUKk8aIL5HLTJ8kl2Qf8ovS
         zVjsyS6QJmeMgMpl9k6rsoNtKy+N7CQ1EiJNA1Vwq+5duY3f+MNBRGyc8eFPfecXLC/W
         7HhLeOlmijNJZcuQ2tD8vNlSOzXkZ3MtumnpOFSZcZA3L3W4pSsv4QlR8El7cwh9ddph
         8k9oKhPaNQF93ptmeTsGQ189SBH1/Ap6Kk42AIUILtEaIYpfwk6h/XBJWi2FiuVgSBaE
         w09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514566; x=1756119366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1b8N64MqBxtdg6Md3INHXM2YASwrOfNIX/lKR/8J+KM=;
        b=BH8IobqpEHhzTgIDd9aZ7kkT43/ffNHebdhCoJMb1pZiHKAMHAIHuNZOQc4gXS3Q5h
         +Q8KtZY6HGsd5p7s3olae/FEavstaZWmom2vgabO5MgI3elHEwCcsKt167oMmAHdRd84
         YJFGVXq8upl78djoUWXnRD1Ah54+wpc+xDKGWCvj1vmuRNrEbwFyS3y2o7Z0ACP+CNwy
         Q0f8yoRZAytGrzTo4/jbe/roZ6dEGrBTYRiy/0lgqNtG0Nc2uhk7Te82TBh1I85xcBba
         NghPVrwlBPWajhc4nDjfXWdmMahMqbNYDv0lNwC5FxfAAkbWI0ztCn/lG6Agd9eo8pwT
         3arg==
X-Forwarded-Encrypted: i=1; AJvYcCVpqt6jl6zyo+Dr6CKEUt0epX8XsDlIaFSb8RYUWTTcsL/D0WTRgwcenhpsnafXWEmhJOOjiHSe2SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrsp9N301vlnYxyA7s10qxYPWfLgNI5CE1bDFQrfwGO5+hsz7U
	taq7RR4kDLUJiDejOL2SQTZQtY+xIhG30Q58nbwyi9RuawnuKcDILzSjG0N3nUrJ1PJNNZ7haFo
	UBa700GqFQJou32sSUa/PzgL9iRou4GgC/hMcRRL8YKmMQO5HgrVp
X-Gm-Gg: ASbGncunl1+7ZH+8XLtTUPhbKZZSxLjNa4/h8g7lfFwH574h76ai91hU5aNka/pi1mS
	AGa5Xm0C0EmR3mrHMcdorqVDG331sXr0PDNoRL7ul3aGslhclBcY+B/Qh2+Kp+9aJV1RITJiEMC
	MUYQILwU8Jh0ui59p6HwHbEO/NpxDNQaPUnvgF8r+p2xhz1unwhcsQ6UD7sE4ua2iUaeLzDMPUT
	7R9uOcK
X-Google-Smtp-Source: AGHT+IH15gkPWwCvc5PywNU5D/QK0nGxHhRHiumu/lEM3Txj8hZO2Y340R+Kfm/qCGDXBKcQw9v3YihoNtgwIe7LbYU=
X-Received: by 2002:a05:690c:74c8:b0:71b:f500:70c0 with SMTP id
 00721157ae682-71e6d9f2fe0mr141459777b3.6.1755514565675; Mon, 18 Aug 2025
 03:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com> <20250813161517.4746-11-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250813161517.4746-11-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:30 +0200
X-Gm-Features: Ac12FXzrKO2nm0jcbAZqxzbeAAtZHnjZ63sxktJhx4Uo6D36k115qSOwu0HiS6c
Message-ID: <CAPDyKFqiF2b-LOr8aGgy--u76=z14dCwUveTN_zQOKLpjyhY3A@mail.gmail.com>
Subject: Re: [PATCH 10/21] mmc: remove unneeded 'fast_io' parameter in regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 18:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
>
>  drivers/mmc/host/sdhci_am654.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e4fc345be7e5..8a099508b939 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -95,7 +95,6 @@ static const struct regmap_config sdhci_am654_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
>         .reg_stride = 4,
> -       .fast_io = true,
>  };
>
>  struct timing_data {
> --
> 2.47.2
>
