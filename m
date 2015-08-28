From: LIYONG <sdliyong@gmail.com>
Subject: RE: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Fri, 28 Aug 2015 08:38:22 +0800
Message-ID: <BLU168-W13574B00F22F09F6F0E357FD66E0@phx.gbl>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>,<CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>,<CAPDyKFpVN8aK6aF2Fk9UNgFfJU5W1CT4v4YBtJDF6t57cwXsKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34680 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbH1Ai1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 20:38:27 -0400
In-Reply-To: <CAPDyKFpVN8aK6aF2Fk9UNgFfJU5W1CT4v4YBtJDF6t57cwXsKg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Uffe,

Since=A0Reliable Write depends on the CMD23. I think we need to disable=
=A0Reliable Write if the card does not support CMD23(due to performance=
 impact issue), so I add this patch.

Do you think we still need to enable=A0Reliable Write even if the card =
does not support CMD23?

Thanks,
Yong Li
----------------------------------------
> Date: Thu, 27 Aug 2015 15:22:44 +0200
> Subject: Re: [PATCH] mmc: block: disable the reliable write If the ca=
rd does not support CMD23
> From: ulf.hansson@linaro.org
> To: sdliyong@gmail.com
> CC: chris@printf.net; linux-mmc@vger.kernel.org; linux-kernel@vger.ke=
rnel.org
>
> On 25 August 2015 at 14:06, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
>> On 14 August 2015 at 09:30, <sdliyong@gmail.com> wrote:
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
>> Further down in mmc_blk_rw_rq_prep() we check for
>> MMC_QUIRK_BLK_NO_CMD23. That check becomes redundant after this
>> change, please remove that check as a part of this patch as well.
>>
>>>
>>> memset(brq, 0, sizeof(struct mmc_blk_request));
>>> brq->mrq.cmd =3D &brq->cmd;
>>> --
>>> 2.1.0
>>>
>>
>
> Please ignore my previous answer. MMC_QUIRK_BLK_NO_CMD23 is intended
> to indicate to the mmc block layer whether using CMD23 for regular
> block IO request could have a performance impact for some cards. If
> that's the case we don't use it - except when using reliable write!
>
> So this patch is just plain wrong.
>
> Kind regards
> Uffe
 		 	   		  