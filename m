From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Mon, 14 Feb 2011 09:27:52 -0800
Message-ID: <E318EA02-8219-41BD-81B0-90C91E84F2D8@marvell.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
 <20110214095528.GA30100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50636 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755867Ab1BNRcr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 12:32:47 -0500
In-Reply-To: <20110214095528.GA30100@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Pierre Tardy <tardyp@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


I wonder if I can remove the locking (spin_lock).  The disable and enable irq should be enough.  

Thoughts ..

Philip

On Feb 14, 2011, at 1:55 AM, Wolfram Sang wrote:

> 
>> It looks like the mdelay are not in the fastpath, so why bother.
> 
> On embedded systems, we had audio streaming or CAN communication or similar
> running in parallel. Currently, those mdelays (there are a couple, sadly)
> produce significant latencies, e.g. when inserting/removing a card. The latter
> gets especially bad with BROKEN_CARD_DETECTION.
> 
> The proper solution is probably to check the locking and see if it can be made
> fine-granular, I'd assume?
> 
> Regards,
> 
>   Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

