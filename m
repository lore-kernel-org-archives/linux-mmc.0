From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2 0/2] sdhci: Dual Data Rate Support
Date: Sun, 2 Jan 2011 08:42:47 -0800
Message-ID: <EA32CB41-AABC-43C3-ACC2-295E9029C6B5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45453 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751823Ab1ABQmu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jan 2011 11:42:50 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


[PATCH 1/2] sdhci: register definitions for sd 3.0 HOST CONTROL 2
adds the definitions needed for HOST_CONTROL_2 Register

[PATCH 2/2] sdhci: Support for SD/MMC Dual Data Rate
Enables support for Dual Data Rate 1.8V signalling SD/eMMC when 
the capability high register indicates support (bit 2 set) if
the controller is SD 3.0 compiliant.

Implemements support for DDR by programming the appropriate
registers in the HOST CONTROL 2 register.

Code was tested on linux-next using MMP2 brownstone development
board.  

Note:  this board design runs a fixed voltage to the card and
signaling voltage cannot be changed.
