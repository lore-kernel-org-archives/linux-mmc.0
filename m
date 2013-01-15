From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] A couple of gpio fixes
Date: Tue, 15 Jan 2013 16:37:34 +0800
Message-ID: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:36042
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755158Ab3AOIhQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Jan 2013 03:37:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

I recently sent a patch "mmc: slot-gpio: use devm_* managed functions
to ease users" for mmc-next inclusion, and got a error report [1] from
Fengguang (Thanks!), saying it breaks blackfin build.  It seems to me
that the error is caused by devm_gpio_* unnecessary dependency on
GPIOLIB.

While at it, I also include a patch (#1) to fix the 'struct gpio_chip'
declaration warning that's already been there with blackfin build.
And the patch #2 remove the unnecessary dependency between devm_gpio_*
and GPIOLIB to get the reported error fixed.

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/18650

Shawn Guo (2):
  gpio: fix warning of 'struct gpio_chip' declaration
  gpio: devm_gpio_* support should not depend on GPIOLIB

 drivers/gpio/Kconfig       |    3 ++
 drivers/gpio/Makefile      |    3 +-
 include/asm-generic/gpio.h |   91 ++++++++++++++++++++++----------------------
 3 files changed, 50 insertions(+), 47 deletions(-)

-- 
1.7.9.5


