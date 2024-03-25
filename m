Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714714D42C
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372732; cv=none; b=tod5V/4o3+vXTK2f5ca5MAPzHuDVHQIztoi7N4lMc7BOBvgeaOtaMtmlcQyEwSuhCdQzlbAYiLu95gi09qikO3hO++lDkynZ+zStVam3x2/R0Bg2m5o63Wf7FlznoJ+YtQql8KzmJvgdRMU4Z/aLk6rWSLqcGAE6cj5zTegg0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372732; c=relaxed/simple;
	bh=n3k0iYRKHsrgv7l06dQ8fzZi31Diqx4FQuGjvbP0wXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md1JJBk9slWkxVXQcW3/V1tKLYkIabWKv4ZTsJG0N6TOJrVkNnWL43bhMwH/+8xoMV0cr+XkTRCo0k7xzGWm/bZigVFE2S1t9dOVen2GMlU3s2DIs/+vjwjiRHfhq9R5GpPAWA/IPIbt1eJzmU37iAIdKE3EjyAhtjS4gH61pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcZYgWo6; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcZYgWo6"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61130dd21c1so21368317b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372729; x=1711977529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cvgUqXkNCnMPYOL9pmGocb12/7B31f9lQJOhAhiYpoM=;
        b=xcZYgWo6bFyKOMzWgEUGG3/sFecmMBKxoFxiAd3K4/yUdLmWOIESgUcK364taDGv/q
         MjDUsnkbyx+PW5GYwADd6dRIg9o8lSUumNgNo14QnjbhCDgB4Z4nMoOKFCt8g1s0eRMt
         HmihjWsKu0GMCJA9AxLIlKbjj0WwnSoVVcWQk+NBBXF8TYeY6MLvYtNHz97Kp1nc2zSO
         nVzXVsYn/sA2APofDGdJKMZDQoK2Mn12eoHS26xPqxvcoykdm86ijF4yv4Pon/vk08iq
         Q7ChWGMgXgxdL2g9a4VJR9Qe+us+7Xt8BeG7ZibOFKG+5v0YTdxkC0euCPxI0SPsaV78
         9FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372729; x=1711977529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvgUqXkNCnMPYOL9pmGocb12/7B31f9lQJOhAhiYpoM=;
        b=VfkqLJKMHC5ctNftJjZpBQBYs8bc1o0lKvW6TKS3YXuHrqK8LK859TNDRoJKgdj9QR
         +nUUWU66TikapPwvC3xScQxnXfps8l3tZFkTSqHRrPpl18j82BV3luiKI+ImUhUCoquS
         358rkIiZqiqP9y/n8qabFZhv6W4F6Q4/DOBMI+CTnIDAD1GcVvKELqlgrAPyHx/fh/PG
         pnqXt7zh3PdSVJKqesgK/bVYkSPOjX/APRWoSUN2cFtqMOwaHPt6SyX6PT7WM35DCms8
         mrnrL0AH2z4KVZBx58ERj4LHonvofHG3J1n6GcCVHFOF+4pyctZ+9OSZfaVGm03NbR/S
         Nf6Q==
X-Gm-Message-State: AOJu0YzJtEl0M98OYj5XJ3RMlMGrivTGuDCWdBAhP6kRj+8x/bvVS1aM
	QnhsKTYasObY8n7U8BMvX6YfeTmwlwfIUGIYL7Scb6R3WbXM4LBGvCF/NU1qCjokRzzA5uPyJqh
	vp2/uPEGYHs8XtvxdrIf+nVGFVJPssyWt+6eciA==
X-Google-Smtp-Source: AGHT+IHZVBThr1gKl1PUGSzyaGohCWnTiHIIdzOXuyMY7iKKwFdfPBat5kQW50jTwj/J1exaj8/EfpqCHQHzicLEWPk=
X-Received: by 2002:a25:2e0c:0:b0:dc2:470b:887e with SMTP id
 u12-20020a252e0c000000b00dc2470b887emr4783512ybu.21.1711372729682; Mon, 25
 Mar 2024 06:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:14 +0100
Message-ID: <CAPDyKFpyF2OAQGP+RYmzYCh-ZFk+T+9w0A3AkJSdODEy5rHLJQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-s3c: Replace deprecated of_get_named_gpio()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 13:19, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It seems the of_get_named_gpio() is solely used to check
> if the GPIO is present in DT as the function can return 0
> if and only if it's present and it becomes in the global
> number space 0. But this quite likely shows that the code
> wasn't ever been tested on the systems when no GPIO is provided.
> In any case, the proper test is just to call of_property_present()
> without any attempts in requesting GPIO (as we haven't saved the
> number or descriptor anywhere in the code).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 0e8a8ac14e56..6493b0edba34 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -17,10 +17,8 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> -#include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>
> @@ -446,7 +444,7 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>                 return 0;
>         }
>
> -       if (of_get_named_gpio(node, "cd-gpios", 0))
> +       if (of_property_present(node, "cd-gpios"))
>                 return 0;
>
>         /* assuming internal card detect that will be configured by pinctrl */
> --
> 2.43.0.rc1.1.gbec44491f096
>
