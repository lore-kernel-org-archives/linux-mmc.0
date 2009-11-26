From: Jassi Brar <jassi.brar@samsung.com>
Subject: Patches for S3C64XX SPI controller driver
Date: Thu, 26 Nov 2009 15:47:59 +0900
Message-ID: <1259218079-9755-1-git-send-email-jassi.brar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:40630 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbZKZGxQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2009 01:53:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: dbrownell@users.sourceforge.net, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>

Hello,

 In subsequent mails, I am going to submit new SPI driver
for the S3C64xx Samsung SoCs.

 The driver has been tested with 9pin MMC card slot soldered
to pins of SPI-1 port on the SMDK6410.
Since that is not a standard h/w configuration of SMDK, the patch
to enable SPI-1 controller for MMC_SPI in machine init code,
is not being submitted.

Regards.
