Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB29156F25
	for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888656; cv=none; b=IIM7+LRV9uUpbGmnkmkFkMROW84FtCDRc6GmJHCrtEV3+IEcHAzgBrata2HVH/+MmvvsDlcKkIfbXHwzTBXSPbtUVUplA4q2QG5g8VkXLVLo4xlPiKkP6oNM5VRjqW/btWEyZQ2HQPcaBtC6ER2OINlFeD858mY05FbqM5CwemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888656; c=relaxed/simple;
	bh=WJRxDDCwe1r+cGN/5oFq52lRYe30ytOZkfrkgk8TaSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWQ8bYOGuQfxOOPeLckTXle8rw1h0Ma4jj2Dta/IU1xOabi5kckCHQwxcthxZ6DbND1sVXL05/3vpn0X2JmotO9cfJLjBK6MkVz3FF8qTxmXs4PA0B0VLMievdOH7zm0STAOjGfjSUbmUg38WHkQWybcrWzNFpJSJB6Kfx6sMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bI+RCWed; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bI+RCWed"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e974862b00so5865231fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716888651; x=1717493451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GeDX4IQwDQDJtjpBLNQxj6g39RMuIlmmyZG0b2JVKEk=;
        b=bI+RCWedZ6Z4aMYP0UPcfht6AO+6RM0+rLwfvUBTdcXgtfOsz44PYrdab1QFDFif3c
         qmF/er95pbh9DT4G1eFt/BXIwcPXnCtgxyiUV0DoLwCRkC6KShx0lpItw1MPBPXKCKrm
         CAVlkWZZC9OP4hzZP6LQHrDwT+JeVSmg+LpLo2fOCvuhAKjlcekxiKGi1uqPMhb3QkXZ
         tqV5iP6e8hpOnpDBdYcGKcNTI8/oBLQ8iGC8twqFUix+zDsuFj+h2xrvNjlniAAZqknc
         RkFZ1jmtWZNeIJCd0xV/dYg8+axs+AaDzAJ9xtB8Tl6DfG6DupBGbpQ4YY1jeI7OyDJe
         PyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888651; x=1717493451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeDX4IQwDQDJtjpBLNQxj6g39RMuIlmmyZG0b2JVKEk=;
        b=RduIBLJUhgzglt8zDsv2s/fomhXItSnXgA5mPnZrGm1P2Job8GRvFL6TD6zPY9z+9O
         vJuqItDwF7Brf/Sz3DSHtCwmX1AeFDfwlezcYn1upeoYrF24sWhHT/VFhAtNDWuWh9fG
         Mg/9JcnD+8RUF55Vj9wT50+dmWvKTESP5ylly2FheGfTKxFFMqiMlgGWLhNbYix/OB8F
         gC1EI6GumdgAyv/wqyLjBICSKmcHI7YlWXbM+IuNldRqms1l/XOW9DAkYpZiOhrckzZh
         EUMGm9pHyzUPV7L9VQYQG5XNryudjciMtcaogQEOzo8RkE5/ldmFIxHXCctwzhSwIITQ
         MUQw==
X-Forwarded-Encrypted: i=1; AJvYcCXytqZcKy9dGBAT0JvO9+uiZRBSszz57NtkUe9KTKBmr4Y+2//reZvzUGcYhB2mBCNVq3sEoYUXb0gIDm+NSlhhrdqpS261jMjx
X-Gm-Message-State: AOJu0YyN59kUUrh/nv7gUtk5wnpzuy0VGphIrAo/vXOVUhQawWPSvPwC
	h60HwgJXCa9PoyfJ5bdmE++5Vh6N60f4Aw1NG8UPdGWpBbytCsJyx2pStO1PqhE=
X-Google-Smtp-Source: AGHT+IHgzrfQ9MC+g0Udj5wPSqEf953Emf/p5rF/Qi5duSrqYkyswcPhNyw1oK3vTXXcoPztAfiN4w==
X-Received: by 2002:a2e:780a:0:b0:2e9:81f0:8597 with SMTP id 38308e7fff4ca-2e981f0868fmr21754631fa.43.1716888651391;
        Tue, 28 May 2024 02:30:51 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcca242sm22159681fa.12.2024.05.28.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:30:50 -0700 (PDT)
Date: Tue, 28 May 2024 12:30:48 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <ZlWkSCCjJ2fbE2ML@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>

Hi,

On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > On 5/27/24 14:13, Jens Wiklander wrote:
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > frames via tee-supplicant in user space. A fallback mechanism is kept to
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
> > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
> > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
> > > new file mode 100644
> > > index 000000000000..c9144d16003e
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > @@ -0,0 +1,15 @@
> > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> >
> > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> 
> Doesn't the routing model concern tee-supplicant more than a TEE
> client? Then it might make more sense to have
> /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> devices representing the same internal struct optee makes it easier to
> find. Anyway, I don't mind removing one. Mikko, what do you prefer?

As simple as possible. A single sysfs file is enough. Even the existence of the sysfs file
could be the needed indicator for userspace to queue tee-supplicant startup.

Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
currently requires tee-supplicant to be started. Detecting the existence of TPM before
kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.

In userspace and systemd it's just important to know that service need to wait for a TPM2
device to appear in early initrd and when can things be postponed to main rootfs and later
stages. Kernel and udev will bring up the device then once discovered.
Knowledge about the RPMB backend is important when something like TPM2 device
depends on it.

Hope this helps,

-Mikko
