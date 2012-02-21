From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc sdhci i.MX5: make mmc cards work
Date: Tue, 21 Feb 2012 11:03:12 +0800
Message-ID: <CAAQ0ZWTRQaiLjd+LoRG6V3gPKJTq-buiGk2FdO_eivqhqyFhRw@mail.gmail.com>
References: <1329475909-29047-1-git-send-email-s.hauer@pengutronix.de>
	<20120220063132.GA19668@S2101-09.ap.freescale.net>
	<20120220184146.GZ3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37596 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751800Ab2BUDDO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 22:03:14 -0500
Received: by lagu2 with SMTP id u2so7084790lag.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Feb 2012 19:03:12 -0800 (PST)
In-Reply-To: <20120220184146.GZ3852@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>

On 21 February 2012 02:41, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Feb 20, 2012 at 02:31:36PM +0800, Shawn Guo wrote:
>> I do not have a mmc card to test the patch, but I tested it and
>> confirmed it does not break anything about SD support.
>>
>> On Fri, Feb 17, 2012 at 11:51:49AM +0100, Sascha Hauer wrote:
>> > On i.MX53 we have to write a special SDHCI_CMD_ABORTCMD to the
>>
>> Is this i.MX53 only?
>
> Don't know. I don't think I have ever explicitely tested MMC cards on
> !i.MX53 boards.
>
>>
>> > SDHCI_TRANSFER_MODE register during a MMC_STOP_TRANSMISSION
>> > command. This works for SD cards. However, with MMC cards
>> > the MMC_SET_BLOCK_COUNT command is used instead, but this needs
>> > the same handling. Fix MMC cards by testing for the
>> > MMC_SET_BLOCK_COUNT command aswell. Tested on a custom i.MX53
>> > board with a Transcend MMC+ card and eMMC.
>> >
>> I did not find the similar handling in FSL internal tree, but I think
>> that FSL QA team should have tested it with MMC/eMMC card.
>
> Which kernel did they test this on? The mmc core uses the
> MMC_SET_BLOCK_COUNT command since v3.0-rc1. Earlier kernels
> probably worked.
>
FSL internal tree was recently upgraded to v3.0, and I just knew from
QA team that they tested the new tree with a Sandisk eMMC card and it
worked, but have not found a Transcend card to test.  Since you are
fixing a problem you are actually seeing and the patch does not break
anything with my testing, so

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn
