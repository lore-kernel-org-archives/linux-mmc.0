From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] Fix mmc_test build order
Date: Mon, 26 Jul 2010 14:05:29 +0300
Message-ID: <4C4D6BF9.1040704@nokia.com>
References: <20100726100956.GA17996@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20720 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab0GZLGC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jul 2010 07:06:02 -0400
In-Reply-To: <20100726100956.GA17996@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>

Kyungmin Park wrote:
> To use the mmc_test, it should be build before mmc_block.
> 
> Reported-by: Adrian Hunter <adrian.hunter@nokia.com>

I did not report this.  I just pointed out that mmc_test
will not work if mmc_block has already been given all the
MMC devices.

You can always switch between mmc_test and mmc_block by
unbinding / binding e.g.


# ls -al /sys/bus/mmc/drivers/mmcblk
drwxr-xr-x    2 root     0               0 Jan  1 00:00 .
drwxr-xr-x    4 root     0               0 Jan  1 00:00 ..
--w-------    1 root     0            4096 Jan  1 00:01 bind
lrwxrwxrwx    1 root     0               0 Jan  1 00:01 mmc0:0001 -> ../../../../devices/platform/mmci-omap-hs.1/mmc_host/mmc0/mmc0:0001
--w-------    1 root     0            4096 Jan  1 00:01 uevent
--w-------    1 root     0            4096 Jan  1 00:01 unbind

# echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind

# echo mmc0:0001 > /sys/bus/mmc/drivers/mmc_test/bind
[  128.221313] mmc_test mmc0:0001: Card claimed for testing.



I suggest adding explanation to the Kconfig help text for
MMC_TEST and also the module decription in drivers/mmc/card/mmc_test.c

> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
> index 0d40751..9d50437 100644
> --- a/drivers/mmc/card/Makefile
> +++ b/drivers/mmc/card/Makefile
> @@ -6,9 +6,9 @@ ifeq ($(CONFIG_MMC_DEBUG),y)
>  	EXTRA_CFLAGS		+= -DDEBUG
>  endif
>  
> +obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
>  obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
>  mmc_block-objs			:= block.o queue.o
> -obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
>  
>  obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
>  
> 

