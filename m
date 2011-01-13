From: "Mark Thurlow" <mthurlow@ipwireless.com>
Subject: building mmc_core.ko - invalid module format
Date: Thu, 13 Jan 2011 10:45:48 -0000
Message-ID: <DB5D3F56DF583645AEFD1920B15E0B73A179BB@ipwuk-mail05.ipwirelessus.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.ipwsecure.com ([193.130.71.38]:49703 "EHLO
	mail6.ipwireless.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421Ab1AMKq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jan 2011 05:46:29 -0500
Content-class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Pat Clark <pclark@ipwireless.com>

Hi,

I'm trying to build mmc_core.ko with a modified sdio_cis.c  in order to
add more debug to see what our card is doing.

I have the following setup:
1.	Ubuntu 10.04 - 2.6.32-27-generic.
2.	I have downloaded the source for this via 
	a.	sudo apt-get build-dep --no-install-recommends
linux-image-$(uname -r)
	b.	apt-get source linux-image-$(uname -r)

In the top level source directory I run "make menuconfig".  Under the
device driver option I set MMC/SDIO to M - produce modules. So
MMC_CONFIG=m in the .config file.

I then run "make modules"

All builds OK. I get a mmc_core.ko produced. However, if I then insmod
this .ko then I see the "invalid module format".

Any ideas of what I'm doing wrong ?

Thanks,

Mark


