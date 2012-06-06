From: Rahul Bedarkar <rpal143@gmail.com>
Subject: Re: [RFC/PATCH 1/1] mmc: block: Add MMC write packing statistics
Date: Wed, 6 Jun 2012 12:02:10 +0530
Message-ID: <CA+NV+VknemgROF5DsSVJ8MDUEyMnrM_vtj66nUTKP6ZvxsF+ag@mail.gmail.com>
References: <1338963389-3147-1-git-send-email-merez@codeaurora.org> <1338963389-3147-2-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1338963389-3147-2-git-send-email-merez@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

See comments inline.

On Wed, Jun 6, 2012 at 11:46 AM, Maya Erez <merez@codeaurora.org> wrote=
:
> The write packing statistics are used for the packed commands unit te=
sts
> in order to determine test success or failure
>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 2785fd4..c33c0c8 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -63,6 +63,11 @@ MODULE_ALIAS("mmc:block");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(rq_data_dir(req) =3D=3D=
 WRITE))
> =A0#define PACKED_CMD_VER =A0 =A0 =A0 =A0 0x01
> =A0#define PACKED_CMD_WR =A0 =A0 =A0 =A0 =A00x02
> +#define MMC_BLK_UPDATE_STOP_REASON(stats, reason) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stats->enabled) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stats->pack_stop_reason=
[reason]++; =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 } while (0)
>
> =A0static DEFINE_MUTEX(block_mutex);
>
> @@ -1313,6 +1318,35 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
> =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
> =A0}
>
> +struct mmc_wr_pack_stats *mmc_blk_get_packed_statistics(struct mmc_c=
ard *card)
> +{
> + =A0 =A0 =A0 if (!card)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 return &card->wr_pack_stats;
> +}
> +EXPORT_SYMBOL(mmc_blk_get_packed_statistics);
> +
> +void mmc_blk_init_packed_statistics(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int max_num_of_packed_reqs =3D 0;
> +
> + =A0 =A0 =A0 if (!card || !card->wr_pack_stats.packing_events)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 max_num_of_packed_reqs =3D card->ext_csd.max_packed_wri=
tes;
> +
> + =A0 =A0 =A0 spin_lock(&card->wr_pack_stats.lock);
> + =A0 =A0 =A0 memset(card->wr_pack_stats.packing_events, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (max_num_of_packed_reqs + 1) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*card->wr_pack_stats.packing_even=
ts));
> + =A0 =A0 =A0 memset(&card->wr_pack_stats.pack_stop_reason, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(card->wr_pack_stats.pack_stop_re=
ason));
> + =A0 =A0 =A0 card->wr_pack_stats.enabled =3D true;
> + =A0 =A0 =A0 spin_unlock(&card->wr_pack_stats.lock);
> +}
> +EXPORT_SYMBOL(mmc_blk_init_packed_statistics);
> +
> =A0static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct re=
quest *req)
> =A0{
> =A0 =A0 =A0 =A0struct request_queue *q =3D mq->queue;
> @@ -1325,6 +1359,7 @@ static u8 mmc_blk_prep_packed_list(struct mmc_q=
ueue *mq, struct request *req)
> =A0 =A0 =A0 =A0u8 put_back =3D 0;
> =A0 =A0 =A0 =A0u8 max_packed_rw =3D 0;
> =A0 =A0 =A0 =A0u8 reqs =3D 0;
> + =A0 =A0 =A0 struct mmc_wr_pack_stats *stats =3D &card->wr_pack_stat=
s;
>
> =A0 =A0 =A0 =A0mmc_blk_clear_packed(mq->mqrq_cur);
>
> @@ -1359,20 +1394,26 @@ static u8 mmc_blk_prep_packed_list(struct mmc=
_queue *mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys_segments++;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 spin_lock(&stats->lock);
> +
> =A0 =A0 =A0 =A0while (reqs < max_packed_rw - 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq(q->queue_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0next =3D blk_fetch_request(q);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!next)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BLK_UPDATE_STOP_REA=
SON(stats, EMPTY_QUEUE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (next->cmd_flags & REQ_DISCARD ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0next->=
cmd_flags & REQ_FLUSH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BLK_UPDATE_STOP_REA=
SON(stats, FLUSH_OR_DISCARD);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_back =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rq_data_dir(cur) !=3D rq_data_dir(=
next)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BLK_UPDATE_STOP_REA=
SON(stats, WRONG_DATA_DIR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_back =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1380,18 +1421,22 @@ static u8 mmc_blk_prep_packed_list(struct mmc=
_queue *mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_req_rel_wr(next) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(md->f=
lags & MMC_BLK_REL_WR) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!en_re=
l_wr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BLK_UPDATE_STOP_REA=
SON(stats, REL_WRITE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_back =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req_sectors +=3D blk_rq_sectors(next);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req_sectors > max_blk_count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stats->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stats->=
pack_stop_reason[EXCEEDS_SECTORS]++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_back =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys_segments +=3D =A0next->nr_phys_se=
gments;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (phys_segments > max_phys_segs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BLK_UPDATE_STOP_REA=
SON(stats, EXCEEDS_SEGMENTS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_back =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1407,6 +1452,15 @@ static u8 mmc_blk_prep_packed_list(struct mmc_=
queue *mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (stats->enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reqs + 1 <=3D card->ext_csd.max_pac=
ked_writes)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stats->packing_events[r=
eqs + 1]++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reqs + 1 =3D=3D max_packed_rw)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BLK_UPDATE_STOP_REA=
SON(stats, THRESHOLD);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock(&stats->lock);
> +
> =A0 =A0 =A0 =A0if (reqs > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_add(&req->queuelist, &mq->mqrq_cu=
r->packed_list);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->mqrq_cur->packed_num =3D ++reqs;
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 9b68933..e3b0e74 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -251,6 +251,8 @@ struct mmc_card *mmc_alloc_card(struct mmc_host *=
host, struct device_type *type)
> =A0 =A0 =A0 =A0card->dev.release =3D mmc_release_card;
> =A0 =A0 =A0 =A0card->dev.type =3D type;
>
> + =A0 =A0 =A0 spin_lock_init(&card->wr_pack_stats.lock);
> +
> =A0 =A0 =A0 =A0return card;
> =A0}
>
> @@ -353,6 +355,8 @@ void mmc_remove_card(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_del(&card->dev);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 kfree(card->wr_pack_stats.packing_events);
> +
> =A0 =A0 =A0 =A0put_device(&card->dev);
> =A0}
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 9ab5b17..898e358 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -318,6 +318,164 @@ static const struct file_operations mmc_dbg_ext=
_csd_fops =3D {
> =A0 =A0 =A0 =A0.llseek =A0 =A0 =A0 =A0 =3D default_llseek,
> =A0};
>
> +static int mmc_wr_pack_stats_open(struct inode *inode, struct file *=
filp)
> +{
> + =A0 =A0 =A0 struct mmc_card *card =3D inode->i_private;
> +
> + =A0 =A0 =A0 filp->private_data =3D card;
> + =A0 =A0 =A0 card->wr_pack_stats.print_in_read =3D 1;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#define TEMP_BUF_SIZE 256
> +static ssize_t mmc_wr_pack_stats_read(struct file *filp, char __user=
 *ubuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t =
cnt, loff_t *ppos)
> +{
> + =A0 =A0 =A0 struct mmc_card *card =3D filp->private_data;
> + =A0 =A0 =A0 struct mmc_wr_pack_stats *pack_stats;
> + =A0 =A0 =A0 int i;
Best practice is to initialize variables at the time of declaration,
even if you initialize it before using. Many times we forget to do
that and there could be logical errors.
> + =A0 =A0 =A0 int max_num_of_packed_reqs =3D 0;
> + =A0 =A0 =A0 char *temp_buf;
Same here.
> +
> + =A0 =A0 =A0 if (!card)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cnt;
> +
> + =A0 =A0 =A0 if (!card->wr_pack_stats.print_in_read)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (!card->wr_pack_stats.enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: write packing statistics a=
re disabled\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->h=
ost));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pack_stats =3D &card->wr_pack_stats;
> +
> + =A0 =A0 =A0 if (!pack_stats->packing_events) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: NULL packing_events\n", mm=
c_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 max_num_of_packed_reqs =3D card->ext_csd.max_packed_wri=
tes;
> +
> + =A0 =A0 =A0 temp_buf =3D kmalloc(TEMP_BUF_SIZE, GFP_KERNEL);
> + =A0 =A0 =A0 if (!temp_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
> +
> + =A0 =A0 =A0 spin_lock(&pack_stats->lock);
> +
> + =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE, "%s: write packing st=
atistics:\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host));
> + =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> +
> + =A0 =A0 =A0 for (i =3D 1 ; i <=3D max_num_of_packed_reqs ; ++i) {
This is something magical number for iterations. why can not we start f=
rom zero.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pack_stats->packing_events[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP=
_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s:=
 Packed %d reqs - %d times\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(card->host), i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_st=
ats->packing_events[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf,=
 cnt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: stopped packing due to the foll=
owing reasons:\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->host));
> + =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> +
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[EXCEEDS_SEGMENTS]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: excee=
d max num of segments\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->h=
ost),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pack_stats->pack_sto=
p_reason[EXCEEDS_SEGMENTS]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[EXCEEDS_SECTORS]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: excee=
d max num of sectors\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_stats->pack_stop_r=
eason[EXCEEDS_SECTORS]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[WRONG_DATA_DIR]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: wrong=
 data direction\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_stats->pack_stop_r=
eason[WRONG_DATA_DIR]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[FLUSH_OR_DISCARD]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: flush=
 or discard\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_stats->pack_stop_r=
eason[FLUSH_OR_DISCARD]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[EMPTY_QUEUE]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: empty=
 queue\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_stats->pack_stop_r=
eason[EMPTY_QUEUE]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[REL_WRITE]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: rel w=
rite\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_stats->pack_stop_r=
eason[REL_WRITE]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pack_stats->pack_stop_reason[THRESHOLD]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(temp_buf, TEMP_BUF_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: %d times: Thres=
hold\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_stats->pack_stop_r=
eason[THRESHOLD]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcat(ubuf, temp_buf, cnt);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock(&pack_stats->lock);
> +
> + =A0 =A0 =A0 kfree(temp_buf);
> +
> + =A0 =A0 =A0 pr_info("%s", ubuf);
> +
> +exit:
> + =A0 =A0 =A0 if (card->wr_pack_stats.print_in_read =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->wr_pack_stats.print_in_read =3D 0=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return strnlen(ubuf, cnt);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t mmc_wr_pack_stats_write(struct file *filp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0const char __user *ubuf, size_t cnt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0loff_t *ppos)
> +{
> + =A0 =A0 =A0 struct mmc_card *card =3D filp->private_data;
> + =A0 =A0 =A0 int value;
same here
> +
> + =A0 =A0 =A0 if (!card)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cnt;
> +
> + =A0 =A0 =A0 sscanf(ubuf, "%d", &value);
> + =A0 =A0 =A0 if (value) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_init_packed_statistics(card);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&card->wr_pack_stats.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->wr_pack_stats.enabled =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&card->wr_pack_stats.lock);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return cnt;
> +}
> +
> +static const struct file_operations mmc_dbg_wr_pack_stats_fops =3D {
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D mmc_wr_pack_stats_open,
> + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D mmc_wr_pack_stats_read,
> + =A0 =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D mmc_wr_pack_stats_write,
> +};
> +
> =A0void mmc_add_card_debugfs(struct mmc_card *card)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *host =3D card->host;
> @@ -350,6 +508,12 @@ void mmc_add_card_debugfs(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&mmc_dbg_ext_csd_fops))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>
> + =A0 =A0 =A0 if (mmc_card_mmc(card) && (card->ext_csd.rev >=3D 6) &&
> + =A0 =A0 =A0 =A0 =A0 (card->host->caps2 & MMC_CAP2_PACKED_WR))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!debugfs_create_file("wr_pack_stats=
", S_IRUSR, root, card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&mmc_dbg_wr_pack_stats_fops))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> =A0 =A0 =A0 =A0return;
>
> =A0err:
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9b421fb..6b0b85d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1268,6 +1268,24 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.packed_e=
vent_en =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!oldcard) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_PACKED_CMD)=
 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_packed_write=
s > 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We would like to k=
eep the statistics in an index
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* that equals the nu=
m of packed requests
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (1 to max_packed_w=
rites)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->wr_pack_stats.pac=
king_events =3D kzalloc(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->=
ext_csd.max_packed_writes + 1) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
*card->wr_pack_stats.packing_events),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->wr_pack_stat=
s.packing_events)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fr=
ee_card;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!oldcard)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4aeb4e9..d3ffef6 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -205,6 +205,25 @@ struct mmc_part {
> =A0#define MMC_BLK_DATA_AREA_GP =A0 (1<<2)
> =A0};
>
> +enum mmc_packed_stop_reasons {
> + =A0 =A0 =A0 EXCEEDS_SEGMENTS =3D 0,
> + =A0 =A0 =A0 EXCEEDS_SECTORS,
> + =A0 =A0 =A0 WRONG_DATA_DIR,
> + =A0 =A0 =A0 FLUSH_OR_DISCARD,
> + =A0 =A0 =A0 EMPTY_QUEUE,
> + =A0 =A0 =A0 REL_WRITE,
> + =A0 =A0 =A0 THRESHOLD,
> + =A0 =A0 =A0 MAX_REASONS,
> +};
> +
> +struct mmc_wr_pack_stats {
> + =A0 =A0 =A0 u32 *packing_events;
> + =A0 =A0 =A0 u32 pack_stop_reason[MAX_REASONS];
> + =A0 =A0 =A0 spinlock_t lock;
> + =A0 =A0 =A0 bool enabled;
> + =A0 =A0 =A0 bool print_in_read;
> +};
> +
> =A0/*
> =A0* MMC device
> =A0*/
> @@ -277,6 +296,7 @@ struct mmc_card {
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
> =A0 =A0 =A0 =A0struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physic=
al partitions */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0nr_parts;
> + =A0 =A0 =A0 struct mmc_wr_pack_stats wr_pack_stats; /* packed comma=
nds stats*/
> =A0};
>
> =A0/*
> @@ -498,4 +518,8 @@ extern void mmc_unregister_driver(struct mmc_driv=
er *);
> =A0extern void mmc_fixup_device(struct mmc_card *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct =
mmc_fixup *table);
>
> +extern struct mmc_wr_pack_stats *mmc_blk_get_packed_statistics(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_card *card);
> +extern void mmc_blk_init_packed_statistics(struct mmc_card *card);
> +
> =A0#endif /* LINUX_MMC_CARD_H */
> --
> 1.7.3.3
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
