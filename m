From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 3/5] mmc: card: Add eMMC command queuing support in mmc
 block layer
Date: Wed, 10 Dec 2014 10:08:03 +0530
Message-ID: <5487CE2B.1080902@codeaurora.org>
References: <20141202115821.GA27658@asutoshd-ics.in.qualcomm.com> <loom.20141208T030638-232@post.gmane.org> <CAA=bF1QaKLJv2rXLhpBoGA52syNgXL31yV2fKoLaTn2MP_Jw3w@mail.gmail.com> <89813612683626448B837EE5A0B6A7CB47068B1E58@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:60873 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbaLJEiJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Dec 2014 23:38:09 -0500
In-Reply-To: <89813612683626448B837EE5A0B6A7CB47068B1E58@SC-VEXCH4.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>, Asutosh Das <das.asutosh@gmail.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ziji
On 12/9/2014 12:33 AM, Ziji Hu wrote:
> Hi Asutosh,
>
>          May I ask whether you have tested the code on hardware platf=
orm?
I have done some basic testing on an emulation platform that using an=20
earlier kernel version.
>          If you have not tested it yet, do you have a schedule for te=
sting?
>
> -----Original Message-----
> From: Asutosh Das [mailto:das.asutosh@gmail.com]
> Sent: 2014=C4=EA12=D4=C27=C8=D5 21:59
> To: Ziji Hu
> Cc: linux-arm-msm@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH 3/5] mmc: card: Add eMMC command queuing support =
in mmc block layer
>
> Hi Ziji
> Thanks for your comments.
>
> I'm adding linux-mmc to this as well.
>
> On 8 December 2014 at 07:47, Hu Ziji <huziji@marvell.com> wrote:
>>
>> Asutosh Das <asutoshd <at> codeaurora.org> writes:
>>
>>> +static inline bool mmc_cmdq_should_pull_reqs(struct mmc_host *host=
,
>>> +                                     struct mmc_cmdq_context_info
>>> +*ctx) {
>>> +     spin_lock_bh(&ctx->cmdq_ctx_lock);
>>> +     if (ctx->active_dcmd || ctx->rpmb_in_wait) {
>>> +             if ((ctx->curr_state !=3D CMDQ_STATE_HALT) ||
>>> +                     (ctx->curr_state !=3D CMDQ_STATE_ERR)) {
>>
>>                          Because CMDQ_STATE_HALT =3D=3D 0 and
>> CMDQ_STATE_ERR =3D=3D 1, it is impossible that condition ((ctx->curr=
_state
>> =3D=3D CMDQ_STATE_HALT) && (ctx-
>>> curr_state !=3D CMDQ_STATE_ERR)) is satisfied. Thus the above
>>> if-condition will
>> always be true.
>>
>
> Agree.
>
>>
>>> +                     pr_debug("%s: %s: skip pulling reqs: dcmd: %d=
 rpmb: %d state:
>> %d\n",
>>> +                              mmc_hostname(host), __func__, ctx->a=
ctive_dcmd,
>>> +                              ctx->rpmb_in_wait, ctx->curr_state);
>>> +                     spin_unlock_bh(&ctx->cmdq_ctx_lock);
>>> +                     return false;
>>> +             }
>>> +     } else {
>>> +             spin_unlock_bh(&ctx->cmdq_ctx_lock);
>>> +             return true;
>>> +     }
>>> +}
>>
>>> +/**
>>> + *   mmc_cmdq_halt - halt/un-halt the command queue engine
>>> + *    <at> host: host instance
>>> + *    <at> halt: true - halt, un-halt otherwise
>>> + *
>>> + *   Host halts the command queue engine. It should complete
>>> + *   the ongoing transfer and release the SD bus.
>>> + *   All legacy SD commands can be sent upon successful
>>> + *   completion of this function.
>>> + *   Returns 0 on success, negative otherwise
>>> + */
>>> +int mmc_cmdq_halt(struct mmc_host *host, bool halt) {
>>> +     int err =3D 0;
>>> +
>>> +     if ((halt && (host->cmdq_ctx.curr_state & CMDQ_STATE_HALT)) |=
|
>>> +         (!halt && !(host->cmdq_ctx.curr_state & CMDQ_STATE_HALT))=
)
>>> +             return 1;
>>> +
>>> +     if (host->cmdq_ops->halt) {
>>> +             err =3D host->cmdq_ops->halt(host, halt);
>>> +             if (!err && halt)
>>> +                     host->cmdq_ctx.curr_state |=3D CMDQ_STATE_HAL=
T;
>>> +             else if (!err && !halt)
>>> +                     host->cmdq_ctx.curr_state &=3D ~CMDQ_STATE_HA=
LT;
>>
>>                  Since CMDQ_STATE_HALE =3D=3D 0, ORed with CMDQ_STAT=
E_HALT
>> and ANDed with ~CMDQ_STATE_HALT will neither modify the value of
>> curr_state. Thus CMDQ_STATE_HALT as 0 cannot indicate the halt state=
 of cmd queue.
>
> Agree.
>
>>
>>
>>> +     }
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL(mmc_cmdq_halt);
>>
>>> +enum cmdq_states {
>>> +     CMDQ_STATE_HALT,
>>> +     CMDQ_STATE_ERR,
>>> +};
>>
>>      According to above definition, CMDQ_STATE_HALT is 0x0 and
>> CMDQ_STATE_ERR is 0x1.
>>
>
> I will address these comments in the next patch.
>
>>
>>
>> Hi Asutosh,
>>
>>      I think that the definition of CMDQ_STATE_HALT might fail to
>> indicate halt status correctly.
>>      Could you check my comments please?
>>      If I misunderstand your source code, please correct me.
>>
>> Best regards,
>> Ziji
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-arm-msm" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Thanks & Regards
> ~/Asutosh Das
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=81=7F)=DE=BA=
{.n=81=7F+=89=B7=A5=8A{=B1=9Ag"=9E=D8^n=87r=A1=F6=A6z=81=7F=1A=81=EBh=99=
=A8=E8=AD=81=7F&=A2=F8=1E=AEG=AB=9D=E9h=81=7F=03(=AD=E9=9A=8E=8A=DD=A2j=
"=9D=FA=1A=81=7F=1Bm=81=7F=81=7F=EF=81=EA=E4z=B9=DE=96=8A=E0=FEf=A3=A2=B7=
h=9A=88=A7~=88mml=3D=3D
>


--=20
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
