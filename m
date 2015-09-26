From: Nishanth Menon <nm@ti.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Fri, 25 Sep 2015 21:54:36 -0500
Message-ID: <560608EC.4020208@ti.com>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk> <20150924233756.GN23801@atomide.com> <20150925011334.GP23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43175 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbbIZCzM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Sep 2015 22:55:12 -0400
In-Reply-To: <20150925011334.GP23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>

On 09/24/2015 08:13 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150924 16:42]:
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150924 02:04]:
>>> Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
>>> SDP fail to boot due to lack of working MMC.  Both platforms fail to
>>> find their rootfs, which is on a SD card.
>>>
>>> The breakage occurred somewhere between trees of September 9th (commit
>>> 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
>>> merge window.
>>
>> Yes sorry things got messed up in multiple ways :( I've summarized
>> the mess here earlier:
>>
>> http://article.gmane.org/gmane.linux.kernel.mmc/33911
>>
>> And today commit b9c93646fd5c ("regulator: pbias: program pbias register
>> offset in pbias driver") hit mainline so I'll send a pull request for
>> the related dts change.
> 
> Kishon, while testing I noticed there are still at least two
> issues remaining that seem to need fixing in the MMC driver:
> 
> 1. The legacy booting without device tree does not probe MMC at
>    all on omap3
> 
> 2. I'm getting the regulator warning on omap4 duovero
> 
> Anyways, I'm sending a pull request for the fixes so far as that
> gets MMC working again for most platforms.
> 
> Regards,
> 
With 0925, i think the patches got merged. here is my testing status on
the boards I have access to:

https://github.com/nmenon/kernel-test-logs/tree/next-20150925

Looks like with omap2plus_defconfig, at least
https://github.com/nmenon/kernel-test-logs/blob/next-20150925/omap2plus_defconfig/am335x-evm.txt
somethign is broken there - dunno what yet.

There are a few more farm related failures in various locations, but not
too interesting.


-- 
Regards,
Nishanth Menon
