Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF618FC70
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154645; cv=none; b=GjpvqUNHr1ZvUDPX1HHNQ+p/KvdXt4BFRC4P1Q2SUAV/nrhkGSVL1ORsLm7cOHQv13WCrcAAAOFJUhhsnqnC4oGNfqB8iDb3vvPvVARY2L2h89YLLw7OfA7pOj/Uan8aMwDFgNphsIEwc7tzaYW3l348KJlFKcT7dqbOTFl0JaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154645; c=relaxed/simple;
	bh=+N0fCfo75321OdOJcVcEyAnRKFBXqAIaZvFl/KyVYCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx4qo2liSlNzUtqWQeKR+gf3iBLUg6gDmZK9KRJZNA0qTM8LXRV7FQnsoYdafA4Vto2vez2CdrVjtNoAEoKSN6QMwTWvRVD+VzEnTgr1x7o4de3O53PtmxsJhAyEeqNdbIxC/Nzgtq3m7B6hQy2GXSvRn0j1hfpeEow70zAEvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=naH22V54; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naH22V54"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5975441276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154643; x=1724759443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9DVd0Gefl7PHpJ5IcyG9GzUh0GMs/G2HRBX2T94h5zQ=;
        b=naH22V54vnmnpUC0mBpyC/NRdrlRbT6takB5P5dnQm3rOJKXC+Nd70ThDge7XAccan
         AeB1X+7eFglWcQjxhwmrpaRgRXvYWKr3nyllQlzsJ244GspXZfGy7BaareRy0GalWyQd
         yfKpEox6sIs1qfKPp/Gr9KEK1T1JMbNwva1Hkris63try70xC3L9HETl/7kcM9U31kis
         ILSPsWJP9wTxRgSGV14jKCFmDwGpp3IEwxHZMnCkmtsvO8bSFcTg8vEiZWPvHVJEBJMt
         qHnQmGL2D3SJm7SZBUqvxSoQlat9uvDsSOtjRX8E7M2WpB8CRyrd6zBlZbn0oYNTnxx8
         yVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154643; x=1724759443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DVd0Gefl7PHpJ5IcyG9GzUh0GMs/G2HRBX2T94h5zQ=;
        b=HDUDIbKQqou+Q4d+0N0tjlzGh0heLdaDkUbN60SJ0+kgAgTisUQfvZxeK1mAaE94KC
         3sEklq3n+AC8Z6BtZTMhqaxagUmABWnKjRL9MlhxGCJMocLzbyQv4xq3WbRZYAHIKARW
         /zbblIi0SWwdKAIAMyBDaKytMlSkm0djBSsiHULs8hIp7n793uw86z1B0ig8jgRPBFjU
         V//9f+hE2Nw/rDL9DLCF2TWxOM1efX7RFPN07G8w9oDIaYUUGXTo5a5rxYu4HV1gqFcZ
         NwjgLblwjs8gHQmPCfaSDSvRCLk+nhLx40eNuPmcDrzjQ9C/992SeVaJAnqH1i9AjDP1
         /ghg==
X-Forwarded-Encrypted: i=1; AJvYcCULicE3e1u86E4PRYYOs3z1Ij4qWN41xXPj8iGSDv2mfF5mUDou2NGjlhxZBN8M8ZPHVWafWKVClt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGWmCiBzRe9B2UL1Rs/ZNBFABGkCSlQOzxGhuwXJGfFA3ptO+
	EboghJt1H/v42t+0xkO5Nr3hK9EM1AC3lpqDxrixbdfIm83oBt4SEL5fkocYg+uUqprmhB5Fw4L
	ZRJv1sVUROEZZhqUt3VLNO1RYBSUijSshb2UcIw==
X-Google-Smtp-Source: AGHT+IEMB3TMQoKoMENuYx3+vgX9Vhmt9+GFb4+PSf+bt1316IqMO95UvkjliFqkRrK+xxXvuI3QTNie11Iwttdbqgk=
X-Received: by 2002:a05:6902:e10:b0:e0b:eb96:fd95 with SMTP id
 3f1490d57ef6-e1650d3fd97mr1995243276.19.1724154643077; Tue, 20 Aug 2024
 04:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c90be28-67b4-4b0d-a105-034dc72a0b31@stanley.mountain>
In-Reply-To: <8c90be28-67b4-4b0d-a105-034dc72a0b31@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:50:07 +0200
Message-ID: <CAPDyKFrdNWTsP_cKM4+RmmL-j=nu+r2HktFRxGxhcOhPcSt8vA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix NULL dereference on allocation failure
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pierre Ossman <drzeus@drzeus.cx>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 10:44, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> If the "test->highmem = alloc_pages()" allocation fails then calling
> __free_pages(test->highmem) will result in a NULL dereference.  Also
> change the error code to -ENOMEM instead of returning success.
>
> Fixes: 2661081f5ab9 ("mmc_test: highmem tests")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> This code is from 2008 so it must not be that much of an issue in real
> life.
>
>  drivers/mmc/core/mmc_test.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 8f7f587a0025..b7f627a9fdea 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3125,13 +3125,13 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>         test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
>  #ifdef CONFIG_HIGHMEM
>         test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
> +       if (!test->highmem) {
> +               count = -ENOMEM;
> +               goto free_test_buffer;
> +       }
>  #endif
>
> -#ifdef CONFIG_HIGHMEM
> -       if (test->buffer && test->highmem) {
> -#else
>         if (test->buffer) {
> -#endif
>                 mutex_lock(&mmc_test_lock);
>                 mmc_test_run(test, testcase);
>                 mutex_unlock(&mmc_test_lock);
> @@ -3139,6 +3139,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>
>  #ifdef CONFIG_HIGHMEM
>         __free_pages(test->highmem, BUFFER_ORDER);
> +free_test_buffer:
>  #endif
>         kfree(test->buffer);
>         kfree(test);
> --
> 2.43.0
>
