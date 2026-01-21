Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621D480DE4
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990648; cv=pass; b=e4zz2Vp3ktp8nY7Q298odvBbjEZdjJUCOcV6/8t+9G7YS8SIAW8SMHh5behwyIyLY0DMEzuWWeydM+MlcZEl9oeVGVJJ3iybMuw+b0UNPihgeN6FmsGB+Kumc/jNAIx18plSMKKXKSe6rW1sayvXStq3BvJBzpvN7cBTxrSrx60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990648; c=relaxed/simple;
	bh=yLQMzxIhT7zp8auXJr0IV3M6Il9Pl78mfxbzfuc1jCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkUHOt+23HHT09asz4TGYwNhbAUK6kwtlAhk3mnqIBhT1yapXrCjFbkNicaHhDpcWJhoLnr7chhZwVj6iNkMOpfim5jX7a8oJNUFJaDIITDmYYtXVuP5WrLprQ0WqHJfTOazzSYCK9U4LgUYNCCbl24m+zsvyuL5xzYYL+j0bHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xA/vj/x7; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA/vj/x7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b834e3d64so9208561e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 02:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768990644; cv=none;
        d=google.com; s=arc-20240605;
        b=cw22efpJ2FCeLXw2LxdF15aUcuwSzTVdmFX8DRogfY1Q9triuPY/lsj5NF1ArL2BAw
         XJMOVYyTCZIo6cqcin9X1ps6VWA4za9Q95YSoZgA8BSl2+kdIZA+1kPXsxwp2fIQpjho
         uuEsICzOflrC6YNLddrldVqObCxtjyCO7icJkioN5FqK6mhK824xs54s4ao8MWI1GVLC
         5mR9Xus6bMcvNPvcSngYZkozK25kkobZm79tZuZudwmis6L8NoQjR4FLElZZj81ioJ59
         wq/Li+19jaxtEyemtC2za4eULT3AuhMpqgjtfOxjMeZ2dZrAdza1KwFLj/pHbMQCVxkN
         HNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yLQMzxIhT7zp8auXJr0IV3M6Il9Pl78mfxbzfuc1jCA=;
        fh=qGPFKfu4f1gUmrmW/EWhkTyjQXbBaSqtV2jH7BL6Uh8=;
        b=lWo/aPzgaPGuTiWocHL78EIzvO14krCf7TefBh1Fq2ImBPFAD7n6NLNh2N1sJEV6zO
         lO9kTwFUBpAPQpO3waX07G8dSOdIBlgsdorBcs4FOctlZsS5dgV3lwQYxW3f2IOJ678Z
         4/SMhy7SUDY0wXAWG8A58gnE11qLMu77ZeyencKji79DKyrb7EhvP4xu8Sq08CR5ID/g
         u7qmMukxKfJE1qfCd9iLS96EyAqkFuLnb+cRRq/sODBWYotbGQaFwaHMVjMnceyY48U/
         N+lVW7pmjH5JW/N3WbOwDNT8qVIN6UBTBaUXf7iKopeWIEUBkdep0uSjNQFC3cjOT/+W
         as1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768990644; x=1769595444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLQMzxIhT7zp8auXJr0IV3M6Il9Pl78mfxbzfuc1jCA=;
        b=xA/vj/x797jCOGZHn1lE7a1pKP32A7B9FAnP4aqaBHpAvXEFjih5rEvFmHouIcOidy
         qRvXNWtonPo9AIBEqLM1I721RFdBEyt5dnqshhwNrau5B50SZjQSVFr9ck8wXX0hlERu
         gmoo5BWun/iBZu5CGkTaPeJIUMgR7hNMBlGsn4waIJSz4x5oiRKGbl9KISWYHivafMbf
         QFPZ/y7wqfnUDmwzZARY94SfubJELT4v3UG/NfLDg9eFPFIsJE3pKEp7hDqopoqQin1I
         ta1ndargLw49+YpNKYdwzk8bxYaI+dDVYsx1LOY2/ExAQr8148uOzkt3/u4VTgJbR3tf
         XfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768990644; x=1769595444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLQMzxIhT7zp8auXJr0IV3M6Il9Pl78mfxbzfuc1jCA=;
        b=W6M7zQiK5FBHhEEXahDyepSp73tUyu6v8bS/glK3ZXKqvVYByhcAcYdWgtNcYqj0fP
         8pVs7rAZN/hdmXFzUlqRRLEuT2Yjf0KgRRMcbXWoAnt5UzJp355fR2GmGunPLRunJGOp
         /KpKwG5BQaUueM2868OKON4ky7jR22zvFC/3Yx6Mh1jyb077cuMQV7OdHptZYXpnyvYR
         gz8tFb6C9dZs4QEaJCrcXEkfMRpZPKlJuL3sZMUUy7u8Jc429h5b2svYesbrBwp0U3XU
         0vnmj8bi1V4wLEb2INNzM1AFjFtB4nLSosNnqlKSXCsLp+we4htdVPTRsxOEZW03r7EI
         mx8w==
