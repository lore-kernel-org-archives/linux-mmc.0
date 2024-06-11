Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82E14F9E4
	for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102616; cv=none; b=DkZx5BZuyAsTX2gXQMe2YVRnbPekRxB33Qj+cxZ56kgUpZnzdleJ+zrvWqCCumoDsL3ZT7ADISRXao6Nww+Iev3O+D6fsXHJROhqA8y3zChDaebgW2Lnn/upjA9Cp2LrkVZj0cnEqdujs+YOw6xva2+PHFfzNA1dO0AYjUU1cgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102616; c=relaxed/simple;
	bh=MGVPZT99C7czUylQoinKVYX89BF9iCjGD6vVH+sJD04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzgq4ggYpWojVdePL0E7wYNdqrxk6kUBVZHd1X79k4xTKWEq3C2aonZ++O/Kck5DyeDqUczdi9vXhX2RSY1Ta5lxAkEcPPnC7GRdrH7u8kFi8nKWkS+4+DOjyVRoIS3SXoT9J+2QPjQeZjFDAiS9+bw4Ph5grVWwmHS2AL0EeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbW5gedb; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbW5gedb"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48c54370c56so656962137.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2024 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718102613; x=1718707413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjJPPu+V3wPP4/Iy5VWY/CaPSv8B3HGHbuPTt5kcSF4=;
        b=nbW5gedbVxOc2VTtTsm/c+nP2S7GGY+A6WgVnz9jWZD95Zyqq5Cuw91Iwg1NMihuPg
         jyH3Pm07A9l7AfUcikRMN5hZyBnrhSl5Swt/j9cvn8PwKa1PvnbJVT2PAVukgDpVsD4b
         Edg3RBWBy6v31Nl+q5z8MkfJbovReXUK7gZqloVi/ZUk7RkD1Xvh9e8pWYbsiefSV7Gv
         KoholIQQJObsmyngTLSyFvMjLupqdsNsWsSqFtB7RB+VIXY57Yk3F6lcYjmHfB8pvcHy
         4IinojPmR/U21g6lgUzDN8jmGSb1N5aLT9jrxcPW+sijDm1t2jY78B25yfTcRoTQFGZU
         PVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102613; x=1718707413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjJPPu+V3wPP4/Iy5VWY/CaPSv8B3HGHbuPTt5kcSF4=;
        b=YrEawklkQI9y1d10uJoSGam1DIKHvMcB1UvBaEi25xl+9rqztGivn7vWpHUq+qbNz9
         eEaGBtpjJvwWXlLCQ3FmUxEDEWQo9K1609LGKKCoZkgLQJbIUMo5TtVG+qthj6+qXgM6
         6Q6O0mNMNYWxG/mXO7qbzpHCp+XyJmXWpafkLDnt64AH6NgkXiQ5WvM1drOLQFsrcnRP
         siAYkqRlZ4iLM6tlMWE997x+n6evehh5qjeFUm4KhRSAQsLDf7GzP+IBuUEFRLlrqIwa
         QFAT3xzYRljKCIvd9GlTXf8OHHZaQshSP2CznOOHHE9rp9qTQHK1WwR3UDHmlECt4F2Y
         a9nA==
X-Forwarded-Encrypted: i=1; AJvYcCWOmJkGXu0+R8Sna8bJvXJGdnQyXVXTxgh2d7kVarnE+rrSLkTPvunEGNi9VcBaqG8kICSxsS2ueUI7DxnIesWuChcoAPmLRAAp
X-Gm-Message-State: AOJu0YzWu4FQUcf2pg3mZonfkeWcyQXt7KRmqh2I0cVaoayEgOvw9i+f
	DRxOmt8/cpmMZMHaFSes2XuIgS+4uIOMHZhOl8nKq5OSQRbA8tty0PMOfJQ2Dkd2jmv2llIgf+o
	816k8RboHb77E0CeMT1MVP2zvVYBHAe2E+RzskA==
X-Google-Smtp-Source: AGHT+IFpr23aYuAqSidt1J8SNJdOcXSGq4NhSt3mf8LKhmevYSl9NpAPajnw1ksyeFGk4/eT2fWADV1msYIaZ9C0Gss=
X-Received: by 2002:a67:f851:0:b0:48c:3b13:7ff5 with SMTP id
 ada2fe7eead31-48c3b138113mr8743658137.22.1718102612732; Tue, 11 Jun 2024
 03:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <Zl2Ibey9Qck-VLWE@manut.de>
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com> <Zme-NMa3Bvp2h7aL@nuoska>
In-Reply-To: <Zme-NMa3Bvp2h7aL@nuoska>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 11 Jun 2024 16:13:21 +0530
Message-ID: <CAFA6WYPYSfrDtnLPRs7_0h5Hf01oPfOpqmt4c7_Twxv-re87xQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Manuel Traut <manut@mecka.net>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 at 08:32, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> > Hi Manuel,
> >
> > On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.net> =
wrote:
> > >
> > > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/arm_ffa.h>
> > > >  #include <linux/errno.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *=
ffa_dev)
> > > >       optee->ffa.bottom_half_value =3D U32_MAX;
> > > >       optee->rpc_param_count =3D rpc_param_count;
> > > >
> > > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > > +             optee->in_kernel_rpmb_routing =3D true;
> > >
> > > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the mo=
ment.
> > > If I remove this check here, the series works for me.
> >
> > You're right, I missed pushing those flags to optee_os. I've pushed the=
m now.
>
> Thanks! Tested with optee 4.1 and your patches from
> https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
> in Trusted Substrate uefi firmware
> ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
> and this series and a bunch of dependencies backported to
> our Trusted Reference Stack
> ( https://trs.readthedocs.io/en/latest/ )
> 6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
> the optee side fTPM TA device used to create an encrypted rootfs with
> systemd. Kernel side RPMB routing is in use and works for the TPM use cas=
es.
>

Glad to see that you can get fTPM to work without tee-supplicant after
this patch-set.

> Full boot and test log (with unrelated test failures)
> https://ledge.validation.linaro.org/scheduler/job/88692
>
> root@trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
> ...
> kernel

So coming back to the real question, do we really need this new
rpmb_routing_model ABI? Did systemd still need it with no
tee-supplicant dependency? IMHO, a user-space ABI requires use-case
justification otherwise it's just going to add on maintenance burden.

-Sumit

>
> Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> Cheers,
>
> -Mikko
