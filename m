From: LIYONG <sdliyong@gmail.com>
Subject: RE: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Wed, 26 Aug 2015 14:15:18 +0800
Message-ID: <BLU168-W65065971596DEBF42F841D6600@phx.gbl>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>,<CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33204 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbbHZGPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2015 02:15:21 -0400
In-Reply-To: <CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Uffe,

The bool variable=A0do_rel_wr is used on line 1408 and line 1436:
if (brq->data.blocks> 1 || do_rel_wr) {
		/* SPI multiblock writes terminate using a special
		 * token, not a STOP_TRANSMISSION request.
		 */

	if (do_rel_wr)
		mmc_apply_rel_rw(brq, card, req);

If a card does not support CMD23, I think we need to set the do_rel_wr =
to false at the beginning of this=A0mmc_blk_rw_rq_prep function

Thanks,
Yong Li
----------------------------------------
> Date: Tue, 25 Aug 2015 14:06:43 +0200
> Subject: Re: [PATCH] mmc: block: disable the reliable write If the ca=
rd does not support CMD23
> From: ulf.hansson@linaro.org
> To: sdliyong@gmail.com
> CC: chris@printf.net; linux-mmc@vger.kernel.org; linux-kernel@vger.ke=
rnel.org
>
> On 14 August 2015 at 09:30, <sdliyong@gmail.com> wrote:
>> From: Yong Li <sdliyong@gmail.com>
>>
>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>> ---
>> drivers/mmc/card/block.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 452782b..d9e3c45 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
>> bool do_rel_wr =3D ((req->cmd_flags & REQ_FUA) ||
>> (req->cmd_flags & REQ_META)) &&
>> (rq_data_dir(req) =3D=3D WRITE) &&
>> - (md->flags & MMC_BLK_REL_WR);
>> + (md->flags & MMC_BLK_REL_WR) &&
>> + !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
>
> Further down in mmc_blk_rw_rq_prep() we check for
> MMC_QUIRK_BLK_NO_CMD23. That check becomes redundant after this
> change, please remove that check as a part of this patch as well.
>
>>
>> memset(brq, 0, sizeof(struct mmc_blk_request));
>> brq->mrq.cmd =3D &brq->cmd;
>> --
>> 2.1.0
>>
>
> Kind regards
> Uffe
 		 	   		  