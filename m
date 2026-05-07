Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6A326928
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142175; cv=none; b=acCfwJo6zDeo3iJ9MvIuAzslV5CTOJKfUubJLkDe9u7YpkJvuOyY3atzXHSYvbUM9NpK8U+BSbqDvxufZnZPTMy13w7dkLEUriC4grPYXVctJhrMaGmaCIvKPbnfUFawbwVUCb1rPmu1HflSlcAKTdP1qlL/REVqVFkyxtvgmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142175; c=relaxed/simple;
	bh=LMq8xDnxTdKYfCuCG+skFVBIcnSJmYOfPOAasdH6jC8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPOUEZVeAvtMW/FUk6RSuNy/pjfu4HA7b6VTxVenus+1tJzRs5CT+HVarSsO/epB3PqHLVjuYmaUK9I+Dw9V/VsA3bh5TafClNLfq5p8AFinTCe68iLuE+L7lBOUCElRd6uv6xZxa9CDLZlrEeL8bYAmy1NtRtRujUSBA1iTw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxhLYK5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxhLYK5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27813C2BCB2
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778142175;
	bh=LMq8xDnxTdKYfCuCG+skFVBIcnSJmYOfPOAasdH6jC8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=qxhLYK5growdB95Km/kYbJk/TAOwNG8Y8bBGm9bco5HO6H1D1k1RzSiP54M96fL+Q
	 C532LPLOojpRcvXtVpafQDExIwtCFDK6Gtpheq2fTdFhx4T7HXUE0ptixVMcBtXJNv
	 7hse5d/InE/zhkqPNdSnL/U0T41zN5Y1HM+5//5KBYYXUC72bfh5guda75ef6Ziy4E
	 Rb53wDE/lcyw0RkfZkRFXmPJh0W/0ROENyu2wnPaopdIZ0MPF887Ag34jtvboVaOz3
	 nHb7GOkVN0FG8ls9SM+eCvYyq7oJ3Gz+OSmriL+oVafZ+qDJjuGlj8m+CVd3ueqwKx
	 /XaT2ofpTkzuA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a860667fabso460302e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2026 01:22:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+La2WDnwzuDzYJTt26W38gcg7MVD19nPtVPECVXfLiPevGFZ3X8v50aX/2OFUPzeIx6UVbhX2yKDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHLiZV77UaWxn84WRsDgmWwoAY4xFnf85qLwHaWXiu6Cajnuf
	p4VimDAKitX4x8eaQ3kmr2S5FKIonqL/eJ9wuvGvkBxfRS8Fsq9K4jgz28YJFZHHEKGXEwHBzo1
	EaZBL16LVz4nJsrnlFd5ASoERhzRMCmmRJq41tmtpWQ==
X-Received: by 2002:a05:6512:3d17:b0:5a8:97d7:8c2e with SMTP id
 2adb3069b0e04-5a897d78d68mr853517e87.28.1778142173725; Thu, 07 May 2026
 01:22:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 01:22:51 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 01:22:51 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260506190538.596-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506190538.596-1-sozdayvek@gmail.com>
Date: Thu, 7 May 2026 01:22:51 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdwD6yzc-RTFxrnvryLbq_MWYJPD9Xsgt47Q0V=zUckOQ@mail.gmail.com>
X-Gm-Features: AVHnY4IZpcmG123-F6F4RQApOAxVE42MPJtpmmk9jKT5PYjWCPRUPG8ZLrJbh-A
Message-ID: <CAMRc=MdwD6yzc-RTFxrnvryLbq_MWYJPD9Xsgt47Q0V=zUckOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: avoid NULL deref of host->data in IRQ handler
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: brgl@kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 21:05:37 +0200, Stepan Ionichev <sozdayvek@gmail.com> said:
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
> ---
>  drivers/mmc/host/davinci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 42b0118a4..42ad87aa4 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -928,7 +928,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
>  		}
>  	}
>
> -	if (qstatus & MMCST0_TOUTRD) {
> +	if (data && (qstatus & MMCST0_TOUTRD)) {
>  		/* Read data timeout */
>  		data->error = -ETIMEDOUT;
>  		end_transfer = 1;
> @@ -940,7 +940,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
>  		davinci_abort_data(host, data);
>  	}
>
> -	if (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD)) {
> +	if (data && (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD))) {
>  		/* Data CRC error */
>  		data->error = -EILSEQ;
>  		end_transfer = 1;
> --
> 2.43.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
