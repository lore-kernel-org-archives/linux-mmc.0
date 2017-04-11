From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/2] provide isr for card-detect interrupts
Date: Tue, 11 Apr 2017 18:20:54 +0800
Message-ID: <20170411102056.2869-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

We found one issue on BG4CT platforms with GPIO for the card detect
interrupt: remove sdcard when there's read write access to the sdcard,
sometimes the card remove event can't be handled for a long time, so
the  system still think the sdcard is still plugged in. It turns out
that the sdhci_card_event() is missing in common slot gpio's card
detect isr. This should be common for all sdhci platforms.

We fix this issue by providing sdhci's own isr for card-detect
interrupts. In this own isr, we call sdhci_card_event() then process
the change of state.

patch1 is to prepare the fix in slot-gpio
patch2 is the real fix

Jisheng Zhang (2):
  mmc: slot-gpio: check cd_gpio before setting up cd_gpio_isr
  mmc: sdhci: provide isr for card-detect interrupts

 drivers/mmc/core/slot-gpio.c |  3 +++
 drivers/mmc/host/sdhci.c     | 12 ++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.11.0
