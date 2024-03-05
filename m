Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDA5C05F
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640927; cv=none; b=G8Xj6ZZ/fZcYY9K2Ey8O45LIP0lXjZgKJzYjo5+nsohLaonxitV4HOlXuNKuxZsHaOHvQ8WP9AlPoYE9fJB5shAICXOGJlEVwisNpJ/6HhoNYRu3U6epLqt15jIm9KbxfqCq9LkAnOEzdOMrOgLNHIIZFFE/0d/ncp9k1E2Toe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640927; c=relaxed/simple;
	bh=DcnzC15jjmF1MCyU9zIkSIhTwgFm9vccBcmaQItPkJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvuP8Le1LL9Q9Z7mA9pioUOLJ/QjpCbZTyQTqG+PXrbUIVYXuR/PEdu6KDWu7KkYqBd5nZJxEW1YSCb+zXIERUA9nuGNro/MxMk/nG61LT13tNRC8YLnOcs6A7oAADUamS+zZTrpg8lBUDyoz1QhVWzfB4Fxs9aJqjinM79w3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZMb+mZMy; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMb+mZMy"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc73148611so5862170276.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 04:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640923; x=1710245723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ5xx2edHD5FMmLecpHNeUGAP2uUzcBfz2t1dwA+19A=;
        b=ZMb+mZMye31AX8BUxTkQi0P/LOw3S6FuUIQ7H0+F39vTNu2l7MQIO85lr2HMZjtB7q
         shpCenLHdBUqe5PMUd8gUAVet5XkbHyovNHZAiRk4tGiJETpKxjNV5DkOHpILzwfC2jc
         X1XQtgUKLgDjmUpDtTtRxmxY9cDxF8nIq1IlzKZGVJ2CLHU4GB0lhNRz0qmKD32llPXg
         MoqBMRQSJywPXHJL+OVSkjVe8hSl537PvR1543TVNgfA3SP+zqSXpJvxuZHLgp1F0Ei+
         nl6JNXv3eesRUmXBx231qvY2wgSZiHX5SKiLiPrJDYf8QQQ8PTpY5NytVWottJ+AofR2
         qZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640923; x=1710245723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ5xx2edHD5FMmLecpHNeUGAP2uUzcBfz2t1dwA+19A=;
        b=qGWJZ3OtkA4G81m9iBOnipqW4nEsa7DLIFBICi4KkZqXJ6R7WllsYQ9u1rxRamDNs1
         aA7/5xrpAORk62Pv8F0n4+6LODVVnGYiLDvjIt56sa21RXs+1TJOLPHItlVMDSZp8HIZ
         /0BwGu6wv1en9xm1Sl/wS6yrJt4w9+OYg5D/MwZ3JxaH6Vk1GYi6vk0GwjTncX622mBP
         ESMhF4nDaH82OLa5P+LAG3BIALmDjSrY2B2N6pwom/Wzc5aGNgXoMbw2DBeTh6HnMjRH
         REVgzU0Y6KIUMA44zyb0Qg98UM8Q+Z25XQM2MbDjGFuuAyIzQIexj94LUeF0FvsN20h+
         bAAA==
X-Forwarded-Encrypted: i=1; AJvYcCV62J6/7Dg/75AnTL4/ekJUqR0zrycQf74B1xGsPHJjal+FI90yPxSaF34dMNloMt6jb3OIXXd811/bFuAjNB/xPDpZ8hY7rH6x
X-Gm-Message-State: AOJu0Ywu/RktZwyIdGF1mIJF5DaPNWgo3USIUzyC8ibTc7CzuJcVu6Hz
	usKVxV4SbdOX3VsQJu8Z77Xw7Prsql7UjgNpCQB2UCiizSqSdHydf+1FgUkifJj6risMcXDrJls
	24faNUR9oz4XmRKceEuS5bam9WXRy77VfeeiuSA==
X-Google-Smtp-Source: AGHT+IFRHrlt93okZ8pF8wCozXRKOrxXQZtOR31rF4Oxv2ktk0VBMY0lfxSqY9Tg9+i8KGWI6harXSX+rrTSNtu1DrM=
X-Received: by 2002:a25:b91:0:b0:dc7:46b7:6d67 with SMTP id
 139-20020a250b91000000b00dc746b76d67mr9606155ybl.33.1709640923661; Tue, 05
 Mar 2024 04:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305105623.3379-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240305105623.3379-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:48 +0100
Message-ID: <CAPDyKFr_GyWVXPbaeLf5hp_SKuRpr9sixhDQxoYBbFEU2qiJ-Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: comment the ERR_PTR usage in this driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 11:56, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> It is not super obvious why the driver sometimes uses an ERR_PTR for the
> current mrq. Explain why in comments.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index c253d176db69..93e912afd3ae 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -972,6 +972,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 return;
>         }
>
> +       /* Disallow new mrqs and work handlers to run */
>         host->mrq = ERR_PTR(-EBUSY);
>
>         spin_unlock_irqrestore(&host->lock, flags);
> @@ -1006,8 +1007,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                         "%s.%d: IOS interrupted: clk %u, mode %u",
>                         current->comm, task_pid_nr(current),
>                         ios->clock, ios->power_mode);
> -       host->mrq = NULL;
>
> +       /* Ready for new mrqs */
> +       host->mrq = NULL;
>         host->clk_cache = ios->clock;
>
>         mutex_unlock(&host->ios_lock);
> --
> 2.43.0
>
