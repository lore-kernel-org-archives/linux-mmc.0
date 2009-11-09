From: Mike Borsuk <mike@borsuk.org>
Subject: mmc-spi on pxa2xx, flipping sph bit
Date: Mon, 9 Nov 2009 14:16:43 -0500
Message-ID: <20091109191643.GA22840@mixtec.wiredsoul.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mixtec.wiredsoul.org ([64.5.53.156]:40942 "EHLO
	mixtec.wiredsoul.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbZKIT0b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2009 14:26:31 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I am working on getting mmc_spi to work with a an ARM PXA270 on 2.6.31
I am able to successfully mount the fs on a Transcend mini-sd card
(though some i/o errors are reported during init sequence),
but some cards such as SanDisk Ultra II MiniSD 2GB fail to initialize.
The card is identified but then every command sent to it appears to
return an error.  The block driver reports errors such as:

  mmcblk0: error -38 sending status command
  mmcblk0: error -84 sending stop command, response 0x8, card status 0xff04
  mmcblk0: error -38 sending status command
  mmcblk0: error -38 sending read/write command, response 0x4, card \
  status 0xff04 end_request: I/O error, dev mmcblk0, sector 3969984

Interestingly, if I toggle the value for the SPH bit in the SSCR1
register, which should control the SSP port's clock phase, the SanDisk
card starts working but the Transcend card then fails to even be
detected.

Does anyone know if this indicates timing issues on the board, chip
configuration problems or anything else in particular?

-- 
Michael Borsuk
mike@borsuk.org
http://www.borsuk.org
