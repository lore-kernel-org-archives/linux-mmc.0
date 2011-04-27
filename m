From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/7] mmc: msm_sdcc: Use MCI_INT_MASK0 for PIO interrupts
Date: Wed, 27 Apr 2011 08:52:15 -0700
Message-ID: <4DB83BAF.2070800@codeaurora.org>
References: <1303796066-6784-1-git-send-email-stummala@codeaurora.org> <1303796066-6784-5-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:45699 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396Ab1D0PwR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 11:52:17 -0400
In-Reply-To: <1303796066-6784-5-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Murali Palnati <palnatim@codeaurora.org>

On 04/25/2011 10:34 PM, Sahitya Tummala wrote:
> @@ -659,8 +662,13 @@ msmsdcc_pio_irq(int irq, void *dev_id)
>  {
>  	struct msmsdcc_host	*host = dev_id;
>  	uint32_t		status;
> +	u32 mci_mask0 = 0;

Is this assignment there to silence an "unused variable" warning? If it
is, please use the uninitialized_var macro. If it isn't please remove
the assignment.

>  
>  	status = msmsdcc_readl(host, MMCISTATUS);
> +	mci_mask0 = msmsdcc_readl(host, MMCIMASK0);
> +
> +	if (((mci_mask0 & status) & MCI_IRQ_PIO) == 0)
> +		return IRQ_NONE;
>  
>  	do {
>  		unsigned long flags;

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

