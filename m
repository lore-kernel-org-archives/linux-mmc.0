Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4227190470
	for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548392; cv=none; b=bpyv/zJLyW0U7cA3QYAIWjTpx3un6d+Ym2wkJYFpWwOO5zZxWhbazKsMsfxpa15+qr9Z3zzn9NR0k0voaJWJ6IloaKJlKJRwPAS8Y4i+23SLO3fJAR/m+4o36ylIXqHiiru40O/a21h7ZRx5vw7UlVUCkosDHtPLhMnsJX+3+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548392; c=relaxed/simple;
	bh=FwpQPZaZownGys16tIIRTbTH5Pl+L3AghxOMJwhap/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUJgECCJSD2Y0aENorjdH9/wgjD3tMF1WZ2U7FepehKtjL1vaqoz6fqAG4+fU7ggJk95CyGJm4YTKh6EQOwfyqtil1YKqQDY7SKjqvyOSvKxpvYaLnTHfhNJTBbjUUQJu2mH2X1ZtL+tN/90WveefKQFRNkIB9b+bTnGiKKz7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q75QLfeg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q75QLfeg"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2689e7a941fso3597821fac.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723548390; x=1724153190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ42mAm0PGh+S/W22e7yYSDhvCDheJds0Y8DV5bgOPs=;
        b=Q75QLfegpDNfJsyNOWzdjpfcscVQ26Gq7NDttuBDkgCOB93ZFuMDQu1nM5F6MKVeb5
         p4NxmXjUs88r7jTdtPJGVslGe/vWdZrsnZ00Jh1hZscX2TStS0dCQJ6Cis5Twa2v4BX3
         ur/sCcW5HItptmitilPCiQ04A3dKazPXqxBtvzmlHunyVPfHPRVkB19gxC+YfRBfk9VH
         drz2HRIpOFDmMDCPH73Mc6+mPQ0dcGzRIAD4hnrzHw7RZy4SjyYtnOzV4GKYmJsFFIKk
         TKtyf2T6ZZHxP3quVBTFu1Q2aT7aQZ6hq/ul0CDELvLATtXsYeSU7H+9IyoqcjAmw9zP
         NpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723548390; x=1724153190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ42mAm0PGh+S/W22e7yYSDhvCDheJds0Y8DV5bgOPs=;
        b=gYTJPl9+QzNqp5k987LvF72eG7Vs5qI8GSmZXPd4hphD+oGP96MjyRn+Z0Y3KJC6XX
         M6zsWheJBi5BauzTY8s9qDjboUnYJkF5iKSU0nc6TtoWiloIuuU+JABRBA5VYliAmK9h
         zOig30wZmCg+aM8Dn5sP+nDX9/GONHdtbhK0IYvnLgoa29rt8F2kgv5KNK3o5J5dXzo8
         8TdlUHLSHZW+xpydqZ2gONHf/6tdYBT4+a41hv1Towf+lLoK9klWnr0RcPLhUdo/gbzD
         /UZku7gIT0hLHEL8klfWEX8jxbttv82MKVwatw2ijXeHUo04euQx1cIG92BCLcHMmLm7
         kPGw==
X-Forwarded-Encrypted: i=1; AJvYcCVUlSX7K+Tz3Pgbt+s8t2Okk+9r4APlITTMI6jjf5nZ/J3Gnfe6T5i/mV2cp1ezpGg3BUZ2ANcZwZLrm10Trz9OWQEQrm4U4IbB
X-Gm-Message-State: AOJu0Yy25HGvztUoDsCQBc+LB8DWY+VOjn3aPXoOplL5gqajzGwhAlJd
	PFrC12j4Ruu/6S4BlPXaJI483XMRONYJlr7w/Ys8IfI6EXIGZ1iO7JaZl/hvnY8jKfZ+l+NYn8z
	3OJ9EGwaok6RkybkY2CTRQxZIWmBBtVrYRjlwdA==
X-Google-Smtp-Source: AGHT+IG8gqm83e9g/rJZ3FO2MQeP4LHgHhY5VJivHLmApt8VoHwKszZd7wDHqUFg9IwoiA+PDtzW6UWv56TdB0upWYk=
X-Received: by 2002:a05:6870:8a23:b0:25e:1edb:5bcf with SMTP id
 586e51a60fabf-26fcb641ef2mr3532611fac.6.1723548389774; Tue, 13 Aug 2024
 04:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org> <2024081346-dutiful-stalemate-0e07@gregkh>
In-Reply-To: <2024081346-dutiful-stalemate-0e07@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 13 Aug 2024 13:26:18 +0200
Message-ID: <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Fine, but:
>
> > --- /dev/null
> > +++ b/include/linux/rpmb.h
> > @@ -0,0 +1,136 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
>
> Really?
>
> Why?  I need lots of documentation and a lawyer sign off for why this is
> a dual license for a file that is obviously only for internal Linux
> kernel stuff.

I'm sorry that was added via one of the patch sets before mine. I'll
revert to GPL-2.0 only.

Thanks,
Jens

>
> thanks,
>
> greg k-h
