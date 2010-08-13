From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: 'error: 'SDHCI_QUIRK_NO_HISPD_BIT' undeclared' and 'undefined
 reference to `sdhci_card_detect''
Date: Fri, 13 Aug 2010 10:13:04 +0200
Message-ID: <000901cb3abf$5ef59b30$1ce0d190$%szyprowski@samsung.com>
References: <008d01cb3ab9$ae73da60$0b5b8f20$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43074 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205Ab0HMIO7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2010 04:14:59 -0400
In-reply-to: <008d01cb3ab9$ae73da60$0b5b8f20$%kim@samsung.com>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, 'Andrew Morton' <akpm@linux-foundation.org>

Hello,

On Friday, August 13, 2010 9:32 AM Kukjin Kim wrote:

> This is just information about Samsung sdmmc stuff building error now.
> 
> I found Marek's 'sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk' in the
> Linus' tree.
> (commit ID: a1d5646005af1247d6ae78434bb4db15b07a07b2)
> 
> But not defined the quirk yet...so following build error happened with
> s3c6400_defconfig in Linus' latest.
> 
> drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
> drivers/mmc/host/sdhci-s3c.c:400: error: 'SDHCI_QUIRK_NO_HISPD_BIT'
> undeclared (first use in this function)
> drivers/mmc/host/sdhci-s3c.c:400: error: (Each undeclared identifier is
> reported only once
> drivers/mmc/host/sdhci-s3c.c:400: error: for each function it appears in.)
> make[4]: *** [drivers/mmc/host/sdhci-s3c.o] Error 1
> make[3]: *** [drivers/mmc/host] Error 2
> make[2]: *** [drivers/mmc] Error 2
> make[1]: *** [drivers] Error 2
> 
> Kyungmin Park's below patch can solve this and it is in mmotm now.
> (commit ID: 2935b9e7fcc4bea3751b8d039b383b2036a7d36d)
> 
> But I think, to update quirk definition should being in Marek's patch for
> avoiding build error.
> Of course, I'm not sure whether the commit order changed.
> Anyway, in this case, will be solved after merging mm tree.
> 
> 
> And second case is same.
> 
> Marek's 'sdhci-s3c: add support for new card detection methods' cause
> following build error.
> (commit ID:17866e14f3a4f219e94f1374ece7226479418ff8)
> 
> drivers/built-in.o: In function `sdhci_s3c_notify_change':
> /home/kgene/linux/linux-2.6-mainline-dev/drivers/mmc/host/sdhci-s3c.c:255:
> undefined reference to `sdhci_card_detect'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
> 
> And Andrew's patch(b567e5dd5a34c184e5642100e752cb87e064bb97) can solve this.
> (of course this needs another patches...)
> 
> Anyway...
> Marek, in future please make sure your patch has no building problem before
> submitting.
> (or it can help to add some kind of dependency note in your patch)

My patches submited to Andrew Morton had the description and a note that they
have been prepared especially for his tree, taking into account all patches
that are already there (mainly a tasklets to threaded irq conversion). For me
it was quite obvious that they will be merged after all other sdhci changes
from that tree. I have no idea why the order of the patches has been reversed
and my sdhci patches has been submitted to Linus before the other sdhci
changes.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

