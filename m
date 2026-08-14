Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE6379EF5
	for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738086; cv=none; b=KixLqPCuOiUsmp+rT9X4zW6BhsoC+qxekDxshrB9p8tFy0TkYJD+WkfEAxh4MJXfD5sfEP65DCnSpt0hKk9tkJtdWgkJ6Rt2qezaYgaI/PrOcwQW+64Fc3Ns6mX10xMfxKdROibTLqMJcklLDSXuk7opDyI/WAWGAFm0UxbhCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738086; c=relaxed/simple;
	bh=fMcz0fIx5jwW7Anrid9vFAsz+gx7Ea+GImrHPz5zjio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1S/sojJWsYoqcWUtLUI62vJXpLXqU7rO2fdEGk5ZpRy8uMdFkoewsRRmawTFYBqHCNmQzNKwvHaJNWdjWOmzjY++oNcnz0/wGKubwrCFp8sPKuyiEiGNTBdSFFcx3Rv/iQA/MBcRHXuXRvYsuBenzxM7mI8Aj72FlMBUSrogEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcITPsdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcITPsdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285B31F00A3F
	for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786738083;
	bh=fMcz0fIx5jwW7Anrid9vFAsz+gx7Ea+GImrHPz5zjio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GcITPsdOHtxmJ/y0g6EV3U7Qp00xQgKAWS37ZFRiCl+lzpWcUuqRbFYvN3zJ4H//g
	 jXNV5TmNEBbPXMAlPn5HBeXDoQh7PX/1/ucvwtXLnlV60Vbs7Rtc9JRvRZIwV5hGQu
	 T2K4OM3gieFHCPIDNKJpUf0mV52DZYnBuBZakmiHAzy14UtFrxhLCIljzUJqBCkB9l
	 zoYxfYcNlLV/7SPTiOdm19Vnh2KaGSlaGf78eu0p15XAWs1ZiEoyxQbr12MUprJGed
	 aksCJ32lydKOCHLCzujahq/t+cYLFRKJEbqaMJe/fzdEz78LG6mWX3jwtMVCGbtK5z
	 7G8uzoThO6t0Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so1226363e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 13:08:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1nfqCw727yRiur8iwtU3M7iGFW1b8z7s7RJvtE1MVnRCZTQ8vOP73Gotka8qmcSgQ/ut4NFpt3EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz883Esn/HitAVLKrOUkyPWCb+sKkvAefWxKQitIjUTkIKK5UXh
	FX50eVIlFM2+FK86Kps0pZBRw+l0SVDtEcTx+yEHZV21x+/H9YbZiGt7ivqdbhI15/r1jjj1h31
	qvK9uTzMwgjfuy4Kf5hr5+ZwS13NYtso=
X-Received: by 2002:a05:6512:685:b0:5b0:1108:c58f with SMTP id
 2adb3069b0e04-5b45918c165mr1328398e87.49.1786738081940; Fri, 14 Aug 2026
 13:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814082550.211496-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260814082550.211496-1-fanwu01@zju.edu.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 22:07:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLn0FbhgVasONV9phBActz47umr80GARCrdpQ+nZt7M_9A@mail.gmail.com>
X-Gm-Features: AcwNN1WH0045Tqncz0uBSmMoA_gTslGLLl50fYlu3tn_-pNgFGFLiiZWF8zpAGY
Message-ID: <CAD++jLn0FbhgVasONV9phBActz47umr80GARCrdpQ+nZt7M_9A@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Fix use-after-free in busy-timeout work
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux@armlinux.org.uk, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:27=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:

> ux500_busy_complete() can queue ux500_busy_timeout_work for an R1b
> command, but mmci_remove() never cancels it. The work can subsequently
> dereference the devm-allocated mmci_host after it has been released.
>
> Mask the controller interrupts and disable the delayed work during
> removal. This drains any queued instance and stops an IRQ handler that
> is still in progress from queueing the work again once it has been
> disabled.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: b1a665932dc2 ("mmc: mmci: Add support for SW busy-end timeouts")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
