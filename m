From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 0/4] Add SDHCI driver for Tegra
Date: Tue, 14 Dec 2010 22:49:32 -0600
Message-ID: <1292388576-25600-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:38597 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756150Ab0LOE5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Dec 2010 23:57:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Chris,

This series introduces a SDHCI driver for the on-chip MMC/SDIO controller
on tegra. Some of the erratas weren't feasible to work around locally
in the driver, so it also adds a couple of new quirk bits.

Thanks,

-Olof

