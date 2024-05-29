Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20B156F38
	for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992781; cv=none; b=Dpn1AuRZByTtrBliH+Mhqp4iL6RyWh5DSk0JI3FTWd7RyqSWlQNSgGdkbb+om5eb9cy8ch0sTVdQZV3FjBljetzhFs/ubwfLnSaKT5kr3rInXMm+bvmIHp0fyHTbpUgkljUtT00BVKnfgP8zPmPO/3AHQqtS+3tRiW45Eh7igvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992781; c=relaxed/simple;
	bh=QrLuus/ddYRG3g6S9T7cGvQgPirUyP0mDiK8KG3KEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Taeo9/mHbs+Geg+NvymCBabvPEBQrB5/NubCxwBImdTPtgnXpHQFkZTS5mVQwFA5WON2kB4LXC6wPnoiQtruYAgEnSF+Lj7HGlC7f2qmvgMyX4K0N4N7ectbvXwm4Dp2VaU9uLhlNDC4k+M1xVK5cqMtdtElFZo7VFDQ3W4pf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q2RqcFY0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2RqcFY0"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b03d66861so795165e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 May 2024 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716992778; x=1717597578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyxh5VplKpU4UfQh/55j1yOtR36kGic/9apRwO/97YQ=;
        b=Q2RqcFY0Z596jbOiVcxPZ2FNZBaTInpAA63uda9EpltpQy9pJhPXVNAUPHNYiuJD/3
         feuvtXS0GDxq9xisAfjw8wPa24ZVfTU4zahX434a8+CNc3GgE23BbTyJA7IIcrxS3jJb
         j8gsG0+2IFjAXSM8NBB6wIZ1qWAw2KHhSbkVedDxtx7G3fXWrkDn7nlArVVLZH+UT7i1
         /TUhgJP7HO30GPY8oq0y0gHtQsToxoyYG3o57TjklnCYN6cSrtNoB7MOEaWG7LN+m/tU
         H4HoSTYR9icVBfe3AQgQMmyxoEx8LC6sHTHCdqVKizk6IoWst///MZzpwje49MS1yA2A
         tmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992778; x=1717597578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyxh5VplKpU4UfQh/55j1yOtR36kGic/9apRwO/97YQ=;
        b=rASwCmbhNyQolOmrB4mE3yBMrXoSdVb9i0wd6mlOabcKBe18SBNGjwyB+ryvxVRfij
         uIlkTWoPdKIma1jGwVBWy+jaGPXhgbz38QQ5F5i/pWySpU4bEib/Oed3NtN6ZVl++bDe
         nXoXYJrltpBcCzUiaFjGtgyPY2el2h+yUzHO2YBDHTnNt2Ijw8vmeyY69rQnaygziL+P
         lhjt0cve6GY9W6eFeq+6EPILMFaYVBYJ2V91S19LjZt7pAH4/YDATDVRTs14Af6NILwC
         C9uPkO7BQkA/Fu6Th9YMEaEHAsrnKQa5ONIPuMdw3LqNWBrf4ppivpriN7x9NNXlKEha
         SqBw==
X-Forwarded-Encrypted: i=1; AJvYcCVIYzuBggiX1jn1ZIt9z265cL/39us2jssS4khCeiwnb1YR84TxNGT/03lnfrGoPkU1YB0HqblhbFKhjdsLyY5bKrFSyrG2YN6s
X-Gm-Message-State: AOJu0YxOrWWyfoOsRldhXZLGzuvl+a/ZAq1w/rI7Jl1WnFEzrUXZYv2G
	K3LzTdNBfU+gzjLSftM2muwYpAkgWqE+fIKWiCbLE5BR2HQ5q/mLJsM78RiCkL8=
X-Google-Smtp-Source: AGHT+IEZZrvin2LBIlhwXhgEBlMd/20NgKjTBRGvVraaT3pbscqdEf2xm1BFKbMiu8cRBQjYLMWuTw==
X-Received: by 2002:ac2:4902:0:b0:51f:128d:a6b0 with SMTP id 2adb3069b0e04-52964baf210mr8451827e87.26.1716992778098;
        Wed, 29 May 2024 07:26:18 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970d2a2f7sm1299522e87.227.2024.05.29.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:26:17 -0700 (PDT)
Date: Wed, 29 May 2024 17:26:15 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Manuel Traut <manut@mecka.net>
Cc: Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <Zlc7B6khuhGZ6QOZ@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
 <ZlWkSCCjJ2fbE2ML@nuoska>
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
 <ZlbUwI0G3HGvioNm@nuoska>
 <Zlb3fuqvQIO9ghQX@manut.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlb3fuqvQIO9ghQX@manut.de>

Hi,

On Wed, May 29, 2024 at 11:38:06AM +0200, Manuel Traut wrote:
> Hi Mikko,
> 
> On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
> > > > currently requires tee-supplicant to be started. Detecting the existence of TPM before
> > > > kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
> > > > or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.
> > > 
> > > One thing I am trying to find an answer about is why do we need to
> > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > > As per your example below, the motivation here seems to be the TPM2
> > > device dependent on RPMB backend but what if other future systemd
> > > services come up and depend on other services offered by
> > > tee-supplicant?
> > 
> > There is an annoying depedency between firmware side optee and TAs, and kernel optee driver,
> > tee-supplicant in userspace and kernel TA drivers like fTPM.
> > 
> > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB, RPC etc.
> > 
> > This patch series is adding kernel side support for RPMB handling so that the dependency to
> > tee-supplicant in userspace can be removed. For fTPM use case, there is still the optee RPC
> > buffer setup which currently requires tee-supplicant in userspace or fTPM TA will panic.
> > 
> > So yes, currently, tee-supplicant must be started. But it would be great if kernel drivers
> > and firmware optee trusted applications would not depend on tee-supplicant running in userspace.
> > The startup sequence is really tricky to get right. My fTPM use case is using the TPM device
> > to encrypt rootfs and thus all SW components including tee-supplicant need to run early in
> > initramfs. Currently also switch from initramfs to main rootfs requires unloading
> > fTPM kernel driver and stopping tee-supplicant in initrd, and then starting tee-supplicant
> > and loading fTPM kernel driver from main rootfs. udev and automatic module loading for
> > fTPM can not be used due to the tee-supplicant userspace dependency.
> 
> I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
> implemented in u-boot so it can already write PCR registers.

Is build in TA same as early TA? I presume so.

> With this series and the required changes in OP-TEE and a compiled in fTPM
> kernel driver and systemd v256 it is possible to use the fTPM in the initrd
> without tee-supplicant.
> 
> Maybe this information is helpful to you, regards

This is very interesting and I'm trying to get to the same state, though with
fTPM kernel driver as module. With v6 of this patch set and matching optee changes
I was not able to make this work as fTPM TA was crashing when loading ftpm kernel driver
due to failing RPC allocation, which tee-supplicant was setting up in the whole chain.
I'll try to get v7 patches working and test this again on my yocto based setup and kernel 6.6.y.

Cheers,

-Mikko
