From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: max_discard anomaly on certain Sandisk eMMC
Date: Mon, 16 Dec 2013 16:18:08 -0700
Message-ID: <52AF8A30.9050700@wwwdotorg.org>
References: <52AB8DA2.9000001@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50141 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab3LPXSM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 18:18:12 -0500
In-Reply-To: <52AB8DA2.9000001@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 12/13/2013 03:43 PM, Stephen Warren wrote:
> On one of my eMMC devices, I see the following results from calling
> mmc_do_calc_max_discard() with various parameters:
> 
> [    3.057263] MMC_DISCARD_ARG max_discard 1
> [    3.057266] MMC_ERASE_ARG   max_discard 4096
> [    3.057267] MMC_TRIM_ARG    max_discard 1
> 
> This causes mmc_calc_max_discard() to return 1, which makes the discard
> IOCTL extremely slow.

Further investigation shows that if I make a few hacks that essentially
revert e056a1b5b67b "mmc: queue: let host controllers specify maximum
discard timeout":

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 357bbc54fe4b..e66af930d0e3 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -167,13 +167,15 @@ static void mmc_queue_setup_discard(struct
request_queue *q,
 		return;

 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
-	q->limits.max_discard_sectors = max_discard;
+	q->limits.max_discard_sectors = UINT_MAX;
 	if (card->erased_byte == 0 && !mmc_can_discard(card))
 		q->limits.discard_zeroes_data = 1;
 	q->limits.discard_granularity = card->pref_erase << 9;
 	/* granularity must not be greater than max. discard */
+#if 0
 	if (card->pref_erase > max_discard)
 		q->limits.discard_granularity = 0;
+#endif
 	if (mmc_can_secure_erase_trim(card))
 		queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
 }

I end up with:

$ cat /sys/.../block/mmcblk1/queue# cat discard_granularity
2097152
$ cat /sys/.../block/mmcblk1/queue# cat discard_max_bytes
2199023255040
$ cat /sys/.../block/mmcblk1/queue# cat discard_zeroes_data
1

With those values, mke2fs is fast, and I validated that "blkdiscard"
works; I filled a large partition with /dev/urandom, executed
"blkdiscard" on the 4M at the start, and saw zeroes when reading the
discarded part back.

This implies that the issue is simply the operation of
mmc_calc_max_discard(), rather than the eMMC device mis-reporting its
discard abilities, doesn't it?
