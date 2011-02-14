From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/3] mmc: core: misc bug fixes
Date: Sun, 13 Feb 2011 23:11:53 -0800
Message-ID: <17DFB171-645B-43E4-BBF1-11A60B5ECED8@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59207 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358Ab1BNHRO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:17:14 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Patch set 8/12

[PATCH] mmc: core: add comment why sdio_reset is done at init time
sdio_reset sends a CMD52 to reset the sdio card.  This is
highly recommended for sdio cards being reinitialized.  Since
we do not know if the card is being reinitialized we just send
the command.  SD/eMMC cards are supposed to ignore the CMD
before the CMD0.  Document why we are doing this.

[PATCH] mmc: mmc.c check if mmc cards < 2GB do sector addressing

Some TOSHIBA MMC cards only support sector addressing
even though the size is < 2GB.  According to JEDEC
Spec JESD84-A441-1 the ocr register (bits 30, 29)
determine byte/sector mode.  Use them.


[PATCH] mmc: rename ddr to uhs in ios structure to indicate usage

uhs mode comprises dual data rate, single data rate options
such as ddr_1_8v as well as sdr50 and sdr104
ddr name changed to indicate its true usage

