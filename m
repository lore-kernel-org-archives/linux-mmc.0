Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF01898E6
	for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553736; cv=none; b=UlXqX5wGhb0LtPUnFLKrd62X5pqpVT9vnR7p4M/FDaB2DBV6YZVd2Bd2G651ATSBTnftEaahJLcaefkhRnNqlx/NGuSdoZrZuzJKG5CrYU52nu1Q6bzCHZ2RjucCIbjSz9ehjFX1BTHiXbF8P4mtn99snUHWpR0SZNZgRtPEPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553736; c=relaxed/simple;
	bh=sMt3LKrmOc719vezuHf1VRSZGs6/0CM5RTgHCegvxJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2m5vmR9QYHHLQvPqUbVEzVAYgNJ+HzPSqdr4NDIenmUT3FpJPwn4kmQKzUSuh1HBNMvPa0lbcVSByA+ollnkS5bJauVRMW6g8s/kvSN0tuRrZxeX6kyQp41oYsOzntmLPStkNpDjMehFH/5tZHyjNm6hxxP0PVI/bopYcoq/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jk0NiueA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jk0NiueA"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db23a60850so3942595b6e.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723553733; x=1724158533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9lL9WqMnQjQOnekmoitnaUPmKnczN9wyi/i7ULYQYg=;
        b=Jk0NiueAgOmCccw31t7IEAdesukY4PkAPfSXMR64Yww79AlS01wIVbCfYlF2ZJYuZ0
         O0kKbpLIngyGuuVQGgax8W/NSiT1OUQ22XkbxqzV2LRlQNmwCCUtKvQENj///hvq4x3t
         knEw3wlzqRyejfhpIU8wGzHcXETqUsTEn07diIntUxnjjlwD73Gl7d8v8UdYOyBJrIvC
         JWpxgk2T3AVWGv0JxHAkYaeV1GiApLP+m5Ru+vm0XYPthUBesvSN2TqDFIbp98Nry0IV
         UbBIxj7VxcNTGCpylcIg1Wqcyo/AvlcG2onG90xzz4ZTb+WqbkjB8xsHRzMCL1wtwV/8
         9wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553733; x=1724158533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9lL9WqMnQjQOnekmoitnaUPmKnczN9wyi/i7ULYQYg=;
        b=bad2k2ju7/tMPphKikQmcC/8PBtWjyORE8TteLUdTo51plnfv27iGS2hUbwwXPyax8
         LBciEixZffqKI3SUwLLgknn7M44RUESwcwtTnQzTjQai0vPBB1VUr6i/SOZiQfVB1VSC
         O9Xo9FmJLFbvLNqoZd656L4+nwhFvQcPrm3451y+DE51Tj2p/7FsMs7Yt3HcqvS+2ZIG
         O/01sUVRXU8BM4SUdBsrxnx6KZbtYMvZ34joFf7OhJ3K1KJKLQiQ5Rzzat2IxAFdlnGV
         FeOFk6gbOMxJbzQD1QVgspcv1PbrBPJyd4IWX3QJx1447n3lFsHzvrDGKm+dK0iGXhx5
         D04Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt4UU9o7B1JsOIA5vOlj5+IVktsyqEjE0hCM52BtZlEfEetdSS4LEN3SKOCMr4rUBXITi72YT4AL6OBKXDIRfCu0pegPsKeENE
X-Gm-Message-State: AOJu0Yyewmhg62lVbHcUAECxgU22rKx54GUEXxvzBZT7XXga57k/8VEn
	l9NrY0gXNPWVaAsTcORoXOws8ZGlidnGZElWrFx61O9pJ6pn8no+jzYKPSdxDS8SykNo41tCkeG
	Yo3E8Hx9zPeFDvEvdIlw7hvVshb1J8scHUnCdcQ==
X-Google-Smtp-Source: AGHT+IGhHMdletYoHKrkd+skKgfq/oIS8lvXHTlw104CPOGIvKJHMCnK3QFi+TRfuGbaCQhpYcAlIR0gdw66CwaIbsA=
X-Received: by 2002:a05:6870:32d3:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-26fcb8928e7mr4027118fac.42.1723553733587; Tue, 13 Aug 2024
 05:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-4-jens.wiklander@linaro.org> <CAFA6WYNwsgLD4bYRbPPG4MqshP8cmvZ5YdvgnX6Zsoeez8b-bw@mail.gmail.com>
In-Reply-To: <CAFA6WYNwsgLD4bYRbPPG4MqshP8cmvZ5YdvgnX6Zsoeez8b-bw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 13 Aug 2024 14:55:21 +0200
Message-ID: <CAHUa44G6JHLyUCd=ZAaDY=jjsKJWFiQJ=r7u9kEKK4L8crHqrA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] tee: add tee_device_set_dev_groups()
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Tue, Aug 13, 2024 at 1:40=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Jens,
>
> On Mon, 12 Aug 2024 at 19:01, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Add tee_device_set_dev_groups() to TEE drivers to supply driver specifi=
c
> > attribute groups. The class specific attributes are from now on added
> > via the tee_class, which currently only consist of implementation_id.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/misc/rpmb-core.c | 155 +++++++++++++++++++--------------------
>
> These changes don't seem to belong to this patch but rather patch #1.
>
> >  drivers/tee/tee_core.c   |  19 +++--
>
> >  include/linux/rpmb.h     |  53 +++++--------
>
> Ditto here.

Ouch, thanks for noticing this. I'll fix it in the next version.

Cheers,
Jens
