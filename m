Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E22BE056
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749976; cv=pass; b=MJcSVeaB2qnXysAd35k4y4wc3lmWKwQP/ml3JlUaxIXtnnu4qMzVSpp6bcgYHxNR/ednblPOXU5dGWZr89njLTMfHJqx3FpkW++aMpflGo4cCEk97kHpDN8hVSdeYJkKUjsbs/x4QdiamScL2Higt3SdI2ZckVpQhCIjV7X0jLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749976; c=relaxed/simple;
	bh=0cEH43Iwq7MevT3qkSU8cBZ/dgwleLbSPnjJSGgNDS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml5lP0T1lg+pqOjssctjgqvs1B/U3LKZw4RgR76shyfjvCvj94VtUqv61MhZm8bJu4uD+G0ZIcIs+rLhpgzH6fCIZ+0PpQoK0Cj3mzzQr5zdTOuVU2oMCulFmM4Pta5l4zk/19sBFFO9WOQbDni/JX3qQBpQKQWwzTzLOxiuaGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJRi5Vrp; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJRi5Vrp"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3e5b4acc1so918066e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 08:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775749973; cv=none;
        d=google.com; s=arc-20240605;
        b=RFnSKN6AKGq6NI8ydo9xLIeKcnjoFOJ8lPdSNZvi/yCbuXNveoeCaGv7RzofF2jz3X
         0dNoYxC0qQHscR1+BpwnFfJyFFJdKC5mIhT4QMooHHJ+sSpqRoUGt+0ds5rGkk//rvMM
         V+9XIumWZVXwL2uxmaFphqGXInpWLsczq7dDUD516mJW1YkhIpyHJfWDfkxvM8Ch78xn
         zjHgeAY1aQRP0emcZukTP2sr9SQTNGglEaSggGkB1Qx76TxKDye+SDLWP1guK23NB0/F
         5ce2EWpJfdDSlMU7Lo9O2ecpYlJ3BMjpvq5/diSnIayO9X82e6ALju03hT/P07SyEq/A
         +5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=psYXBWtAq2sdT92rYBCHeqq0nuIKsr40tKMiw0L2UxA=;
        fh=5obraWZEuawUzlBY+W1a+TGNwKFOLyq9QOdFgtgXiNc=;
        b=Jr2JE/QGEjdU63vXE0mv61glqvet0LcthAZwNd2xauQCBhs2nye6AK6qlhvJ/n9Lf8
         W5gs5uoRYM1e3f8JxZm1kMSCw80KCbOXUhxVDW/AEzKSk4HKubtHWzvFlx9JK3UEod/Q
         nN8zIIOB4M683int00vOIeK5rcbqI/VN4Nd1siNzqiYddV8MBNerngp33itfJTyW7Ey6
         ojMk0oZoZfNjUd5nXTNknMo15Ub8JTxaM36ux/d4UVBZnnnrR87t+LNMHGzjRV18PEkd
         jkxjC2UZlITUWdP90aX72nt75SxH0OWmFLaqFJaxQUCIHjA0pnKFjBr/MRtnd6dwQSv3
         ceQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775749973; x=1776354773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=psYXBWtAq2sdT92rYBCHeqq0nuIKsr40tKMiw0L2UxA=;
        b=AJRi5Vrp1JyRFVeV/djdyZYBJccBn9jRh0/2IgXOdbt2pbaJEH74d1Uyssug1J5Inm
         hOlaYGZ0Ih5zjWG6ydmEIRhlax5NyZi7JzjuAQ6xVtZbA445CsZBT3iyvohPAPkwOcA/
         etuVwcf7t+7l0RXwkc/1HEre/EOUua/kXfYy00K6+1LWzHmTRRxVBxA6yrqk9orY9egw
         N1LGkK2PDGhnbPYm7UHq3Upfjkd7VvVbDy9povDwmbWUW+cNRoi6iRLrmV13qP/FXe1T
         KbFNvbukqz0nAUsrR6eu5A53uGS1ydZLvyP6GsQGAToz4nfZ5Tjf/YQFOQBsRvkA7+AB
         WFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749973; x=1776354773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psYXBWtAq2sdT92rYBCHeqq0nuIKsr40tKMiw0L2UxA=;
        b=LxG/EYZVGZkU3drJHv/W3uNhXoJilL55bKn2kmquKEIFOJa+5kL+ujrjDbahuspwsn
         zH9MvROxzG0sLJQsuJjJio9KIeZr7p4ElYbyzFbPcEKuApup8AO0jiQr6kX/t4+bTSvg
         sasAYxg3+GSRmBDcPKoI3mbMFpIyv7bnKGsrMTV7ZTB0la1KFhCH0eKnQ/33dVWtTmlN
         0Mt0JyXkkmCkwog3UTGRrsOrK9H/WueD93gnL/x4E45YVe411Jfvk3jMYo63+u6Wrd0J
         cKbFzXDJyJiSqof50OTENnb6JE25ABwjGxbLL5O7w117FJo53RaI7FghNMAIrmSesC9y
         lTQA==
X-Gm-Message-State: AOJu0YzezSoSFLu/Ly+vaGepI8sDkLXSsYQWC4p83wK5FSgXWVGysEj7
	z5Bod2qtrLxAChgUFq5dtsm33ernaaXaKsTT+SNUAs+9jKRXI3PYLty/es2+Pephu7vRd2srCAA
	/Fwb73cy/phQOVLgqhjBCJ8IkJQPQMvzaYDDCowyY5AONeEQQBcUL
X-Gm-Gg: AeBDievhcWP6i2xgYsEFhleYfDOk9FKmIQlzNyca+aUTy8lIjjH9o/GwcKfg3HVaD5a
	JDS+GCoiAzsWt+KYnQGufNUXca+rM+DIr2dmy9LGYqmMd4cPGOttotAEuCUw4qhgbcBDGaKRlDI
	AH0bRkPUmvyCt+OSvx2M0fpoYQvFD1lZEc7PZzoZ+oslFizci9PU6a3aMy/q4LOJrZCe6zo+/y8
	5CsFn9T/1CyUg10t2xw93Lmle2+xwaAYjhqwxxawEeHj61LUjT7LjgHcOED+edIWCpdDbZa6OIe
	QTthmhAe
X-Received: by 2002:a05:6512:3e0e:b0:5a2:bc5c:2e7 with SMTP id
 2adb3069b0e04-5a3e7a16578mr1549390e87.3.1775749972488; Thu, 09 Apr 2026
 08:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327200851.3669019-1-b-liu@ti.com> <20260402123155.1896449-1-b-liu@ti.com>
In-Reply-To: <20260402123155.1896449-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Apr 2026 17:52:16 +0200
X-Gm-Features: AQROBzApYd3mewoaXZWF6LoVMHF7tY7eWvE0Lwl51dpyqdI9MsgFQ3uFkt7zQDU
Message-ID: <CAPDyKFoj_JkGUnEV8aByJi=OtR1bw77w7m+yAFpotNshtV6CCw@mail.gmail.com>
Subject: Re: [PATCH c2] mmc: block: optimize size of struct mmc_queue_req
To: Bin Liu <b-liu@ti.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 14:32, Bin Liu <b-liu@ti.com> wrote:
>
> ioc_count won't be more than MMC_IOC_MAX_CMDS (255),
> retries won't be more than MMC_NO_RETRIES (6),
> flags is newly introduced and uses only 1 bit now.
>
> so change all 3 of them to u8 type.
>
> Signed-off-by: Bin Liu <b-liu@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: rebase to upstream tree
>     change flags to u8 too
>
>  drivers/mmc/core/queue.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index c254e6580afd..dd7211e3a6d5 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -69,9 +69,9 @@ struct mmc_queue_req {
>         enum mmc_drv_op         drv_op;
>         int                     drv_op_result;
>         void                    *drv_op_data;
> -       unsigned int            ioc_count;
> -       int                     retries;
> -       u32                     flags;
> +       u8                      ioc_count;
> +       u8                      retries;
> +       u8                      flags;
>  };
>
>  struct mmc_queue {
> --
> 2.34.1
>
