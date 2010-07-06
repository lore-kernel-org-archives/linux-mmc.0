From: Madhav <singh.madhav@samsung.com>
Subject: Re: [PATCH RESEND] sdhci-clk-gating-support
Date: Tue, 06 Jul 2010 11:25:22 +0530
Message-ID: <3F49B9D37E2841269BAD6E68AAF5B3E2@sisodomain.com>
References: <23314024.108801278080144319.JavaMail.weblogic@epml07>
 <m3eiflx47q.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13958 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab0GFFz1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2010 01:55:27 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L5400AEAGGCJ170@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Jul 2010 14:55:24 +0900 (KST)
Received: from madhavsingh ([107.108.86.158])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L5400EJ0GGAR3@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Jul 2010 14:55:24 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, kyungmin.park@samsung.com

> Hi Madhav,
>
>> +       host->user = 0;         /*For Clock gating*/
>> +       host->clk_restore = 0;
> Also, it's not obvious to me why two variables are necessary.  What's
> wrong with just setting host->clk_restore when disabling clock, and
> testing whether it's non-zero instead of testing host->user?
> (host->user would need a more descriptive name, too.)
we used host->user for making enable disable in a proper sequence i.e. 
enable-disable-enable and
were facing some issues as we were using workqueue.So in current version we 
tested the patch
without host->user and it works fine so we can remove it.
>Some general points:
> * have you measured whether there's a performance impact from
>   bringing the clock up and down for every request?
I will test  this and update you soon.
> * I'd expect this to be implemented as an MMC capability, so
>   that it can be avoided on specific controllers.
Yes we can do this just we need to add one macro for clock gating capability 
in struct mmc_host  and
also looking for any other  good alternative  for the same. Do we have such 
host controllers for them we
should avoid this??

>
> Thanks,
>
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>
> One Laptop Per Child 

