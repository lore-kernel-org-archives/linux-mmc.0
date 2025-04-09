Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422E265637
	for <linux-mmc@vger.kernel.org>; Wed,  9 Apr 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204468; cv=none; b=FPJHEXLbrsS1njBATjxYL2tRy8IPIz6Ko9zz+GVMuoi7fdCKeErGYhP60d+5nm0V/bAc7mFjxUyphwanQnxIpBz4wcvisSadh6la06Jp5bLttiA+iev9TdL8pFH11wxwb6r77BkvMvtttnr3QdweHeKsYgizCLq2gVw3w/jJbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204468; c=relaxed/simple;
	bh=7zbFeCLuI+K99uAK3B6Tbmrqzoz0Zborq7yQnLiljzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoU9owu4iu7XaNaU0mpLEztPtygbLjEMu2AlZ+eGlzV3TP+TdmT9XApUJfPWnQ2h6drJ9PG51FWhtrIW8Bqe7/pkH/YH53ce60YPMviH7ctbjF9V2q51EicwI46q7lBxqmAtkU2dYjp1QWswiUXgtoqkjnk5ghVjm4LOkboLZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmNhFEZK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmNhFEZK"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fead015247so61286487b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2025 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744204465; x=1744809265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZVX5PQPrfquBJMxVk5gyHF9PFmvV5mvI058XbwmWQ0=;
        b=rmNhFEZK9TNfxgaKI861YjADyfu8zsHpCCnLswuweMje3foKiL9ac30+Q66ClekgH6
         VOBaXnLOsiK5opGK64pFcZ7PsQfhkM+2F/8VdjFHKkfDe+YZl/mueG82d38VhHx97y/d
         0LtGPLCV6XKrTIoOEQXyIFJR1/Kd/JK2FJ+IHUdAFZB+fK90QSsHmtAuse9cmBROTVuE
         SSancx8yzCIMjiCtMJTUdyi/bqamxXAIh8ygxj6eDPJg7F29+nfU7gaLhNn8cIlBuD1h
         g2b4p60EwMfJLoBdqO9suVUSLdnXJUuoY1LA6Y0PwoVtJV1DC0ex984ANDXvMrXp4k6a
         KpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204465; x=1744809265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZVX5PQPrfquBJMxVk5gyHF9PFmvV5mvI058XbwmWQ0=;
        b=FukuwSkGaFGCTkyqpnMiVobQJXny6mujK+ek9iIAIO56mq/2c+6MQ6laLj2c3hXIr7
         vTpms1nQwsYIJhyWUdd7iRBICoLtEf4TZYTVAQglH4R5HY6oz4gGG/D6kXAAPU+x8hoX
         rRnQImKjTWtd0ZM1AzeliF8qTSJ1mzuKlo3B5YEJrhRNZK+ePB57nTcJZrqoFhsZXhDt
         3YJYi7VfLBMxxNVWbTC1ESQ16JMvEShZqP+Z+0P8KzjY8jlA1qmx6gqCXAllFU0b84ay
         4yyIXwApY6wmliUeiqsY8XZHz5uU2+DcSOBQwEw9zb4T68KfwBhmZEqcXNDdfVYaKlry
         KLlw==
X-Forwarded-Encrypted: i=1; AJvYcCXNGpyf8gBLJnNAfA3UErH/joStjGPCfFHzlzz3apF99z0xYGATaFm0JRR7AVywY3+SozV8wbCgByY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Tx+KarDeHyCWO19s3serQ6sc097i+qmZAorSQdMmNDnqtu8Q
	VitRLM4PO25Jd9ilzdJacmfUV0t2ySdTmL7qo9wmuQAtyH8Loi7ZxkpyGQIKzfa1i6gxZ7z5aul
	uh8hh6BupI5qFgUc3Cpl58QfgbM/V5rZwapmS4A==
X-Gm-Gg: ASbGncuAwEcZgjEY1joW+xLq4QcVdwKWsdbS1aNKJ24AFg/SFyT0PCaABpvM0qM95JT
	eVPapW6/49RlI5UqL0H2dxcQQOLAfu1+Qpc+Sw3UkM4XnPLYFbhLb9GHOE3Kz7JwPrR4TTRloxc
	gAfuXpqZ0WQ17h5ppbwkuyC+A=
X-Google-Smtp-Source: AGHT+IHbawswjfdH3sqFi36CBNn1RNgtkyGSJ/NGOXxL4dZhfzW2bxsKoLqgb75/B41CMWmJKQ4D2DTNItFMQGhMGyk=
X-Received: by 2002:a05:690c:4482:b0:6f7:55a2:4cd8 with SMTP id
 00721157ae682-7053ad41c01mr37577897b3.5.1744204465406; Wed, 09 Apr 2025
 06:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401195751834zbm34YDvwPeQf7ooZBCdh@zte.com.cn>
In-Reply-To: <20250401195751834zbm34YDvwPeQf7ooZBCdh@zte.com.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 15:13:49 +0200
X-Gm-Features: ATxdqUFC3YjMsK4_mQfKP9WcVyJ3UW9jxF0KfI-w6NTkkAFGErDieKR4c5JNlbQ
Message-ID: <CAPDyKFouaoE67WtdnQvohT9VjqCVC6CeFaCg0WZDWnVF5G+YNg@mail.gmail.com>
Subject: Re: [PATCH] mmc: alcor: Use str_read_write() helper
To: shao.mingyin@zte.com.cn
Cc: yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, ye.xingchen@zte.com.cn, 
	feng.wei8@zte.com.cn, u.kleine-koenig@baylibre.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 13:58, <shao.mingyin@zte.com.cn> wrote:
>
> From: Feng Wei <feng.wei8@zte.com.cn>
>
> Remove hard-coded strings by using the str_read_write() helper.
>
> Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/alcor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index b6b6dd677ae5..24abd3a93da9 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -20,6 +20,7 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> @@ -208,7 +209,7 @@ static void alcor_trf_block_pio(struct alcor_sdmmc_host *host, bool read)
>         len = min(host->sg_miter.length, blksize);
>
>         dev_dbg(host->dev, "PIO, %s block size: 0x%zx\n",
> -               read ? "read" : "write", blksize);
> +               str_read_write(read), blksize);
>
>         host->sg_miter.consumed = len;
>         host->blocks--;
> --
> 2.25.1
