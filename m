From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH V4 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks	using
 generic names
Date: Thu, 13 Oct 2011 11:40:33 +0200
Message-ID: <4E96B211.1090908@samsung.com>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
 <1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
 <4E956ADB.3060604@samsung.com>
 <CAPs=JDf2N1kh4BO9nPBb-J6k51e-ytntrNOvw_UOKtw-ktdycA@mail.gmail.com>
 <4E95BDF8.2080406@samsung.com>
 <CAPs=JDeFyoCYnR-Xa_fdmBVHxfNGuVNfdHd-MZgYcPytprsmFg@mail.gmail.com>
 <4E969958.9020200@samsung.com> <20111013085521.GJ21648@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:35686 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab1JMJkl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 05:40:41 -0400
In-reply-to: <20111013085521.GJ21648@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rajeshwari Shinde <rajeshwari.s@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On 10/13/2011 10:55 AM, Russell King - ARM Linux wrote:
> On Thu, Oct 13, 2011 at 09:55:04AM +0200, Sylwester Nawrocki wrote:
>> Yes, it allowed to add clkdev support with minimal changes required.
>>
>> But let's see what happens when the works on common struct clk for all
>> architectures are more or less completed and we convert Samsung platforms
>> to use it;)
> 
> The common struct clk shouldn't have much to do with the clkdev part of
> it - clkdev just provides a method to associate a struct clk with the
> drivers request.  The common struct clk doesn't change that.

Indeed. I was just wondering where we end up with the arch struct clk attribute
which is specific to clkdev processes.
It could just go into the hardware-specific data, although it doesn't sound
like a perfectly right approach.
