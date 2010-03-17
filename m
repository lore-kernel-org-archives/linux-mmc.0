From: "Hemanth V" <hemanthv@ti.com>
Subject: Highmem issues with MMC filesystem
Date: Wed, 17 Mar 2010 19:10:33 +0530
Message-ID: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44449 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982Ab0CQNkq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Mar 2010 09:40:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, pierre@ossman.eu

Hi All,

We are trying to enable highmem support for OMAP based boards, while doing 
so we are
unable to boot poky UI if the filesystem is in a MMC card.

The poky UI comes up fine if the filesystem is in NAND or NFS,
while with MMC it gives errors like segmentation faults/syntax error while 
there are none.
Seems like read from MMC is getting corrupted.

I tried  the 4 tests which are available as part of mmc_test for highmem, 
all of them seem to PASS.
Wanted to get inputs if there are any known issues with MMC block layer 
handling highmem pages.

Thanks
Hemanth 

