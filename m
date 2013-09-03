From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V3 0/4] mmc: mmci: Support ap_sleep in cpuidle for ux500
Date: Tue,  3 Sep 2013 11:29:32 +0200
Message-ID: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:38035 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab3ICJ3s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:29:48 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so2828716eae.23
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 02:29:47 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

To be able to enter ap_sleep state in cpuidle were the APE power domain
regulator will be cut, a register save and restore mechanism needs to be
implemented. This patchset adapts to these restrictions.

Changes in v3:
	- Fold in a new patch, mmc: mmci: Adapt to new pinctrl handling
	- Updated patch "mmc: mmci: Use optional sleep pinctrl state" to
	use the new pinctrl API.
	- Added Acks from Rickard Andersson.

Ulf Hansson (4):
  mmc: mmci: Adapt to new pinctrl handling
  mmc: mmci: Use optional sleep pinctrl state
  mmc: mmci: Adapt to register write restrictions
  mmc: mmci: Save and restore register context

 drivers/mmc/host/mmci.c |   78 ++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/mmci.h |    4 ---
 2 files changed, 61 insertions(+), 21 deletions(-)

-- 
1.7.9.5

