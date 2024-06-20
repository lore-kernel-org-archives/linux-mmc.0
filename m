Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4E1AD3F5
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894009; cv=none; b=THPzUK8FdMKvCKduYsp5jJqqJEIDk2xLDOjTlY2X/WDzkn0FUjSXdNfzll25A2IkqFKyQj6Iv1aWo1JKoyHiPbKGFgPfjgQYPW6sSGyNmR6znPQy934esJMQ1qVmwm30NxtTRgxFWa5fgRJHAzIplAjXYPRO3dLcV11QGwZ4kW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894009; c=relaxed/simple;
	bh=grrLR5UA8Ko4qkIvunWXLJpxL8GpmTY8TRHFqKM8aCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HX21ZA/nO+icSNs2mut2VHvlbJld11I2bX7UGevw9FoOQ2Z0irgiGVn9DIKSkK6np63BDfUEWHw0kM8Z3yqJHLhDJxeGwXCflF4XnNEvejg1GrQk2NIvhM1fLTVVMFhDCMjAE6Z3QipxeHkIKJhdd6mIbIeUpy5hKzoPsjMbSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q75BJXLx; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q75BJXLx"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62f3ccc877eso15147927b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718894007; x=1719498807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=grrLR5UA8Ko4qkIvunWXLJpxL8GpmTY8TRHFqKM8aCU=;
        b=q75BJXLxfQ2sSGJ1vunT4PXqtHJNff66P4LCQLfYDolSPObjulZS7bSKVvQDyFmeAX
         rbtwgXYySCTtNew4BDlB3ynvi9lJMG33NMgt3VSNHDfYNFdPaKojy6LGMw0SBARotz6b
         lE8ATSJlU0afwtBLrdV6pQH44G0zAQFZ9goNgQKoQD1GcIET6Ilwsv90iu1IZ5xECMBk
         hQIj+LWzIs63pI4ZgTTsiUnHAKyaGq9aEheh82hAW72JzLMFEKEcgXgRIF0MXgZsN6Hm
         V4IH3Czu3jECY7pcE+/YBAjqwCkmIZR/J0f2Jl9G33THzx4FPJ51ikpvrWHF5AmVaITK
         AWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894007; x=1719498807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grrLR5UA8Ko4qkIvunWXLJpxL8GpmTY8TRHFqKM8aCU=;
        b=GVu3XC2PLboOUkGRik2b8JpRHMz6xhFF4u68YkPfDXkAq9QSPI4S3KYiEAMKW+dk79
         8rfbZWjs+qvMCoBOkIG40CBMF+jX5gveIB/qAnV42YOGG/JZdUKqfw47wg7y5WyGqCHa
         F/hMUlYaadJ0LueFsXrMB0pf4Es1UHE2eGBZUJotmX8LDRYX8o6l/rJ0/KCU2IvI+j2P
         HhOIamJJRiOOT9bfsWiGq1zYztTV07uBRq81zRTPGYYUyYrLIkU3wxcFEbHOit4+z65i
         kU09QsZS2UxmGBTtUv+VBoCZ9pPnDqZFubmgIsBK65O/ifbwrFQMmdN0iY/V8XO2Wp6G
         x/lw==
X-Gm-Message-State: AOJu0YzWa5hBkfL9LhvtW6sLCfCkNc8yrro84YhplvDTn2ZPg7dqkvjA
	4EeDysey54rBE1hjNrNaNOEqLyZdGNzd0zMvWY18huzqSr+Jhw9qKpn1pWqYMKgeFzAS67aitIs
	1rX48wWoLT8jDvWeI2nF5DdkjPOSiRxgW5HR9R3ps99Js1UKR
X-Google-Smtp-Source: AGHT+IEKZdxSG+rKl8atDm+Bd0wE+qLojVgljkBIPB7wZImMYGy6/MhtAcMFjNHWHvCEkBcrwIbnaKLR6O6Gr0Iv/gg=
X-Received: by 2002:a25:d8d7:0:b0:dfa:fec6:464c with SMTP id
 3f1490d57ef6-e02be24b13cmr3912996276.27.1718894007078; Thu, 20 Jun 2024
 07:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131222.1131880-1-linux-mmc@danman.eu> <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
 <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
In-Reply-To: <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 16:32:50 +0200
Message-ID: <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
To: Daniel Kucera <linux-mmc@danman.eu>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 14:59, Daniel Kucera <linux-mmc@danman.eu> wrote:
>
> On 2024-06-20 14:38, Ulf Hansson wrote:
> > On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
> >>
> >> From: Daniel Kucera <linux-mmc@danman.eu>
> >>
> >> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
> >> so it was failing to initialize previously. When skipped,
> >> the card will get initialized and CMD42 can be sent using
> >> ioctl to unlock the card or remove password protection.
> >> For eMMC, this is not necessary because all initialization
> >> commands are allowed in locked state.
> >> Until unlocked, all read/write calls will timeout.
> >
> > Skipping the commands above, only means the card gets partially
> > initialized.
>
> Correct, but it's an improvement in comparison to current state.

Not sure I agree with that, sorry.

>
> > Leaving a card in that state seems fragile.
>
> Fragile in what sense? Nothing can happen to the card as it is locked.

We may end up having a card half-way initialized that we can't really
communicate with in a stable manner. From a system point of view, I
would be worried.

I would rather just power off the card if initialization fails and
remove its corresponding device from the system.

>
> > What will
> > happen to upper block layers and filesystems when trying to access it?
>
> Everything will simply time-out.

Yes, but it's uncertain what that could lead to?

What will happen with power consumption and power management support,
for example.

>
> >
> > Several years ago Al Cooper made an attempt [1] to manage the
> > unlocking of the card during initialization, by finding the password
> > through the "keys" subsystem. The series didn't really make it to the
> > upstream kernel, but overall the approach seemed to make sense to me.
> > It should allow us to complete the initialization of the card inside
> > the kernel and prevent unnecessary complexity for userspace to manage.
>
> Yes, he did a great work but obviously no-one got too excited to
> review/merge
> his work. His solution was complex.

It's quite some amount of code. On the other hand, it seemed quite
straight forward, not that complex to me.

>
> Mine targets the smallest change possible to make it work at least.
> I wanted to avoid a solution that would be hard to test, review and
> maintain.
> Especially when there is only a small interest in the feature.
>
> > Perhaps you can have a closer look at that series and see if it's
> > possible to update it?
>
> I don't think I have the skills to revive his work.

I see, maybe we should ping Al and other interested folkz to see if
there still is some interest to move this forward?

[...]

Kind regards
Uffe
