Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF4303C93
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105038; cv=pass; b=XugS6SwW+KHjFLYsCuYj12itrdM1qfdxLywD4H3+Y6HESOSJWO1rU6pfK8k7XgDCYKvumo6ufufSoJvkD7LTrAnkFQaWcGm7UgVr7sEjd11/K6LqNETKRVGaRFbgA5dg/tXIgCn/wLOEG7qrOi583z2v/G0zic90erJIaSPae/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105038; c=relaxed/simple;
	bh=KlwItc1xOCl4Qajq57MJ947GZYUEryV7Uvo6MNw9qIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXMFVoyF+9KbYlmgrC3jaxaOQtOKewYqe9KmKp0xseh1fm80wFgOS7HbfgOXsj4Sq8nXk5hgXcnN1lVBGclH7q7LEGDL4w+ZT4D9ABeSy2dm+j/l0ziJK3oTAlXXfbSn6QzkCttQL9bKMdc0flkLlT9IXdGg4EsjKqU769I0msQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TyVjEDX7; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyVjEDX7"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so1065892e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:03:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105025; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2dqjMlhpe1mpkTlx+U0CTTlH1GjowN71kS+KcLqTrmBxIsGqi4yZXnx/FYG/3Z6Cf
         0A291ZSYblsD2DolHvoH0sw+7oVjzq1UxVRlWSTBEcDmA8byMa6VJ1xgxX8wNIbBK3Na
         6uP95emyTnRsmnLXAWEDw6Ca/KgVK8EBbr9TeCfXLmRAnUanhptJVXONDE6x1ulGvQfa
         fA4rxu0rIuzJSN2TZzQxSC9CzEPSR5qiw0EE+0aQl7Ixx964U2TIYeOgLs+QOAxWpLpU
         hiFvp1F7EZYDPKpCcUgtWBFyyMTdkKdhbtY9iK2Vurw27/T6lWWW2ij/0ZbWNWI2Jssl
         oI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VjsUeeOVmg64LvF4dvZ8dsB4WTQULlf7rf5dA2++D6A=;
        fh=46l6nioBwLFHE7Fuwzjgyq7hxcmgcsoj5abNIOGCkzg=;
        b=QJUtyiZ0A9NJE1wbIusQ2SzJByRzbp6xn0bXFHRHdA85SxSugWj6p8H4CEvZZ0MgVc
         S4qXhwXWLdValEDRp++G68pVnszL8p+e181SsvRD91C5Bv5GalSfZdXubgLoIDa3pta9
         B9Foxzj9aP75fpW5TZI+zv3BkOhUMCGJBHEIoVmvpWg4x5qMyJzEUnUyqZfncZHhkBt5
         q3Hgsl4CkSaw3O93YujLURBV7yFzsY3RaHcPRPTPqpmRxWBVU7UsjbIfIYxIvO6vmIYT
         S2D/derhiJUq1oed8RMJknUUFf3zPDboOdRQ57UWrj4VouWaeHsjBrsBSmxSraVr0JKz
         q3yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105025; x=1769709825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjsUeeOVmg64LvF4dvZ8dsB4WTQULlf7rf5dA2++D6A=;
        b=TyVjEDX78KvjpX1kLgvKkd/kBAsWJdL6s1TzZetP7TI4KFUazsiNCCQ5n9M5WXeMbw
         oFp3CtZKT7gs9LPcPHG3xBNHuts/ZcpjoJaibeWp9E5q29sHDJcJI7cn+QN3xKgWzO++
         bV/meR+/e7VWvKwAYspie8JzUStDwYe/6RXawNv82BaVqUNjfdPfy4N7TuS/FXN5KJ/a
         v2Hqz4nFHaz0EgqY9KF/FM9IfHDz3POcr0Z+cv6Bpm4Q1XrJcAWAW0gZ2jKd1ba1oJ5N
         RPC5RtQr7F1+d9gb7Fhm5qo5WAjzmGbCMdXU4mBGUXS/W/c5bknWcd8eLHR333HQAFnE
         7XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105025; x=1769709825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjsUeeOVmg64LvF4dvZ8dsB4WTQULlf7rf5dA2++D6A=;
        b=VKUdPXwXARKNPfBV4oaYysr2zxqSi//hqUFfLDjgFUp6CQRaa6d+/0bfhri4gaOO3k
         9KGoKiJZWuTh+7NgT/2q2xVP7baf5C2BeTDpzUJhBvdzO0X9x5lwpereWpDq0VfJt4ZH
         YDzoPy6sPkEhD/S8IbCf7w7N0dFrYi4yIYOqJXOZ5gvGDjWQLrnNamR42w7D4Af7JEgS
         0asCln5iGGpdJgGiV5L/JGimcL1shCxBcM2iYkumH09RQt7ZW9KFu7Qm1gp0gx7jNRq1
         QxmbHMxnXn/K0O67W9siIbNVVztv4dg8Nz6s7PQdwmcUp9pzSIsgv38f1Db2GZWpojOp
         5tlA==
