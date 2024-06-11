Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8841A84
	for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074943; cv=none; b=nkskQtnqMVyX/90ns29vUYwuy0/hyjyCM0DHp1ckjXrjWqqq9tuiwuITBoADgfaDhq6X5mCg6ihejFxnPyQKe+Emx40Scrhn3n++EGF62z3dj03ggdbvAHjzg6IjVl5hT9PQLFLkmCyj+LHDC4Lldbypae3wDXMkc6SdNMSfFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074943; c=relaxed/simple;
	bh=Wo+7MDPiRrHkJdKMQg5KqO5WMIaIBW2lHLx+wWqGzeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDKwk5LratDqWhBq+e36OvapL7mfio2XRk8Ta7q9MjZcMklcvaZYi4MCBMMQbSuEfxAOjc/lKgf4Ax99RQx/gnysIVT4+eiFez7XknQ5BGwS60te6RdPapTGLOvvloDNX9IWpJphw/bWAdTtTHBFTSbqe+lLkPfQ9s1QDys6gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZdaDO32E; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdaDO32E"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70421e78edcso563995b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718074941; x=1718679741; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MfZaz1wvKyeEU3aLE3EHOvoZTj6CAZMgWSBoZL5SrsI=;
        b=ZdaDO32E5pitJP0WsV8hxAfDgMkFrlwpYOR6bQa4XSPXweRFc5TsyYnrOIAh8z8ylY
         QzMm6L7Wo9Tgz6UTdb1juv5E5Jj7hAkj3lwKjBbvVsTKULXO73lnQpU7aKNAVpSmVwnF
         AoEJIhoiEbLyZCxmAQKNOrdHz9BV77O1AUJymhcxdTYA3YkS5tpyhTrtUTXTSLUBHy4E
         fVXDJRtXj8J8CmwP0UB14+iOdsNx2AVBltfkGR+mtgrNk2LyPPoElCdlfUTJuumChDqI
         y4Jq9R8MHCa8laVXnP8lX3i3C+d2wi6UBUu2WeIhCg6OD9GxGnHxigVjjSY4QRfJEXWf
         Qm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718074941; x=1718679741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfZaz1wvKyeEU3aLE3EHOvoZTj6CAZMgWSBoZL5SrsI=;
        b=smaOHhEuFV4znBsKL9wIuoEe6ZSGUefni4bQi8OTAweKczzvJ6D7Ck/tOO30pwriQ6
         xzWS994HDpbyuz2fJVnqRikcffjejIe1lQaejNzurrJFBbWKTpMcKVd2tqQvoqzXZ4ue
         kl+cPIEmecjQr68HqmbPjKZuKrHbYGsKPkafHYSCYeuENpJV+sWM4yialRaRCSWFISBr
         qBLzwYgMi2BrJoADbNVGSN22MVeLCYWzW8arRQXwXeBmFZbDk7ta3EuGjBoq7lePVyvy
         L2B6oCXXy7Y3VdNfW5z3VoMym+rkzJdDrlrdGfTpeuOsw7hYRQCz4QVuJhtFO7H7ZDgW
         +STA==
X-Forwarded-Encrypted: i=1; AJvYcCVxPT6mDKFhrG38dy1N7wTM7ztC4UcbOoiztXe2e5O9TUhf7GdpIBOuB7POHb8mo/qvksQPlOOgftCNhZLU3+NQ0Phxhel34zRD
X-Gm-Message-State: AOJu0YyDXutHQWLciDzu6322D0iDsNS00WepzwB/4NVtAZdNS5JPtdMa
	xxuwI+K6hfNsJCHyttyTZXCBiCZRCsUHHeHxfntTsEwsErH7eWFksI8AMLKVXa0=
X-Google-Smtp-Source: AGHT+IGwgxxR31tiVauz1yF4f5ElLFjhij1x+Y0kGvJ2MAmRnFfI29tH+aI/3fypGL7nKGytkMfLDg==
X-Received: by 2002:a05:6a00:130d:b0:6ed:21c0:986c with SMTP id d2e1a72fcca58-7040c73c48fmr14920568b3a.24.1718074940694;
        Mon, 10 Jun 2024 20:02:20 -0700 (PDT)
Received: from nuoska ([2405:6580:800:9800:b841:9d1f:6a68:11b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70427eb9f16sm4484421b3a.163.2024.06.10.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 20:02:19 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:02:12 +0900
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Manuel Traut <manut@mecka.net>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <Zme-NMa3Bvp2h7aL@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <Zl2Ibey9Qck-VLWE@manut.de>
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>

Hi,

On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> Hi Manuel,
> 
> On Mon, Jun 3, 2024 at 11:10 AM Manuel Traut <manut@mecka.net> wrote:
> >
> > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <linux/arm_ffa.h>
> > >  #include <linux/errno.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/slab.h>
> > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > >       optee->ffa.bottom_half_value = U32_MAX;
> > >       optee->rpc_param_count = rpc_param_count;
> > >
> > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > +             optee->in_kernel_rpmb_routing = true;
> >
> > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment.
> > If I remove this check here, the series works for me.
> 
> You're right, I missed pushing those flags to optee_os. I've pushed them now.

Thanks! Tested with optee 4.1 and your patches from
https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
in Trusted Substrate uefi firmware
( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
and this series and a bunch of dependencies backported to
our Trusted Reference Stack
( https://trs.readthedocs.io/en/latest/ )
6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
the optee side fTPM TA device used to create an encrypted rootfs with
systemd. Kernel side RPMB routing is in use and works for the TPM use cases.

Full boot and test log (with unrelated test failures)
https://ledge.validation.linaro.org/scheduler/job/88692

root@trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
...
kernel

Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Cheers,

-Mikko
