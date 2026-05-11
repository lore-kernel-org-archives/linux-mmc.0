Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F9407597
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514053; cv=pass; b=PqRaK+c13wXWlO3nq3wJFkht2cJM3OWq++xfKL0H/Y7ukCfva7jJZjXjZ88K56o5Qnh2lvHfQS1RahuLI0oHEJde1OuqLrmweKy6HyVsSznC21UXyjpGkdCoOPrtbq3eWaI9bQAQ4QIrTH8lBqbf7GUadj6ZzJwxER4Uv3PQbhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514053; c=relaxed/simple;
	bh=YYndEmOMjCNNsKuApISmQ2T3lUbaRUZdNplQaoN77rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpHCS2fzlpb7LMAA5MCB9yc/WVHXVbSKJTYNxjb89H0A7/fOXS4KKJ3ecYg4J9N6E/Nsy2mH6exzF5jjnUUcsG9VRp1XHlxkztYrWenChzLd62hDqeVlvga9Owue3pfY+dDIQnbjRDSWgbDh2pH9n/XIPD1iJEHnlJ/p8cGrwpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GfOiF4q9; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfOiF4q9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso4085629e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514050; cv=none;
        d=google.com; s=arc-20240605;
        b=E/Cx8qV9HNWvu7XNX2WdUmKhU5qa87+LrVYA8wHC3Yms4z/x0JWhhjnXuyTcVBYeaR
         96OSsVP6voFtJGwMpbbeX8ce1+K7Gvn2mdHHYpFQ61Yel+CH1uEu3mdihyK7XyA+XQO2
         cvMwtreEh+dSDKleolvRejpczxIZGSGWpOSsQRi7wWmZTSOisg9khHSHZ5wv54L/s/oo
         TNMS8EAW9qmTC7xeGQZHRgKcmFa8WNUauoEgluTdWLekga8v25Msg77NmUGBza3GjSl7
         cKtbRYMXtkbGBt6t/5LmfyMkQ/bWVSay9y4uZXnaGwzpD6FBd7tqZOAQelbG7fv6CYHp
         BH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vmwb7DAwmyvjAf1IkP/b/C+gnygE+nYIl1lFsfQt/Ug=;
        fh=2C83EebHtTY/Ov1tOHAuO/ccnzGzLoDHkikcTNNJlNM=;
        b=WDLU0AkHfXJufGaAa6Hc0QvR0jl4Xq3KHY7zSFe/rrpSX5fBf3U9ohuz4mvK6niXCL
         EX3xsmC2lORDxurK53f/Q0NRAUgkGgPiND7730ObSg0qlD+B2lYpuZ3+h4TSK3qO9iaS
         4STfiq/Ky674goWvqc/255jlGRcUGfeLb85cdbcWvoo61/5IsThXb86Hh6bwIHyzZWFK
         8ISMYbEwJ6RAgI4xaqKM75NumD0R1z7dVmLPztSK1K0vKZpr1d9mlyx7l4gTHNuRD5MD
         FF+8kQE52/H5Wq7W+d8Q4IFcuGpxO66u6CQQi/6EoL/FDDnK9q3hfN8mUOANA45hPirQ
         7ZKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514050; x=1779118850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmwb7DAwmyvjAf1IkP/b/C+gnygE+nYIl1lFsfQt/Ug=;
        b=GfOiF4q9XaUPaWrkYsiRt1+o9EtZRpfGFtLVGSjCc1XshljjCzb2o8uPooVzgPf3ka
         9OQtR0rB96Vw59hhI3J1j6C7rRytpmMKnvygVhvqn+Gjs/Gi9/rsfnB5cceSmXXo0aoY
         jQ2AMkySF7ki2PGAwtmt16GMW2YM24y5/VLz9ydxzeNEEsOyRc/9G+Z1U/dDXwy5F1um
         I6AajgNyaLG44GagiCeSY0nT3kLL2Jbps4BXeKtJYF0hAMTcRzk2m3OYGpd3j9yRCTza
         3WFQaxkJsgq4sd4vezU0KZNj3khwt/77edB07URpWbXuqkObXJ9vwr4OR6bc33KTPbq/
         sRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514050; x=1779118850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmwb7DAwmyvjAf1IkP/b/C+gnygE+nYIl1lFsfQt/Ug=;
        b=GgBIDru07Por2GWGFCdP/Nu+AlJZOjlOQXocudS7J5614/sJuDgxnI6l6b5B9h1AXe
         MiCdlodJlmWWDhPis0dND/KSg9TE0tzQU6DGw9xSGqq6ZLLVHKnx/4T1ZCRFQS6But6h
         uaelrGVVxg2Jz1H4W6qMTgcK77pHuX7QX8apJ53K9GDvUz66Iqrhj467psGjYDK5rxnx
         ofVm1VLp7uYcVXUJtplWrxgCyb8jv7+kG0NdaQpE5QgYUyLFIMNtgGmReC/CrJ1LBWbT
         rZH2nUz5JvlPt1fTtLerz/88a8DvQ87IUWB+2rG3Fq149z1oLj1xSoQojU0cZ+yU6VXu
         dGXg==
