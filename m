From: Daniel Drake <dsd@laptop.org>
Subject: reference implementation of runtime PM
Date: Mon, 6 Dec 2010 17:57:22 +0000
Message-ID: <AANLkTikK-SvvDHfeNHXP4tw_e3p3gZ4XaT8Ta5YpuDar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50327 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LFR5X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 12:57:23 -0500
Received: by gyb11 with SMTP id 11so6160418gyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Dec 2010 09:57:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I'm working on getting runtime pm working on the XO-1.5 laptop
(sdhci-pci) in case it is related to some other power-related issues
we have been having.

Right now, when runtime is enabled, the card cannot be brought back
online again after it has been powered off.

I've dug down and I think that runtime PM is doing basically nothing.
i.e. when the system decides to runtime-suspend my SD card, nothing
actually happens to the SD card. It remains fully powered and
untouched. I'm basing this assumption on mmc_power_save_host() which
relies entirely on host->bus_ops->power_save() doing the actual
power-down work. On sdhci this method does not exist.

I figure that if I write sdhci power_save and power_restore functions,
the problem might be solved.

I looked at the other host controllers hoping to get a feel for the
kind of thing that should be done in such a handler but didn't find
any host controller that implements this.

Is there a host controller patch somewhere that implements
power_save/power_restore? Maybe even for sdhci?

cheers,
Daniel
