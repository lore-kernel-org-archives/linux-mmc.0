Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203831E47BA
	for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286492; cv=none; b=ajwgGdd1nnZgqfSaERtt8/CtNsG+mVpj9VW/agCPXENkaDyNB3nHpl+RvgFEW3/Ob+kJBc4mVmeCJHjKiRyDhvc6aylW9zSbi6hRh4ekvb8x95K2YXEAJ9nMLM5vLgWLGlfb1zOt6SwSSflaovqrY/1143KfenEfcZE9+vwuDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286492; c=relaxed/simple;
	bh=1lwKuaby2rxdJvGX7FjuVGno98Zy+KsJ0slckdUyDPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKXwCLM0H0jhS0BXD7UMIhxrPq/xFjSWiHOnlBX2ElwxkzbaSdHPqKDP4lfp7jq4jezRVuca+3rAQYGnuDI6lTjDaq/RmPmotckIktwUBHrKBkWIWCCiCaSfl2d99EKMDCl+qseUSIYbLTaGeZdgDOEnDmu2gbPzKZzoSYGWYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b1yGVSm3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1yGVSm3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso8322610a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286488; x=1730891288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UnqA1/VyP2GaUG0I6DWNe9vsGfHeO2r+Xl4NmfSfDTE=;
        b=b1yGVSm3Mf3FZ8hTa9lCv2UopraAiEoAKwjsvBDJD3OtQrzjhxsIX9U4w4OlpDYc1E
         V9YWX0RyAEinpShPuGJfwbN6DKLPqdvqug6ZfPhU25GsmtNd7R6DruOzpAIHZNHK6bm4
         0Uhs0nRXNoIG0fKjkZXKeEcYwD3jY5NpWEJyX2PY3Us5hvwhnCJAn2R2PsL7ZhKXe762
         Rhp583SnVeqfL4Q0OJHSO9L0IuF5kjKIbmmXQfXX9OeB2EFp0wDxy/xvqPbmUskVPesY
         CfhUiE3nusOljGzZaWdHamxqjeOCeDs4CF5IdQr/EptgWkm5hyMgmZIWfgaWDhnkvo8i
         CT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286488; x=1730891288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnqA1/VyP2GaUG0I6DWNe9vsGfHeO2r+Xl4NmfSfDTE=;
        b=dzKjIuL0rQOXbOnxzMQqnkISwYqsSXKnQ4tAQVD9djys3m27Ai7BE0AUuV19ZezvKb
         vUgvLfgoKVA1MQODTt2qzJsUpCeiCZcVfrMDVBJ//MYk1gswv2kv8blcbqJGbIgbSwwC
         4NkxXqdKMyD5cLNovsdFRgZchrg/0gbQmvksOf1w0g9kBplLvbuXUEUnvw74CrCD7gT5
         Ve6oiK7Gge3qxEBBHTFgEc/0jDXH0sOcuDef+I6KP8/+Ig2l5ZGBvXtW9y5NAKZ6S5ZQ
         HUlr/FMuO1X0r+IAYZS1VU5sli3INGSsxbi/UAfY9FafkJwlolSOwDE/HixA4yazicxt
         ip7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtT85UzQHJJfSjJOhym+eNJUdRDKUH8eLblrY9NCzofwCp3TWqxnbspqsfrS2DInAaTacz2fCiCdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKodYF4vbqP7kQlOxwMy4mIg3+YUIqt3taoY4z1PvCUTZQdXof
	4j0Xue86ZluILI1A19oZsOB8txF/fpBYUPhiAkMQkGfNJ9yd/HNSZtMvBqhZlWVU0gVT/dm/HXo
	qjazY5xCP5Zw002+x2JzyLhWVWi/nEOdHcvUfhA==
X-Google-Smtp-Source: AGHT+IGdyGcqOldNvwewAC0KpsUZIXUtN/yALriYjSXCcd6dndKmnspOWwUk9QcF5DI4DfwPz6hBbGu50dx7SxZEuO0=
X-Received: by 2002:a05:6402:520c:b0:5c8:8416:cda7 with SMTP id
 4fb4d7f45d1cf-5cbbf8b11e8mr10328645a12.15.1730286488358; Wed, 30 Oct 2024
 04:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030015326.2289070-1-benchuanggli@gmail.com>
In-Reply-To: <20241030015326.2289070-1-benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Oct 2024 12:07:28 +0100
Message-ID: <CAPDyKFqNxMG8d_rSnmy6XrweH+YSdejmR3Ma9=1UVKYaGAnapw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-uhs2: Remove unnecessary NULL check
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	victor.shih@genesyslogic.com.tw, dan.carpenter@linaro.org, 
	takahiro.akashi@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 02:54, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The "host->ops" pointer points to an offset into the "sdhci_ops" struct
> so it cannot be NULL. Remove "host->ops" check in "if" statement.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410271835.tqz9s9JV-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next and by amending the commit message a bit, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c488c6d56015..b0e4ab852a94 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -413,7 +413,7 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
>
>         DBG("Begin do uhs2 detect init.\n");
>
> -       if (host->ops && host->ops->uhs2_pre_detect_init)
> +       if (host->ops->uhs2_pre_detect_init)
>                 host->ops->uhs2_pre_detect_init(host);
>
>         if (sdhci_uhs2_interface_detect(host)) {
> --
> 2.47.0
>
