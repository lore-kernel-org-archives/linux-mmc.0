From: Asutosh Das <das.asutosh@gmail.com>
Subject: Re: [PATCH 3/5] mmc: card: Add eMMC command queuing support in mmc
 block layer
Date: Mon, 8 Dec 2014 11:28:47 +0530
Message-ID: <CAA=bF1QaKLJv2rXLhpBoGA52syNgXL31yV2fKoLaTn2MP_Jw3w@mail.gmail.com>
References: <20141202115821.GA27658@asutoshd-ics.in.qualcomm.com> <loom.20141208T030638-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <loom.20141208T030638-232@post.gmane.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Hu Ziji <huziji@marvell.com>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Ziji
Thanks for your comments.

I'm adding linux-mmc to this as well.

On 8 December 2014 at 07:47, Hu Ziji <huziji@marvell.com> wrote:
>
> Asutosh Das <asutoshd <at> codeaurora.org> writes:
>
> > +static inline bool mmc_cmdq_should_pull_reqs(struct mmc_host *host,
> > +                                     struct mmc_cmdq_context_info *ctx)
> > +{
> > +     spin_lock_bh(&ctx->cmdq_ctx_lock);
> > +     if (ctx->active_dcmd || ctx->rpmb_in_wait) {
> > +             if ((ctx->curr_state != CMDQ_STATE_HALT) ||
> > +                     (ctx->curr_state != CMDQ_STATE_ERR)) {
>
>                         Because CMDQ_STATE_HALT == 0 and CMDQ_STATE_ERR == 1, it is
> impossible that condition ((ctx->curr_state == CMDQ_STATE_HALT) && (ctx-
> >curr_state != CMDQ_STATE_ERR)) is satisfied. Thus the above if-condition will
> always be true.
>

Agree.

>
> > +                     pr_debug("%s: %s: skip pulling reqs: dcmd: %d rpmb: %d state:
> %d\n",
> > +                              mmc_hostname(host), __func__, ctx->active_dcmd,
> > +                              ctx->rpmb_in_wait, ctx->curr_state);
> > +                     spin_unlock_bh(&ctx->cmdq_ctx_lock);
> > +                     return false;
> > +             }
> > +     } else {
> > +             spin_unlock_bh(&ctx->cmdq_ctx_lock);
> > +             return true;
> > +     }
> > +}
>
> > +/**
> > + *   mmc_cmdq_halt - halt/un-halt the command queue engine
> > + *    <at> host: host instance
> > + *    <at> halt: true - halt, un-halt otherwise
> > + *
> > + *   Host halts the command queue engine. It should complete
> > + *   the ongoing transfer and release the SD bus.
> > + *   All legacy SD commands can be sent upon successful
> > + *   completion of this function.
> > + *   Returns 0 on success, negative otherwise
> > + */
> > +int mmc_cmdq_halt(struct mmc_host *host, bool halt)
> > +{
> > +     int err = 0;
> > +
> > +     if ((halt && (host->cmdq_ctx.curr_state & CMDQ_STATE_HALT)) ||
> > +         (!halt && !(host->cmdq_ctx.curr_state & CMDQ_STATE_HALT)))
> > +             return 1;
> > +
> > +     if (host->cmdq_ops->halt) {
> > +             err = host->cmdq_ops->halt(host, halt);
> > +             if (!err && halt)
> > +                     host->cmdq_ctx.curr_state |= CMDQ_STATE_HALT;
> > +             else if (!err && !halt)
> > +                     host->cmdq_ctx.curr_state &= ~CMDQ_STATE_HALT;
>
>                 Since CMDQ_STATE_HALE == 0, ORed with CMDQ_STATE_HALT and
> ANDed with ~CMDQ_STATE_HALT will neither modify the value of curr_state. Thus
> CMDQ_STATE_HALT as 0 cannot indicate the halt state of cmd queue.

Agree.

>
>
> > +     }
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(mmc_cmdq_halt);
>
> > +enum cmdq_states {
> > +     CMDQ_STATE_HALT,
> > +     CMDQ_STATE_ERR,
> > +};
>
>     According to above definition, CMDQ_STATE_HALT is 0x0 and
> CMDQ_STATE_ERR is 0x1.
>

I will address these comments in the next patch.

>
>
> Hi Asutosh,
>
>     I think that the definition of CMDQ_STATE_HALT might fail to indicate halt status
> correctly.
>     Could you check my comments please?
>     If I misunderstand your source code, please correct me.
>
> Best regards,
> Ziji
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Thanks & Regards
~/Asutosh Das
