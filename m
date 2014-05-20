From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Tue, 20 May 2014 14:26:27 +0200
Message-ID: <5135756.ICUSXn8hND@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com> <6873175.VdOFbJiHYM@wuerfel> <CA+E=qVe0GONTbpe4E_dhg7kwUzG4QpTkxGbBQ2Z00M1B_octQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61361 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaETM1R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 May 2014 08:27:17 -0400
In-Reply-To: <CA+E=qVe0GONTbpe4E_dhg7kwUzG4QpTkxGbBQ2Z00M1B_octQw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Tuesday 20 May 2014 14:55:40 Vasily Khoruzhick wrote:
> On Tue, May 20, 2014 at 2:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> Let's just leave channel number hardcoded, how it was before conversion.
> >> It doesn't seem to be a good idea to clean non-DT machine code now, since
> >> it's better to put some effort into converting s3c2410 and s3c244{0,2} to DT.
> >
> > Ok, fair enough.
> >
> > I'm actually more interested in making s3c24xx multiplatform capable than
> > moving it to DT, but we that requires a few other patches as well, and
> > we can fix this one along with those.
> 
> Hm, but s3c2410, s3c2440 and s3c2442 are armv4t. Is it possible at all
> to make them multiplatform?

Yes, of course. We can run any combination of armv4, armv4t and armv5
CPUs in a multiplatform, we just can't combine them with armv6, armv6k
or armv7.

There is an interesting dependency here: for armv6/v7, we have multiple
Samsung platforms that are mutually exclusive as long as they use ATAGS
based boot: s3c64xx, s5p64xx, s5pc100, s5pv210 and exynos, because the
plat-samsung directory uses mutually exclusive options to pick which set
of mach/*.h headers it uses. The plan here is to move s5pv210 to DT
(same as Exynos already is) and delete s5p64xx and s5pc100, which don't
seem to be used by anybody really. Then all that is left is s3c64xx
using board files and all the non-DT code from plat-samsung becomes
s3c64xx-only.

For s3c24xx, we don't have that problem at all, we can just build
plat-samsung with the s3c24xx headers into the same kernel as things
like mxs, imx1/2, kirkwood, orion, or versatile.

	Arnd
