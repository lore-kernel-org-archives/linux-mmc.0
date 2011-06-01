From: Per Forlin <per.forlin@stericsson.com>
Subject: [PATCH v2 0/2] sdio: add quirk for spurious SDIO IRQ
Date: Wed, 1 Jun 2011 10:48:31 +0200
Message-ID: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:35509 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758264Ab1FAIuB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 04:50:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Linus
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

From: Per Forlin <per.forlin@linaro.org>

Daniel Drake reported an issue in the libertas sdio client that was
triggered by the sdio_single_irq functionality. His SDIO device seems to
raise an interrupt even though there are no bits set in the CCCR_INTx
register. This behaviour is not supported by the sdio_single_irq feature nor
the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
overhead of checking the CCCR_INTx registers, this result in no error
handling of the case if there is a pending IRQ with none CCCR_INTx bits set.

This patchset adds a quirk to support this spurious IRQ issue and also report
a warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.

Changes since v1:
 * Replace public sdio function to enable disable SDIO single IRQ function
   with a quirk

Per Forlin (2):
  sdio: add quirk to handle pending IRQ in case of none CCCR_INTx bits
  sdio: report error if pending IRQ but none CCCR_INTx bits

 drivers/mmc/core/sdio_irq.c |    9 +++++++--
 include/linux/mmc/card.h    |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.7.4.1
