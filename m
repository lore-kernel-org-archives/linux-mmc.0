From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: mmc_test
Date: Tue, 14 Feb 2012 09:50:53 +0200
Message-ID: <4F3A125D.8000603@intel.com>
References: <CAMKhXh=5eymTCzDPRd0ipxQN5z4ZB2BSoTxwy1C+v7iP8T_BiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36658 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab2BNHut (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 02:50:49 -0500
In-Reply-To: <CAMKhXh=5eymTCzDPRd0ipxQN5z4ZB2BSoTxwy1C+v7iP8T_BiQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shridhar Rasal <shri.rasal@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 14/02/12 08:41, Shridhar Rasal wrote:
> [sorry for spamming you]
> 
> Dear Adrian,
> 
> I am working on K3.1. 
> I am trying to run mmc_test on my set-up. I have added mmc_test as a driver.
> But sysfs entries(test/testlist) are getting created only for any of SDIO host.

mmc_test will not work if mmc_block has already been given all the
MMC devices.

You can always switch between mmc_test and mmc_block by
unbinding / binding e.g.


# ls -al /sys/bus/mmc/drivers/mmcblk
drwxr-xr-x    2 root     0               0 Jan  1 00:00 .
drwxr-xr-x    4 root     0               0 Jan  1 00:00 ..
--w-------    1 root     0            4096 Jan  1 00:01 bind
lrwxrwxrwx    1 root     0               0 Jan  1 00:01 mmc0:0001 ->
../../../../devices/platform/mmci-omap-hs.1/mmc_host/mmc0/mmc0:0001
--w-------    1 root     0            4096 Jan  1 00:01 uevent
--w-------    1 root     0            4096 Jan  1 00:01 unbind

# echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind

# echo mmc0:0001 > /sys/bus/mmc/drivers/mmc_test/bind
[  128.221313] mmc_test mmc0:0001: Card claimed for testing.


> 
> I digged  further and found that,  
> 1.  mmc_test_probe is invoked only in case of SDIO and not for other hosts.
> 2.  this is because of from mmc_bus_probe( ), only for SDIO host -
> mmc_test_probe () invoked and for other hosts - mmc_blk_probe () invoked.
> 
> 
> - What can be reason for this?
> - Am I missing some patches? 
> 
> Also, please let me know, where can I post such mmc related queries.

MMC mailing list:

	http://vger.kernel.org/vger-lists.html#linux-mmc


