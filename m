Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20028DB46
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266369; cv=none; b=eLlMF/NKWIVb+V1qHCFLjcjzDf7AGgoE5uZSO1tOapxxLjojQzeTQY6Wjm2jJRDPY68wG1I/i8i1s9QdIUBwfbnIM4BS/IxApzvCX2eqJBzbCcRKvjc8DLB931Miw9+njyi8QwgnLsVKhKR3luLz/I1Nu/9OWP2ys7QIeB3nYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266369; c=relaxed/simple;
	bh=89wYcJ16h/vBsYqaJ40twaimJn/xvhA0SCY527VaqkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMiR91L/KC9w/6iaxqij/rCHdKK8u691c9oME116KVmc5iXlRCLR/k0VRwr3BOXtwwxWUF6MtAAOjPOaBQQ44Xrgu9yB4Z/EEzCCSe2AZfXWIt0EvaTn3C/5Y+KboXn3+AcpmzjQaZ5TVoMve3po/aWVZI355jJi9Uasl8sE+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hx5tFD3C; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hx5tFD3C"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-712be7e034cso64319527b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753266367; x=1753871167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=41nGtfIS+0AAlnYT3zsrXsXWjzXIGVgKsqDTuC+Cygk=;
        b=hx5tFD3CqFNBYbrZaUAIR4S+3fQ32OBPEKhp8dNvYySMVsWKtoSNoXFcBwYocU1jd1
         5rmOmk5lwVWvLbltCP7maqF0h1BSjJ5XR/cpVGacZ3LC+hpUriF6m9Ozo0dRNhVmOJV0
         Ae3RmDbxdkEcUx8DZPWnIZiSD+tDC2jTVhIC/ub6chJ1+c+x1HnJ/Ox1ehQmtAKfKg10
         iZ5FmgeC2p63Dr5gAhcTJY7AoTvBq9YddGd5QjJGUJS71NF+USRNaeaFZFimBW9fu74o
         33PKUBywZPPEzZ9qJ6bbiIaHkoUFDH+KuEuucd2DZgNbckzaNnyPCx5KcpsFHiVq8F8a
         xdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266367; x=1753871167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nGtfIS+0AAlnYT3zsrXsXWjzXIGVgKsqDTuC+Cygk=;
        b=hFUHNwm0svsNKVzJ2xOFIoA8O1jFTavQ9rmQln6mTKNRRJsal0BpVj4YYjXtlY2m5i
         uWXuMyPZ4OHequRQJrXcgIWPBGNt/3H0HjWC8epJQpu91bCc0J5AJknuMGwXn2CSMyF1
         zj3B6gUE1J8r5tU+8Ud3BygHijfuaRYsEhsY5QVNiWZvH6cfAreRDLtJgYfcLfYHC5IA
         FgH9TF/kh+2QED7vI+xnJubQSEhf51MLqL+ALv1gzpo5LEd//Gtp6PQUypeqbCd0vlld
         GiNR4iLQ/L5AhjCO2GQ00FaYEeEAQ7chD99YzY8wHr1NUm840ysjIT6fR/JanZeJ8aI2
         8pig==
X-Forwarded-Encrypted: i=1; AJvYcCUYsREM2vxJovkg6ggqYty8wNyIaLRmKHrfM3Jzs/a+/kTdze2odAPrHzDgwC2Lg0ZK51smhzwCnF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKKKu2yxvtN2DLupZWbfmJTX/OhnwTpMtXK7DHpEENUT1qiJA
	zjbXm5ZshOEf6n/XSIB36r/srzqLKA6q6QZ608/IH2GFRUAqvKbvtjRublthI9URrK3izvDjnAr
	3OB4HxSbfI8lY2gnuqRHTYOb5KuESvBD832u4AEihsA==
X-Gm-Gg: ASbGncsMY5jNXngvTJfzwSKyQ5t9iG2btm6irxnO9s6WGtqz9dyBPl9K3R6Sw4RcRCa
	bKdepEn7UQDG5SZw+otgCcIATmOMTcg/YJ04mOhF5OpNWzFZK7YY45auY6BhVtX1L4N/gw1Fkrk
	d/nMelFTPN7WH1nL1OKof/DKjGk6324XLmdQmrIH6mzWHwiMk4Ras8gfi5mYOb9Ze3/F9rzEN+s
	izAAD7qr51bn73ozM2fU0X1KYO3hH2C6yvZjUSyBQ==
X-Google-Smtp-Source: AGHT+IG6B6yrfLJOT0qbrE/bqWHii4PWByxkzfFfz63PKVDO/33ZG/QA9czSlFnn0T62zfPa4elBf5y125sdMA/uqoU=
X-Received: by 2002:a05:690c:7:b0:714:3e:f424 with SMTP id 00721157ae682-719b4236b7cmr32887317b3.35.1753266366506;
 Wed, 23 Jul 2025 03:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721094328.6556-1-quic_sayalil@quicinc.com>
In-Reply-To: <20250721094328.6556-1-quic_sayalil@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Jul 2025 12:25:29 +0200
X-Gm-Features: Ac12FXxL_k4CqcJQuBJ2hNtSKMJ4XE8sFEx6XTYV90O9wlUWmP5N9jedMU35YWY
Message-ID: <CAPDyKFrarv7AebbcfrJ6hWTX0B=iAxLOomQ+7VfAeKZU6eewAw@mail.gmail.com>
Subject: Re: [PATCH V1 0/1] Export an API to reinit SDIO card
To: Sayali Lokhande <quic_sayalil@quicinc.com>
Cc: wsa+renesas@sang-engineering.com, avri.altman@wdc.com, 
	adrian.hunter@intel.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 11:43, Sayali Lokhande <quic_sayalil@quicinc.com> wrote:
>
> Some SDIO client drivers, manage external power to the SDIO card.
> In such cases, the card may be power-cycled independently of the
> MMC core's runtime PM state.
> Currently, reinitialization of the SDIO card is tied to the runtime
> PM resume path. However, if the card is powered off and on again before
> the autosuspend delay expires, the runtime suspend/resume callbacks are
> not triggered, leaving the card in an uninitialized state.
>
> To address this, export sdio_reinit_card() so that client drivers can
> explicitly trigger reinitialization after powering the card back on,
> ensuring proper device state regardless of runtime PM behavior.
>
> This change enables more robust handling of power-managed SDIO devices
> in scenarios where runtime PM is disabled or insufficient.

Please use mmc_hw|sw_reset() instead.

Kind regards
Uffe

>
> Sayali Lokhande (1):
>   mmc: sdio: Export an API to reinit the SDIO card
>
>  drivers/mmc/core/core.h       | 1 +
>  drivers/mmc/core/sdio.c       | 2 +-
>  drivers/mmc/core/sdio_io.c    | 6 ++++++
>  include/linux/mmc/sdio_func.h | 2 ++
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