X-Forwarded-Encrypted: i=1; AJvYcCXV/xbPlVUeLNKgqJ9N/qkmvg47uvfuM+6ZGmq7Qy0UUqfCodKrjBGOnPeNnKQxmPN/dA8d8fqxlLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiIfppiXfkpW7bnpLkWtN7gYT6etEWpzO4XcMPS9mufadFJMC
	oiEkS0nuqXHupqDddAXj5esb6JSCUQVoHgE0XksqZEWDSNfp0UOLJ9T8diuWy64iZwuznrFDQUo
	U7eVhuLfsPJfwU4MvmhreE5qOo+wKGufdSmYcESLG3A==
X-Gm-Gg: AZuq6aLB0FL5EtOQuoUp1W+TDWOyAL7gMRIpriZdsYOCL3nCjme8f1g0cdrwxH1xynY
	4+nZlZN8g+d+uTTD/FLDkK9TBKsATT4eWWLU/sbTEiG4eiclemNYIwnvBdyeE6uZQwvacvYWz1Q
	4TLQ5Y/mVbekYMhu6cbYYOZI+ejw/FbKMoH5DihUysBf3gH/eQga4pkAWNH7uw0PrJTQNVv/FrX
	LjPnG7MiW7Lx1sXn7hBDkcRJS6gt714PsRst93J8A2nZ0JYQrdG3VOBfK5ljeQghnukKTno
X-Received: by 2002:a05:6512:3e2a:b0:59d:db92:a8ee with SMTP id
 2adb3069b0e04-59de49067b6mr61421e87.4.1769105024770; Thu, 22 Jan 2026
 10:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114122256.1587-1-hehuan1@eswincomputing.com>
In-Reply-To: <20260114122256.1587-1-hehuan1@eswincomputing.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:08 +0100
X-Gm-Features: AZwV_Qgb1fAmMScbz2v-vd4jLDnbRwZT1vo0-0RSkKHZBLOUOfLsvyF-_HrSSjU
Message-ID: <CAPDyKFqcMyM-=x+2FWNLhHY=gu5ApHNPQhp0xBKDJGr7BhEx4Q@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: fix DMA 128MB boundary
To: hehuan1@eswincomputing.com
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	xuxiang@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 13:23, <hehuan1@eswincomputing.com> wrote:
>
> From: Huan He <hehuan1@eswincomputing.com>
>
> This DWC MSHC has a 128MB limitation where the data buffer size and start
> address must not exceed the 128MB boundary. Registering the missing
> 'adma_write_desc' callback function.
>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Applied for fixes and by adding a fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 51949cde0958..cabb709a8108 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1726,6 +1726,7 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
>         .set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
>         .set_power = sdhci_set_power_and_bus_voltage,
>         .irq = dwcmshc_cqe_irq_handler,
> +       .adma_write_desc = dwcmshc_adma_write_desc,
>         .platform_execute_tuning = sdhci_eic7700_executing_tuning,
>  };
>
> --
> 2.25.1
>
