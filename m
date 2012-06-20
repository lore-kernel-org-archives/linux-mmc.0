From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_cd_gpio_request() failed request_threaded_irq()
Date: Wed, 20 Jun 2012 02:15:06 -0400
Message-ID: <87sjdq4ihh.fsf@octavius.laptop.org>
References: <87aa09xcd6.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1206122323040.6800@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45723 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab2FTGPM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 02:15:12 -0400
In-Reply-To: <Pine.LNX.4.64.1206122323040.6800@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 12 Jun 2012 23:24:02 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: kuninori.morimoto.gx@renesas.com, linux-mmc@vger.kernel.org

Hi Guennadi,

On Tue, Jun 12 2012, Guennadi Liakhovetski wrote:
>> I noticed that mmc_cd_gpio_request() failed on request_threaded_irq().
>> Now, I'm using v3.5-rc2 kernel.
>> 
>> current ${LINUX}/drivers/mmc/core/cd-gpio.c :: mmc_cd_gpio_request() uses
>> 
>> request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
>> 		   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> 		   cd->label, host);
>> 
>> It doesn't have hander (2nd is NULL), and flag doesn't have IRQF_ONESHOT.
>> Then, it run  request_threaded_irq() -> __setup_irq()
>> and, it got this error.
>> 
>> pr_err("Threaded irq requested with handler=NULL and !ONESHOT for irq %d\n",
>> 	irq);
>> 
>> I'm not sure detail of it, but maybe from this commit
>> 
>> -------------------------------------------
>> commit 1c6c69525b40eb76de8adf039409722015927dc3
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date:   Thu Apr 19 10:35:17 2012 +0200
>> 
>>     genirq: Reject bogus threaded irq requests
>
> Also see this thread: https://lkml.org/lkml/2012/6/12/151
>
> For now you can add an IRQF_ONESHOT flag to the call.

Should we get this change into 3.5?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
