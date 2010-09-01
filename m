From: Chris Ball <cjb@laptop.org>
Subject: MMC patches in-flight.
Date: Wed, 01 Sep 2010 19:49:02 -0400
Message-ID: <m3tym9xbwx.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46085 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab0IAXsr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Sep 2010 19:48:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

Hi,

Here's an attempt to summarize the state of MMC patches submitted to
linux-mmc@ that haven't been merged.  Feel free to correct anything,
especially if you have a patch that you think is waiting to be merged
that I've listed without "->", or that I haven't listed at all.
Please also consider reviewing any patches in the "review" state.
Thanks!

Patch author   | Patch subject                                | Next step

Don Mullis     | mmc: Unify and generalize UNSTUFF bits macro | review
Don Mullis     | mmc: Add SD_STATUS register dump to debugfs  | review
Jerry Huang    | Add the callback get_cd to dtect the card    | design
Hein Tibosch   | mmc: Make ID freq configurable               | -> akpm
Martin Fuzzey  | mxc: Add i.MX21 support to mxcmmc driver     | resubmit
David Vrabel   | mmc: omap_hsmmc: support SDIO cards          | resubmit
Thomas Abraham | Modify checks to determine presence of card  | review
Thomas Abraham | S3C: Modify timeout clock calculation        | review
Guennadi Liakho| initialise DMA engine before MMC             | design
Marek Szyprowsk| sdhci-s3c: increase the timeout value        | resubmit
JiebingLi      | MMC driver full patch for Moorestown platform| resubmit
Madhav Chauhan | sdhci-clk-gating-support                     | test
Bing Zhao      | sdio: add MMC_PM_SKIP_RESUME_PROBE           | design
Sukumar Ghorai | mmc: failure of block read wait for long     | design
Ohad Ben-Cohen | adding SDIO runtime PM support               | review
Peppe CAVALLARO| mmc: add SDHCI driver for STM platforms      | resubmit
Yusuke Goda    | tmio_mmc: Revise a limit of the data size    | resubmit
Zhangfei Gao   | sdhci: Enable high speed support for MMC card| -> Linus
Sonic Zhang    | mmc_spi: Recover from CRC error for SD read/w| review
Esben Haabendal| of_mmc_spi: add card detect irq              | -> akpm
Kishore Kadiyal| hsmmc: card detect and register offset handli| resubmit
Matt Fleming   | Add helper function to check if a card is rem| test
Peppe CAVALLARO| sdhci: add MMC_CAP_8_BIT_DATA in the Host    | review
Chuanxiao Dong | mmc: implement eMMC4.4 standard HW reset     | review
Jaehoon Chung  | sdhci-s3c: support non-standard clock .. c210| review
Linus Walleij  | MMC: move regulator handling closer to core  | review
Richard Zhu    | sdhci: add host's own set_power func         | design
Andy Shevchenko| mmc_test: show test results via sysfs        | review

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
