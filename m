From: Simon Horman <horms@verge.net.au>
Subject: Re: [ulf.hansson-mmc:next 17/49] ERROR: "renesas_sdhi_remove"
 [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
Date: Tue, 30 May 2017 20:42:21 +0200
Message-ID: <20170530184219.GA12741@verge.net.au>
References: <201705300837.5KUEHiHI%fengguang.wu@intel.com>
 <CAPDyKFoK0Q0M7OFe69aYePb6tk3roEfxB+MuW7W+807WgKicxg@mail.gmail.com>
 <CAK8P3a1G2JdkWO=uKGfe9Af97Pn-s9DTL95HsEQ5PLEMm6B+0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:59260 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE3SmV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 May 2017 14:42:21 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a1G2JdkWO=uKGfe9Af97Pn-s9DTL95HsEQ5PLEMm6B+0A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa-dev@sang-engineering.com>, kbuild test robot <fengguang.wu@intel.com>

On Tue, May 30, 2017 at 11:55:08AM +0200, Arnd Bergmann wrote:
> On Tue, May 30, 2017 at 11:40 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > +Arnd
> >
> > On 30 May 2017 at 02:07, kbuild test robot <fengguang.wu@intel.com> wrote:
> >> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> >> head:   32f392efd4b345819bfab7e64296902b3887f834
> >> commit: 3e48fdd88e8a52cb11b82534485be954e20877a1 [17/49] mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file
> >> config: arm-allmodconfig (attached as .config)
> >> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> >> reproduce:
> >>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         git checkout 3e48fdd88e8a52cb11b82534485be954e20877a1
> >>         # save the attached .config to linux build tree
> >>         make.cross ARCH=arm
> >>
> >> Note: the ulf.hansson-mmc/next HEAD 32f392efd4b345819bfab7e64296902b3887f834 builds fine.
> >>       It only hurts bisectibility.
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>>> ERROR: "renesas_sdhi_remove" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
> >>>> ERROR: "renesas_sdhi_probe" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
> >>
> >> ---
> >> 0-DAY kernel test infrastructure                Open Source Technology Center
> >> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> >
> > So I decided to fold in Arnd's change to the commit causing the bisect
> > problem, of course keeping his SOB tag but also adding the below line
> > before that tag:
> > "[Arnd: Fixed module build error]"
> >
> > Please tell me if you aren't happy with this!
> 
> Sure, sounds good.

Thanks, sorry for the fall-out.
