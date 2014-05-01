From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: wait_for_completion in mmc_wait_for_req_done never returns
Date: Thu, 01 May 2014 16:57:33 +0300
Message-ID: <536252CD.3000400@codeaurora.org>
References: <8D4F0053-96FB-4ED3-B224-275E3CDDCFBC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:56315 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbaEAN5i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 May 2014 09:57:38 -0400
In-Reply-To: <8D4F0053-96FB-4ED3-B224-275E3CDDCFBC@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Ringle <jonringle@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>

On 03/01/14 18:03, Jon Ringle wrote:
> I'm porting an arm board from linux-3.10 to linux-3.12 and found that I can no longer detect the SD card. I found that the wait_for_completion(&mrq->completion) in drivers/mmc/core/core.c:mmc_wait_for_req_done() is never returning.

Can you post relevant kernel log file, so I'll try to understand the flow?
What command is not getting completed? I suppose it is not data command.

Thanks,
Kostya

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