X-Forwarded-Encrypted: i=1; AJvYcCWrCjfJa3fo6R+1fiQRj/ThcaISz+lTZ4OrpB2AHWPwkdgeLo1PMAJZjoDWLunypjl+3y0DKb3uBrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJS4lSrezB3uZ88H2wm3GZUDz6tv0CfkfKgo9IDmtYf5jMLl7
	e8OckxYmcncWKxdnsKfQ9c6vl83E+//QJk8q2Hd6IXsEzPsYJDOoVNL/+Px9MppEt2UV7xGq4of
	xcBp5vG89jXdK4La0tGuAr58knbiWwMIRCpLtp8SvDQ==
X-Gm-Gg: AZuq6aK0/awQnvP7seldmHBeEDC+FuJ1A6uGjY3nIsKc0eyzIar0q04T+xBKPQFWVFZ
	zTTHdVLETSQqsjMGWTgFpoGWNCGRQ+HbeMeq4kNAWpUttcbruMezqoiQZmIeV9Erl3OqLEZEmfE
	m7Wa33UJSaWpWzDBxMQ4yTw4ruVdfwLtkb1UTeHVoa7wl7DnsgJypE9IDt6K9wX+9O50/ka213k
	P9yQBQWjGbf8rA7RCw+YLZgK7TWtm73Owt5XohgNLIU2eV60GIkfc5g46wOyS6Os0Av/5Wo
X-Received: by 2002:a05:6512:1289:b0:595:7cf5:f7cf with SMTP id
 2adb3069b0e04-59baffd366amr5983334e87.38.1768990644254; Wed, 21 Jan 2026
 02:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
 <20260105060236.400366-2-matthew.schwartz@linux.dev> <CAPDyKFo-2TcU6MPZpeEU7kPx4tOLG4ekEFyZnzy1qeH09MTNfQ@mail.gmail.com>
 <79349439-97ea-4147-961e-63cd6a5bfd68@linux.dev>
In-Reply-To: <79349439-97ea-4147-961e-63cd6a5bfd68@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 11:16:48 +0100
X-Gm-Features: AZwV_QiKgW5jdxGgRp-26RB1awU388_dZ037chnvZPErE_NqpYc1s6mT-EACuiQ
Message-ID: <CAPDyKFrg4-QxDpE_MkQacK_VRA6yQyFk4N3umZ1i2D=RTQisAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rtsx: reset power state on suspend
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Jan 2026 at 19:39, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> On 1/20/26 4:41 AM, Ulf Hansson wrote:
> > On Mon, 5 Jan 2026 at 07:02, Matthew Schwartz
> > <matthew.schwartz@linux.dev> wrote:
> >>
> >> When rtsx_pci suspends, the card reader hardware powers off but the sdmmc
> >> driver's prev_power_state remains as MMC_POWER_ON. This causes sd_power_on
> >> to skip reinitialization on the next I/O request, leading to DMA transfer
> >> timeouts and errors on resume 20% of the time.
> >
> > The mmc core should power-off the card, via the ->set_ios() callback
> > before the rtsx_pci suspends. In other words, the mmc core should have
> > set MMC_POWER_OFF.
> >
> > That said, there seems to be something wrong in
> > drivers/mmc/host/rtsx_pci_sdmmc.c's ->set_ios(), if that isn't tracked
> > correctly. The parent device/driver, rtsx_pci should not need to
> > inform that the power to the card is removed, as that should be known
> > already by the rtsx_pci_sdmmc driver.
>
> Ah, I see what you mean now, I think it should be fixed in rtsx_pci_sdmmc
> too.
>
> These already seem to be in char-misc-next, so I think I need to wait
> until those hit upstream and then revert as a part of a v2 patch? If I revert
> from char-misc-next I'm worried the commit id won't match once it gets merged
> into master.

I have asked Greg to drop them from his misc tree. We should either do
that or revert them in his tree. Let's see what he responds.

In the meantime, it's perfectly possible to continue working on the
issue and please base your patches on top of the mmc tree.

[...]

Kind regards
Uffe
