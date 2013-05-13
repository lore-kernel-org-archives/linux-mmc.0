From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500
Date: Mon, 13 May 2013 15:47:14 +0200
Message-ID: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:57527 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752791Ab3EMNsV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 09:48:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

To be able to enter ap_sleep state in cpuidle were the APE power domain
regulator will be cut, a register save and restore mechanism needs to be
implemented. This patchset adapts to these restrictions.

Ulf Hansson (3):
  mmc: mmci: Use optional sleep pinctrl state
  mmc: mmci: Adapt to register write restrictions
  mmc: mmci: Save and restore register context

 drivers/mmc/host/mmci.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 74 insertions(+)

-- 
1.7.10

