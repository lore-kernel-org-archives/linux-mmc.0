Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56F1A4B64
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912212; cv=none; b=Y8H9SGwrYKsOVOWr6XEZH8DcxPGLmhG3W9SVf2K2ostL7BdHqvxRpMem49IFjVhrG7EZiPw1beBUXPxYkv7aoWXEOM262z9kWZPgnPH6UNlyVagV/xuaOlpgUz3EQOWreOs6efBOkqV0+h/8bOWYxKKrUHc3VzyBr0Tq5aIhtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912212; c=relaxed/simple;
	bh=Cy8jm79kKyoeyBVmUKmg0vqDck5145Jib7RrRvUb+lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJW+vXic2k48azAYN2B/hhthBAN+ergr+96uvM8QKxDGMSsCTmL1KmWkTPLRHbEXihDyj133Yt7HYGJf40dG9WzDKEhBjy4sJz01zkpsrAQ1i0gYoqC7Koq8oO5Im+Y9a8p+wofnWUy4SgMM3nJ9Vsep2R/8qkq9wIy4Y2GqG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMl9BPx6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMl9BPx6"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e26114a1b16so365866276.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912209; x=1728517009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMmIsSIqxw2lLS9EL8ZWnjAaMUTml/AJZkW1/YN3TRU=;
        b=eMl9BPx6vc+8IxQsqM4UNx5ILpoyiwDcvbE8EFtgE1aUdHnYXE7ZyGtqeYL3lrNqBA
         RlGVZgFIeDCRnworsENO4/3sgeBVlvI0kF2/kldXfvs8DrRLw8MBy+UyRIe9Mr6uH85i
         +zW2KolE0oZ0+dCSwKzRa4UgJX6P0btIQyzlcZ6jIM/bf4ABlnerIS5pQuQPEysSyCj5
         z/3wwVjWmZs1kIqHSRbT/JYJORGGCCgPjM5Sn7zst9khTLk9yz67sWycv9g4/YMbEWKV
         DA5hiqVoxSkzLu7jUB7FDCXBbNii8dSwKx1l0KlDi6q/uTVytvycjut3QEfA/lofO5IE
         GfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912209; x=1728517009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMmIsSIqxw2lLS9EL8ZWnjAaMUTml/AJZkW1/YN3TRU=;
        b=ohT28ACN79c29CJzSuj0EiQwpplY7tvggsKJ2+HEb5lvidssn4Ozk3E9nUavg/KNAD
         BURQbubvg2x8hWlmTCFotr7KzOHfaxixLynYKjZWWsXMQYibyuIKJ2IPrq/WxryLXg8c
         vGJDTni0V7+aNrH1iZmoRVZAzuzqOF46RfGNuVBXRRwzFqWnYuJYABDV/Gi6eFuMsStC
         z7dpUySXc4ncErBRaf8EHOxAZQX9khvX6rqO+e/RQReHi3boczdJ0ssmLujXuLUyDX7N
         hR7bMeRHOGlr9bpir+xaecqL3gRwGCfzPQHQrRvBpzMF+zikr5pYM5EI/nok4WeexE6F
         1eiw==
X-Forwarded-Encrypted: i=1; AJvYcCVGQobkpbzyjQBP3h2RNuFl8tAWiOsBQ1bP4zoyIuuN8DomYTIsfyYzgQ1V8N5E9YzGUHiT4sD0L14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzol3Mk8gXVswEbmWiQOGB9s8ffV/cPQZGmhDlYKG1aqaKuUR
	aT6ZZ4H/wOfiUUQ8+4jkx0uer3S0PbxfMTzzJ5RyNLe1qMuqdjqYxJQVHjtvq3twp6T9y9Ho59p
	GYe2rOllNtNKoxMN0DE+jHwO6dMHxjkOwbuVmDg==
X-Google-Smtp-Source: AGHT+IEtfDZUzgk/RKfYheURMvQhUbLGY40ln0Wzu7T/i625eC/l0Cs8uWSg5Wr0L3A5nhmvt0c8ctP6sFH0lfC4icc=
X-Received: by 2002:a05:6902:2389:b0:e25:cfc9:489d with SMTP id
 3f1490d57ef6-e263840ca01mr3890390276.34.1727912208827; Wed, 02 Oct 2024
 16:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:13 +0200
Message-ID: <CAPDyKFraZUQu0hawOK1owNNNjA3WD0Nhq9_zwvcYzGy0rN+nsA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 08:11, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Enable SDHCI_QUIRK_NO_LED for i.MX7ULP, i.MX8MM, i.MX8QXP and
> i.MXRT1050. Even there is LCTL register bit, there is no IOMUX PAD
> for it. So there is no sense to enable LED for SDHCI for these SoCs.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8f0bc6dca2b0..ef3a44f2dff1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -238,6 +238,7 @@ struct esdhc_platform_data {
>
>  struct esdhc_soc_data {
>         u32 flags;
> +       u32 quirks;
>  };
>
>  static const struct esdhc_soc_data esdhc_imx25_data = {
> @@ -309,10 +310,12 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>  static struct esdhc_soc_data usdhc_imxrt1050_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
> @@ -321,6 +324,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
>                         | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE
>                         | ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx8mm_data = {
> @@ -328,6 +332,7 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  struct pltfm_imx_data {
> @@ -1687,6 +1692,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>
>         imx_data->socdata = device_get_match_data(&pdev->dev);
>
> +       host->quirks |= imx_data->socdata->quirks;
>         if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
>                 cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
>
> --
> 2.37.1
>
