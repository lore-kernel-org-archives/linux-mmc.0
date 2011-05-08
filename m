From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Sun, 8 May 2011 17:09:34 +0200
Message-ID: <201105081709.34416.arnd@arndb.de>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com> <BANLkTi=omboE=fh16KSAa__JyG=hARmw=A@mail.gmail.com> <BANLkTimrN_T-nGws6T6baLPV+sWtFYC6Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58681 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab1EHPJl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 11:09:41 -0400
In-Reply-To: <BANLkTimrN_T-nGws6T6baLPV+sWtFYC6Bw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On Saturday 07 May 2011, Per Forlin wrote:
> > The mmc queue never runs empty until end of transfer.. The requests
> > are 128 blocks (64k limit set in mmc host driver) compared to 256
> > blocks before. This will not improve performance much since the
> > transfer now are smaller than before. The latency is minimal but
> > instead there extra number of transfer cause more mmc cmd overhead.
> > I added prints to print the wait time in lock_page_killable too.
> > I wonder if I can achieve a none empty mmc block queue without
> > compromising the mmc host driver performance.
> >
> There is actually a performance increase from 16.5 MB/s to 18.4 MB/s
> when lowering the max_req_size to 64k.
> I run a dd test on a pandaboard using 2.6.39-rc5 kernel.

I've noticed with a number of cards that using 64k writes is faster
than any other size. What I could not figure out yet is whether this
is a common hardware optimization for MS Windows (which always uses
64K I/O when it can), or if it's a software effect and we can actually
make it go faster with Linux by tuning for other sizes.

	Arnd
