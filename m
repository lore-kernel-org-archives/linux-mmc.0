From: boris brezillon <b.brezillon@overkiz.com>
Subject: Re: [PATCH v3 2/7] mmc: atmel-mci: prepare clk before calling enable
Date: Tue, 16 Jul 2013 17:49:11 +0200
Message-ID: <51E56B77.2050105@overkiz.com>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com> <1373987208-24120-1-git-send-email-b.brezillon@overkiz.com> <20130716171324.7d483ada@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:60549 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932749Ab3GPPtS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2013 11:49:18 -0400
Received: from mail31.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 92FD3FF9413
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2013 17:49:17 +0200 (CEST)
In-Reply-To: <20130716171324.7d483ada@skate>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Thomas,

On 16/07/2013 17:13, Thomas Petazzoni wrote:
> Dear Boris BREZILLON,
>
> On Tue, 16 Jul 2013 17:06:48 +0200, Boris BREZILLON wrote:
>
>>   	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
>>   	if (!buf)
>> @@ -389,9 +391,13 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>>   	 * consistent.
>>   	 */
>>   	spin_lock_bh(&host->lock);
>> -	clk_enable(host->mck);
>> +	ret = clk_prepare_enable(host->mck);
> I am not very familiar with the spin_lock_bh() variant, but are you
> sure we are allowed to sleep within a spin_lock_bh()-protected critical
> section?
>
> Remember that clk_prepare_enable() calls both ->prepare() and
> ->enable() for the clock, and ->prepare() is allowed to sleep, while
> ->enable() is guaranteed not to sleep.
>
> Therefore, clk_prepare() is usually called at probe time, while
> clk_enable() is called whenever enabling/disabling the clock is really
> needed. So not all clk_enable() can transparently be converted into a
> clk_prepare_enable().
You're absolutely right. We should not call clk_prepare/unprepare inside 
a critical section,
as the prepare/unprepare callback may sleep.

In this particular case it won't hurt as the mci clk is a peripheral clk 
which does not
implement the prepare callback (and as a result won't sleep).

Anyway, I will fix it.

What is the best approach to do so ?
1) call clk_prepare/unprepare in the probe/remove functions and call 
clk_enable/disable
     in resume/suspend functions
2) get clk_prepare_enable/disable_unprepare outside of the critical 
sections (I don't think
     there is any need for the mci host lock to be held when enabling 
the clk,
     clk framework already handle concurrent accesses to clks)

I will check other patches of this series to see if they introduce 
similar issues.

> Best regards,
>
> Thomas

