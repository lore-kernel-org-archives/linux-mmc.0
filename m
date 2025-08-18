Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA05321429
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514556; cv=none; b=UenjZyMDjp7V8ILXln687rsjE62YAmYlu6QWw2Y0Dz8oLjSxQQXprQbSsQoAIAbToBRsvTPYtorgHFYOm1bv709Y6/GVE0UCffvCywJrhjltEH7sJZxmIn+9HMzGOhx1xGQp/Ooy1t78l+/0svE6F36Mprzr0VtfqnLPrk6oLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514556; c=relaxed/simple;
	bh=UP7+e4B8R1vPgU2CDLucQUs3/3XdVO4lV0FXk9HRIxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9Rhs7ORJwHm+SjVbqdxczddYFeLGDTtC2xaZERG/2rKoPPJIuCYmlTbOjhKFWk4DvTzI43YEp+vsdMvZzWp+5BvLriSi8rs4cZLvmK/Xlg6VatFF26ZlImlxy83zfJ+IrNu5CDQ6g4PhRggjIuRUeAsH4fVRYnMW4mMC9uwbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ+isTgo; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ+isTgo"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931cdd710dso3043238276.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514554; x=1756119354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QIGyc7zpEFVUm3lI2jgzfkEXQnPtPbTfkBgrHspZGAA=;
        b=bQ+isTgo5+PCrNlA93Lw63SVtP0f7ydYX1Jr8MpFr7ZPR2OJ2yWZqhUbs0HLx1Mmw6
         aY8OJ6IeQQJcLrSIv+DJ/TVEtjv8czQYpaf3yGH51aUBnt8dqgsdy1cr6lZ4FeYwWyio
         6E5egB1g53KyrzqQDbBGuPdwydKdlGUT6tuhsUxPFuL2+/J+YiSOyyopTdGghbeC0f8m
         dGBOUev1aNU6kkB2Rplw+IBt5gdWWGuTaiW+xfOPUeVLryfgyBXSMFZjjJzKhJ4dqsPe
         c9D88aPJ99ebehZsJndzd4SaEVLrjOU/OGzOeRHFaTUD7n6UGQ/Z/7mM95DaDTCNu3m/
         Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514554; x=1756119354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIGyc7zpEFVUm3lI2jgzfkEXQnPtPbTfkBgrHspZGAA=;
        b=vzFwjLzDg6bUBEz6zFwCsQk4CEvqWF/7UStY/3nNH3RxvkRoj9r8DAYusKJSWEMwQS
         EIKfKJ9BAmj/d0MakLzIsrs/1Ymuu5EZYkjSJDGgU34jmml4xmdo4aQPxzex9amVcuyX
         /hwGmmUdiplbcioQhO5sRsVdrloHy0BZTmq/T9Dp70uF36YlEO1MQJJ01QWbSGB4S8kE
         6o/NcpXX8fPM0QD1BiW4aIETHlv6SW0OOBPSEi/f3rmQZG2UwBDDO4PvjGZwecXUmqYA
         0CIrGptNY02JM0yXr/ckezIxn8nimp98dYlnIlHezbkess7Nn4uecFJuwflARdo1euqa
         1UMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNOfr0KjSve7QETJNMSliHuhgTFIcW6mfHHLzArqlqhh5g0/LmPXV7h64xPCtBYkrqSn1hTjvv+Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQ2ji21rJ/hd1HBnJId+UVGnmB56x+WbsQNNDCcT5oAyxE8aF
	AuSi0Jjmb3nF8aYoytbo0fDcTZF2Uj0tANeeB+iKZ487IZNhGOJc1EaIeEt8vJXlWFbmuu4AUXd
	HGRbkIfT3ytRAqSxNvVQ3wNsdM5AldFv8pbCoWVBZ8w==
X-Gm-Gg: ASbGncuntVPgTriAutbhgE0D2DWU7xXH7BSxjxy+hw8xKMN3BvZygUEjiraX8JvlfbJ
	k/Fr3QklkPGwrT9MozrFgY7Y61xB7t/R5GoiOeMER2qpG8opCu0ynxTx3bN4oZP0Msxxf40QF1T
	SwU+59E5x1Oe3YNOapfsmNp6pCXdEdPbYb8VK2p05sEyoDBkfl+G1WNw+8Bcw/OkahKKKkTJWrR
	lXmhnoH
X-Google-Smtp-Source: AGHT+IFkq8ZQsPYffmYGOn8sv5vUZY4ueg4jyolAPL3LCIeR/KHuj2dAdOaW0+N6sVeSogB72m6F5xqA/Vzy/BlhP84=
X-Received: by 2002:a05:6902:1581:b0:e93:4575:4d51 with SMTP id
 3f1490d57ef6-e9345754e38mr8117383276.46.1755514554219; Mon, 18 Aug 2025
 03:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804024825.1565078-1-lijiayi@kylinos.cn>
In-Reply-To: <20250804024825.1565078-1-lijiayi@kylinos.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:18 +0200
X-Gm-Features: Ac12FXwrjUQMO0k8DZEzoreMphRWa6TOQ4HOnWDvjf8kvUENWbni2X6of6EJVDA
Message-ID: <CAPDyKFr4CkPb5jTSsCOcsz+VaZRFOT5ZT-jJZ3oDahj14H_BWQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: Add timeout to prevent indefinite waiting
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: gregkh@linuxfoundation.org, kai.heng.feng@canonical.com, oakad@yahoo.com, 
	maximlevitsky@gmail.com, luoqiu@kylinsec.com.cn, viro@zeniv.linux.org.uk, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jiayi_dec@163.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 04:48, Jiayi Li <lijiayi@kylinos.cn> wrote:
>
> Add timeout handling to wait_for_completion calls in memstick_set_rw_addr()
> and memstick_alloc_card() to prevent indefinite blocking in case of
> hardware or communication failures.
>
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 95e65f4958f2..3eeb93b51f80 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -370,7 +370,9 @@ int memstick_set_rw_addr(struct memstick_dev *card)
>  {
>         card->next_request = h_memstick_set_rw_addr;
>         memstick_new_req(card->host);
> -       wait_for_completion(&card->mrq_complete);
> +       if (!wait_for_completion_timeout(&card->mrq_complete,
> +                       msecs_to_jiffies(500)))
> +               card->current_mrq.error = -ETIMEDOUT;
>
>         return card->current_mrq.error;
>  }
> @@ -404,7 +406,9 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>
>                 card->next_request = h_memstick_read_dev_id;
>                 memstick_new_req(host);
> -               wait_for_completion(&card->mrq_complete);
> +               if (!wait_for_completion_timeout(&card->mrq_complete,
> +                               msecs_to_jiffies(500)))
> +                       card->current_mrq.error = -ETIMEDOUT;
>
>                 if (card->current_mrq.error)
>                         goto err_out;
> --
> 2.47.1
>
