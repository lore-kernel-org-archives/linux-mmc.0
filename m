From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [patch] mmc: fix init f_min
Date: Mon, 27 Sep 2010 10:33:17 +0100
Message-ID: <4CA064DD.6040705@csr.com>
References: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>	<4C9770E4.7000801@csr.com> <AANLkTi=toSZuEUBYBeGi=sq4QNnqZ=c-Ai1L32Bnpi=V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:57130 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849Ab0I0JeY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 05:34:24 -0400
Received: from rly13g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly13g.srv.mailcontrol.com (MailControl) with ESMTP id o8R9Y2Rx002112
	for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2010 10:34:20 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly13g.srv.mailcontrol.com (MailControl) id o8R9XMCJ025442
	for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2010 10:33:22 +0100
In-Reply-To: <AANLkTi=toSZuEUBYBeGi=sq4QNnqZ=c-Ai1L32Bnpi=V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

zhangfei gao wrote:
> On Mon, Sep 20, 2010 at 10:34 AM, David Vrabel <david.vrabel@csr.com> wrote:
>> zhangfei gao wrote:
>>> index 5db49b1..9114c87 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host)
>>>       if (host->f_min > 400000) {
>>>               pr_warning("%s: Minimum clock frequency too high for "
>>>                               "identification mode\n", mmc_hostname(host));
>>> -             host->ios.clock = host->f_min;
>>> -     } else
>>>               host->ios.clock = 400000;
>>> +     } else
>>> +             host->ios.clock = host->f_min;
>> NAK.
>>
>> The code is already correctly requesting 400 kHz (unless the controller
>> can't go that slow).
> 
> Original code
> if (host->f_min > 400000) {
>                 pr_warning("%s: Minimum clock frequency too high for "
>                                 "identification mode\n", mmc_hostname(host));
>                 host->ios.clock = host->f_min;
>         } else
>                 host->ios.clock = 400000;
> 
> With this code, the init clock is would be at lease 400 kHz, and no
> matter how bigger the host->f_min it is, is this really correct?

It's not clear what you're saying or why you think the original code is
wrong.  Consider a host controller that reports a minimum frequency of 1
Hz.  Obviously we wouldn't want to do the card identification at this
clock rate, yes?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
