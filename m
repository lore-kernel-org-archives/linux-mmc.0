From: Rich Felker <dalias@libc.org>
Subject: Unsynchronized access to spi bus by mmc_rescan?
Date: Fri, 22 Apr 2016 17:28:42 -0400
Message-ID: <20160422212842.GB21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:54471 "EHLO
	brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbcDVV2p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 17:28:45 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org

I'm working on a driver for the J-core (http://j-core.org) SPI master,
which is currently limited to PIO and using the spi-bitbang framework
(probably not the right thing to use, but planned to change, and seems
orthogonal to the issue at hand). We're using it to access an SD card
via the mmc_spi mmc host driver, and experiencing crashes/corruption
that I tracked down to mmc_rescan (we don't yet have an interrupt for
media change) happening during SPI message transfers. Which locks are
supposed to preclude this from happening? Is it likely something wrong
our driver is using, or is there possibly a general bug in the MMC/SPI
subsystem(s)?

Rich
