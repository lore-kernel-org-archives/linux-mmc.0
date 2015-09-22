From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
Date: Tue, 22 Sep 2015 17:30:23 +0200
Message-ID: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbbIVPaa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Sep 2015 11:30:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arend van Spriel <arend@broadcom.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ulf,

Here is a non RFC version of my patch-set to wait for card_busy before
starting sdio requests. It is the same as the RFC version of the set,
but this time it has been tested no hardware which actually needs this
and I can confirm now that this fixes wifi on that hardware.

This patch-set should also allow removing this dw_mmc specific fix:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc.c?id=0bdbd0e88cf6b603a2196418672715b0890fb040

As this patch-set fixes this problem in a generic manner.

Regards,

Hans
