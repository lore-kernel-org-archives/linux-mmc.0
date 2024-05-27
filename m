Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF715E5D4
	for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816256; cv=none; b=uc06cC3+Ch8Jd9KCGzhn6FKkR9j4W1ehbzGjDjYgXBtXm60YB+v/EJPDSNLdxSvn1pB6FHlwW/MRI+ooiRjw6zJ+lCvgsyjetCQZQk5HNdEuohdkuvqUD7Bfm57ipz6Fr+o0n2JzeLlEt+hqgiz8nsmCFd8m+qHkNIL4Z8JBroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816256; c=relaxed/simple;
	bh=BeMqoH5GvSpJ1d9avTl/slNkeZp+MwMFavChpJnITDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDFC4otrL3E4HhO2m0cFwqFpbpf6HVX+Cesfc6yAUt9sD4DUBkKhuOJeQ0m38PnaKoiXuZBzfStbRoDxz4uu49y3bBERMO/K4o2q+OtmWOHRPtGRW8K21nDdJPeBnulGdNaxKx8jg9nYiYaKWrI805I27LvgoO/4upLUuStjfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2ka2B0X; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2ka2B0X"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b277a61f6fso2110156eaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816254; x=1717421054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHrHZEEV9e4XfK4jWbKD94symQTEPPz3n5O2dV/Sklk=;
        b=T2ka2B0XNH2fbhlUlOYkda/4neCoJZnbbZitc6m2ZLtd/9pHRrwSP5AXzGL2pqiZui
         NStIEqWW+UKuI1tdydtCzwy4fGB/LxPUVEsk+6JfF3VYJLD4vj05k0oEorsOdMcgZoTw
         2KIX1pAoeedXHOiQE8ShwbF23Hg9JWNV4mKNoG9ebr6lEaM5OkbBjeYfN0vzb3Xxk3xY
         V2jBTzejhOXwz7F+sLI2OZP5uyQAdAezFdIdvJKzOGBcROpRxNQQepBXOLBHx4Ihg0wq
         +qezH8fip8RBP7wMT+psPhmgu98ERMHqU559NGw6y7xt2ZSi4Z+WHLGx5ZRybQxTiO3i
         S56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816254; x=1717421054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHrHZEEV9e4XfK4jWbKD94symQTEPPz3n5O2dV/Sklk=;
        b=CNY7nOgECyOyfLZtsfb004ghpzXFnnVkh4Fr1VtGuUuxnr/uNy4pl6eXMr9ixH5Xe9
         766XISmy5x42WsHFmaqCVxA18fe8b4Y919DpRMtCWl36l109GgovSTdW+aeQHLyzb/3+
         cR/eR9/DWh9QquR8gxGayCSaG85cpAtiXyaRxzgxL3t7LHzneHM/sTNhXnk6DU6jklo1
         bLYfoK+RekCA2vxYmZUpR0vRv/2FGWuZGueYMavJYRR9zLcqjQJMUCgxp9BMemMcJxAX
         n6wZsKrTZNl4WvBsu54r0NUG1XF9n7cke+fkr/18cOznUruSEgQsXt5xU0KwpRxGp2X2
         yoOw==
X-Forwarded-Encrypted: i=1; AJvYcCWovLvyR0GDBe1ObvCLB6Ukg0pMWkZUXYfGKG/oGNlpZGNn4BUn6X49Ad85cImO2B47b0ozQDgGDABYvfIYIvKVn/1OKnYeJTaf
X-Gm-Message-State: AOJu0YwSYlLDD0GuvOND5l7tA8lxObMjafMKjA3rzEIJ+VPOATxAea40
	uDOyvSqI4AGjj7zNmifAlGXxMf+skV7+FcN13VIqgFhCbRv721hrZ+25KWK5IBsNgujl837sT8U
	lGOj9iQ8DdIzi4esDTLC0VEt6gBZ1kPPJmAnt3Ys388cx7SL6sqAF0w==
X-Google-Smtp-Source: AGHT+IFJyq+AmvAn3DRrmHTUYcPq5TlAmpW0rWrghLQmgqDTzPzpoHnXo1PKce+wt5kaPQ1qmeH225azZTV6JbGWreY=
X-Received: by 2002:a05:6820:22aa:b0:5b9:89d9:c5ef with SMTP id
 006d021491bc7-5b989d9c96amr2849706eaf.0.1716816253777; Mon, 27 May 2024
 06:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
In-Reply-To: <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 May 2024 15:24:01 +0200
Message-ID: <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> On 5/27/24 14:13, Jens Wiklander wrote:
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
> > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
>
> Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?

Doesn't the routing model concern tee-supplicant more than a TEE
client? Then it might make more sense to have
/sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
devices representing the same internal struct optee makes it easier to
find. Anyway, I don't mind removing one. Mikko, what do you prefer?

Cheers,
Jens
