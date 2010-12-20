From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch] workaround of 1-bit mmc card in case cmd19 & cmd 14 not supported
Date: Mon, 20 Dec 2010 03:24:24 -0500
Message-ID: <AANLkTimxigW=W_vgP1yFiendwqHHP+Ru+EJgkY_No3cR@mail.gmail.com>
References: <AANLkTim8BAxZE9SFigp3WD68qgMAWUpOABo4-dwsfv7N@mail.gmail.com>
	<989F0D94-CD2D-4AA5-8F7A-68488E0DB01D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:39813 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0LTIY0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Dec 2010 03:24:26 -0500
Received: by fxm18 with SMTP id 18so2734985fxm.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Dec 2010 00:24:25 -0800 (PST)
In-Reply-To: <989F0D94-CD2D-4AA5-8F7A-68488E0DB01D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Sun, Dec 19, 2010 at 11:52 PM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> On Dec 16, 2010, at 7:21 PM, zhangfei gao wrote:
>
>> If controller does not support cmd19 & cmd14, here is workaround we =
using.
>> Send just in case somebody require.
>>
>> From b95c5e8d1c5b42a149a521c4992dfd8fc8d61143 Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Thu, 16 Dec 2010 22:28:40 -0500
>> Subject: [PATCH] mmc: workaround of 1-bit mmc card
>>
>> =A0 =A0 =A0 In case controller does not support cmd19 & cmd14.
>> =A0 =A0 =A0 Use workaround to decrease bus width when error happen v=
ia reading
>> partition table
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> drivers/mmc/card/block.c | =A0 28 ++++++++++++++++++++++++++++
>> include/linux/mmc/host.h | =A0 =A02 ++
>> 2 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 217f820..c0d2b73 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -432,6 +432,34 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>> *mq, struct request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* programming mode even when things g=
o wrong.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (brq.cmd.error || brq.data.error || b=
rq.stop.error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 width =3D=
 card->host->ios.bus_width;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (width =
=3D=3D MMC_BUS_WIDTH_4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 printk(KERN_WARNING "%s: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "retrying using 1 BIT WIDTH \n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 req->rq_disk->disk_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_set_bus_width(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (width =
=3D=3D MMC_BUS_WIDTH_8) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 printk(KERN_WARNING "%s: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "retrying using 4 BIT WIDTH \n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 req->rq_disk->disk_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_4);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_set_bus_width(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (brq.data.blocks > 1 =
&& rq_data_dir(req) =3D=3D READ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Redo =
read one sector at a time */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(K=
ERN_WARNING "%s: retrying using single "
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 4a9d9d2..2a2c1ab 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -249,6 +249,8 @@ extern struct mmc_host *mmc_alloc_host(int extra=
,
>> struct device *);
>> extern int mmc_add_host(struct mmc_host *);
>> extern void mmc_remove_host(struct mmc_host *);
>> extern void mmc_free_host(struct mmc_host *);
>> +extern int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 v=
alue);
>> +extern void mmc_set_bus_width(struct mmc_host *host, unsigned int w=
idth);
>>
>> static inline void *mmc_priv(struct mmc_host *host)
>> {
>> --
>> 1.7.0.4
>
> Curious,
> What cards fail without this patch ? =A0and on what system ?
> PXA168/PXA910 and MMP2 all support bus width testing for mmc cards.
>
We found some controller can not support cmd19 & cmd14 well, such as
pxa955, also mmp2 will support these two cmd after A2.
Here just send as reference in case still other controller has the same=
 issue.

>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
