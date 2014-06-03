From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: lockdep dump on devtree_lock (involving esdhc)
Date: Tue, 3 Jun 2014 15:10:54 +0100
Message-ID: <CACxGe6ufSLJUnsM9emkDUeGHojmb37JeY8_OFMnSdrB_oMeScg@mail.gmail.com>
References: <20130611233330.GA15342@home.buserror.net> <alpine.LFD.2.02.1306120948430.22970@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:64664 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaFCOLR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 10:11:17 -0400
Received: by mail-ig0-f174.google.com with SMTP id h3so4757052igd.13
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2014 07:11:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1306120948430.22970@ionos>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Scott Wood <scottwood@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Jun 12, 2013 at 8:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 11 Jun 2013, Scott Wood wrote:
>
>> I get the following lockdump output on p2020rdb using
>> v3.10-rc5-43-g34376a5.  While it's not particularly polite for the
>> esdhc driver to be calling OF functions while holding another lock which
>> can be acquired from interrupt context, why is devtree_lock usually
>> acquired in an irqsafe manner but sometimes not?
>>
>> Both types of usage were added by the same commit:
>>
>> commit d6d3c4e656513dcea61ce900f0ecb9ca820ee7cd
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date:   Wed Feb 6 15:30:56 2013 -0500
>>
>>     OF: convert devtree lock from rw_lock to raw spinlock
>>
>> Stephen, you asked about this here:
>> http://lkml.indiana.edu/hypermail/linux/kernel/1302.1/01383.html
>>
>> Did you ever get an answer?
>
> https://patchwork.kernel.org/patch/2470731/
>
>> I'm also curious why devtree_lock was made raw to begin with...
>> Iterating over a device tree doesn't seem like something you'd want to
>> trust to be low-latency.
>
> The reason is that it's taken in low level cpu bringup code and I did
> not find a different solution. :(

Hey, Thomas,

Do you remember where the offending code is? I'm looking at completely
refactoring FDT locking so I'd like to take a crack and solving the
cpu bringup problem.

g.
