From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue,  6 Nov 2018 14:30:07 +0100
Message-ID: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On some of our boards containing Micron eMMC chips compatible with
the eMMC 5.0 specification we starting seeing boot failures due to
timeouts:
  mmc1: error -110 whilst initialising MMC card

It turns out that switching the cache on after a power loss event can
take quite long. In some simple testing thusfar we've seen values up to
700ms, which is far longer then the GENERIC_CMD6_TIME of the chip
(250ms).

Looking at both the eMMC 4.51 and 5.0 specification there doesn't seem
to be a defined upper bound for the CACHE_CTRL ON command. For both
CACHE_CTRL OFF and FLUSH_CACHE it is documented that they can take
essentially unbounded time, but CACHE_CTRL ON i get the impression that
it's assumed to be "fast". Unfortunately this is not true in reality.

To resolve this, simply drop the timeout from CACHE_CTRL ON and assume
it might take an unbounded time similar to the FLUSH_CACHE command.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 drivers/mmc/core/mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bc1bd2c25613..ac70b508a939 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1794,8 +1794,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!mmc_card_broken_hpi(card) &&
 	    card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1,
-				card->ext_csd.generic_cmd6_time);
+				EXT_CSD_CACHE_CTRL, 1, 0);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
-- 
2.19.1
