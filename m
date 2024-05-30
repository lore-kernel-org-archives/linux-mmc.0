Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D0176AD4;
	Thu, 30 May 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054547; cv=none; b=CafBAFKmCTMaRTLAYthw/SjvnMCMqnsWkNTvpj/tqLhjBROUh8/7lECXGWbakywWCdexAhNalEyugKAuUCUz5easEJQNprwY/KJ6eqqtVXpej0HR4PrWA01UTJo6PTsJ6nUemBoLZeyauDRWSU91upQ7yzuf+jZG7RCRUPlGuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054547; c=relaxed/simple;
	bh=qmrd9r2vsNDHYtSP6NNXhKeIjxw8FMvpIGgiZjUpdlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwL6zN5NJxkxZIrTbjXacuqLOf9PDPD6JQRWl+e95erN+/R/xTpMP/opakEQ5tRnsT8aCWzVpPxusmMP+lX11PHPFcostz6pWNOfd7kX0HUzl92dpRsuSadAygmo1+4q9WgYuAGxzCONlukS8WmUV2R6InznPl36hx+IUTACWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=HBmI0Pfo reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="HBmI0Pfo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1717054542; bh=qmrd9r2vsNDHYtSP6NNXhKeIjxw8FMvpIGgiZjUpdlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBmI0PfowWAQPbx6cZpE/gPD/kud5y6pBDadZiVuGqHMfEgJYOGBQkFyY2iQTjwFH
	 77p/pcKRkXnshTGTulOJBXBausGKWMpcmwepg268LykyDVifNCEE6ubFsIdKByLsPQ
	 pKgxBxrPhFnR3zkDrQ5ddb7mVK2J6ePFdgvTJ1OmwFaLFlQW0w4PLd//yTjqhpGtmC
	 9sdhhkQRm4zbGOaSL59oh47i1UInHPKMJZE+ADIObEd2s70Mr1ZFWxg+wMoJRWYcZa
	 oBhECABCrbBEBoZJnvqqb7l1xO5WKUweo/1pmw94Xv/0qMDuSE2BSLF6GEBvQSU0Zw
	 qiTAS2y77VYyw==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 2A51650BE4B;
	Thu, 30 May 2024 09:35:40 +0200 (CEST)
Date: Thu, 30 May 2024 09:35:10 +0200
From: Manuel Traut <manut@mecka.net>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
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
Message-ID: <ZlgsLibqO59kNQUE@mecka.net>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
 <ZlWkSCCjJ2fbE2ML@nuoska>
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
 <ZlbUwI0G3HGvioNm@nuoska>
 <Zlb3fuqvQIO9ghQX@manut.de>
 <Zlc7B6khuhGZ6QOZ@nuoska>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlc7B6khuhGZ6QOZ@nuoska>

Hi Mikko,

On Wed, May 29, 2024 at 05:26:15PM +0300, Mikko Rapeli wrote:
> Hi,
> 
> On Wed, May 29, 2024 at 11:38:06AM +0200, Manuel Traut wrote:
> > Hi Mikko,
> > 
> > On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> > > On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > > > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> > > > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > > > On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> > > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > > Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
> > > > > currently requires tee-supplicant to be started. Detecting the existence of TPM before
> > > > > kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
> > > > > or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.
> > > > 
> > > > One thing I am trying to find an answer about is why do we need to
> > > > defer tee-supplicant launch if it's bundled into initrd? Once you
> > > > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > > > As per your example below, the motivation here seems to be the TPM2
> > > > device dependent on RPMB backend but what if other future systemd
> > > > services come up and depend on other services offered by
> > > > tee-supplicant?
> > > 
> > > There is an annoying depedency between firmware side optee and TAs, and kernel optee driver,
> > > tee-supplicant in userspace and kernel TA drivers like fTPM.
> > > 
> > > Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB, RPC etc.
> > > 
> > > This patch series is adding kernel side support for RPMB handling so that the dependency to
> > > tee-supplicant in userspace can be removed. For fTPM use case, there is still the optee RPC
> > > buffer setup which currently requires tee-supplicant in userspace or fTPM TA will panic.
> > > 
> > > So yes, currently, tee-supplicant must be started. But it would be great if kernel drivers
> > > and firmware optee trusted applications would not depend on tee-supplicant running in userspace.
> > > The startup sequence is really tricky to get right. My fTPM use case is using the TPM device
> > > to encrypt rootfs and thus all SW components including tee-supplicant need to run early in
> > > initramfs. Currently also switch from initramfs to main rootfs requires unloading
> > > fTPM kernel driver and stopping tee-supplicant in initrd, and then starting tee-supplicant
> > > and loading fTPM kernel driver from main rootfs. udev and automatic module loading for
> > > fTPM can not be used due to the tee-supplicant userspace dependency.
> > 
> > I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
> > implemented in u-boot so it can already write PCR registers.
> 
> Is build in TA same as early TA? I presume so.

Indeed.. sorry for using the wrong term.

> > With this series and the required changes in OP-TEE and a compiled in fTPM
> > kernel driver and systemd v256 it is possible to use the fTPM in the initrd
> > without tee-supplicant.
> > 
> > Maybe this information is helpful to you, regards
> 
> This is very interesting and I'm trying to get to the same state, though with
> fTPM kernel driver as module. With v6 of this patch set and matching optee changes
> I was not able to make this work as fTPM TA was crashing when loading ftpm kernel driver
> due to failing RPC allocation, which tee-supplicant was setting up in the whole chain.
> I'll try to get v7 patches working and test this again on my yocto based setup and kernel 6.6.y.

I'll try today also with v7 and 6.10-rc1 on an i.MX8MM. It should also
work with fTPM as kernel module if you use systemd in the initrd
with the new tpm.target in systemd v256.

Regards
Manuel
