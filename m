From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v1] mmc: core: Verify SD bus width
Date: Mon, 15 Apr 2019 15:00:31 -0600
Message-ID: <20190415210031.54062-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The SD Physical Layer Spec says the following: Since the SD Memory Card
shall support at least the two bus modes 1-bit or 4-bit width, then any SD
Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").

This change verifies the card has specified a bus width.

verified it didn't mount.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
AMD SDHC Device 7806 can get into a bad state after a card disconnect
where anything transferred via the DATA lines will always result in a
zero filled buffer. Currently the driver will continue without error if
the HC is in this condition. A block device will be created, but reading
from it will result in a zero buffer. This makes it seem like the SD
device has been erased, when in actuality the data is never getting
copied from the DATA lines to the data buffer.

SCR is the first command in the SD initialization sequence that uses the
DATA lines. By checking that the response was invalid, we can abort
mounting the card.

Here is an example of a bad trace: https://pastebin.com/TY2cF9n0
Look for sd_scr and sd_ssr.

 drivers/mmc/core/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..f6481f8e9fe7 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -205,6 +205,13 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
 	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
+
+	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
+	if (!scr->bus_widths) {
+		pr_err("%s: invalid bus width\n", mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	if (scr->sda_vsn == SCR_SPEC_VER_2)
 		/* Check if Physical Layer Spec v3.0 is supported */
 		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
-- 
2.21.0.392.gf8f6787159e-goog
