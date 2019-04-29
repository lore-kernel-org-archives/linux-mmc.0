From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v3] mmc: core: Verify SD bus width
Date: Mon, 29 Apr 2019 11:32:39 -0600
Message-ID: <20190429173239.51305-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Avri Altman <avri.altman@wdc.com>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The SD Physical Layer Spec says the following: Since the SD Memory Card
shall support at least the two bus modes 1-bit or 4-bit width, then any SD
Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").

This change verifies the card has specified a bus width.

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

Acked-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
Here is the testing I did:

Good Trace: https://paste.fedoraproject.org/paste/oVEI5b0IzHD23Yo7CDZgEg
[   30.103686] mmc0: new high speed SDHC card at address 0001
[   30.105262] mmcblk0: mmc0:0001 00000 7.41 GiB
[   30.108258]  mmcblk0: p1
[   31.947250] mmc0: card 0001 removed

Bad Trace (before patch): https://paste.fedoraproject.org/paste/jBWfpFBM8gdEmGOzxij~hw

Bad Trace (after patch): https://paste.fedoraproject.org/paste/8gB8MLYOKEUZEgHXmQ0W1Q
[   33.810760] mmc0: invalid bus width
[   33.810782] mmc0: error -22 whilst initialising SD card
[   34.068818] mmc0: invalid bus width
[   34.068839] mmc0: error -22 whilst initialising SD card
[   34.329521] mmc0: invalid bus width
[   34.329543] mmc0: error -22 whilst initialising SD card
[   34.592061] mmc0: invalid bus width
[   34.592084] mmc0: error -22 whilst initialising SD card

In the traces you can see sd_scr is different

Changes in v3:
- Rebased on mmc/next

Changes in v2:
- Made the bus width check stricter. It now requires the value to match
  the spec.

 drivers/mmc/core/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..d3d32f9a2cb1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -221,6 +221,14 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+
+	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
+	if (!(scr->bus_widths & SD_SCR_BUS_WIDTH_1) ||
+	    !(scr->bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		pr_err("%s: invalid bus width\n", mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.21.0.593.g511ec345e18-goog
