From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] sdhci: wakeup from runtime PM
Date: Fri, 25 Mar 2016 17:05:01 +0100
Message-ID: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

When not using the SDHCI controller, it is logical to save power by suspending
it. The issue is that SDHCI assumes that the controller is completely disabled.
It means the only way to wake up on a card event is to have a gpio for the card
detection (so two pins for the same signal). A possible workaround is to use
polling but the controller will be resumed/suspended between each attempts.

We have already discussed a long time about this and it seems we don't agree.
In my opinion, even if I can't disable all clocks, I should use runtime PM 
to save some power.

I propose two patches, one which is a draft to try to solve it at sdhci level
and one at sdhci-of-at91 level.

Concerning the first one, I don't understand why we need to reject irqs if
runtime_suspended is true. Only SDHCI_INT_CARD_INT irq is enabled so why we
should have other IRQs than this one?

Since you were not in favour of allowing to wakeup on SDHCI_INT_CARD_INSERT or
SDHCI_INT_CARD_REMOVE, I assume you won't take it so I
solved my issue only by modifying my driver.

I have not noticed side effects. I have compared a wakeup with a gpio for card
detection and the controller card detect. It seems the two paths are rougly
the same (mmc_detect_change -> mmc_rescan then resume is performed).

Regards

Ludovic
