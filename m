From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: question for mmc_test
Date: Thu, 28 Feb 2013 09:21:20 +0200
Message-ID: <1362036080.28241.86.camel@smile>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDE9843EA@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab3B1HVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 02:21:36 -0500
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDE9843EA@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Wed, 2013-02-27 at 22:15 -0800, Kevin Liu wrote: 
> Andy,

Added linux-mmc@ ML.

> I never used mmc_test.c and I have several questions for it.
> 1. I have 3 sdh controllers (sd, emmc, sdio) in system, then which host does mmc_test test?
> 2. I found mmc_test always bind to sdio, so fail to add the debugfs. 
> mmc_test_probe was not launched for sd and emmc, why?

It binds to the card. It seems you have sdio attached when module is
initialized.

> 3. Currently, I just build mmc_test in the kernel and didn't change anything.
> In git log, I found below comments written by you.
>     Example of usage:
>       # mount -t debugfs none /sys/kernel/debug
>       # modprobe mmc_test
>         [  581.395843] mmc_test mmc0:0001: Card claimed for testing.
>       # echo 25 > /sys/kernel/debug/mmc0/mmc0\:0001/test
>         [  604.568542] mmc0: Starting tests of card mmc0:0001...
>         [  604.582733] mmc0: Test case 25. Best-case read performance into scattered pages...
>         [  604.923553] mmc0: Transfer of 8192 sectors (4096 KiB) took 0.124664314 seconds (33644 kB/s, 32856 KiB/s)
>         [  604.933227] mmc0: Result: OK
>         [  604.936248] mmc0: Tests completed.
>       # cat /sys/kernel/debug/mmc0/mmc0\:0001/test
> 
> I can also make mmc_test build-in kernel, right? Do I miss anything?

Yes, you missed something.
You have to attach the card you would like to test, then go to the sysfs
and do unbind-bind cycle manually by echoing proper card ID.

I could ask Adrian if we could provide piece of documentation he wrote
few years ago at Nokia.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
