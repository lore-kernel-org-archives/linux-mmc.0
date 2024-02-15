Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9112D74D
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006020; cv=none; b=fWKJrw3OQWESb1RwIScfPsePrRdI57XMvOYVPpKM7JmpNAWekEbVzopqd1qJuTpY7aB/8V7Iq4t6WNWqh9iCLn39hZVZfgqQAaOCBBoeleAV9UcLczby5YcrM2wKsjx2XEfnWgRroo1B8KhfCrGU0YpXE5HLcFL855U4CAQlMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006020; c=relaxed/simple;
	bh=O49GmFBEFJw1evYJI71geRk1H8X54jjO+we1/8XpdBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoKBhQgBb60fceYOXUkk+jckBl7jDkYw5YQe18Bv03dCj6MqybvzBym0kkjHSt/KRnoIzYWrj80Q+BaVOO7a65v/v5Hu02AC+n0IZGwVE6guSLv2M5vJeqgItjwZzjfqkkUJX17ko2GH9JSHNPzLhk0zyCGa1U0+BMOjin4lFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d071UX7X; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d071UX7X"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6078c4cadd7so9585857b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708006017; x=1708610817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wTyKyvN/7Akhe2ktPgbpToPejagjmVZVc+5gYu9vRkA=;
        b=d071UX7Xg0ToRIkXmdEfvMWlLFMfqAtuegKd4cAB2DIm7E5UpIbvtIa1HwcObDfY8W
         vNq7WO7uK1ALcZ4zncRd/n3WjG4xl8BAy+XJe7MOzoDdemlF24NEF9Wrnc6fAAYQtNYW
         bghu4/aXZBr0pKh1MvJBFNGyH1VCGqdvIQMDh+o69MAmtB9S+eyQScjl1jAc2xcQDe7F
         fnWqibBCMjtASRTh4V7QzD/rAmVr7CsqKK68tk1HejgOnDkbCkSwmnWrNTWdQrZfEpHd
         KPRacKfI+OfpAjIIidGAETYc3tE6rcYGkahLFSvJEB7x37y9985IrDWHBvkfE1/xgohK
         qW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006017; x=1708610817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTyKyvN/7Akhe2ktPgbpToPejagjmVZVc+5gYu9vRkA=;
        b=DPONYgCukz5Ie3O6hBSycQkxG6vv/LR/rqgBQ5IgWfAjOPriHVeGdxhOAGcfN05Bxo
         PcazFZLoA52zfPd0r7hweUWNjXNvfDmoCbUbbcmQM4wjwOoeQxWW9AuofY4jvM2LNkED
         riVhCm8HJRgXXNeoBGcuG94eoobSNRhoOXjehWnlZx89ilxRIhARYBuolwLxQhH1zJCS
         aG2AJrT/0dVaNpGBbv9fK6b+jXYBUF0ahTruQWJt6CNb2BFXU/V9mN+0NT0nO8CjHu5g
         +M8UyNKv5s0VB2PhmbBj5yK2y3X/rUQV/zqngFrurQnb4f64q8piB4qDC5HpJs6YmkKn
         qSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOkVpZY8lXFb51obOWT2DHrmhU7k7cOgwSRXOJ6yq/zAIciG2RVKEedLtdaMY4nSpiAgcSqu772refuEdGsnNog34F1e64EIHQ
X-Gm-Message-State: AOJu0YyLaZvfLJSFNxkno0dLpoZvaWapjtE7KqEAA0Og1S3e3r91S5jH
	TjiX5SFgKHJ+JZvxMHMWCInMQROQNpTpsxN4n7NTJ82lznpbyb3YPCn4PeAaoTBjeUAgDgm9b+/
	esxBECVFLGKIKdMVJ+fUTFQ5N9TW7qer6yZ9dxQ==
X-Google-Smtp-Source: AGHT+IEiCyF+JHk89EqcWCFh5S3vbjma3++fudpcHT+C0/fUt25LrhjmSlnQIO9axgVL4SJNSoiB2WRkw8PviOUyl5A=
X-Received: by 2002:a0d:dd94:0:b0:603:c656:5e31 with SMTP id
 g142-20020a0ddd94000000b00603c6565e31mr1893830ywe.28.1708006017260; Thu, 15
 Feb 2024 06:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mmc-fix-davinci-v1-1-a593678ca7bf@linaro.org>
In-Reply-To: <20240215-mmc-fix-davinci-v1-1-a593678ca7bf@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 15 Feb 2024 15:06:46 +0100
Message-ID: <CACMJSevp-xG74Z2sfzmyXibHfh1zZa3AHuL14OKKO8HANrwHiw@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci_mmc: Drop dangling variable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 14:28, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The sg_miter conversion left a dangling unused variable.
> Drop it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402142042.vg0lnLdb-lkp@intel.com/
> Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/davinci_mmc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c46577305138..8bd938919687 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -211,7 +211,6 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>                                         unsigned int n)
>  {
>         struct sg_mapping_iter *sgm = &host->sg_miter;
> -       size_t sglen;
>         u8 *p;
>         unsigned int i;
>
> @@ -224,7 +223,6 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>                 return;
>         }
>         p = sgm->addr;
> -       sglen = sgm->length;
>
>         /* NOTE:  we never transfer more than rw_threshold bytes
>          * to/from the fifo here; there's no I/O overlap.
>
> ---
> base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
> change-id: 20240215-mmc-fix-davinci-bda788e8ee69
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>

Good catch

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
