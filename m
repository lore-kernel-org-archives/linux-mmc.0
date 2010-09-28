From: Ethan Du <ethan.too@gmail.com>
Subject: Re: [PATCH] MMC: Refine block layer waiting for card state
Date: Tue, 28 Sep 2010 19:03:50 +0800
Message-ID: <AANLkTi=UGy-Q=LZRPUnGqojTCcMOVDGHFJW5hhAWr50a@mail.gmail.com>
References: <AANLkTi=E9imw9GQFU2_eMMPULKuWXMWeXdzCgjUFycD0@mail.gmail.com>
	<4CA1905D.5010701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61724 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab0I1LDv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 07:03:51 -0400
Received: by gxk9 with SMTP id 9so1861718gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 04:03:50 -0700 (PDT)
In-Reply-To: <4CA1905D.5010701@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

On Tue, Sep 28, 2010 at 2:51 PM, Adrian Hunter <adrian.hunter@nokia.com=
> wrote:
> On 27/09/10 06:32, Ethan Du wrote:
>>
>> =A0 =A0 The while loop when handling rw request may become deadloop =
in
>> case of bad card
>> =A0 =A0 I've seen mmcqd gets blocked forever after a single error me=
ssage:
>>
>> mmcblk0: error -110 sending read/write command, response 0x900, card
>> status 0x80e00
>>
>> =A0 =A0 Also there was case of card reports status without error
>>
>> mmcblk0: error -110 sending read/write command, response 0x900, card
>> status 0xe00
>>
>> =A0 =A0 After this error, the card can stay in prg state, and never =
comes
>> back,
>> =A0 =A0 and may not report any error further. So a break out conditi=
on
>> =A0 =A0 should be set in mmc block layer:
>> * should not enter the waiting loop in case of error
>
> How do you know there are not any errors where you do need to wait?

Would you enumerate an example?
I am not sure all hosts, seem most host controllers already wait
enough time before return to block layer when cmd->flags has
MMC_RSP_BUSY

>
>> * should break out from the waiting loop, if card response with erro=
r
>> * should break out from the waiting loop when timeout
>>
>> =A0 =A0 These will not help with the card, one more thing to do:
>> * re-init the card in case of too many errors
>
> Using mmc_detect_change() will give you a new block device.
> That is probably a bad idea for a non-removable card. =A0Also

Yes, figured it is better to do something like host resume.
I made a function mmc_reinit_host(), will send out the patch

> if the reinitialization is going to help, then why wait for
> lots of errors before doing it.

With the hope that, card can still work after this error

