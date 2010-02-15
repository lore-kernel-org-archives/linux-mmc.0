From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 0/3] [MMCI] remove custom DBG macro and printk
Date: Mon, 15 Feb 2010 12:23:20 +0100
Message-ID: <1266233000-16256-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:55592 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755245Ab0BOLXc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Feb 2010 06:23:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>

This series is a few fixups to the MMCI driver, admittedly
based on top of the DMA support patch, so if that thing needs
revising I will update this series to include that patch as
well when I rebase them.

As usual I prefer that these go in through Russells tree due
to being a generic ARM PrimeCell.

Linus Walleij
