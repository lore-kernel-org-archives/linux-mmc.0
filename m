From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] mmc: sh_mmcif: add SET_BLOCK_COUNT support
Date: Fri, 28 Jun 2013 18:50:17 +0900
Message-ID: <51CD5C59.2020909@renesas.com>
References: <51BFD0C0.4080908@renesas.com>
 <Pine.LNX.4.64.1306280843140.29767@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <Pine.LNX.4.64.1306280843140.29767@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi, Guennadi-san,

(2013/06/28 16:54), Guennadi Liakhovetski wrote:> Hi Shimoda-san
>
> Thanks for an update. Sorry it took me so long to get down to reviewing
> it. I looked at it originally and I knew, I would need a significant time
> this time to look and think about it, so, I had to postpone. This looks
> much better already, thanks! The flow is already correct, but I think it
> might be possible to improve it further. Please, see below.

Thank you very much for your review!

> On Tue, 18 Jun 2013, Shimoda, Yoshihiro wrote:
< snip >
>> +	struct mmc_request mrq_sbc;	/* mmc_request for SBC */
>
> I don't think we'll need this eventually.

I got it.

< snip >
>> @@ -936,9 +942,27 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>  		break;
>>  	}
>>
>> -	host->mrq = mrq;
>> +	if (mrq->sbc) {
>
> Ok, this is an entry point, you have to act here, agree. But how about the
> following: we add a new WAIT state: MMCIF_WAIT_FOR_SBC and use that one
> inside sh_mmcif_start_cmd() instead of MMCIF_WAIT_FOR_CMD in the SBC case?
> Then maybe you won't need to change sh_mmcif_request() at all or almost at
> all:

I will add a new WAIT state.

< snip >
>> +		/* Store original mrq to mrq_orig */
>> +		host->mrq_orig = mrq;
>> +
>> +		/* Copy original mrq data to mrq_sbc */
>> +		host->mrq_sbc = *mrq;
>>
>> -	sh_mmcif_start_cmd(host, mrq);
>
> this call might change, see later.
>
>> +		/* Switch the mrq_sbc.cmd for SBC */
>> +		host->mrq_sbc.cmd = mrq->sbc;
>> +		host->mrq_sbc.sbc = NULL;
>> +		host->mrq_sbc.data = NULL;
>> +		host->mrq_sbc.stop = NULL;
>> +
>> +		/* Set current mrq pointer to mrq_sbc */
>> +		host->mrq = &host->mrq_sbc;
>> +	} else {
>> +		/* Set current mrq pointer to original mrq */
>> +		host->mrq = mrq;
>> +	}
>> +
>> +	sh_mmcif_start_cmd(host, host->mrq);
>
> This will set "host->wait_for = MMCIF_WAIT_FOR_CMD"
>
>>  }
>>
>>  static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
>> @@ -1212,13 +1236,35 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>
> Now, when we enter sh_mmcif_irqt() after an SBC command completion, we
> still have "host->wait_for == MMCIF_WAIT_FOR_CMD" so we enter
> sh_mmcif_end_cmd(), right? But you set mrq->data = NULL above, so, it just
> (possibly) gets a response and returns. So far so good.

Your point is correct.

> With the proposed MMCIF_WAIT_FOR_SBC you'll have something like
>
> 	case MMCIF_WAIT_FOR_SBC:
> 		wait = sh_mmcif_end_sbc(host);
> 		break;
>
> In sh_mmcif_end_sbc() you would do a similar to sh_mmcif_end_cmd() error
> processing, maybe get a response (no idea, whether SBC has MMC_RSP_PRESENT
> set), call sh_mmcif_start_cmd() again, but there now you have to take care
> not to jump to the same state again, but to use MMCIF_WAIT_FOR_CMD this
> time. So, your wait-assignment in sh_mmcif_start_cmd() would look like
>
> 	if (mrq->sbc && host->wait_for != MMCIF_WAIT_FOR_SBC)
> 		host->wait_for = MMCIF_WAIT_FOR_SBC;
> 	else
> 		host->wait_for = MMCIF_WAIT_FOR_CMD;
>
> and return true.

I got it, I will modify this.

>>  		return IRQ_HANDLED;
>>  	}
>>
>> +	if (mrq->sbc && (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) &&
>> +			(host->wait_for != MMCIF_WAIT_FOR_WRITE_END)) {
>> +		/* Wait for end of data phase */
>> +		host->wait_for = MMCIF_WAIT_FOR_WRITE_END;
>> +		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
>> +		schedule_delayed_work(&host->timeout_work, host->timeout);
>> +		mutex_unlock(&host->thread_lock);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (mrq->sbc && (mrq->cmd->opcode == MMC_READ_MULTIPLE_BLOCK) &&
>> +			(host->wait_for != MMCIF_WAIT_FOR_READ_END)) {
>> +		/* Wait for end of data phase */
>> +		host->wait_for = MMCIF_WAIT_FOR_READ_END;
>> +		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
>> +		schedule_delayed_work(&host->timeout_work, host->timeout);
>> +		mutex_unlock(&host->thread_lock);
>> +		return IRQ_HANDLED;
>> +	}
>
> Hm, this is interesting. Why do you need those? Currently we only wait for
> read- and write-end conditions in single-block read- and write-operations,
> but not in multi-block ones. With SBC you also want to wait for them in
> the multi-block case. Is it really SBC-specific or maybe we have to do
> this always? In either case I wouldn't add it here but to respective
> state-handlers, called from the switch statement above. And if this is
> indeed needed for all multi-block operations, this should be a separate
> patch.

In the previous code, the driver always enables the "Automatic CMD12 Issuance"
function in the multi-block case. So, we don't need wait for read- and write-end
conditions. However, if we use SBC, we disables the "Automatic CMD12 Issuance"
function. So, we have to do this only when we use SBC.

So, Should I separate this code as other patch?
Or, should I remove this code, and add similar code to sh_mmcif_end_cmd() and
sh_mmcif_[mread,mwrite]_block()?

>> +
>>  	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
>
> Currently you enter this path also after processing an SBC, which isn't
> needed, but just happens to be harmless. If you use MMCIF_WAIT_FOR_SBC you
> don't get here at all.

Since we have to set the "data->bytes_xfered" below, we need to enter this path
even if we use SBC:

>>  		struct mmc_data *data = mrq->data;
>>  		if (!mrq->cmd->error && data && !data->error)
>>  			data->bytes_xfered =
>>  				data->blocks * data->blksz;

We need this code.

>> -		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
>> +		/* If SBC, we don't use CMD12(STOP) */
>> +		if (mrq->stop && !mrq->cmd->error && (!data || !data->error) &&
>> +		    !mrq->sbc) {
>>  			sh_mmcif_stop_cmd(host, mrq);
>>  			if (!mrq->stop->error) {
>>  				schedule_delayed_work(&host->timeout_work, host->timeout);
>> @@ -1228,6 +1274,14 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>>  		}
>>  	}
>>
>> +	if ((mrq->cmd->opcode == MMC_SET_BLOCK_COUNT) && !mrq->cmd->error) {
>
> This won't be needed.

I will remove it.

Best regards,
Yoshihiro Shimoda

>> +		/* Send the original .request() command */
>> +		host->mrq = host->mrq_orig;
>> +		sh_mmcif_start_cmd(host, host->mrq);
>> +		mutex_unlock(&host->thread_lock);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>>  	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
>>  	host->state = STATE_IDLE;
>>  	host->mrq = NULL;
>> --
>> 1.7.1
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
