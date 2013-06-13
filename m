From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] mmc: sh_mmcif: add SET_BLOCK_COUNT support
Date: Thu, 13 Jun 2013 18:01:26 +0900
Message-ID: <51B98A66.8060902@renesas.com>
References: <51B97CDB.7010207@renesas.com>
 <Pine.LNX.4.64.1306131024260.31976@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <Pine.LNX.4.64.1306131024260.31976@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Guennadi-san,

(2013/06/13 17:33), Guennadi Liakhovetski wrote:
< snip >
>> +static bool sh_mmcif_send_sbc(struct sh_mmcif_host *host,
>> +			      struct mmc_request *mrq)
>> +{
>> +	struct mmc_request req_orig = *mrq;
>> +	long time;
>> +
>> +	/* Switch the commands around */
>> +	mrq->cmd = mrq->sbc;
>> +	mrq->sbc = NULL;
>> +	mrq->data = NULL;
>> +	mrq->stop = NULL;
>> +
>> +	/* Send SBC Cmd */
>> +	sh_mmcif_start_cmd(host, mrq);
>> +
>> +	/* Normal completion time is less than 1us */
>> +	time = wait_for_completion_interruptible_timeout(&host->sbc_complete,
>> +							 host->timeout);
> 
> I'm afraid this doesn't look like a correct approach to me. In commit 
> f985da1 "mmc: sh_mmcif: process requests asynchronously" I converted the 
> driver to not wait inside its .request() method. This your patch makes a 
> part of the .request() processing synchronous again by adding a wait to 
> it. Besides you're very much special casing the processing of the SBC 
> command. I think, it would be better to process it asynchronously too, 
> implementing it as a sequence of two requests, similar to how sdhci.c does 
> it (see sdhci_request() nearer the end the "if (mrq->sbc...) handling and 
> sdhci_finish_command() below the "Finished CMD23, now send actual 
> command" comment). Would that be possible to convert this patch to execute 
> similarly and to avoid special-casing as much as possible? Just check for 
> an SBC in .request(), if there is one send it instead of the proper 
> request. Then in completion check, whether it's the SBC that has just 
> completed, and if so, now send the actual request.

Thank you for your comment. I should have checked your patch...

I will modify this SBC patch to remove the wait_for_completion...() in
the .request().

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
> 
