From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc sdhci i.MX5: make mmc cards work
Date: Fri, 02 Mar 2012 15:34:17 -0500
Message-ID: <m2y5rin3na.fsf@bob.laptop.org>
References: <1329475909-29047-1-git-send-email-s.hauer@pengutronix.de>
	<20120220063132.GA19668@S2101-09.ap.freescale.net>
	<20120220184146.GZ3852@pengutronix.de>
	<CAAQ0ZWTRQaiLjd+LoRG6V3gPKJTq-buiGk2FdO_eivqhqyFhRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44558 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622Ab2CBUe0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Mar 2012 15:34:26 -0500
In-Reply-To: <CAAQ0ZWTRQaiLjd+LoRG6V3gPKJTq-buiGk2FdO_eivqhqyFhRw@mail.gmail.com>
	(Shawn Guo's message of "Tue, 21 Feb 2012 11:03:12 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

Hi,

On Mon, Feb 20 2012, Shawn Guo wrote:
> On 21 February 2012 02:41, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> On Mon, Feb 20, 2012 at 02:31:36PM +0800, Shawn Guo wrote:
>>> I do not have a mmc card to test the patch, but I tested it and
>>> confirmed it does not break anything about SD support.
>>>
>>> On Fri, Feb 17, 2012 at 11:51:49AM +0100, Sascha Hauer wrote:
>>> > On i.MX53 we have to write a special SDHCI_CMD_ABORTCMD to the
>>>
>>> Is this i.MX53 only?
>>
>> Don't know. I don't think I have ever explicitely tested MMC cards on
>> !i.MX53 boards.
>>
>>>
>>> > SDHCI_TRANSFER_MODE register during a MMC_STOP_TRANSMISSION
>>> > command. This works for SD cards. However, with MMC cards
>>> > the MMC_SET_BLOCK_COUNT command is used instead, but this needs
>>> > the same handling. Fix MMC cards by testing for the
>>> > MMC_SET_BLOCK_COUNT command aswell. Tested on a custom i.MX53
>>> > board with a Transcend MMC+ card and eMMC.
>>> >
>>> I did not find the similar handling in FSL internal tree, but I think
>>> that FSL QA team should have tested it with MMC/eMMC card.
>>
>> Which kernel did they test this on? The mmc core uses the
>> MMC_SET_BLOCK_COUNT command since v3.0-rc1. Earlier kernels
>> probably worked.
>>
> FSL internal tree was recently upgraded to v3.0, and I just knew from
> QA team that they tested the new tree with a Sandisk eMMC card and it
> worked, but have not found a Transcend card to test.  Since you are
> fixing a problem you are actually seeing and the patch does not break
> anything with my testing, so
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.3.  It sounds like you'd like this to
go to 3.{0,1,2}-stable, too?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
