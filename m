From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH next 0/2] mmc: sdhci-pxav3: fix unbalanced pm and clock issues
Date: Sun, 4 Jan 2015 23:15:46 +0800
Message-ID: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

These two patches fix unbalanced pm and clock issues. The clock unbalance
issue would cause power consumption regression because the clock will never
be gated at runtime PM suspend.

Jisheng Zhang (2):
  mmc: sdhci-pxav3: fix unbalanced clock issues during probe
  mmc: sdhci-pxav3: fix pm unbalanced issue in -> remove()

 drivers/mmc/host/sdhci-pxav3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.1.4
