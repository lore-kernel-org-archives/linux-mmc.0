From: Chris Ball <cjb@laptop.org>
Subject: Re: [comments] MMC: Reliable write support.
Date: Wed, 30 Mar 2011 18:38:53 -0400
Message-ID: <m3mxkc44jm.fsf@pullcord.laptop.org>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<201103290901.31680.arnd@arndb.de>
	<AANLkTinDdEJ0bwH3Kj_QmhD=Z=07eaRvpA=sASn+DmkJ@mail.gmail.com>
	<201103301405.21047.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38916 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184Ab1C3WdC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Mar 2011 18:33:02 -0400
In-Reply-To: <201103301405.21047.arnd@arndb.de> (Arnd Bergmann's message of
	"Wed, 30 Mar 2011 14:05:20 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 30 2011, Arnd Bergmann wrote:
> On Wednesday 30 March 2011, Andrei Warkentin wrote:
>> On Tue, Mar 29, 2011 at 2:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 29 March 2011, Andrei Warkentin wrote:
>> >> On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >>
>> >> I confirmed with two MMC vendors that there is no "flush". Once the
>> >> DAT transfer completes, the data is stored on non-volatile storage as
>> >> soon as the busy status is cleared.
>> >>
>> >> Reliable writes are still "more reliable" because if the DAT transfer
>> >> is interrupted (power or reset through CMD0/CMD15 or hw pin for eMMC),
>> >> you have predictable flash contents. So it makes sense to map REQ_FUA
>> >> to it (and REQ_META, I would guess).
>> >
>> > Yes, sounds good.
>> >
>> > So I guess on MLC flash, a reliable write will go to a flash page
>> > that does not have data in any of its paired pages.
>> 
>> Should I resubmit the patch?
>
> I think the patch was ok, you can add my
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Chris, what is your opinion on the patch?

Looks unobjectionable to me, I'd take it with your ACK -- the only
thought I had was whether it might make sense to add a test to mmc_test
to check that reliable writes make it out successfully with the same
data they went in with; it would be awful if there was a data loss bug
in the code that we didn't catch because we aren't choosing to use
REQ_FUA/REQ_META.

Then I wondered if there are *other* types of request and data integrity
that we should be growing mmc_test to handle, and then I was wondering
whether this is the realm of mmc_test at all.  Any thoughts on that?  :)

I'd also apply the indentation/cleanup patch below, rebase against
mmc-next, and shorten the commit message to 74 chars.  (Andrei, please
check the below over for correctness in case I missed something.)

Thanks,

- Chris.

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 712fe96..91a6767 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -340,9 +340,9 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_data *md = mq->data;
 
 	/*
-	   No-op, only service this because we need REQ_FUA
-	   for reliable writes.
-	*/
+	 * No-op, only service this because we need REQ_FUA for reliable
+	 * writes.
+	 */
 	spin_lock_irq(&md->lock);
 	__blk_end_request_all(req, 0);
 	spin_unlock_irq(&md->lock);
@@ -364,16 +364,14 @@ static inline int mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	int err;
 	struct mmc_command set_count;
 
-	if (!(card->ext_csd.rel_param &
-	      EXT_CSD_WR_REL_PARAM_EN)) {
-
+	if (!(card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)) {
 		/* Legacy mode imposes restrictions on transfers. */
 		if (!IS_ALIGNED(brq->cmd.arg, card->ext_csd.rel_sectors))
 			brq->data.blocks = 1;
 
 		if (brq->data.blocks > card->ext_csd.rel_sectors)
 			brq->data.blocks = card->ext_csd.rel_sectors;
-		else if (brq->data.blocks != card->ext_csd.rel_sectors)
+		else if (brq->data.blocks < card->ext_csd.rel_sectors)
 			brq->data.blocks = 1;
 	}
 
@@ -396,8 +394,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	int ret = 1, disable_multi = 0;
 
 	/*
-	  Reliable writes are used to implement Forced Unit Access and
-	  REQ_META accesses, and it's supported only on MMCs.
+	 * Reliable writes are used to implement Forced Unit Access and
+	 * REQ_META accesses, and are supported only on MMCs.
 	 */
 	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
 			  (req->cmd_flags & REQ_META)) &&
@@ -464,10 +462,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 			brq.data.flags |= MMC_DATA_WRITE;
 		}
 
-		if (do_rel_wr) {
-			if (mmc_apply_rel_rw(&brq, card, req))
-				goto cmd_err;
-		}
+		if (do_rel_wr && mmc_apply_rel_rw(&brq, card, req))
+			goto cmd_err;
 
 		mmc_set_data_timeout(&brq.data, card);
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
