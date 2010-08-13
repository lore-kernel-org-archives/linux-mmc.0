From: Kukjin Kim <kgene.kim@samsung.com>
Subject: 'error: 'SDHCI_QUIRK_NO_HISPD_BIT' undeclared' and 'undefined
 reference to `sdhci_card_detect''
Date: Fri, 13 Aug 2010 16:32:07 +0900
Message-ID: <008d01cb3ab9$ae73da60$0b5b8f20$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi, 

This is just information about Samsung sdmmc stuff building error now.

I found Marek's 'sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk' in the
Linus' tree.
(commit ID: a1d5646005af1247d6ae78434bb4db15b07a07b2)

But not defined the quirk yet...so following build error happened with
s3c6400_defconfig in Linus' latest.

drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
drivers/mmc/host/sdhci-s3c.c:400: error: 'SDHCI_QUIRK_NO_HISPD_BIT'
undeclared (first use in this function)
drivers/mmc/host/sdhci-s3c.c:400: error: (Each undeclared identifier is
reported only once
drivers/mmc/host/sdhci-s3c.c:400: error: for each function it appears in.)
make[4]: *** [drivers/mmc/host/sdhci-s3c.o] Error 1
make[3]: *** [drivers/mmc/host] Error 2
make[2]: *** [drivers/mmc] Error 2
make[1]: *** [drivers] Error 2

Kyungmin Park's below patch can solve this and it is in mmotm now.
(commit ID: 2935b9e7fcc4bea3751b8d039b383b2036a7d36d)

But I think, to update quirk definition should being in Marek's patch for
avoiding build error.
Of course, I'm not sure whether the commit order changed.
Anyway, in this case, will be solved after merging mm tree.


And second case is same.

Marek's 'sdhci-s3c: add support for new card detection methods' cause
following build error.
(commit ID:17866e14f3a4f219e94f1374ece7226479418ff8)

drivers/built-in.o: In function `sdhci_s3c_notify_change':
/home/kgene/linux/linux-2.6-mainline-dev/drivers/mmc/host/sdhci-s3c.c:255:
undefined reference to `sdhci_card_detect'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

And Andrew's patch(b567e5dd5a34c184e5642100e752cb87e064bb97) can solve this.
(of course this needs another patches...)

Anyway...
Marek, in future please make sure your patch has no building problem before
submitting.
(or it can help to add some kind of dependency note in your patch)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
