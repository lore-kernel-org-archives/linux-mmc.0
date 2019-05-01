From: Raul E Rangel <rrangel@chromium.org>
Subject: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after reset
Date: Wed,  1 May 2019 11:54:56 -0600
Message-ID: <20190501175457.195855-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, Raul E Rangel <rrangel@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

There is a race condition between resetting the SDHCI controller and
disconnecting the card.

For example:
0) Card is connected and transferring data
1) mmc_sd_reset is called to reset the controller due to a data error
2) sdhci_set_ios calls sdhci_do_reset
3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
configured.
4) Wait for SOFT_RESET_ALL to clear
5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
   IRQs are not configured a CARD_REMOVED interrupt is never raised.
6) IRQs are enabled again
7) mmc layer never notices the device is disconnected. The SDHCI layer
   will keep returning -ENOMEDIUM. This results in a card that is always
   present and not functional.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
You can see an example of the following two patches here:
https://privatebin.net/?b0f5953716d34ca6#C699bCBQ99NdvspfDW7CMucT8CJG4DgL+yUNPyepDCo=
Line 8213: EILSEQ
Line 8235: SDHC is hard reset
Line 8240: Controller completes reset and card is no longer present
Line 8379: mmc_sd_reset notices card is missing and issues a card_event
           and schedules a detect change.
Line 8402: Don't init the card since it's already gone.
Line 8717: Marks card as removed
Line 8820: mmc_sd_remove removes the block device

I am running into a kernel panic. A task gets stuck for more than 120
seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
calling something correctly?

Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=

I sometimes see the following:
[  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time

I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
So I'm guessing I'm missing an upstream fix.

Do the patches look correct or am I doing something that would cause a
kernel panic?

I have a DUT setup with a GPIO I can use to toggle the CD pin. I ran a
test where I connect and then randomly, between 0s - 1s disconnect the
card. This got over 20k iterations before the panic. Though when I do it
manually and stop for 2 minutes the panic happens.

Any help would be appreciated.

Thanks,
Raul


 drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..9206c4297d66 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 
 static int mmc_sd_hw_reset(struct mmc_host *host)
 {
+	int present;
 	mmc_power_cycle(host, host->card->ocr);
+
+	present = host->ops->get_cd(host);
+
+	/* The card status could have changed while resetting. */
+	if ((mmc_card_removed(host->card) && present) ||
+	    (!mmc_card_removed(host->card) && !present)) {
+		pr_info("%s: card status changed during reset\n",
+		       mmc_hostname(host));
+		host->ops->card_event(host);
+		mmc_detect_change(host, 0);
+	}
+
+	/* Don't perform unnecessary transactions if the card is missing. */
+	if (!present) {
+		pr_info("%s: card was removed during reset\n",
+			mmc_hostname(host));
+		return -ENOMEDIUM;
+	}
+
 	return mmc_sd_init_card(host, host->card->ocr, host->card);
 }
 
-- 
2.21.0.593.g511ec345e18-goog
