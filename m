From: Per-Henrik Lundblom <ph@whatever.nu>
Subject: sdhci-esdhc-imx and SDIO interrupts
Date: Wed, 31 Aug 2011 14:09:12 +0200
Message-ID: <20110831120912.GN21500@whatever.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from roadrunner.df.lth.se ([194.47.250.105]:43718 "EHLO
	roadrunner.df.lth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab1HaMTP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2011 08:19:15 -0400
Received: from roadrunner.df.lth.se (localhost [127.0.0.1])
	by roadrunner.df.lth.se (Postfix) with ESMTP id 1D4326A4
	for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2011 14:09:12 +0200 (CEST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I'm working with a driver for an SDIO Wireless LAN card and just tried
it out on an i.MX35 based development board (Phytec PCM-043). My
impression is that the sdhci-esdhc-imx driver doesn't support SDIO
interrupts, is that correct?

Regards,

PH


--
Per-Henrik Lundblom           epost: ph@whatever.nu
hemsida: www.whatever.nu

