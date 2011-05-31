From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH 0/2] sdio: make sdio_single_irq optional due to suprious IRQ
Date: Tue, 31 May 2011 22:33:26 +0200
Message-ID: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62419 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758244Ab1EaUeE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 16:34:04 -0400
Received: by eyx24 with SMTP id 24so1794491eyx.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2011 13:34:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

Daniel Drake reported an issue in the libertas sdio client that was
triggered by the sdio_single_irq functionality. His SDIO device seems to
raise an interrupt even though there are no bits set in the CCCR_INTx
register. This behaviour is not supported by the sdio_single_irq feature nor
the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
overhead of checking the CCCR_INTx registers, this result in no error
handling of the case if there is a pending IRQ with none CCCR_INTx bits set.

This patchset intends to resolve the libertas issue by making
sdio_single_irq feature configurable and also report a
warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.

Per Forlin (2):
  sdio: add function to enable and disable sdio_single_irq optimization
  sdio: report error if pending IRQ but none function bits

 drivers/mmc/core/sdio_irq.c |   22 +++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 22 insertions(+), 1 deletions(-)

-- 
1.7.4.1

