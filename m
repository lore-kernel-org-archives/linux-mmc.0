From: Patch from Johan Kristell <linuxtv-commits-bounces-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
Subject: [linuxtv-commits] [git:v4l-dvb/master] mmc_test: block addressed
	cards
Date: Sat, 06 Mar 2010 15:26:03 +0100
Message-ID: <E1Nnux9-0000fV-RS@www.linuxtv.org>
Reply-To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtv-commits-bounces+gcvl-linuxtv-commits=m.gmane.org-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://www.linuxtv.org/cgi-bin/mailman/options/linuxtv-commits>,
	<mailto:linuxtv-commits-request-dJidKbW2IEtAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:linuxtv-commits-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtv-commits-request-dJidKbW2IEtAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://www.linuxtv.org/cgi-bin/mailman/listinfo/linuxtv-commits>,
	<mailto:linuxtv-commits-request-dJidKbW2IEtAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: linuxtv-commits-bounces-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
Errors-To: linuxtv-commits-bounces+gcvl-linuxtv-commits=m.gmane.org-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
To: linuxtv-commits-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Johan Kristell <johan.kristell-VrBV9hrLPhE@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Johan Kristell <johan.kristell-VrBV9hrLPhE@public.gmane.org>

This patch fixes a bug in the multiblock write tests where the written
data is read back for verifying one block at a time.  The tests in
mmc_test assumes that all cards are byte addressable.

This will cause the multi block write tests to fail, leading the user of
the mmc_test driver thinking there is something wrong with the sdhci
driver they are testing.

The start address for the block is calculated as: blocknum * 512. For
block addressable cards the blocknum alone should be used.

Signed-off-by: Johan Kristell <johan.kristell-VrBV9hrLPhE@public.gmane.org>
Cc: <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Signed-off-by: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

 drivers/mmc/card/mmc_test.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

---

http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=c286d03cce118e9fb8dda8da43f9131c169c5a75

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b9f1e84..e7f8027 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -74,6 +74,9 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
 	}
 
 	mrq->cmd->arg = dev_addr;
+	if (!mmc_card_blockaddr(test->card))
+		mrq->cmd->arg <<= 9;
+
 	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	if (blocks == 1)
@@ -190,7 +193,7 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
 	}
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -219,7 +222,7 @@ static int mmc_test_cleanup(struct mmc_test_card *test)
 	memset(test->buffer, 0, 512);
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -426,7 +429,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 		for (i = 0;i < sectors;i++) {
 			ret = mmc_test_buffer_transfer(test,
 				test->buffer + i * 512,
-				dev_addr + i * 512, 512, 0);
+				dev_addr + i, 512, 0);
 			if (ret)
 				return ret;
 		}
