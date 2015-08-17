From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Mon, 17 Aug 2015 14:48:03 +0800
Message-ID: <55D183A3.5010601@rock-chips.com>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
 <55CDA30E.7030208@rock-chips.com>
 <BLU168-W190F53E1D56BC43511D7BFD67B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:51236 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbHQGsK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 02:48:10 -0400
In-Reply-To: <BLU168-W190F53E1D56BC43511D7BFD67B0@phx.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: LIYONG <sdliyong@gmail.com>, "chris@printf.net" <chris@printf.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: shawn.lin@rock-chips.com

On 2015/8/15 20:14, LIYONG wrote:
> Thanks Shawn. Please help to check the below in the mmc_blk_rw_rq_pre=
p:
> 	if (do_rel_wr)
> 		mmc_apply_rel_rw(brq, card, req);
>
> I think we need to set the do_rel_wr to false( at the beginning of th=
is function) if the card does not support the CMD23. The above code is =
executed before the "if ((md->flags & MMC_BLK_CMD23)" code.
>

ok, it makes sense.:)

> Thanks,
> Yong Li
> ----------------------------------------
>> Subject: Re: [PATCH] mmc: block: disable the reliable write If the c=
ard does not support CMD23
>> To: sdliyong@gmail.com; chris@printf.net; ulf.hansson@linaro.org; li=
nux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> CC: shawn.lin@rock-chips.com
>> From: shawn.lin@rock-chips.com
>> Date: Fri, 14 Aug 2015 16:13:02 +0800
>>
>> =E5=9C=A8 2015/8/14 15:30, sdliyong@gmail.com =E5=86=99=E9=81=93:
>>> From: Yong Li <sdliyong@gmail.com>
>>>
>>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>>> ---
>>> drivers/mmc/card/block.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 452782b..d9e3c45 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
>>> bool do_rel_wr =3D ((req->cmd_flags & REQ_FUA) ||
>>> (req->cmd_flags & REQ_META)) &&
>>> (rq_data_dir(req) =3D=3D WRITE) &&
>>> - (md->flags & MMC_BLK_REL_WR);
>>> + (md->flags & MMC_BLK_REL_WR) &&
>>> + !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
>>
>> Hi Yong,
>>
>> pls check that code below.
>>
>> MMC_BLK_REL_WR will not be enabled if we know this card CANNOT suppo=
rt
>> CMD23 form SCR. AND=EF=BC=8C "card->quirks & MMC_QUIRK_BLK_NO_CMD23"=
 would be
>> checked here as well. So I think your code is unnecessary.
>>
>> if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
>> (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
>> do_data_tag)) {
>> brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
>> brq->sbc.arg =3D brq->data.blocks |
>> (do_rel_wr ? (1 << 31) : 0) |
>> (do_data_tag ? (1 << 29) : 0);
>> brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>> brq->mrq.sbc =3D &brq->sbc;
>> }
>>
>> Thanks.
>> Shawn
>>
>>>
>>> memset(brq, 0, sizeof(struct mmc_blk_request));
>>> brq->mrq.cmd =3D &brq->cmd;
>>>
>>
>>
>> --
>> Shawn Lin
>>
>   		 	   		  N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=
=EF=BF=BDy=EF=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7=
v=EF=BF=BD^=EF=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD{=EF=BF=BD=EF=BF=BDg"=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BD=
=EF=BF=BDz=EF=BF=BD=1A=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD&=EF=BF=BD=EF=BF=BD=1E=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=
=BD=03(=EF=BF=BD=E9=9A=8E=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD=1A=EF=BF=BD=
=1Bm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=
=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=
=BF=BD~=EF=BF=BDmml=3D=3D
>


--=20
Shawn Lin

