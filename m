From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: mmc-utils boot enable conflict with mmc_blk_part_switch
Date: Thu, 14 Aug 2014 11:11:05 +0200
Message-ID: <20140814111105.55aadaee@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:29246 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbaHNJKr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Aug 2014 05:10:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,


Boot enable setting is enable with writting PARTITION_CONFIG ext csd.
But the kernel also write it in mmc_blk_part_switch.

This lead to weird result :


~ # mmc_utils extcsd read /dev/mmcblk0 | grep PARTITION_CONFIG
Boot configuration bytes [PARTITION_CONFIG: 0x00]
## no boot partition enabled
~ # mmc_utils boot enable 1 1 /dev/mmcblk0
~ # mmc_utils extcsd read /dev/mmcblk0 | grep PARTITION_CONFIG
Boot configuration bytes [PARTITION_CONFIG: 0x48]
## boot partition enabled
~ # dd if=/dev/mmcblk0boot0 of=/dev/null count=1
1+0 records in
1+0 records out
~ # mmc_utils extcsd read /dev/mmcblk0 | grep PARTITION_CONFIG
Boot configuration bytes [PARTITION_CONFIG: 0x01]
## kernel erased your boot partition config.


This is because the kernel have a cache of ext_csd in card->ext_csd and
is not aware of modification done by the mmc_utils.


Matthieu

