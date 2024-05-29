Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8715B567
	for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716959113; cv=none; b=b5xT2O0bN/wpWgtxZcKnYqPgtxxvYldU20/5pFJUt93xSWxd6FmZ04faDZeAdQVHe8KOH9WR1/oG1DZSdc+0KITM3jKSn0x6SwzXbjjWXwv6BDDYARGaXxJNL6ip/1iQkZ175dxrSkfpAP1f3ltlvVgN8aRj+HoXToUaHjBo9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716959113; c=relaxed/simple;
	bh=edYATESJWmsjM0xhVxjlpyLFJN2AzhjUneUPftzfzJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqBvKHZhBnZG3oX0LOqqq9RWb1DFNlUHn+VSh78JfHckjExrMDFcoTeP9qXg630VqXNA9tZKq/xUAcy2O+i5ReHfAuzIu/+bveKC5FQdXMFHuM9oLrGPClOdbPIF8b7uVlPLBqlgK+cwx01u3E/Lv1ink+GJ5hCsRTxGlYCtwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3N7tETX; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3N7tETX"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48a39e3923fso543399137.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 22:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716959110; x=1717563910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKmbUeAYX99Z/W8wHYS7l713oDOhasoyW6w2BmqBmx0=;
        b=g3N7tETX30wucCzrKJCbJQwD0P4Et0XZsSMwojoks6QDeGnhSOsgI/TsBhBlkC4cVp
         mh+6oyk0yKTtKYcbAjgZhXXr3hyV2t3j5kXCxiTkEBeiuXP40F2F/UEUG8H5UlbCTv07
         GYev2HnnZKcSCXf+KkUUIeB5JKB34ibcM8OgMvL3mLubkh1GCI9XqtIL2kQTSoIh0Bpm
         l67QDaLa7cz1oOQ21/knagatgBEyRat1wEEApNSRd1nV5lcePv3VoZtjiB+A5R2YuM2C
         vfHnahrJar7RGs3fLZJtXUGjWybU4tJbFuz9zo8rksaql4MN+XMNCkYXlrUqjNMMAjoK
         yhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716959110; x=1717563910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKmbUeAYX99Z/W8wHYS7l713oDOhasoyW6w2BmqBmx0=;
        b=p4nID5fC9CJCkixn3cWYwBgS4AtEJMEhp3UeLmkBtBLMf9IOrak/92KaBfdh/X9b52
         8Ewz0YBpEZ0FXCtHzLj3rGLLRtEs47z8DAyd6UwcE9qg2D1GoDV7c9qnOB6rrPGgSx2K
         VWEcGgppiuMh+27hVInqPX2jyuYSz7l6W4cYHVLOlIdcdxfGyHth4jMW3LUc5vwTDqj8
         NLGm1EihhTBGczmzLzjYB1Hk1Uorakzp1W6Kz8qqgO3czTRqDWVBsrU5GAug3iUgTn7k
         oHxIRy+dxZHp53u5qAHcqR3GLrNZhN0gESyIp8C1MZQbUMFGT2ZG3v3KY5Cs+c788y20
         I0vA==
X-Forwarded-Encrypted: i=1; AJvYcCU6LHvJhhoVwdQrA1kDhQK5XQBG5B6TkJigjXkLsQ1lOQ6MMLTq2mAfFFmoViVCxThTwRuKizho6B39eLNMpTfBX3ISk6zD5TkF
X-Gm-Message-State: AOJu0YxUlPSMvpdqOrnypObLTw/LUL1DBP7HCxluPFiwBT9aszpIGgPS
	DlDFBBHHFodxo7UplpoExnzdXOymu3wf4R1QCDEeczWxoZC3PIcyFaqQQJfe4RI9f8u9k3B5wul
	9P4ehLoN4hjf3tgbhVBwQVDoAqSFsPzgqmyBDRA==
X-Google-Smtp-Source: AGHT+IGLmzof1jZ4cDRooqbgTFk+QfXjN2BKW7YXz8qJTEkMgr7Y2s74VX0eUhStsUj7n1f+KqTK4cvVJU85NhMUGvw=
X-Received: by 2002:a05:6102:98:b0:47b:614e:cbd with SMTP id
 ada2fe7eead31-48a386d7d64mr12686870137.31.1716959110120; Tue, 28 May 2024
 22:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <CAFA6WYNF77WrpC6PPY4idM7XkObnrS9hDyyBJDsaLRLcqdH_9g@mail.gmail.com>
 <CAHUa44EFYwYU6LSGfv+2ym_pweDKbJzqQG0MfW=bqx5UGSnYSQ@mail.gmail.com>
In-Reply-To: <CAHUa44EFYwYU6LSGfv+2ym_pweDKbJzqQG0MfW=bqx5UGSnYSQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 10:34:58 +0530
Message-ID: <CAFA6WYMobtWMFjv11Gg5-bhU_Guf_R4tx35kwdK-aT4hjLfn0g@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 at 14:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Sumit,
>
> On Mon, May 27, 2024 at 4:38=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 27 May 2024 at 17:44, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe =
and
> > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > frames via tee-supplicant in user space. A fallback mechanism is kept=
 to
> > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > available.
> > >
> > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > devices until one is found with the expected RPMB key already
> > > programmed.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Tested-by: Manuel Traut <manut@mecka.net>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > >  MAINTAINERS                               |   1 +
> > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > >  drivers/tee/optee/device.c                |   7 +
> > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > >  drivers/tee/optee/optee_smc.h             |   2 +
> > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++=
++
> > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentatio=
n/ABI/testing/sysfs-class-tee
> > > new file mode 100644
> > > index 000000000000..c9144d16003e
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > @@ -0,0 +1,15 @@
> > > +What:          /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > > +Date:          May 2024
> > > +KernelVersion: 6.10
> > > +Contact:        op-tee@lists.trustedfirmware.org
> > > +Description:
> > > +               RPMB frames can be routed to the RPMB device via the
> > > +               user-space daemon tee-supplicant or the RPMB subsyste=
m
> > > +               in the kernel. The value "user" means that the driver
> > > +               will route the RPMB frames via user space. Conversely=
,
> > > +               "kernel" means that the frames are routed via the RPM=
B
> > > +               subsystem without assistance from tee-supplicant. It
> > > +               should be assumed that RPMB frames are routed via use=
r
> > > +               space if the variable is absent. The primary purpose
> > > +               of this variable is to let systemd know whether
> > > +               tee-supplicant is needed in the early boot with initr=
amfs.
> >
> > Why do we need this if we already have [1] [2]? AFAICS, whichever
> > devices like fTPM etc. systemd depends upon, it can be easily known
> > via existing sysfs property.
> >
> > [1] https://docs.kernel.org/admin-guide/abi-testing.html?highlight=3Dop=
tee#abi-sys-bus-tee-devices-optee-ta-uuid-need-supplicant
> > [2] Documentation/ABI/testing/sysfs-bus-optee-devices
>
> The dependency is reversed. A TA depending on tee-supplicant will not
> be loaded until tee-supplicant is ready. rpmb_routing_model is used as
> one of the inputs to determine if tee-supplicant must be started early
> or if it can wait until the real rootfs is available.
>

Okay but I am still not able to understand the reasoning as to why
tee-supplicant can't be started unconditionally. If it's available in
the initrd then systemd should be able to launch it unconditionally.
Or is there any dependency I am missing for the tee-supplicant to be
started? RPMB routing isn't the only service offered by tee-supplcant,
so gating it behind that for no real reason isn't making sense to me.

IOW, why do we need to defer starting tee-supplicant until the real
rootfs is available?

-Sumit
