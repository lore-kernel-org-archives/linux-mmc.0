Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82B1BC9FB
	for <linux-mmc@vger.kernel.org>; Fri, 28 Feb 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729776; cv=none; b=N7SzJYorK05dYeGt2+NumT+EiESAS41wakYyk9vsMzKXH1QtBU5pssqyZGUhQtoSDBE9Gq/tBykyQdZiTuq8BTzyOOmX5HAx/ZU4kdRuUmjCZPROWR9KTljJWeDLZweNpE4MiIbksanonxaWf1ruExCUDZv7dzf91MrY+FDE91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729776; c=relaxed/simple;
	bh=dzID++3XktGDEzV2iNVFJihvJ3tFvaCLWgWAWJvqJCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpCQKn0KwFNbf2YUCc68EvR7PnybBsTbrL3gXioNjX553LQVBq6URtEzF1WhBzTsH4EHEMh0yUFVizlClomgZl+osWmtApuQT/Yp4mdJ+W1EeCrF0Gf1QKzm7LgPYH2z9tJn03/MNy1E4mq9AfAw0majEWfTLpaFEQlJkmbNSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E54REf0d; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E54REf0d"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-548409cd2a8so1845664e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 28 Feb 2025 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740729771; x=1741334571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbr0JlJIE4FS91eTAO4EKTfkc1unVkIhWKA7fZvGtG4=;
        b=E54REf0dpvCieS5sjf7Z1vEZFzoxRDS9S6wEzUuPC3V+MimzfR0VcpOYppz5FOz70D
         tO9VElGDi2qnyerfZazPIOLLvVq/d7hgLjPVTHOa68u0nn6YKSqNJGIZ4xhhi2bPNWya
         sLVHQCqU0rQa8puDMwGpMWin6T/QEeFRJhzS9dUkSEcc6OkbrYwwmgzfQxElnpE1SE1V
         Mo8t5hKSCZIO+DErwvs2JUp+gJeUnLl0MhkpM0p8REJHaOLXQO511emp+qDjCVckApOt
         YqLh4dF0nXiqchvAuE5AQDMaiVgHufBoORhTlyyBpX06KH3q+alDQIFo6SFEkr8BnGhJ
         HSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729771; x=1741334571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbr0JlJIE4FS91eTAO4EKTfkc1unVkIhWKA7fZvGtG4=;
        b=OL4BchmF5HT1JiQmHRH7li7oIox2MXjLl55yGcqo6LBuOqh07UNEnw3jkC8obcjWOc
         NK97LsoEDfMr2f5XJXH+QH6PBkOyh/bQSnTaqaruE4LnIe69wII3NSxR3V5pyw6si2RG
         2igLJCPGEaeJVmbXLADYA04HRngsRKbN6RQnrEvMGEjxp6gPrqHiYW7NU4QiIxQ7z/Lg
         P98wdGChyZPMO6mBBUT5I1pM/ulvsgLtYkCAgFC+ZccM9ggkCTXrmPy6Epog/MBff87r
         tTFq7cJFP7qeEkIEn1rRNOrmvvwzH4+5jx1aXEUT7UrxJ7pip7XKnfZxk18UMTs12O4H
         GPAg==
X-Forwarded-Encrypted: i=1; AJvYcCVNJtZ+kbR/XkAOy/3YlLJQV0Wh6UCIqFyZ2Q8vDUsKZxpV0dSelTy+4jxZLjo+IolCv+m3nDDft4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRacNfXgnsrSqPth+BhuPcENH2xH28FL1ClQbgV3gs8vuBqTDq
	YL/N7rfSfsDmqtW3l/2kTtZm8U89r7movqB4E/yFPC8oY6YBM/lM8Tb+w6l4rPVlC8ANetI3cXh
	jqgL6rgRahZzygn5wJDYtQXqHG7ad0Roa47ZQ5A==
X-Gm-Gg: ASbGncuys0VYcn+NRmPBa2MK4zfXz8EuzCspz7I3Hcr7lDBpPkatrARampmV0K/HdvK
	RWBtFKDSJgvonBBkFCJUb3TE3/kxrY+pxF2LNweDS3/S9JubQkkltQtKIDHFMMDOXAP4bLby0ef
	pzgjT/Hr4=
X-Google-Smtp-Source: AGHT+IFWOcXiVWcdOW41WFhd6agTYR3FpZBByYOSPhq67IJiAnEdPrPDXHVSJmb/dCVk0/uCVFRJDHBQkVe5M5ZJHDM=
X-Received: by 2002:a05:6512:a8b:b0:545:49d:547a with SMTP id
 2adb3069b0e04-5494c122e84mr972716e87.18.1740729771493; Fri, 28 Feb 2025
 00:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com> <20250224045918.3321394-2-guan.wang.jy@renesas.com>
In-Reply-To: <20250224045918.3321394-2-guan.wang.jy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:02:39 +0100
X-Gm-Features: AQ5f1Jqy5qQny_DDgRtOCONi0twJXO_7cwKyXPro4kcz-2ed8U00XvOfzktKY60
Message-ID: <CACRpkdbbXxpOx_uVX6WTWfbqBbXwt2ssvpQDMrmvYSydNaiY8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: add reset workaround for partition switch failures
To: Guan Wang <guan.wang.jy@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@kernel.dk>, guan.wang.jy@renesas.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:00=E2=80=AFAM Guan Wang <guan.wang.jy@gmail.com> =
wrote:

> Some eMMC devices (e.g., BGSD4R and AIM20F) may enter an unresponsive sta=
te
> after encountering CRC errors during RPMB writes (CMD25). This prevents t=
he
> device from switching back to the main partition via CMD6, blocking furth=
er
> I/O operations.
>
> The root cause is suspected to be a firmware/hardware issue in specific
> eMMC models. A workaround is to perform a hardware reset via mmc_hw_reset=
()
> when the partition switch fails, followed by a retry.
>
> Add a workaround that:
> 1. If initial partition switch fails after rpmb access
> 2. Performs mmc card reset using mmc_hw_reset()
> 3. Retries switching to main partition
> This helps resolve cases where the device becomes unresponsive after
> RPMB operations.
>
> Signed-off-by: Guan Wang <guan.wang.jy@renesas.com>

This looks like a reasonable recovery to me.

However not all hosts support HW reset. You currently have to do
something this:

if ((host->caps & MMC_CAP_HW_RESET) &&
  host->ops->card_hw_reset)
   mmc_hw_reset(card);

Perhaps we should first just move this check into
mmc_hw_reset() so that function can be called unconditionally?

Yours,
Linus Walleij
