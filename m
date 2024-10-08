Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361881E0DF2
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398221; cv=none; b=uAEKc2Alu4xJt/2hgW9w1Gk+8eddOPyHDmLI+7j+EfsRoQsW2C0PgM9E5SlGdgO1L/9RgamhY4Xh1rDywJuV6MnF2gRF96bKuH/Ydpegf6T/joqvOE/c5nr2ODgOqiik9bENiWM5NtKuWedhmoa3z4eiu02bZ70+k9TnEt9JAo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398221; c=relaxed/simple;
	bh=tfWzawYGhXkdEvYKnqiELhcgmLikS42E1TNbgZ86up4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKoLgEfDFuszC83lr7qjqkjwEWP6QQH81lxaMCAmSC7EpU35VQTCgNzWAYd4cR/GmXvZqFARHduG3N0X0BnJo5GF/qgiR4mlvYhm8auBYFX3jAQScX+pfIUvcUAxsBz63Ea9YI61KETcFHm/0rIZykxKGsz+xbhd36GrQS0l+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+bGOBT+; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+bGOBT+"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25d57072dcso4983049276.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398219; x=1729003019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhcMpUJNXNzIWsuWAEpwnyWujtUbd/Z7PX5gUoihI+k=;
        b=v+bGOBT+dIlrcQOkkw+vVp/byoaPtwK7at8wJ1vesCzFKqLpK2gZmID0HI1OHuqJkJ
         DtUHnS8DxJWl4e/NAQo8iFa7cWC93py7SlDp2JLx15hZYgkfUtojuKpCZISXNqZu1dm4
         3hvOhVbi3EDLqrxQ5sKxQ25pzFYM7/MB2UpJ+fo6BE++sUuPsuARlFl3ydqnxQS7w46o
         e4uIBbPJBzLr2lsnBGDbtelhpizj0Qdz1LAXn+MgVpjNg/F7QmzeRev3Oy9EE89FwyXu
         EcOe3OA7e2XSmR4E97zIUQ5+q6Itbyn/NVPTN5wfRLT5vgKafHUvuSUmGatHIeaWyDi+
         6LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398219; x=1729003019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhcMpUJNXNzIWsuWAEpwnyWujtUbd/Z7PX5gUoihI+k=;
        b=j9On3betOn5mOzDOsg0B2DchomC8mvpBvjGoxwQDLVAhD9Baer2UT5g/FcctLNgm1D
         el4e1+Xv+0J77aG8dkRcvhx6UxEteSG6RRKP0vllRV+SLQ3bQuHVGoH8DTLrZk58IXTL
         hASMFl+pYnGhAHqtCyEiwJ2VsxC99VkGU2nrFIUNiblpMIm6KHlbaaCZIDBnShmdTVPx
         i6WlUf58RHPTFVRLgMjxYuE46bf06sSSwHNlVgoZvp+Ig+UEzGP3oo1WuNwzOZlgH8al
         N9+Jebgq+aR1x3YJW+JxgSSMgUL7xBfbTB5RXOlEf7QftZy/+iLF4tlZlLU4jEzQDqxL
         A8aA==
X-Gm-Message-State: AOJu0YwALo71BynkOQuaSawb8QvUdTF4B/E+SJ0t2qaxxknzv9uZQAab
	0dNnvIZ02IxoUcw5l2wU+Q1tXIOhcr1NGbrv1W+ZG17+oNpSgyuBwSUB8tuRMqXTx3AjVixI5dj
	stv3dB7xnCXo7Nw6KMfUtZb1w57Q67MhvSxglSQ==
X-Google-Smtp-Source: AGHT+IEIPJK/ecGf/3Q13EJ0zuqhk645glEqzkGN1d/xnGLzO6mTMQf3amsB0zKGEcSqx/iHHpThNNCf9H+Up8qL1Bg=
X-Received: by 2002:a25:df15:0:b0:e28:ea9c:5d3 with SMTP id
 3f1490d57ef6-e28ea9c0a5bmr2378479276.17.1728398219122; Tue, 08 Oct 2024
 07:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007114918.52066-1-brgl@bgdev.pl>
In-Reply-To: <20241007114918.52066-1-brgl@bgdev.pl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:23 +0200
Message-ID: <CAPDyKFo=1RPP1KBUBY8UKe=jFraUjPZQdPGPOOCooaKP7Mg=hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: davinci: order includes alphabetically
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 13:49, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> For better readability, put all header inclusions in alphabetical order.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 7ed533758dbe..fe7712532e84 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -7,24 +7,23 @@
>   * Copyright (C) 2009 David Brownell
>   */
>
> -#include <linux/module.h>
> -#include <linux/ioport.h>
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
> -#include <linux/err.h>
>  #include <linux/cpufreq.h>
> -#include <linux/mmc/host.h>
> -#include <linux/io.h>
> -#include <linux/irq.h>
>  #include <linux/delay.h>
> -#include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/mmc/mmc.h>
> -#include <linux/of.h>
> -#include <linux/mmc/slot-gpio.h>
> +#include <linux/dmaengine.h>
> +#include <linux/err.h>
>  #include <linux/interrupt.h>
> -
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/mmc-davinci.h>
> +#include <linux/platform_device.h>
>
>  /*
>   * Register Definitions
> --
> 2.43.0
>
