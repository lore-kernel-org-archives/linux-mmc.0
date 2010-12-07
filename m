From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH 2/5] mmc: msm_sdcc: Add prog done interrupt support
Date: Tue, 07 Dec 2010 10:27:17 -0800
Message-ID: <1291746437.8000.11.camel@c-dwalke-linux.qualcomm.com>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
	 <1291719316-23948-2-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:23258 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0LGS1a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 13:27:30 -0500
In-Reply-To: <1291719316-23948-2-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, san@google.com, linux-arm-msm@vger.kernel.org

On Tue, 2010-12-07 at 16:25 +0530, Sahitya Tummala wrote:
> Enable prog done interrupt for stop command(CMD12) that is sent
> after a multi-block write(CMD25). The PROG_DONE bit is set when
> the card has finished its programming and is ready for next data.

What's the benefit ? It looks like there is one, but please describe it.

>  	if (status & (MCI_CMDSENT | MCI_CMDRESPEND | MCI_CMDCRCFAIL |
> -	              MCI_CMDTIMEOUT) && host->curr.cmd) {
> +		MCI_CMDTIMEOUT | MCI_PROGDONE) && host->curr.cmd) {

Add a line break here instead of weird spacing.

>  		msmsdcc_do_cmdirq(host, status);
>  	}
>  
> diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
> index 996990d..ac79ed9 100644
> --- a/drivers/mmc/host/msm_sdcc.h
> +++ b/drivers/mmc/host/msm_sdcc.h
> @@ -138,7 +138,7 @@
>  #define MCI_IRQENABLE	\
>  	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
>  	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
> -	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK)
> +	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK|MCI_PROGDONEMASK)
>  
>  /*
>   * The size of the FIFO in bytes.
> @@ -245,6 +245,8 @@ struct msmsdcc_host {
>  	struct mmc_command	*cmd_cmd;
>  	u32			cmd_c;
>  
> +	unsigned int prog_scan;
> +	unsigned int prog_enable;

These need to be bool, and you need to use true and false instead of 1
and 0.

Daniel
-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

