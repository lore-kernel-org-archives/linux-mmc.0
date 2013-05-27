From: Rickard ANDERSSON <rickard.andersson@stericsson.com>
Subject: RE: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500
Date: Mon, 27 May 2013 13:40:55 +0200
Message-ID: <C832F8F5D375BD43BFA11E82E0FE9FE0115A936A54@EXDCVYMBSTM005.EQ1STM.local>
References: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:46856 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757704Ab3E0Lmi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 May 2013 07:42:38 -0400
In-Reply-To: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>

-----Original Message-----
From: Ulf HANSSON 
Sent: den 23 maj 2013 11:45
To: linux-arm-kernel@lists.infradead.org; Russell King
Cc: linux-mmc@vger.kernel.org; Chris Ball; Daniel Lezcano; Linus Walleij; Rickard ANDERSSON; Ulf Hansson
Subject: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500

From: Ulf Hansson <ulf.hansson@linaro.org>

To be able to enter ap_sleep state in cpuidle were the APE power domain regulator will be cut, a register save and restore mechanism needs to be implemented. This patchset adapts to these restrictions.

Ulf Hansson (3):
  mmc: mmci: Use optional sleep pinctrl state
  mmc: mmci: Adapt to register write restrictions
  mmc: mmci: Save and restore register context

 drivers/mmc/host/mmci.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 76 insertions(+)

--
1.7.10

