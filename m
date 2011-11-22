From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH V2] mmc: Kill block requests if card is removed
Date: Tue, 22 Nov 2011 14:10:42 +0100
Message-ID: <CAFEEs1n5k-0MqJXanLN=S1uEfzqFxoeCHnT3Gs6DjJB6t5819Q@mail.gmail.com>
References: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Hi Sujit,

On Tue, Nov 22, 2011 at 11:56 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
> Kill block requests when the host knows that the card is
> removed from the slot and is sure that subsequent requests
> are bound to fail. Do this silently so that the block
> layer doesn't output unnecessary error messages.
>
> This patch implements suggestion from Adrian Hunter,
> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>
> ---
> Changes in v2:
> =A0 =A0 =A0 =A0- Changed the implementation with further comments fro=
m Adrian
> =A0 =A0 =A0 =A0- Set the card removed flag in bus notifier callbacks
> =A0 =A0 =A0 =A0- This patch is now dependent on patch from Per Forlin=
:
> =A0 =A0 =A0 =A0http://thread.gmane.org/gmane.linux.kernel.mmc/11128/f=
ocus=3D11211
> ---
> =A0drivers/mmc/card/block.c | =A0 33 ++++++++++++++++++++++++++++----=
-
> =A0drivers/mmc/card/queue.c | =A0 =A05 +++++
> =A0drivers/mmc/core/bus.c =A0 | =A0 32 ++++++++++++++++++++++++++++++=
+-
> =A0drivers/mmc/core/core.c =A0| =A0 =A08 +++++++-
> =A0include/linux/mmc/card.h | =A0 =A03 +++
> =A05 files changed, 74 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index edc379e..83956fa 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_card =
*card, struct request *req,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* We couldn't get a response from the card. =A0Give u=
p. */
> - =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the card didn't respond to stat=
us command,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it is likely that card is gone. Fl=
ag it as removed,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mmc_detect_change() cleans the res=
t.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_removed(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_ABORT;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Flag ECC errors */
> =A0 =A0 =A0 =A0if ((status & R1_CARD_ECC_FAILED) ||
> @@ -1168,6 +1175,9 @@ static inline struct mmc_async_req *mmc_blk_res=
end(struct mmc_card *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int disable_multi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_async_req *areq)
> =A0{
> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mmc_get_drvdata(card);
> + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> + =A0 =A0 =A0 int ret;
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Release host after failure in case the host is need=
ed
> =A0 =A0 =A0 =A0 * by someone else. For instance, if the card is remov=
ed the
> @@ -1175,11 +1185,24 @@ static inline struct mmc_async_req *mmc_blk_r=
esend(struct mmc_card *card,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0mmc_release_host(card->host);
> =A0 =A0 =A0 =A0mmc_claim_host(card->host);
> -
> - =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
> - =A0 =A0 =A0 return mmc_start_req(card->host, areq, NULL);
> + =A0 =A0 =A0 if (mmc_card_removed(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* End the pending async request with=
out starting
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it when card is removed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd_flags |=3D REQ_QUIET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 -EIO, blk_rq_cur_bytes(req));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disable_=
multi, mq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_start_req(card->host, areq, =
NULL);
> + =A0 =A0 =A0 }
mmc_blk_resend is only called to resend a request that has failed. If
the card is removed the request will still be issued, but when it
retries it will give up here.
You have added a check in mmc_wait_for_req(). What about this:
--------------------------
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b526036..dcdcb9a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -287,11 +287,17 @@ static void mmc_wait_done(struct mmc_request *mrq=
)
        complete(&mrq->completion);
 }

-static void __mmc_start_req(struct mmc_host *host, struct mmc_request =
*mrq)
+static int __mmc_start_req(struct mmc_host *host, struct mmc_request *=
mrq)
 {
-       init_completion(&mrq->completion);
-       mrq->done =3D mmc_wait_done;
-       mmc_start_request(host, mrq);
+       if (mmc_card_removed(host->card)) {
+              mrq->cmd->error =3D -ENOMEDIUM;
+              return -ENOMEDIUM;
+       }
+
+       init_completion(&mrq->completion);
+       mrq->done =3D mmc_wait_done;
+       mmc_start_request(host, mrq);
+       return 0;
 }

 static void mmc_wait_for_req_done(struct mmc_host *host,
@@ -418,7 +424,8 @@ EXPORT_SYMBOL(mmc_start_req);
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
-       __mmc_start_req(host, mrq);
+       if (__mmc_start_req(host, mrq))
+               return
        mmc_wait_for_req_done(host, mrq);
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
----------------------------------
This patch will set error to -ENOMEDIUM for both mmc_start_req() and
mmc_wait_for_req()

mmc_blk_err_check() can check for -ENOMEDIUM and return something like
MMC_BLK_ENOMEDIUM
And eventually do
+               /*
+                * End the pending async request without starting
+                * it when card is removed.
+                */
+               spin_lock_irq(&md->lock);
+               req->cmd_flags |=3D REQ_QUIET;
+               do {
+                       ret =3D __blk_end_request(req,
+                                       -EIO, blk_rq_cur_bytes(req));
+               } while (ret);
+               spin_unlock_irq(&md->lock);

Regards,
Per
