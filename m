From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: mmc: core: retries counter for data command initialization.
Date: Tue, 29 Apr 2014 14:48:03 +0300
Message-ID: <535F9173.1030102@codeaurora.org>
References: <535F5B02.9060908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:39853 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771AbaD2LsH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 07:48:07 -0400
In-Reply-To: <535F5B02.9060908@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

On 04/29/14 10:55, Konstantin Dorfman wrote:

Correction inside

> Hi All,
>
> After 6035d9730d5825e6e3c225b721a5847a521d6556 "mmc: fix async request
> mechanism for sequential read scenarios" mmc layer data path async
> request handling was separated from mmc commands path.
>
> mmc_wait_for_data_req_done() function is used to wait for completion of
> the currently running data request, while for commands
> mmc_wait_for_req_done() is used.
>
> There is code that repeats request cmd->retries times in case of error.
> The problem that for data command this counter is not initialized
> properly as it does for mmc command sending:
>
>
> int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int
> retries)
> {
>      struct mmc_request mrq = {NULL};
>
>      WARN_ON(!host->claimed);
>
>      memset(cmd->resp, 0, sizeof(cmd->resp));
>      cmd->retries = retries;                 <-- supplied by
>                                                      caller
>
>      mrq.cmd = cmd;
>      cmd->data = NULL;
>
>      mmc_wait_for_req(host, &mrq);
>
>      return cmd->error;
> }
>
> I found that there is no similar initialization for data command
> processing code, so the counter cmd->retries remains always 0.
>
> Lets discuss:
> - do we need retries for data request
> - what value is good: for command there are 0 or 5 retries
> - where to do this initialization:

card/block.c: static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
			       struct mmc_card *card,
			       int disable_multi,
			       struct mmc_queue *mq)

>
> Thanks,
> Kostya
>


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
