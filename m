From: Tony Prisk <linux@prisktech.co.nz>
Subject: [RFC PATCH v2] MMC: SD/MMC Host Controller for Wondermedia WM8505/WM8650
Date: Wed, 17 Oct 2012 07:39:05 +1300
Message-ID: <1350412746-16991-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:50573 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534Ab2JPSjH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Oct 2012 14:39:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, girish.shivananjappa@linaro.org, Tony Prisk <linux@prisktech.co.nz>

This patchset adds support for the Wondermedia 8xxx-series SD Host
Controller currently found under arm/arch-vt8500.

v2 changes:
I think this should address most of the issues raised by Girish K S.
* Move the PM functions into .driver, rather than suspend/resume.
* __devexit_p() on .remove function.
* Removed hardcoded mmc caps data from probe() and moved to per-controller caps.

Tony Prisk (1):
  MMC: SD/MMC Host Controller for Wondermedia WM8505/WM8650

 drivers/mmc/host/Kconfig     |   12 +
 drivers/mmc/host/Makefile    |    1 +
 drivers/mmc/host/wmt-sdmmc.c | 1023 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1036 insertions(+)
 create mode 100644 drivers/mmc/host/wmt-sdmmc.c

-- 
1.7.9.5

