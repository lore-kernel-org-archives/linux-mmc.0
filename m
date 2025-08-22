Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5222D47E6
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857784; cv=none; b=VGK7ecNKSIfknozpGzYBOUh37i3QgxMOaDQYXvOvQWO8oJ8ApBxmtCi4a7QU88W7oF90qG6c4Qq6VV2T4Ru8rtS+p0s5GPG1SeByCDg2Vd+IcNuTNyf/QnAWGd1N02q2i2dWie9oVLbYnAmxkMYy2BoyVPsMho1U2P88AyHMkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857784; c=relaxed/simple;
	bh=ljAWuzvOYiIpTo6Czaq+47GM+C7kMXSt3L2+v0PFt8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SF1eaqb45yTl/vGFDBU/FhjhTXOXrSqI9Da1AeNnN24aUIEyVy/tL6nb+ZVR2u3sDCHARQpQ7faT7yn+R9lzf/7fgNFk06n1hKPQUUiPm74zwNQEFvaBq8mMQW3MBsqXMkp7DfryOtpDgsjTnx6WZAeB/ItxHvMT1dB+D3vy1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LxpRTgp+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxpRTgp+"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b60cbso16946407b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755857781; x=1756462581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnmV0us7Kg27Umkj8/JkmwkYYloh1umV4GcZnJysZtA=;
        b=LxpRTgp+GortkgvvCHGdVQlJekUFhnsmNwCeQl+PyWfY+3EARRGSupQ5aAenLuApCK
         nISjSmMrfH3vW9W56oAXACeCoGSGSpoBGpps6r1Kf7xHkWIn5sXioYZ8btJp/HxWy4TY
         UD3jvNfbg2/dZPt7zYiKUIngHCpYX4n2aXR7JIEa9Df1C9jwCP2V5Wi0ToCxr/KnnNNW
         u5wJ6C068EzmI5c3NQEYamG7rIiL4/Y1W7ICiIYsHmzpvCbsQWfnspEsntZByTtwkaC4
         Ihp5x7e7D5iI57R8HO2RXHAKZ5vU5egxMSro2SVeGDn6wnadT2UosTyUaGrIWEpOmGLj
         VWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857781; x=1756462581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnmV0us7Kg27Umkj8/JkmwkYYloh1umV4GcZnJysZtA=;
        b=KPuZjZ+VnI31lZjL4P1+FgBWEa5WOkolFd+SLwr8BApICUtvzTiZT62jmLfxQSg+Ye
         T5J449y4qIF1TFNAkJDDp2ruHcDJopyOoHECkDsAu6lPcuEkOwUJCrAAWLR3XJ1i2rgd
         28OqWzl3j5tREodALhIAgm7fztYAN1ZzcGKwVfeRjzFYk9snBHpfnB5g+nDd5FXkfz3b
         dwsTNW4d9AqHyS/TJ37Si2qxWeMq84dvn2YvJ1hb2k1MfLQeTPZupdyCV0NB8zvQrkSw
         R53TJx7rzWBzYYwuY3GX7ZHZ3yKpCvZelcSkG64mIL2uLbCMYYC4ooZPLolHMBviu6Wz
         mGHA==
X-Forwarded-Encrypted: i=1; AJvYcCVj+MGuE2PRR4PG0aFsehpMBVfoH5DNXLWCbLBCGOk+BslN5tXDvb8rFjXhBjyTvwu5EwD520/OEY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKR+Bpa8Q+XW/vy5r55udhbY6UCyAlPHobeHYnlWqDoTbPAnm
	h3zaAD+BdP2bDpnQzOYjNAjxjXmbWgm4SuT4ioTqJ74U3t/V2EZCqoONGo0fklqaWGVb6bDa7gw
	hjBFeOACeRxw298cDpuUsRP100xrnpf2pZUf/y6VJ2A==
X-Gm-Gg: ASbGncvyDzcc1joxK9a1XN18JUF7JqytTmWOQA3oQ9AuXzBSSeVRaXJWJkUW6e0Ygkw
	pbvyoE3ZmTSXSzu1ckshSGc7UbS7V36DV/PFMMASriglW7ukMeplHEO7rq/dx2MoP1U4UPve6Bk
	lvec35zbH10sTqoj3xdwlH6uAmOMHzHWj95A1LfE/PYoYynBmbK7I8G5cvBlcSwMBpBnoQJ3yAw
	3/J6xkK
X-Google-Smtp-Source: AGHT+IEpjzEssQlLmXKXxadk4uEAS3oj1+xFV7AZ2qzlp06a7zrZrtPvDZicfzfIyyJ392bIlgHbjZLUDN0DNQK3CX4=
X-Received: by 2002:a05:690c:87:b0:71e:7ee9:839b with SMTP id
 00721157ae682-71fdc2e30a0mr26325577b3.12.1755857781289; Fri, 22 Aug 2025
 03:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKcR2ea747xkw_it@stanley.mountain>
In-Reply-To: <aKcR2ea747xkw_it@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:15:45 +0200
X-Gm-Features: Ac12FXx4XgJqgvW0WIQS_GDqdVbcgIgtnbc-eSHmfbfjx2viLj3OvkBKaDsAa_w
Message-ID: <CAPDyKFpHTktROvbW5ev6e_VGoVOUw=2EvRoMzmWLNfqoCPSykQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: remove unnecessary check in mmc_spi_setup_data_message()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Rex Chen <rex.chen_1@nxp.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 14:32, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> An earlier commit changed the outer if statement from
> "if (multiple || write) {" to "if (write) {" so now we know that "write"
> is true and no longer need to check.  Delete the unnecessary check.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 95a32ff29ee1..42936e248c55 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -566,7 +566,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
>         if (write) {
>                 t = &host->early_status;
>                 memset(t, 0, sizeof(*t));
> -               t->len = write ? sizeof(scratch->status) : 1;
> +               t->len = sizeof(scratch->status);
>                 t->tx_buf = host->ones;
>                 t->rx_buf = scratch->status;
>                 t->cs_change = 1;
> --
> 2.47.2
>