>
>>
>> Signed-off-by: Ethan Du<ethan.too@gmail.com>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 35 +++++++++++++++++++++++++++----=
----
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A09 +++++++--
>> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 =A08 ++++++--
>> =A0include/linux/mmc/card.h | =A0 =A03 +++
>> =A0include/linux/mmc/mmc.h =A0| =A0 =A01 +
>> =A05 files changed, 44 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index d545f79..1d304a2 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -316,12 +316,14 @@ out:
>> =A0 =A0 =A0 =A0return err ? 0 : 1;
>> =A0}
>>
>> +#define BUSY_TIMEOUT_MS (16 * 1024)
>> =A0static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct reque=
st *req)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
>> =A0 =A0 =A0 =A0struct mmc_blk_request brq;
>> =A0 =A0 =A0 =A0int ret =3D 1, disable_multi =3D 0;
>> + =A0 =A0 =A0 unsigned long timeout =3D 0;
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(card->host);
>>
>> @@ -453,7 +455,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>> *mq, struct request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq.stop=
=2Eresp[0], status);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_host_is_spi(card->host)&& =A0=
rq_data_dir(req) !=3D
>> READ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_host_is_spi(card->host)&& =A0=
rq_data_dir(req) !=3D
>> READ&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !brq.cmd.error&& =A0!brq.data.=
error&& =A0!brq.stop.error)
>> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies +
>> msecs_to_jiffies(BUSY_TIMEOUT_MS);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int e=
rr;
>>
>> @@ -466,13 +470,22 @@ static int mmc_blk_issue_rw_rq(struct mmc_queu=
e
>> *mq, struct request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 req->rq_disk->disk_name,
>> err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0goto cmd_err;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cm=
d.resp[0]& =A0R1_ERROR_MASK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 printk(KERN_ERR "%s: card err
>> %#x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 req->rq_disk->disk_name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 cmd.resp[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 goto cmd_err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * So=
me cards mishandle the status bits,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * so=
 make sure to check both the busy
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * in=
dication and the card state.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (!(cmd.resp[0]=
& =A0R1_READY_FOR_DATA) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (R1_CU=
RRENT_STATE(cmd.resp[0]) =3D=3D 7));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((c=
md.resp[0]& =A0R1_READY_FOR_DATA)&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (R1_CURRENT_STATE(cmd.resp[0]) !=3D 7))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (time_before(j=
iffies, timeout));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ignore timeout out =
*/
>>
>> =A0#if 0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cmd.resp[0]& =A0~=
0x00000900)
>> @@ -510,11 +523,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queu=
e
>> *mq, struct request *req)
>>
>> =A0 =A0 =A0 =A0return 1;
>>
>> - cmd_err:
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* If this is an SD card and we're writing, we can f=
irst
>> - =A0 =A0 =A0 =A0* mark the known good sectors as ok.
>> - =A0 =A0 =A0 =A0*
>> +cmd_err:
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If this is an SD card and we're writing, we can f=
irst
>> + =A0 =A0 =A0 =A0* mark the known good sectors as ok.
>> + =A0 =A0 =A0 =A0*
>> =A0 =A0 =A0 =A0 * If the card is not SD, we can still ok written sec=
tors
>> =A0 =A0 =A0 =A0 * as reported by the controller (which might be less=
 than
>> =A0 =A0 =A0 =A0 * the real number of written sectors, but never more=
).
>> @@ -541,6 +554,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>> *mq, struct request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D __blk_end_request(req, -EIO, =
blk_rq_cur_bytes(req));
>> =A0 =A0 =A0 =A0spin_unlock_irq(&md->lock);
>>
>> + =A0 =A0 =A0 card->err_count++;
>> + =A0 =A0 =A0 if (card->err_count>=3D ERR_TRIGGER_REINIT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: re-init the c=
ard due to error\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->rq_disk->disk_nam=
e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(card->host, 0);
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 6909a54..79c4759 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -535,6 +535,8 @@ static int mmc_init_card(struct mmc_host *host, =
u32
>> ocr,
>>
>> =A0 =A0 =A0 =A0if (!oldcard)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->card =3D card;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldcard->err_count =3D 0;
>>
>> =A0 =A0 =A0 =A0return 0;
>>
>> @@ -563,17 +565,20 @@ static void mmc_remove(struct mmc_host *host)
>> =A0 */
>> =A0static void mmc_detect(struct mmc_host *host)
>> =A0{
>> - =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 int err =3D 0;
>>
>> =A0 =A0 =A0 =A0BUG_ON(!host);
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>
>> + =A0 =A0 =A0 if (host->card->err_count>=3D ERR_TRIGGER_REINIT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_init_card(host, host->ocr,=
 host->card);
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Just check if our card has been removed.
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 err =3D mmc_send_status(host->card, NULL);
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(host->card, NU=
LL);
>>
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 0f52410..820b0d1 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -635,6 +635,7 @@ static int mmc_sd_init_card(struct mmc_host *hos=
t, u32
>> ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_set_bus_width(host, MMC_BUS_WIDTH=
_4);
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 card->err_count =3D 0;
>> =A0 =A0 =A0 =A0host->card =3D card;
>> =A0 =A0 =A0 =A0return 0;
>>
>> @@ -662,17 +663,20 @@ static void mmc_sd_remove(struct mmc_host *hos=
t)
>> =A0 */
>> =A0static void mmc_sd_detect(struct mmc_host *host)
>> =A0{
>> - =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 int err =3D 0;
>>
>> =A0 =A0 =A0 =A0BUG_ON(!host);
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>
>> + =A0 =A0 =A0 if (host->card->err_count>=3D ERR_TRIGGER_REINIT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_init_card(host, host->o=
cr, host->card);
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Just check if our card has been removed.
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 err =3D mmc_send_status(host->card, NULL);
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(host->card, NU=
LL);
>>
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 6b75250..178de17 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -143,6 +143,9 @@ struct mmc_card {
>> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0**info; =A0 =A0=
 =A0 =A0 /* info strings */
>> =A0 =A0 =A0 =A0struct sdio_func_tuple =A0*tuples; =A0 =A0 =A0 =A0/* =
unknown common tuples */
>>
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0err_count;
>> +#define ERR_TRIGGER_REINIT 1024
>> +
>> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
>> =A0};
>>
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index dd11ae5..3b979a1 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -122,6 +122,7 @@
>> =A0#define R1_UNDERRUN =A0 =A0 =A0 =A0 =A0 (1<< =A018) =A0 =A0 =A0 /=
* ex, c */
>> =A0#define R1_OVERRUN =A0 =A0 =A0 =A0 =A0 =A0(1<< =A017) =A0 =A0 =A0=
 /* ex, c */
>> =A0#define R1_CID_CSD_OVERWRITE =A0(1<< =A016) =A0 =A0 =A0 /* erx, c=
, CID/CSD
>> overwrite */
>> +#define R1_ERROR_MASK =A0 =A0 =A0 =A0 =A00xffff0000
>> =A0#define R1_WP_ERASE_SKIP =A0 =A0 =A0(1<< =A015) =A0 =A0 =A0 /* sx=
, c */
>> =A0#define R1_CARD_ECC_DISABLED =A0(1<< =A014) =A0 =A0 =A0 /* sx, a =
*/
>> =A0#define R1_ERASE_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<< =A013)=
 =A0 =A0 =A0 /* sr, c */
>
>
