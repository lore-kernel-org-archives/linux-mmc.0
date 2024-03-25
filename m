Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3A14037C
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372758; cv=none; b=hmbZcUQKbqdEaom+cHNt+bt9YFJk0k1eexX5qmAgEBLAEb8yZ2katBWgUqEL/weZXIxvr2JEyuX2olbMldcu3hAhWdv9tCj0ie3lGhvwwbO4yevwhna4qN2eAH11JkjC8/UA2fsYX498iImwlfJ6kAC5AjJmCh41IzUPiKsJk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372758; c=relaxed/simple;
	bh=94oaHfW8q3kkUiIIR/cmjM+I50aKVNB68akJ1g1OjWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSx8j8csyDYvcTDHqbJz4kTE+AEPIeZ5Fp8uUR1jODiPhha2NDhITKbwbgQJj77e322tijNmU+kLDuwiOi3KEw0gaI8RfmIdP31+nxRjHOmNDrEjLFUyQsfHEWns5FbVllTxxoKvH4+hvAyOrNZQtDNMd/sXodyyiGb+tLewwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HB7HxWMB; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB7HxWMB"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso3243830276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372756; x=1711977556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uWWEosiNkhyTUXt6it9vKWgUnpfWnt4Y8zWTzw+zh8=;
        b=HB7HxWMBFxrRfiWdRnyd8CJb3LruIXC1B7VQjMgfpsfXAizYZRWe58lqmYZFcTUIxs
         P39tIC7AE0Sv4HTS5n3k7vD8xfn3FsxwHvOn4TWW/Tc1dacMnVvuTLTe6Wpsu2quBM9t
         OZOulXIf/yxjUXBmiSz61vdfdpk5VbwEL41pMNn8S5sr84jAb9vdC7xlM7NXlhXretr6
         w7XmlHQUptWcgR03sNF94qO/u/+yFC1BQqmS6tacBl6r5bprsTh8kU3cm6yegVhzlOr4
         KcRzysrhkvzEXD/BWyNHQJlDtvPTugbCsIztgRnUb9sQENkk2RwmXqY3W3R2uK8gF0Sl
         yb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372756; x=1711977556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uWWEosiNkhyTUXt6it9vKWgUnpfWnt4Y8zWTzw+zh8=;
        b=AIcn/LGhuZiAIaF6kcsMIgFYLfhqRfj3ZWDaZhuVqETjyOUAMJCGuNK2wyJjRQKLIq
         5jJouOxxpj4i+nl/qsgoOMber4ZmAngoFNvDzrfs9JMf4ixJsYziX8ucFWVgbmtSLENF
         uDYNpo/WYPvNj103fIqxVOJNt3kPFHAiiCRYVT4+CJUJ49q43EMCNkpnTJuN75kYohHK
         HWGgcbdiYB1TkvUzBxjtgstGMsFLYoAI5KWe8KMbtxgrkcU0+XHL/lQcUsPntd/0yhpM
         Y3QkG6lRzhQWIzDnIOyphcmT45Fwdi3n6TcDrJ4MGqFvQdEZsmqyqddm1DL50FehtL84
         WDtw==
X-Forwarded-Encrypted: i=1; AJvYcCX79zTUrBhT5Q0Oh4n8vTxFJ4mEoCY1/1shdiOwdo5fJuns1TIvRZ0zCyWlQbeL8lAf27/b92cYCWWEsGfNyAESNnJWaViPH5Br
X-Gm-Message-State: AOJu0Yx4m07bmW4yH5RVNJvVqD1I6nDSVoHdnzFXeivNIF5YiT0acwyl
	AVIzVNltXSZPse8YtTbJ6s7YekKxlwuT3OOH1eQQAYnt9uDfmN21bHM93YPgAAmj2j/iKU/BAPa
	vB+SKy6Q2Ejh6fCPeR7fSTdv3sQmgVogVfLi13Q==
X-Google-Smtp-Source: AGHT+IEAfx8jgfQzVNhKjIT/4Qjs9TEvBHG0zgnv0QMZirUu+xrnxo3NKC/nMJMjbv2KThVVcOczG2lGb73/4zgma64=
X-Received: by 2002:a25:144:0:b0:dcc:97c:5754 with SMTP id 65-20020a250144000000b00dcc097c5754mr3015583ybb.5.1711372755810;
 Mon, 25 Mar 2024 06:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307122129.2359553-1-usama.anjum@collabora.com>
In-Reply-To: <20240307122129.2359553-1-usama.anjum@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:40 +0100
Message-ID: <CAPDyKFrmJjv1WEc2yZFXKHxtN-vbS1k3VMeRyKdFiJkc5Uoimw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Yang Xiwen <forbidden405@outlook.com>, 
	kernel@collabora.com, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 13:21, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
>
> Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")

Again, this isn't needed I think, so I have dropped it.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Applied for next and by amending the commit message prefix to "mmc:
dw_mmc-hi3798mv200", thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798mv200.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> index 989ae8dda7228..96af693e3e37c 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> @@ -133,7 +133,6 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
>                         goto tuning_out;
>
>                 prev_err = err;
> -               err = 0;
>         }
>
>  tuning_out:
> --
> 2.39.2
>
