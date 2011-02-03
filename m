From: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: [RFC] mmc: davinci: fix corruption after surprise card eject
Date: Thu,  3 Feb 2011 18:10:33 +0900
Message-ID: <1296724233-3903-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Ejecting a card during a write results in a bad controller state which
corrupts all writes to subsequently inserted cards.

Work around this by resetting the controller in the set_ios() POWER_OFF
handler.

Tested on DM355.

Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
---

This patch is against 2.6.36, it does not include the latest SDIO patch
at least.

To reproduce this in the unpatched sources, write heavily to the card
and eject it during a write. Note that for the first few seconds of
"writing a file" nothing is actually written to the card, it is cached
by Linux.

In the broken state that results, if a card is reinserted, the effect
is as if an internal write FIFO has not been cleared and contains 2
extra bytes. Tests suggest this is not the documented 32-byte FIFO but
something beyond that.
All blocks appear on the card starting with the last two bytes of the
previous block write, then the remaining sector data; the last two
bytes overflow into the next written sector, etc.

Toggling MMCCTL.CMDRST,DATRST clears this condition. These are toggled
several times during the error handlers called when the card is ejected
during write, but it seems the bad state is entered at some point later.

set_ios(MMC_POWER_OFF) seems to consistently be called at the end of
the cleanup process before a newly-inserted card is accessed, putting
an extra controller reset in here gets rid of the problem - but I'm not
sure this is the right way to fix this, it has a workaround feel.

Comments sought.. thanks.

---
 drivers/mmc/host/davinci_mmc.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 33d9f1b..e5ee1c1 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -795,6 +795,9 @@ static void calculate_clk_divider(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 }
 
+static void
+davinci_abort_data(struct mmc_davinci_host *host, struct mmc_data *data);
+
 static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmc_davinci_host *host = mmc_priv(mmc);
@@ -856,9 +859,14 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		if (lose)
 			dev_warn(mmc_dev(host->mmc), "powerup timeout\n");
-	}
 
-	/* FIXME on power OFF, reset things ... */
+	} else if (ios->power_mode == MMC_POWER_OFF) {
+
+		/* Controller maybe in bad state, e.g. card pulled while writing */
+		davinci_abort_data(host, NULL);
+
+		/* FIXME on power OFF, reset more things ...? */
+	}
 }
 
 static void
-- 
1.6.3.3
