Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D722A4FA
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332049; cv=none; b=PxOsWN6EH6y6xaYkG4WTy0IK5s7uAMQzOXelgu9CsGV6kYh2b2u1ah4NA2t3X6yAxQUzfB0d+z5ZjaVOpWm3UqbV9KKkEmBWroUSkb9YHBbDtFKSZEdwy7NbXupJvscRx9knMan6of3vPyaSolQKumj153Mb6xFvL43kQQXhTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332049; c=relaxed/simple;
	bh=XpZIkc7P5Gd1VuFF2PalUhlkQmpyy96hiOjrxM3sEQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKKV0L0XdHNZfjKf+Ll95fMMOzzVefJp+gLinoD8kJCMvxhNtEeVMVbpI/zu8GBeEKgqe6Fg5bn/h0iFFZr366E7sMYtOAvCHtvz7algPIQofLJyoJSItIfT1+/RKCpES8bZKI8c/zcaJDWlw41eloViFeF2YuC9K3zSNP3GIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdsQXYpX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdsQXYpX"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e81f8679957so640751276.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332047; x=1750936847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3uY/q1REvshZb8ZqHUx9YD6JUoQdmd+nZPMlg3OsvzY=;
        b=zdsQXYpXVisf1CJIU4EnSp4YmM8puBrrdznHJONd5UdRrcIhikIUBQfpIfFPLckDGq
         8tGtrDZ/8Xd2Elfxk8xQM+Rc8+udr9SRlYbieUwXF6mii0wfhfbMZKk3jmA6YdB96ZPM
         RtWX3tloMg2s2aQwPdKuQ53yHR0Gvb1FOH36ng3WV37ZLNE4i8xvmmiOAKrRVFPFnTVI
         iuxRzpNuUrwxNqkh7jWXPaxekT48TmHMv3r60KdMH6q18kSrqjOKIu82QHTnGKW60MJA
         qc+84D9ONaS6tDAxCo3r1HZ4si1C/HNgSLsg8JCFtUtXb816WVt49jJ5ds3hFI0wfs5X
         bvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332047; x=1750936847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uY/q1REvshZb8ZqHUx9YD6JUoQdmd+nZPMlg3OsvzY=;
        b=gGEfE/TWE5GdoIv2EWcuD0FSN56h0Zj99Fh+pyaeRKuM098+NAqXTPk0pqrD/eRvwL
         FXydYnkl/sT5hwn7r3aYFHJBk9gf+7PhpvPFEPFrZo6pgR8uvQDIdaTebhTOIjlwBwKU
         DS5fwHufjdUWO7X/K5QGXxCFU2rCpBOmKl7GenvIy8fdWGlF3mC+vmJIqBYGP6kvEfLF
         5vh3BlGoD59wFtCKwY0NaFB83yLOVnEpGlNv+/F6gFe+/B6GY11uiuqP4QA5dge0kaNM
         3MZk3AVQhlIDxkv0mj+qPtq2S53626Kdp16ZzaIc1Whqzww+hyNbS69Y8H4iI9tWzFGc
         VuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9i9hrg2E959+aqUnYLdzKHQR8PnrhtwnyUjX/Symm8CxHGQeQ372SrZnDxuzt1+2EZ1jTb/AVvvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmaSrGVEAXNeOtT8V4ztf6kxHUN50/RGK004QsxuO+z338aw6F
	QZeds8VDVwIrLIpr9lWFarwdHOKY590CLXn9AhaFsC3zJiMGfWNZWAyYpL4no9WcOtVTeLM5464
	L6ZjUYqTt0STXIpJhpBtnwsl3qv+IrHw2D79yExJqqQ==
X-Gm-Gg: ASbGncvgjnr8+cEEjOZImJ8okYzc9tyHNPW6URDGRdo0qUA/83ydtKPINiBPl7Enl7t
	aCLq4ra2wslWD5dfRvANdAyVyliFOmPuinHdwuLmE4VKWsqflwqN2Pgrq4tPLLUvkbIXFzX1OCn
	EbgX16C5HGp0p4i2A7kgsPRe3PncMesodz/Us0vaxGo5GK
X-Google-Smtp-Source: AGHT+IHrlSuM7JSJr8c9kgmdvNp08MZcOS3NLfvvFtN8yWrHuOaNzCEtscvrXyTnnzpxByEh5NvJmKrao7BhkBqsCeY=
X-Received: by 2002:a05:6902:cc6:b0:e81:b080:31df with SMTP id
 3f1490d57ef6-e822acf0121mr26619202276.36.1750332046758; Thu, 19 Jun 2025
 04:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618115954.10260-1-lidong@vivo.com>
In-Reply-To: <20250618115954.10260-1-lidong@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:20:11 +0200
X-Gm-Features: AX0GCFsNapXRX5ie9F9QwLX0kkV34NiQ3-bC4aojojmuuwqKhvpcjI7kJ4y7s9Q
Message-ID: <CAPDyKFqJuWC+XtC-WByRAeXPT=i4W4L5GzVKvs4+th4Fo4BNKA@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: Convert ternary operator to str_plural() helper
To: Li Dong <lidong@vivo.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 14:00, Li Dong <lidong@vivo.com> wrote:
>
> Replace direct ternary condition check with existing helper function
> str_plural() to improve code readability and maintain consistency.
>
> Signed-off-by: Li Dong <lidong@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cb710-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index d741c1f9cf87..52f9cf7dbc7f 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/delay.h>
> +#include <linux/string_choices.h>
>  #include "cb710-mmc.h"
>
>  #define CB710_MMC_REQ_TIMEOUT_MS       2000
> @@ -215,7 +216,7 @@ static void cb710_mmc_set_transfer_size(struct cb710_slot *slot,
>                 ((count - 1) << 16)|(blocksize - 1));
>
>         dev_vdbg(cb710_slot_dev(slot), "set up for %zu block%s of %zu bytes\n",
> -               count, count == 1 ? "" : "s", blocksize);
> +               count, str_plural(count), blocksize);
>  }
>
>  static void cb710_mmc_fifo_hack(struct cb710_slot *slot)
> --
> 2.39.0
>
