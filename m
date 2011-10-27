From: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Subject: Re: [PATCH]mmc: sdhci: use udelay instead of mdelay for some cases
Date: Thu, 27 Oct 2011 13:09:41 +0800
Message-ID: <20111027050939.GA27531@gmail.com>
References: <20111027041851.GA18442@gmail.com>
 <20111027051532.GA28387@pengutronix.de>
Reply-To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56912 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1J0FW7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 01:22:59 -0400
Received: by ywm3 with SMTP id 3so2289792ywm.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2011 22:22:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111027051532.GA28387@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org

On Thu, Oct 27, 2011 at 07:15:32AM +0200, Wolfram Sang wrote:
>Hi,
>
>On Thu, Oct 27, 2011 at 12:18:53PM +0800, Shawn.Dong wrote:
>> sdhci_set_clock or sdhci_reset or sdhci_send_command may be used in
>> critical region which is protected by spin_lock_irqsave. Thus, these
>> functions will delay the responsing of the kernel interrupts.
>
>Yes, so this needs to be improved, not the delay values.
>
>> So in this case, using a mdelay will cause unnecessary latency. Our
>> hardware, in most case will not cause 1ms to finish its job. Using
>> udelay instead can reduce it.
>
>Could you guarantee this for all other SDHCI hardware out there as well?
Even there are some SDHCI hardwares cannot be stable in microseconds, I
think this is also OK since they just need to wait for a few more loops. The
total waiting time is the same as before.

For the SDHCI hardware which need less time to be stable, this patch can improve
performance for them.

Thanks
Shawn
