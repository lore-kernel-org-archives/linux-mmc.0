Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E03172BAF
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372736; cv=none; b=ngt87aoBLGD4Gdf3KXVld3UJeLkS74oLkaLWGQ5vMp2knnLclIPWcvKf6Fw5EWNVw6Yg1IjG9N3il7ibiXC9irKITHlsLCkbTteEJIr+6L5KNtV1OYxY5H745wCgaE5ltkkY1Xt7tk9WqzxegsJnwyGoi8eo+0bGUCy4nhmIOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372736; c=relaxed/simple;
	bh=UYV4nZ7zGyYTe/ns3hNWN+tH5C1unFEO2/U0In3I0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn353i8rsCj65JL3x/wn9T4hNiFu2Tw9j2deC/hBYWcMGrpJ0JxU2KV6LUfIB1svMQt2ajxjblrOwa3YPXSa7mVGxCDYKBrzkWzcO7bP7cmUr5seD1n/5gurSXW+vsYsH9TY0XBdskhVNk0yjS4LYCQFhOrL+fJeHrLzywLe3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKZlqmuA; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKZlqmuA"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc74435c428so4097633276.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372734; x=1711977534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUWQ4N8aQ4jL2fjYy2Ba7XeBW0vWjhzL38iFdr/etLQ=;
        b=hKZlqmuAWi4TVwpIBPMq2bKfDTUIXnSxso+DVvfJ88uLaA/uKva5U6w2pWthP8OhB4
         Xkjqyt9NE6lUr2mfbtBpMT4nidMQfZzzVeu0KC9MPtS+A2+FAhJ/dnGJAdB3uI1APTXk
         jV4LBgGrYveCluijMjSUTsi/nTmLdC6yJNNLK3Rqu0kMUfRJ8S91tqXIvflJZRvQXAKT
         daCTY8iS39Oi5/lnft8j1xSFknXJgPwaWGc3PJjxTEhgoSZYmzO47SQOQF5pcJXjfpod
         MuaH8YkCerM83xtAdq9Pj4/mAf1VARAjwYRJBC5KO28fKMNwvvA/+OCbMcDH5YILJLd9
         FEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372734; x=1711977534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUWQ4N8aQ4jL2fjYy2Ba7XeBW0vWjhzL38iFdr/etLQ=;
        b=eVDppaxUWFLZI4kDKDevR2obmqDXmTC0nxYw8bGsz4U6bCjfvPGcEbobk8l5MVPbMF
         N3aT1xW8MkKzE1emmx3290ck8IbrD4sWJmKdKZ5Gc7aK4+2OAQN7dUzTYC9kQLIQl/Ef
         vea8kmIMmreVB25LkrZTfVWWawhkFdRZH48FsmDAbVBj+D/f0EAir5HL3r/yDtLYS2BY
         VaJWAPWFFvWD+qVwRGweJglcy3bhJRyPxUQQC7HQ/KjaQBJJ9Rr73JbuD/gVyMaZLgXU
         QQaUPQRNuNzR2b8Fot/vlHFNHuGXxCFg2oecK9KZVzrzMJ8KWMCvd+srnBH7eA+l9rgy
         idpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWioMQ4V+0E50zcgQiLYAYbQwMSgsOvhEFcUwj8l1s/U8zBXraX1+TFIHYYRBvOMOo8B1hBBaziiBVQYvV9Itp6foFdsohuS+19
X-Gm-Message-State: AOJu0YzI+PeR7lt5lA3TMAFQqy//+bVcODUXJNAaYI6hUV9xAUzatr6N
	S0EWETpnviNwfpV5oP63wmuXAiHaVCNt4UVs7OOBJRacak5+RJ+kXVUVIBZR4i+CoA8AlNvheMB
	eM+CrvHnmFOSdq3wJ1TSmDYD2o4pmL3R/FTDrIw==
X-Google-Smtp-Source: AGHT+IHzTD+eD804dUyrAtAijJPdYapsf0OCnAi6GJ6Hmffr3CDyQqbURkpBgSiWK8ZFwu+EzGqtOUIM1EiwoY+Ah6Q=
X-Received: by 2002:a25:3618:0:b0:dcd:6c0:da64 with SMTP id
 d24-20020a253618000000b00dcd06c0da64mr5239723yba.58.1711372734085; Mon, 25
 Mar 2024 06:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:18 +0100
Message-ID: <CAPDyKFr7hQzOzVXK7Nck9jn=PSyJF652rJfVPVayO0mzGP14nQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mtk-sd: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Axe Yang <axe.yang@mediatek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:43, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 1634b1f5d201..a94835b8ab93 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -13,7 +13,6 @@
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>
