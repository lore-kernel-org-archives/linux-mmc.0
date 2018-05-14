From: Faiz Abbas <faiz_abbas@ti.com>
Subject: MMC performance degradation due to too many requests
Date: Mon, 14 May 2018 17:00:56 +0530
Message-ID: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Everyone,

I am debugging a performance degradation issue in some SD cards which
happened around 4.13 kernel on TI's AM335x-evm.

I compare the time taken for a simple dd command (after dropping
caches) to run between kernel versions 4.13 and 4.14. I see that there
is a consistent 15-20% reduction in speed. The amount of decrease
depends on the card used.

command:
# echo 3 > /proc/sys/vm/drop_caches; dd if=/dev/zero of=/dev/mmcblk1p2
bs=1M count=100;


v4.13
~22s for 100M transfer

v4.14
~28s for 100M transfer

Also, I see many times the number of interrupts for mmc1 in 4.14.

v4.14
 34:      2122       INTC  64 Level     mmc1

v4.13
162:       457       INTC  64 Level     mmc1

This increase of interrupts also exists in the latest kernel.

I also printed out the size of the DMA transfers in the omap_hsmmc
driver during the dd command. I see that the maximum size of the dma
transfer has decreased from 1 MB to 256kB between 4.13 and 4.14.

Full log:

v4.13
https://pastebin.ubuntu.com/p/gK2k9GZcNd/

v4.14
https://pastebin.ubuntu.com/p/3YzCbQ79rk/

It looks like something has started splitting the request into 4 times
as many smaller buffers and this is what is causing the performance
decrease.

I also ran the ftrace function profile tool on mmc* and blk* functions
and see that the function mmc_blk_issue_rq() is where the program spends
most of its time and the calls to that and other related functions have
increased around 4 times with the average time per call being reduced.

Function profile Log:

v4.13
https://pastebin.ubuntu.com/p/R5JG6FpTvy/

v4.14
https://pastebin.ubuntu.com/p/Kc6QYYwYcN/

I am not sure why calls to mmc_blk_issue_rq() have increased by so much.
Any ideas why this could be happening?


Thanks,
Faiz
