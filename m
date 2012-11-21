From: Philip Rakity <prakity@nvidia.com>
Subject: RFC: eMMC
Date: Wed, 21 Nov 2012 13:41:51 +0100
Message-ID: <10BF00FE-B50A-4CF0-B4E9-75C8172C1727@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:13046 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2KUMlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 07:41:52 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Recently there have been a number of patches to sdhci.c and discussions on regulators for folks using eMMC.

I would appreciate any feedback.  The opinions below are my own.

eMMC is a hardware device.  It is NOT voltage configurable in any real sense other then turning on/off the voltage,
The board designer is supposed to read the data sheet and hook things up.  It is somewhat unclear to me how having a dummy regulator really helps.

Given that -- voltage checking for vmmc or vmmcq is not meaningful. eMMC either works or does not.
The testing for vccq/vcc has no meaning since it cannot be changed.  In fact the samsung eMMC we used for DDR worked at 2.8v.
Given this -- we have a chicken and egg situation in sdhci.c
if we are in this code and the kernel was on eMMC obviously the system is working.
If we booted the kernel from say SPI then hopefully the boot code has set up the voltage rails correctly.
I would argue that for eMMC the regulator structure should not be exposed to sdhci.c and everything would just work.

SD/UHS cards are a completely different matter and regulators make complete sense.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
