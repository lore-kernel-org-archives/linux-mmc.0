Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACBEC2
	for <linux-mmc@vger.kernel.org>; Sat, 24 May 2025 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748057828; cv=none; b=ZIYJeDbcJpcwp51n+0SQHdjD1XXeMhdNAJhawg0fmSQFZLwmC3LGpouDcDJYld6lVugHZ1eiq2oJO5XjXDw300hMYrB+35youj/xr+NERtRNJZtR+nAZYLmEyjg5FlzFKrGQl5LWvFeFlAkwW7PBW/EX043yTUyP/sSqpwvKvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748057828; c=relaxed/simple;
	bh=HZUjP9DRLExC2MegUevOuNq5YTdWxx60XiFHjOgIso0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY9R9EXrllViGOVzlQcszTwfrr53IZHJUlAQzdz1Os4PvDtayF0+KWDIGQuSUh59OqH4nvpITpxU+oZYriNTf4Pv2NUB5d50TpnqQcCubCP71QvHzdOMXjl1BcFZdklbYGpNi5AGbwMoLB50TEhnDo1S84T1WquDfEohqXFyy5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTbSmGtb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTbSmGtb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so4966105e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2025 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748057825; x=1748662625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZUjP9DRLExC2MegUevOuNq5YTdWxx60XiFHjOgIso0=;
        b=YTbSmGtbS7Iz7Cb1TNK6/0131DEhmo6aKwWN1gqDE3Sc8kaI/nXQJ1SEpZ5vq6/7RQ
         CuHonFZW/+D2yYMoP/WXFaRNpub986sdfjr5T/Fbq7ePUaVeRr3wNfmGbiObpT2ry2zV
         NbNHXYRGqyy9zHLhdoHdJL5omUkFjLNIPJIDSj0TJJWwwQ39VehtRK6Y39P2D0iCVCcy
         vE3TTKLO+KwseNQNTZBe20tvAbTmTNYqE3i7SUd/wBYIcIFx4cmr/8KR6z2ATB+42hV8
         A6BQp7GOzJiC0EdIue5YpaMTWgpR3zmKCSjux+ecIbmWeQMc49rUOE2PrI209lBuqoug
         mYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748057825; x=1748662625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZUjP9DRLExC2MegUevOuNq5YTdWxx60XiFHjOgIso0=;
        b=QwyZ+nLwc/61L+KWZoEq7XM6YCWjtsY5xIyvTR87k9eVXbv94OiOGGOKvdOx7k2p/2
         cNRwtPyMpNZp+3TqA/Us4YRBT6usthwHQ/aI/fZ+Tbg2NcUKRWq1x0aV4gV+ardSeNnj
         jGZmJm8Hgti/s3SEC/PzXagYyLoiVWD1/2DYkGJTnQyhI6tNAzEiL92+cnUseMhtMk8T
         rJVXXSvqNJ+bwhoPrzNNJzWzlG3YMFpD+lq3QaoVMo9HpM7ru71lf4KZEt3N+dpCTJVO
         fG/pFw6RiAmY8sYpqFHv4FOCDjbZiDWg3AyzkUl2BeSyCCwGFvJa5WB/G/aVhH0PHwFZ
         RsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVFm/m+5JsGJ6j87xMORRzYxo+sJTVhcLkc2ZmV5UBLfh4Zr06ZPteUmhNCMIo+2KtwMp5JccZirQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV7/kbFyUicygKxTy5Mb2qH/xU8yeF20rnQGRncD9fDYawtK9
	1eTY/ZOVUbqUaUA4Ps2/MGlE8s3RYuhsCJOtaOY38cDX5F5e5vj8djtheKU12LrEDg5VOnhowvG
	lR4MJQT82o0ehhyqjclblzsShy/xVSBD/Ww==
X-Gm-Gg: ASbGncv33+vxgiiIupIzSzQWt43/hJRFW70I/zXLWraZLy3o5tDtDOAnK4kL7XX0Cmw
	jLL/s8bPFO7RkwuVH2sihGpUdyKUlvoV3QZTTMHyTinboeAhlH53+MLefYqo9gUvz2KkmSWCoR4
	NXyBiCxGDgaEOkALLW3O8ARiI/TGyvrLgx
X-Google-Smtp-Source: AGHT+IEXK3b1q1v3G2QV1+L7Oguque5944lnL/8BDSJE+mERRf2eU3QheyaJ2iHwkMt6Gy/M5SSYFodRnJqCoJrGcAU=
X-Received: by 2002:a17:907:6d0c:b0:ad5:3156:2c04 with SMTP id
 a640c23a62f3a-ad85b113991mr130029566b.25.1748057814659; Fri, 23 May 2025
 20:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510031945.1004129-1-git@thegavinli.com> <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
In-Reply-To: <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
From: Gavin Li <gfl3162@gmail.com>
Date: Fri, 23 May 2025 23:36:43 -0400
X-Gm-Features: AX0GCFvSXXIv8uNxbQqCY43CPxNbfkTEexuXRcgQi91Uk6SgW-m3UppWcgPcpzQ
Message-ID: <CA+GxvY4ByPW4HVJfww2v674f-y5kuqKmY=EB8mD5jnRcy+HmPg@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for
 card presence
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>, 
	linux-mmc@vger.kernel.org, Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 7:50=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> Moving this problem to userspace seems wrong to me. We should be able
> to do the right thing in the kernel.

Unfortunately, I don't have access to the datasheet for the RTS5179 or rela=
ted
chips. This is what I could do to get my own hardware working, and it doesn=
't
make sense to revert to polling mode for all users if the interrupt
mode detection
works and reduces power consumption.

> We should be able to detect if we are running the broken HW and in
> that case, set the flag based on that, right?

I don't know of a way to do so, especially since I don't have non-broken HW
in my possession. On my hardware, once the device enters autosuspend,
inserting a card does not trigger a wakeup. I'm hoping that there's a way t=
o
detect the broken HW via a hardware revision register or something similar.

Thanks,
Gavin
