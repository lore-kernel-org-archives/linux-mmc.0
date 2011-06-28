From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 12/12] mmc: block: add handling for two parallel block
	requests in issue_rw_rq
Date: Tue, 28 Jun 2011 11:39:41 +0200
Message-ID: <BANLkTikkv+RQKZCX2PeZUDhM1gnVXCKO2w@mail.gmail.com>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<1309248717-14606-13-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1309248717-14606-13-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nickolay
List-Id: linux-mmc@vger.kernel.org

On 28 June 2011 10:11, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Change mmc_blk_issue_rw_rq() to become asynchronous.
> The execution flow looks like this:
> The mmc-queue calls issue_rw_rq(), which sends the request
> to the host and returns back to the mmc-queue. The mmc-queue calls
> issue_rw_rq() again with a new request. This new request is prepared,
> in isuue_rw_rq(), then it waits for the active request to complete before
> pushing it to the host. When to mmc-queue is empty it will call
> isuue_rw_rq() with req=3DNULL to finish off the active request
> without starting a new request.
>
> Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =A0drivers/mmc/card/block.c | =A0 80 ++++++++++++++++++++++++++++++++++++=
+--------
> =A0drivers/mmc/card/queue.c | =A0 17 +++++++---
> =A0drivers/mmc/card/queue.h | =A0 =A01 +
> =A03 files changed, 78 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 7ed2c68..825741e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
...
> @@ -1066,6 +1085,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *m=
q, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D __blk_end_request(=
req, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0brq->data.bytes_xfered);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status =3D=3D MMC_BLK_S=
UCCESS && ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If this =
happen it is a bug */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_ERR "%s BUG rq_tot %d d_xfer %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0__func__, blk_rq_bytes(req),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0brq->data.bytes_xfered);
+ rqc =3D NULL
If there is a new request (rqc !=3D NULL)  it will already be started
when reaching this point.
If rqc is set it will be started again at start_new_req.

I wonder if this paranoia check is necessary. If "status =3D=3D
MMC_BLK_SUCCESS" all bytes are transferred and no error returned from
mmc layer.
 __blk_end_request would always return 0 in this case, please comment
if you disagree.

...
> + start_new_req:
> + =A0 =A0 =A0 if (rqc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, m=
q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->host, &mq->mqrq_cur->mm=
c_active, NULL);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}

/Per
