From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 4/5] mmc: cmdq: support for command queue enabled host
Date: Wed, 10 Dec 2014 12:16:04 +0530
Message-ID: <5487EC2C.4040300@codeaurora.org>
References: <89813612683626448B837EE5A0B6A7CB47068B2289@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <89813612683626448B837EE5A0B6A7CB47068B2289@SC-VEXCH4.marvell.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ziji,
Thanks for your comments.

On 12/10/2014 4:37 AM, Ziji Hu wrote:
> Hi Asutosh,
>
>           Could you check me comments please?
>
>      Please correct me if I misunderstand you.
>
>      Thank you.
>
> +irqreturn_t cmdq_irq(struct mmc_host *mmc, u32 intmask)
>
> +{
>
> +       u32 status;
>
> +       unsigned long tag = 0, comp_status;
>
> +       struct cmdq_host *cq_host = (struct cmdq_host
> *)mmc_cmdq_private(mmc);
>
> +
>
> +       spin_lock(&cq_host->cmdq_lock);
>
> +
>
> +       status = cmdq_readl(cq_host, CQIS);
>
> +       cmdq_writel(cq_host, status, CQIS);
>
> +
>
> +       if (status & CQIS_HAC) {
>
> +               /* halt is completed, wakeup waiting thread */
>
> +               complete(&cq_host->halt_comp);
>
> +       } else if (status & CQIS_TCC) {
>
> +               /* read QCTCN and complete the request */
>
> +               comp_status = cmdq_readl(cq_host, CQTCN);
>
> +               if (!comp_status) {
>
> +                       pr_err("%s: bogus comp-stat\n", __func__);
>
> +                       cmdq_dumpregs(cq_host);
>
> +                       WARN_ON(1);
>
> +               }
>
> +               for_each_set_bit(tag, &comp_status, cq_host->num_slots) {
>
> +                       /* complete the corresponding mrq */
>
> +                       cmdq_finish_data(mmc, tag);
>
> According to eMMC 5.1 spec: CQE shall set bit n of this register (at the
> same
>
> time it clears bit n of CQTDBR) when a task execution is completed (with
> success
>
> or error).
>
>       Assume an error and an completion both occur at the same time,
> then two bits
>
> of CQTCN register will be set. One bit presents the completion. The
> other indicates
>
> the error slot.
>
>      Based on your current implementation, host will handle the error with
>
> cmdq_finish_data. Later, mrq->data->error and mrq->cmd->error are used to
>
Agree. I'm planning to change it to:
1. read CQIS
2. first check for errors on all the completed tasks, mark 
success/failure appropriately to the respective mrq
3. invoke cmdq_finish_data on all the completed tasks.

Thoughts ?
> check the error status. However, there is no cmdq source code to set
> those two
I'm working on the error handling part now. Will post the patch when done.
>
> error flag. They are supposed to be setup in legacy eMMC irq handling,
> which is
>
> replace by your cmdq irq handling. Thus actually host will receive the
> error request
>
> with no error flag. As a result, host will treat the error request as a
> successful
>
> completion.
>
>      Thus there will no error handling. Or the error handling will be
> executed after
>
> the error request is finished as a successful one.
>
> +                       /* complete DCMD on tag 31 */
>
> +               }
>
> +               cmdq_writel(cq_host, comp_status, CQTCN);
>
> +       } else if (status & CQIS_RED) {
>
> +               /* task response has an error */
>
> +               pr_err("%s: RED error %d !!!\n", mmc_hostname(mmc), status);
>
> +               cmdq_dumpregs(cq_host);
>
> +               BUG_ON(1);
>
>           Thank you.
>
> Best regards,
>
> Hu Ziji
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
