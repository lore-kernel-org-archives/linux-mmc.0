Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7327875B
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657939; cv=none; b=PMx/BbiSZ7eZoSwKUPEI3U9XBfJCKjMH7oj1228PcNYYe8hgRw2Op1UOfkfwKMNoqZZpAyKdjx2bRICRFuVFysuYiEYL1LqOMx08cn8aIceOzeSw+mTNzEH5713KLhWt2t0SbH016DWKIRCWmIxdjZP2+fauRGTvQBl8kfJinNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657939; c=relaxed/simple;
	bh=6b8ZPtV5F994PMuvcCSu5RtuqE+uyQUk2qhJt6Rgzwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PABLV60yfzODjdHYFZaM3N8h6XbpELoV4dz6rNUEsmo7buzFSSocM88IJwpA8Eu9Zuea59TrsmxtIPGeYgC01nfAIGJF3wiUG2d7EUec/JrTaA8qVrSaZuQPb4v4YISIfkoJ8bMtKZsngZ8M9WJzgna881WGL4h4+yBPbAZGIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdTnRvyJ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdTnRvyJ"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b3410e122so4120359276.2
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747657936; x=1748262736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwPC3/sUg5alnk+vPawV+VRfKcVYwDAJB/XEbxtpgV8=;
        b=RdTnRvyJRPZ502PFl5HL6d/UU9+p//wsXFqMbbZ9q5ddnWho3fT5soQ9FnPSj9mwJY
         DGG8D1gkmMz4l7RO1KPRpxJSZnjsIJqFRMz2j9CzDyDLdF9hJ/gXWYLDA5JZMcAC3ZKX
         b9SZdelV0biPugAkmcqK9wamllKQoW9u4cAKEDGGhmWNtxq/mbHHW3IhJJMr53CE2mOU
         XCoPmX27cslnFA93SClB9OnEtOKRGSF6KyXeJGQLQH8OESMS38L46R4HRN1/9Kdl6kzm
         n6xtNQsX7gf06fE76LCAGMG1DZJVDcFdWlf+KjtnouqTDbDTUZaxV25PyPaOz/ona2oL
         ONrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657936; x=1748262736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwPC3/sUg5alnk+vPawV+VRfKcVYwDAJB/XEbxtpgV8=;
        b=LkQ9dtIEtUQCBbUnTuegpOJp8Oe24RTSowCx5Irh5x4mgKSmSAng9jUwSydtc3dNN+
         r1OvgPoPXjBCpFl4FgZFypdal2TUm7VTe0sZr+8d+5YKSnqz81GOoLGLhCcobOlif5lv
         m9wUrGIxur2mO5nbU57n83SKwhQwz2t6pGWi2X6xuhvp5S01chk5MgwdUSPRYTUFEpZ0
         Oa4+k8DR37LKujqrhHV6m42w9kyKoONH0XbckMtWOYjrh8VwYMt7bSvAe5oCnb6Dw1fZ
         EM/QyAutbbGWIHrtObBlsesX+0G9rEVAKOYOtejwFbDFZF7mhi0sG3Y56ISKujt+t5C+
         AlOA==
X-Forwarded-Encrypted: i=1; AJvYcCXW5YXzttFhyHANQXgvk0a3TMbchVIKk9JDauy8rIagq7RY61uD/AL5Q+K+bDh5Y9agrWdVq+c0L/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnCFuy2LQYAstbFrb89cp5rMW77Ned2N/IC/0AHG0fpj8AfoB
	1gT0+N5rhuWHCnbYyyx/daXtNdEJZ96F0TOQptDVYw2OIfNj57MsDJ21/fOA+igb3RGi+SNXn9U
	XpnJzQYnEfkSI4Ljz/GZQLokr8TV/bkZf0KWRDMQgHA==
X-Gm-Gg: ASbGncvw/gZdMad0VmALDeJlZp6JqJChtDncKMseuaqarvYiQTIiKrmywTj++mfczBu
	Y9ZydpcxKP2tKNvfyMQ66vJnunXhpd/zFG8DtYy3gHRFRj+8BhYTXGkxnWbeWAKeAtRibEHkCNR
	skCBWFyxdvA7RhZ2Z3FvLYw9y1qDCNpSFJbg==
X-Google-Smtp-Source: AGHT+IH+k05RenNE75G05lCkPIFd12fSQl1b4MXO59HUeKq46kiZr+jpNbTHEmQSsew+3IME0NcG8hlXcQsODDtf+tw=
X-Received: by 2002:a05:6902:110f:b0:e7b:94da:55dc with SMTP id
 3f1490d57ef6-e7b94da571amr8538048276.13.1747657935953; Mon, 19 May 2025
 05:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515204201502Kzmj4I6k5Fv2FjqyEjF6n@zte.com.cn>
In-Reply-To: <20250515204201502Kzmj4I6k5Fv2FjqyEjF6n@zte.com.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:31:40 +0200
X-Gm-Features: AX0GCFtXdhUci2gSte12YEy9YP5JWc22zhs6HMihigJb0b76jaF6NMhMse_Mf_o
Message-ID: <CAPDyKFrheefitHyBMz11pcUMi=cz_-nLzG9zY9cbYyZfjsQAKg@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: Use str_read_write() helper
To: long.yunjian@zte.com.cn
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	rjui@broadcom.com, sbranden@broadcom.com, wahrenst@gmx.net, 
	u.kleine-koenig@baylibre.com, fang.yumeng@zte.com.cn, 
	linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ouyang.maochun@zte.com.cn, mou.yi@zte.com.cn, xu.lifeng1@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 14:42, <long.yunjian@zte.com.cn> wrote:
>
> From: Yumeng Fang <fang.yumeng@zte.com.cn>
>
> Remove hard-coded strings by using the str_read_write() helper.
>
> Signed-off-by: Yumeng Fang <fang.yumeng@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index e5f151d092cd..def054ddd256 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -44,6 +44,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/time.h>
>  #include <linux/workqueue.h>
> +#include <linux/string_choices.h>
>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> @@ -391,8 +392,7 @@ static void bcm2835_transfer_block_pio(struct bcm2835_host *host, bool is_read)
>
>                                 if (time_after(jiffies, wait_max)) {
>                                         dev_err(dev, "PIO %s timeout - EDM %08x\n",
> -                                               is_read ? "read" : "write",
> -                                               edm);
> +                                               str_read_write(is_read), edm);
>                                         hsts = SDHSTS_REW_TIME_OUT;
>                                         break;
>                                 }
> @@ -435,12 +435,12 @@ static void bcm2835_transfer_pio(struct bcm2835_host *host)
>                       SDHSTS_CRC7_ERROR |
>                       SDHSTS_FIFO_ERROR)) {
>                 dev_err(dev, "%s transfer error - HSTS %08x\n",
> -                       is_read ? "read" : "write", sdhsts);
> +                       str_read_write(is_read), sdhsts);
>                 host->data->error = -EILSEQ;
>         } else if ((sdhsts & (SDHSTS_CMD_TIME_OUT |
>                               SDHSTS_REW_TIME_OUT))) {
>                 dev_err(dev, "%s timeout error - HSTS %08x\n",
> -                       is_read ? "read" : "write", sdhsts);
> +                       str_read_write(is_read), sdhsts);
>                 host->data->error = -ETIMEDOUT;
>         }
>  }
> --
> 2.25.1
