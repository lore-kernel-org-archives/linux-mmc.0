Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7C13CFAF
	for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887315; cv=none; b=Dz5zp4TaP17PtjC0lnSiPPEyLxF4InSo+CK6rav/Aa+zEgnyo2jeHx7IW5m3B1il1JIwvW1z6izuMdGfVQuVLm6ngKl692g4ksWsWtTT97lMjANEINDVURqiwNNmmkOie7zq1614Ud9L6MaxSAxXgvn2caRna74DF6yE0CDqxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887315; c=relaxed/simple;
	bh=ntOVcrm0U2ktplnaHFH3LL9yRcNdoXc5wQu4I+sJCvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeDOra6jV8kGNPXqEvGC4n62LNdB8fmi/DOfQa6R1Uu3Q6bZOQOtc5NxwhzRUTneM2ibWG1xESME3NJX8FUMVk7Jc+0ur8X4eqs1cQ+GELzR4NdvYPRGAUbEtUzCYZnlQ8sBLw+VkCazvVSmHt9lQ77rIY7RS12Takbb7/sPAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eqW1abJD; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqW1abJD"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b52b0d0dfeso240332eaf.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716887313; x=1717492113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW6Z82a5eWQhMt5GNGN6HAPnjLOfnWk1Amc7xa31Bv8=;
        b=eqW1abJDeLNrfODLXcUJPj87IuuUuIbvr24/JgPw5aUu6BZY8rnv3QAk5JIp415W6n
         tZmjPCPBktGJjeUkwTRuKSExMlNO6XZzY4Z4Z/piatQX+7FOFyeCMlYw3TES5rZaB9SJ
         V0u/HZwLKLfPWWzJvovcxyTWCkgvP55LLu9jpG7TW0XRZNf9gD0blBhUwvdOFc+5iC10
         o5zolGxXrI1YdRJ/G4T2OwfQY1W2kLFwLvg4eMAoZNT1bBS/8qqmO5L5MkOuZwUPWnh2
         p4EbkuCZaRQL2280eEmn56ge1Xm2ztVIyGqtqUFXm7tso1YlPZWXBXuYJkOwrDoa6VIA
         naOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716887313; x=1717492113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW6Z82a5eWQhMt5GNGN6HAPnjLOfnWk1Amc7xa31Bv8=;
        b=Let+4sf/zWplJW4/cLAbZCfby3prTv/NLQsnOlTzajkb2fOa71JTYbZB22C0A2SxYm
         pEqFka0t7r8obZSd5iKi/iqfxIGILd/3nXeusv31+lf6nBWb1W8ZWid786OJB+DH9PCp
         XzSwbKvpuPODNEpdQ+vEYrcjM+e251RCv+aPj5+fdvQ+eB/QpHlVFHBqPf9YhyToJxr1
         5AH0yZnHaiRbFSxpb7GCKs43skOiBGkfgrhrulbkZSm+KjH7Utxhp8nUOnko7Bg/jeHN
         UyBqNTFmtCPXv6Wf1+2ctbO4dfzkKeHpSNnKNa6YAowNxFfREKtEfSddmt+UO25ngXn/
         PA8g==
X-Forwarded-Encrypted: i=1; AJvYcCVZw+VFu+Eygec5IGer1IkdJozTm3GsscGpfw9H+mLpAqKPu0AHExbQYrsbVyAk5XKyMT/8Zj9sOlragWixXCclXL34dnBSM2Am
X-Gm-Message-State: AOJu0Ywn5NuCfoeqkVrd2H2XHu8xGhK/L3BIwj7PgwY0rO8lm04jQHIp
	NIDetmvLb4vu8vQGUIf+y1ORVSmQEyPd26TVwc+h+Et/OaSnYxEURvsZLNZ8+ItajDzlKcG9Mkw
	++vJ5gQatGpyrB58nEOeGvyfzS47mBPsAanTVIQ==
X-Google-Smtp-Source: AGHT+IFAp6TOZgisS+XJm2eHn1foTWT5HiUGBVq7ZXHSreT7NsimNJS98IlLFyc9ohwb59PFjqVXf1l0OHO7/OVh1tY=
X-Received: by 2002:a05:6820:222a:b0:5b9:8a06:5451 with SMTP id
 006d021491bc7-5b98a0655c6mr7962705eaf.8.1716887313327; Tue, 28 May 2024
 02:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <CAFA6WYNF77WrpC6PPY4idM7XkObnrS9hDyyBJDsaLRLcqdH_9g@mail.gmail.com>
In-Reply-To: <CAFA6WYNF77WrpC6PPY4idM7XkObnrS9hDyyBJDsaLRLcqdH_9g@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 28 May 2024 11:08:21 +0200
Message-ID: <CAHUa44EFYwYU6LSGfv+2ym_pweDKbJzqQG0MfW=bqx5UGSnYSQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Mon, May 27, 2024 at 4:38=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Mon, 27 May 2024 at 17:44, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe an=
d
> > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > frames via tee-supplicant in user space. A fallback mechanism is kept t=
o
> > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > available.
> >
> > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > devices until one is found with the expected RPMB key already
> > programmed.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Tested-by: Manuel Traut <manut@mecka.net>
> > ---
> >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> >  MAINTAINERS                               |   1 +
> >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> >  drivers/tee/optee/device.c                |   7 +
> >  drivers/tee/optee/ffa_abi.c               |  14 ++
> >  drivers/tee/optee/optee_ffa.h             |   2 +
> >  drivers/tee/optee/optee_private.h         |  26 +++-
> >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> >  drivers/tee/optee/optee_smc.h             |   2 +
> >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
> >  drivers/tee/optee/smc_abi.c               |  14 ++
> >  11 files changed, 387 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/=
ABI/testing/sysfs-class-tee
> > new file mode 100644
> > index 000000000000..c9144d16003e
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > @@ -0,0 +1,15 @@
> > +What:          /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > +Date:          May 2024
> > +KernelVersion: 6.10
> > +Contact:        op-tee@lists.trustedfirmware.org
> > +Description:
> > +               RPMB frames can be routed to the RPMB device via the
> > +               user-space daemon tee-supplicant or the RPMB subsystem
> > +               in the kernel. The value "user" means that the driver
> > +               will route the RPMB frames via user space. Conversely,
> > +               "kernel" means that the frames are routed via the RPMB
> > +               subsystem without assistance from tee-supplicant. It
> > +               should be assumed that RPMB frames are routed via user
> > +               space if the variable is absent. The primary purpose
> > +               of this variable is to let systemd know whether
> > +               tee-supplicant is needed in the early boot with initram=
fs.
>
> Why do we need this if we already have [1] [2]? AFAICS, whichever
> devices like fTPM etc. systemd depends upon, it can be easily known
> via existing sysfs property.
>
> [1] https://docs.kernel.org/admin-guide/abi-testing.html?highlight=3Dopte=
e#abi-sys-bus-tee-devices-optee-ta-uuid-need-supplicant
> [2] Documentation/ABI/testing/sysfs-bus-optee-devices

The dependency is reversed. A TA depending on tee-supplicant will not
be loaded until tee-supplicant is ready. rpmb_routing_model is used as
one of the inputs to determine if tee-supplicant must be started early
or if it can wait until the real rootfs is available.

Thanks,
Jens
