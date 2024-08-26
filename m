Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBD16C6AB
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672361; cv=none; b=spyFBHlCateOxYbShYeWgaDP6ikF1wZuIN10dDwKCzY+mXsjvS6KPzJLq+XrFu0s2/j7oYUcQ+/cdKmEz9ayD/DALfMKRm7q93TNJ6mAYAPI+IEu/nReePCfbyCc9OFiJFB3Qq2VXFOgl3JSbqbCcchd8w7II9bCkL+48llPwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672361; c=relaxed/simple;
	bh=Rwh2LwwBpzKTgvRHzVQ3gWwFNixZmyAVwJLMdtAh/0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQSAUfLT3YEcD4esUDk5ZSKpksVUJ++C+18TZbmeFPkgJj2qsE32cGP8umdS6kJVrN16JJz+hzln+cvn9mdY3tUFh4SvIXJ0Ps1raMVckpSalv6dbEUaKZ1FAo1xZ45cr2SSlgXKnpWz+KDurdNfd1Wz+8JfrMFb6mBLlWbl/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+dZUjqK; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+dZUjqK"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e11693fbebaso4328605276.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724672358; x=1725277158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lj1uhnFdqDXbAdE4f2Y9iYQuc3TxJEK7JxbQMv0Akk4=;
        b=O+dZUjqKJFA17hOrP3C4AKHUwSiStp9HKQUV7PO3qsuh6AREzSbJiSVLGsPmMHDNEv
         uuMqKDH0zJc2GwpCn8k1edfe+SR+T1gu9E04GTfqTFjO5O8XMNOh0/km+JzZWoZGX3pY
         albD8QKQey2uQI8hfS/RMZZnV8tqtfqsdtYS9MgQELDPgk6SMnpvUYNsbsuSffyE4HMH
         UOjXab1ALUfWH0zwW7VhRw33GxBSDflLh2DzkcMxFIVqOBWw0apklcQrSL+tnAPqymu7
         pLNhvuUmUWNGhOVTAVlFzwanQtgEApr7JdSZKntH/OVUZUP4r3W6iLTltbXYn6TrRpEe
         ueUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672358; x=1725277158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj1uhnFdqDXbAdE4f2Y9iYQuc3TxJEK7JxbQMv0Akk4=;
        b=o9nOf8krSoY2t7L79LBfHhelJsUSIpMnqjofgoXMUULBl+7MZKXDNOcUzaaVP8Mnj3
         lxtWxP8QlXR7KMSlUYKSjyedKFGQY+E1RdawxwLq4zsrxX5rrsxr6YET8lM6YK8kVqy3
         SrnoM6dOftC1TBO9EkZS4eZtCwINyanTvp76DIkPPsNievRMJsirmH7PWPGAyq8jcMq+
         1DMw40fTpo5s+KzgkrMu7nRfTBdEBLjQV6EqHZpykyoXNvuj/Niy6UDwbVOfIHP9JG3j
         OqxWfOEkwzzK0FAOq94ElgAqdE6w3gRKVoz0RflZDDZHTGSt14Hdmo1L3lzkaQAz164H
         Pv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlEehyU999C9xMrwZ9YOmxyPYd1AQduGfU9jYXvrjBa066zE09zH9+WS9t/5MqMpNuVSMMnZcXsF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfXOA9suvvsWy4IKgrFQYcrzg60826sbDXeOPkLSpHNuKHZV7
	WjGj0zG8uafk7TzTKHX8jqTs1Wf5Qr9kAgBw76FTFwPkrzZBIxvnF7peCogCmtQf7cZUW/ApGf3
	bmgcfnUMkxdYhkx/ueow8G/AhOcnJKBg9NGBCs/2BrBVL73qN
X-Google-Smtp-Source: AGHT+IEAA2eR1CF21wxXJhBK6Hja6nGKN6FOH0gS8wg8S5DjXKbEDhtopM9INx+Et4Pz58X0bcnls83hbYMzJRZC6gI=
X-Received: by 2002:a05:6902:2849:b0:e11:6bbb:d700 with SMTP id
 3f1490d57ef6-e17a83e2a1emr8932113276.30.1724672358211; Mon, 26 Aug 2024
 04:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Aug 2024 13:38:42 +0200
Message-ID: <CAPDyKFr9q=EcDpQApyu-RwXth=ghV07B1Mo70hUZEZRp4vdm=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove struct mmc_context_info
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 15:24, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The 'mmc_context_info' structure is unused.
>
> It has been introduced in:
>
>   - commit 2220eedfd7ae ("mmc: fix async request mechanism for sequential
>     read scenarios")
>
> in 2013-02 and its usages have been removed in:
>
>   - commit 126b62700386 ("mmc: core: Remove code no longer needed after the
>     switch to blk-mq")
>   - commit 0fbfd1251830 ("mmc: block: Remove code no longer needed after
>     the switch to blk-mq")
>
> in 2017-12.
>
> Now remove this unused structure.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested in drivers/mmc/ only
> ---
>  include/linux/mmc/host.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 49470188fca7..545bddfd7e1f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -292,20 +292,6 @@ struct mmc_slot {
>         void *handler_priv;
>  };
>
> -/**
> - * mmc_context_info - synchronization details for mmc context
> - * @is_done_rcv                wake up reason was done request
> - * @is_new_req         wake up reason was new request
> - * @is_waiting_last_req        mmc context waiting for single running request
> - * @wait               wait queue
> - */
> -struct mmc_context_info {
> -       bool                    is_done_rcv;
> -       bool                    is_new_req;
> -       bool                    is_waiting_last_req;
> -       wait_queue_head_t       wait;
> -};
> -
>  struct regulator;
>  struct mmc_pwrseq;
>
> --
> 2.46.0
>
