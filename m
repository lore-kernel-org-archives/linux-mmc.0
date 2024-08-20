Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797918E768
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154628; cv=none; b=SaiIO4aclIyfddU8fd2a810MSHNN1zNEVEz1Z84mGgIRs7N19aYs7hQhed82qi5tqMlxGRTXABXe/x8rY26Z+yi/uhN3oH3a/c4tBbncK6BXX1LmjQR8Gorh8OGstgdrNefO0VkhQEQukEjbkGvox3fReDIZPrF+kMUFrQxze3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154628; c=relaxed/simple;
	bh=jc4YbaPRYJlRTbIr8emUt1zth9qkb8yubEiCcaAbw6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mocTsOZSZT6jr5cIIlFPfk8CWNaCXF9epkGlE6kV/FfKIZg3jFfODliPaudWFj2kHpUh5ZE/yllRPKpzy1TW3IWyOPLTZ2yKLgdccTNRy0zLkKLszEld191P09ivp9ccEuXpQbqv553M2QUoGQ1eEvdfnRv8YIkH8d+FDDyM9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p34sWvix; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p34sWvix"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso3556066276.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154625; x=1724759425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCaQiWU5R51EtsPQihcu+5p2olyuei5P9S0S0wyS3fU=;
        b=p34sWvixS3VPAMKJMuwGILNfhseG4bDA/e8rC2LogE6lZXZl4GFjrT1wmLmyR6EYYP
         ZFLgmd0AR6qrrMqcNV+MiF1cgNWeLedRwSt9rOeMtkHvH8FLZO4JxJCCjdxYVoPCV6IL
         SBJAgdBfys6Pzg3P58hpqFov7nUNrY4Y1nyjlZamOHKxMH/XNOGHzni1TuT7zcrAFMYz
         1SxiX7kkXpT+UPj1OEqtluN053vioW4coesu/WeWznuDM/uVcL/81yZZ9qDTPqE8rEuY
         oeDH9iNP7CITUOdh1Y+TLCxaHY9T8i2E+mnTWiVcy47nZ01tr5y21hAvXXfg9ZjeIuPF
         c4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154625; x=1724759425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCaQiWU5R51EtsPQihcu+5p2olyuei5P9S0S0wyS3fU=;
        b=OatHwjJ2hhqRDnqbyaIxFjhh/k/Waz3N1R56Otr/glozixH+iXNcamypO820KEDKb4
         G+RCH7qba80m54r2be6umki6NHCPNH2m67EsUtmnDIVRM58zFQPw1VLOSrPBNo1agN0G
         On+3dnEqiYAMUSvwyCmrM0w5Ek7JWkAQTNoc1LESSS9xE7MT4l8r7mY1yJhFZwRW+/M+
         q+BSbQKdoJPuynY6kfFYCkztiLXDKlG9y8ex7AMSVJwsWwG5brdNgfy3cRG36al3s3jM
         3GaLusTgX9Qtikd2euFc3cpbmN4xN/HDEiIrcC35Z2CNR3UIry3b/drihNVCis4lSrgD
         nypQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRGiYo6UjdfqjJn1Dx+Qm6t+2Y4BtEnGNWQWrDNTCJpVDo8NFtBXjMh+aUiKyX/yyfM0YpmlCVaFybHgTyFO73CFFZkOJ50m61
X-Gm-Message-State: AOJu0Yz2X4LRyAry1X2u/yl/wLOO4DvoJWa68Palp6+RVm21zEzJW1m+
	TT1D27O64LELm3GnjnwooI9RXFjgwhXg/slYhTH9EvlU+dUdSSZMLhS6zNIp9TwSUiGm6ZuIwFm
	oMO3M9UyMi/fX1T+VwAv4rtx3lQy8xu+zsqc9sQ==
X-Google-Smtp-Source: AGHT+IEka4PQNOEQmCKqMTvhJ9/pQoM0AhHYZChG82pN+Q9gnQ5GIfCWaEK++BDwrG/zXoovAAiy4jJe/GkM5ZNmT/E=
X-Received: by 2002:a05:6902:70d:b0:e0b:eb79:d49 with SMTP id
 3f1490d57ef6-e1180edeb7fmr18992461276.18.1724154625483; Tue, 20 Aug 2024
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811212212.123255-1-ben.whitten@gmail.com>
In-Reply-To: <20240811212212.123255-1-ben.whitten@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:49:49 +0200
Message-ID: <CAPDyKFpibjfVuSyuYzkkxxHRoabyZTAbgJJ01TdquC2EeTZ7Kw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: allow biu and ciu clocks to defer
To: Ben Whitten <ben.whitten@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Will Newton <will.newton@imgtec.com>, 
	Thomas Abraham <thomas.abraham@linaro.org>, Abhilash Kesavan <a.kesavan@samsung.com>, 
	Chris Ball <cjb@laptop.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Aug 2024 at 23:23, Ben Whitten <ben.whitten@gmail.com> wrote:
>
> Fix a race condition if the clock provider comes up after mmc is probed,
> this causes mmc to fail without retrying.
> When given the DEFER error from the clk source, pass it on up the chain.
>
> Fixes: f90a0612f0e1 ("mmc: dw_mmc: lookup for optional biu and ciu clocks")
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2333ef4893ee..e9f6e4e62290 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3299,6 +3299,10 @@ int dw_mci_probe(struct dw_mci *host)
>         host->biu_clk = devm_clk_get(host->dev, "biu");
>         if (IS_ERR(host->biu_clk)) {
>                 dev_dbg(host->dev, "biu clock not available\n");
> +               ret = PTR_ERR(host->biu_clk);
> +               if (ret == -EPROBE_DEFER)
> +                       return ret;
> +
>         } else {
>                 ret = clk_prepare_enable(host->biu_clk);
>                 if (ret) {
> @@ -3310,6 +3314,10 @@ int dw_mci_probe(struct dw_mci *host)
>         host->ciu_clk = devm_clk_get(host->dev, "ciu");
>         if (IS_ERR(host->ciu_clk)) {
>                 dev_dbg(host->dev, "ciu clock not available\n");
> +               ret = PTR_ERR(host->ciu_clk);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_clk_biu;
> +
>                 host->bus_hz = host->pdata->bus_hz;
>         } else {
>                 ret = clk_prepare_enable(host->ciu_clk);
>
> base-commit: 5189dafa4cf950e675f02ee04b577dfbbad0d9b1
> --
> 2.43.0
>
