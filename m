From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 0/2 v2] mmc: tmio: handle missing HW interrupts
Date: Wed, 29 Dec 2010 14:21:12 +0100
Message-ID: <1293628874-8140-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:46532 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752681Ab0L2NVT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Dec 2010 08:21:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
Cc: linux-sh@vger.kernel.org

[PATCH 1/2 v2] mmc: tmio: handle missing HW interrupts
[PATCH 2/2 v2] mmc: tmio: fix CMD irq handling

This are rebased equivalents to the patches:
[1/2] tmio_mmc: handle missing HW interrupts
	https://patchwork.kernel.org/patch/201962/
[2/2] tmio_mmc: fix CMD irq handling
	https://patchwork.kernel.org/patch/201982/

They now depend on -rc7 and:
    mmc: tmio: merge the private header into the driver
            https://patchwork.kernel.org/patch/349931/

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
