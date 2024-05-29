Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42E33CFC;
	Wed, 29 May 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975497; cv=none; b=ibWB22FqfxNAvyUhe4PlqfONHkt5Ogmv9u1A5Eg1e6AusZnkqSt2EtS87D0/KLEl/zIZnLNY4LhvWiIJjOdGUkVZtXkh1XRnDbSyNF3UG6YNIQ0gM+71yoAMB3d99E+sx6v7SR4T5g2Ei8b68HMIMUXyIjub1rjbwjd+ZPeNNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975497; c=relaxed/simple;
	bh=t+NQR7JOcisqSyTIuHhXwptMXLRRcGVKKGvUmnuaQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7ANcDfFImX1Sa5FKs13GJMzfxDssDGrpUlrbv1ILr/KCMd2DPqEfJIXnBoMuc9XcRJRjmnOiEJv8+yj0mDTTAGARKZQdkIJiiQyySih6bkMStFL9kIBZnLxuyDtPeQRFkq/cFlCrp4QHScqSZF7OqYXxwv8UTk7Y8bH3rXqFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=none smtp.mailfrom=manut.de; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=nnHXk6+4 reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manut.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="nnHXk6+4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1716975486; bh=t+NQR7JOcisqSyTIuHhXwptMXLRRcGVKKGvUmnuaQ3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnHXk6+4jIfPypE13CpuQyuw5ZPGU7X9fw4pi7s3T40N3XMIHGCTSzseD2yT0pXyc
	 l54m3gG9GGIDTttXaFKWomH1jCFkfE3N1L1p93+HJPPdZcHP/vLv8lOvfXVikt9iUi
	 KDX/VMZ0uhvICNpm+Dq5pAkmwG3PwRdTitFF9aIEKKFJoShxLbsDw8tIarY+Bxp2m6
	 vtW1fc53KZlGnhOGH2GbSszYAb1tgNGVocGsy/Qrula++sTb1rBWe8HXPyIiFjCwTK
	 +iLMMn/S7RH7nnmJmWB3vNDo0gvYKOaG6ZVTiAwN6Vq+uCGJmeiZLxxlluac+O0Dq5
	 c2ArOze6Nr+Qw==
Received: by mecka.net (Postfix, from userid 1000)
	id B31E250B258; Wed, 29 May 2024 11:38:06 +0200 (CEST)
Date: Wed, 29 May 2024 11:38:06 +0200
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
Message-ID: <Zlb3fuqvQIO9ghQX@manut.de>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
 <ZlWkSCCjJ2fbE2ML@nuoska>
 <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
 <ZlbUwI0G3HGvioNm@nuoska>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlbUwI0G3HGvioNm@nuoska>

Hi Mikko,

On 10:09 Wed 29 May     , Mikko Rapeli wrote:
> On Wed, May 29, 2024 at 10:56:04AM +0530, Sumit Garg wrote:
> > On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> > > On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > > > On Mon, May 27, 2024 at 3:00 PM Jerome Forissier
> > > > <jerome.forissier@linaro.org> wrote:
> > > > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > Outside of these patches, I think the optee RPC setup with fTPM TA is one area which
> > > currently requires tee-supplicant to be started. Detecting the existence of TPM before
> > > kernel drivers are loaded is possible via the exported EFI logs from firmware to kernel
> > > or ACPI TPM2 table entry, and detecting optee and thus starting tee-supplicant in userspace too.
> > 
> > One thing I am trying to find an answer about is why do we need to
> > defer tee-supplicant launch if it's bundled into initrd? Once you
> > detect OP-TEE then tee-supplicant should be launched unconditionally.
> > As per your example below, the motivation here seems to be the TPM2
> > device dependent on RPMB backend but what if other future systemd
> > services come up and depend on other services offered by
> > tee-supplicant?
> 
> There is an annoying depedency between firmware side optee and TAs, and kernel optee driver,
> tee-supplicant in userspace and kernel TA drivers like fTPM.
> 
> Kernel fTPM driver and fTPM TA require tee-supplicant in userspace for RPMB, RPC etc.
> 
> This patch series is adding kernel side support for RPMB handling so that the dependency to
> tee-supplicant in userspace can be removed. For fTPM use case, there is still the optee RPC
> buffer setup which currently requires tee-supplicant in userspace or fTPM TA will panic.
> 
> So yes, currently, tee-supplicant must be started. But it would be great if kernel drivers
> and firmware optee trusted applications would not depend on tee-supplicant running in userspace.
> The startup sequence is really tricky to get right. My fTPM use case is using the TPM device
> to encrypt rootfs and thus all SW components including tee-supplicant need to run early in
> initramfs. Currently also switch from initramfs to main rootfs requires unloading
> fTPM kernel driver and stopping tee-supplicant in initrd, and then starting tee-supplicant
> and loading fTPM kernel driver from main rootfs. udev and automatic module loading for
> fTPM can not be used due to the tee-supplicant userspace dependency.

I decided to build fTPM as buildin-TA into OP-TEE. RPMB routing is already
implemented in u-boot so it can already write PCR registers.

With this series and the required changes in OP-TEE and a compiled in fTPM
kernel driver and systemd v256 it is possible to use the fTPM in the initrd
without tee-supplicant.

Maybe this information is helpful to you, regards
Manuel
