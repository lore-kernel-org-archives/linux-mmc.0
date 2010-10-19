From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: sdhci_dumpregs: allow private information to be
	dumped on error
Date: Tue, 19 Oct 2010 14:47:56 -0700
Message-ID: <16B90FE9-6FB8-4FCA-867E-CE40EBF26223@marvell.com>
References: <CF727CE6-DAE4-4B18-9BAE-BF373D6DF990@marvell.com>
 <20101019194724.GC31336@pengutronix.de>
 <20101019200445.GB28424@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48676 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758012Ab0JSVtK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Oct 2010 17:49:10 -0400
In-Reply-To: <20101019200445.GB28424@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


sdhci_dumpregs is used to debug the hardware/driver so I do not see an issue here.  The register info is not useful to a normal linux user.   We can fine tune the timing on the controller so knowing the settings is useful if there are CRC errors.

The reason to add this -- rather than wait -- is that I did not imagine we were the only folks who had private information that might be useful to display.  

Philip

On Oct 19, 2010, at 1:04 PM, Chris Ball wrote:

> Hi,
> 
> On Tue, Oct 19, 2010 at 09:47:24PM +0200, Wolfram Sang wrote:
>> On Tue, Oct 19, 2010 at 11:27:22AM -0700, Philip Rakity wrote:
>>> Our controller has private registers that are useful to see on error.
>>> define a new host->ops to allow these registers to be printed
>>> 
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> 
>> I wonder if we really need such a thing in the mainline kernel? It is probably
>> used for debugging the driver?
> 
> There's another question:  why merge a patch that adds a hook that isn't
> used by anything currently in the kernel?  Should we wait until this is
> accompanied by a print_private_info() implementation in a mainline
> driver, rather than adding it proactively?
> 
> Thanks,
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

