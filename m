From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 4/7] mmc: sdhci-of: fix build on non-powerpc platforms
Date: Tue, 16 Nov 2010 16:34:56 -0600
Message-ID: <4CE30710.6050302@gmail.com>
References: <1289939635-30742-1-git-send-email-robherring2@gmail.com> <1289939635-30742-5-git-send-email-robherring2@gmail.com> <20101116214409.GC19893@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54478 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393Ab0KPWe7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 17:34:59 -0500
Received: by gyh4 with SMTP id 4so776978gyh.19
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 14:34:58 -0800 (PST)
In-Reply-To: <20101116214409.GC19893@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org

On 11/16/2010 03:44 PM, Wolfram Sang wrote:
> On Tue, Nov 16, 2010 at 02:33:52PM -0600, Rob Herring wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> Explicitly include err.h, of_address.h and of_irq.h.
>> Make use of machine_is() conditional on PPC.
>>
>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
>
> Hmm, sins of the past :/ I wonder if we can get away with less #ifdeffery, will
> think about it...
>

I don't want to start a long debate, but is updating a kernel without 
updating the dtb really something to worry about? Isn't a year enough of 
a transition period.

Do these machines have a machine level compatible property that could be 
used instead?

Rob