X-Forwarded-Encrypted: i=1; AFNElJ/PMM28Qf4yA1QVEFUNY1U0cH7v6psUcKmjqJu2sEBJ5/YHojuINp6ZF3QN2yiuUbpgggTBVNyeXRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aPi7UPlibQRIzipgc0DdfnO6oAplsbjvEcpR/XKZ+StUrMTV
	T9GBKDJxY0/O2k+6kpRrni1wskMYzaqpxOr0Ioo078lk39ucPrRfPn+moB9N3Uso08UYxgIuBWS
	HqWmqKo8UG43KUzzAkVF/WMFiaANMIMK9efvqHOStGw==
X-Gm-Gg: Acq92OGuGbO2KR6tXDiAdmHcZY31AUBSkObl/6z0dWBd1+RnRKDGpvCm4pavNog16Ik
	X5Wr6RV2mw6rfP5rr01A7cuH5fBs7PND1vtLw36b47/xj6doaJxtjsVQVNUjkFMY3G1uFCeCAp6
	VUaFO6cOyTJYMpLEic+oYn9+6lEWXvuS8LV8sy2lt6llWKboJ4pxyp7cKEU+HWoo6cxdpFMEzJt
	MpA4KPNKzZWzwtqWGe7NZcBcXTtOcNA83i5zH1V3vqGUUwxQZdulmGApF7sKf3Ql8+JzJyHcWUC
	8DOI+piSU5ZXIm3bHP4=
X-Received: by 2002:a05:6512:3d8a:b0:5a8:a558:63b3 with SMTP id
 2adb3069b0e04-5a8b709b088mr2920906e87.30.1778514050154; Mon, 11 May 2026
 08:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506190538.596-1-sozdayvek@gmail.com>
In-Reply-To: <20260506190538.596-1-sozdayvek@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:40:02 +0200
X-Gm-Features: AVHnY4IfIknd1YNlE1aq0DnMQUiNiMoH11k9pjuFU-tNvWZguuBa9VK8yUFjorc
Message-ID: <CAPDyKFp6YvmTF+OL5WqTfaZ_=+csitJoHiK39An0gM=NPLpU1g@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: avoid NULL deref of host->data in IRQ handler
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: ulfh@kernel.org, brgl@kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 21:05, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> mmc_davinci_irq() returns early only when both host->cmd and
> host->data are NULL:
>
>   if (host->cmd == NULL && host->data == NULL) {
>           ...
>           return IRQ_NONE;
>   }
>
> So we may legitimately reach the rest of the handler with
> host->data == NULL (and therefore data == NULL). The DATDNE branch
> already guards against this with an explicit "if (data != NULL)"
> check, but the subsequent TOUTRD ("read data timeout") and
> CRCWR/CRCRD ("data CRC error") branches dereference data
> unconditionally:
>
>   if (qstatus & MMCST0_TOUTRD) {
>           data->error = -ETIMEDOUT;        <-- NULL deref
>           ...
>           davinci_abort_data(host, data);
>   }
>
>   if (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD)) {
>           data->error = -EILSEQ;           <-- NULL deref
>           ...
>   }
>
> If either bit is set in qstatus while host->data is NULL, the kernel
> will crash inside the IRQ handler. smatch flags this:
>
>   drivers/mmc/host/davinci_mmc.c:933 mmc_davinci_irq() error: we
>     previously assumed 'data' could be null (see line 914)
>
> Gate both branches on a non-NULL data, matching the existing pattern
> used by the DATDNE branch.
>
> No functional change for callers where data is non-NULL, which is
> the only case in which these branches did meaningful work before
> this change.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 42b0118a4..42ad87aa4 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -928,7 +928,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
>                 }
>         }
>
> -       if (qstatus & MMCST0_TOUTRD) {
> +       if (data && (qstatus & MMCST0_TOUTRD)) {
>                 /* Read data timeout */
>                 data->error = -ETIMEDOUT;
>                 end_transfer = 1;
> @@ -940,7 +940,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
>                 davinci_abort_data(host, data);
>         }
>
> -       if (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD)) {
> +       if (data && (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD))) {
>                 /* Data CRC error */
>                 data->error = -EILSEQ;
>                 end_transfer = 1;
> --
> 2.43.0
>
