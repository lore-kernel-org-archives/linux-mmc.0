From: Evan Green <evgreen@chromium.org>
Subject: [PATCH RFC] mmc: sdhci: Don't get card-detect without preemption
Date: Tue,  1 May 2018 16:47:21 -0700
Message-ID: <20180501234721.187135-1-evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Evan Green <evgreen@chromium.org>
List-Id: linux-mmc@vger.kernel.org

For a controller with SDHCI_QUIRK_NO_CARD_NO_RESET, there are several
conditions where sdhci_do_reset is called under a spinlock with interrupts
disabled. The card detect is often a GPIO, which might sleep. Avoid
asking for the card detect status if interrupts are disabled to prevent
a warning like the following:

[    2.480199] Call trace:
[    2.480218] [<ffffff800808a698>] dump_backtrace+0x0/0x228
[    2.480224] [<ffffff800808a8e0>] show_stack+0x20/0x28
[    2.480235] [<ffffff80088a0214>] dump_stack+0x90/0xb0
[    2.480245] [<ffffff80080d7aa8>] ___might_sleep+0x110/0x128
[    2.480248] [<ffffff80080d7b38>] __might_sleep+0x78/0x88
[    2.480260] [<ffffff80083cdd28>] gpiod_get_raw_value_cansleep+0x2c/0xc4
[    2.480269] [<ffffff80086a93a8>] mmc_gpio_get_cd+0x3c/0x68
[    2.480275] [<ffffff80086b008c>] sdhci_get_cd+0x20/0x98
[    2.480280] [<ffffff80086b081c>] sdhci_do_reset+0x50/0x88
[    2.480283] [<ffffff80086b4640>] sdhci_tasklet_finish+0x1a8/0x270
[    2.480292] [<ffffff80080b29d4>] tasklet_action+0x90/0xf4
[    2.480296] [<ffffff80080813b8>] __do_softirq+0x1c8/0x360
[    2.480300] [<ffffff80080b2408>] irq_exit+0x88/0xd0

---

I discovered this warning while trying to bring up SD, somewhat unsuccessfully,
on a new device, and hit this error path.

This change is not ideal as it only makes a best effort to adhere to the quirk,
but may in some cases end up resetting the controller with no card present.

Another option I considered was trying to call sdhci_do_reset within only
sleepable contexts. I actually got as far as converting the tasklet to a
work queue, and deferring the reset to the end of the function in
sdhci_request_done. But 1) I'm not sure if that deferral was actually safe,
and 2) we call sdhci_do_reset from under the lock in several other places,
such as sdhci_card_event and sdhci_cqe_disable.

Finally, I also considered calling the non-_maysleep gpio functions in
mmc_gpio_get_cd. I assume this is not workable as someone somewhere has put
a card detect off of a PMIC or GPIO expander.

Any advice?

---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 759278dd317d..c5273acf6987 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -210,7 +210,7 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		struct mmc_host *mmc = host->mmc;
 
-		if (!mmc->ops->get_cd(mmc))
+		if (preemptible() && !mmc->ops->get_cd(mmc))
 			return;
 	}
 
-- 
2.13.5
