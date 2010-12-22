From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 22 Dec 2010 08:24:54 +0000
Message-ID: <4D11B5D6.3030805@csr.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>	<20101221202408.GA12006@void.printf.net> <AANLkTikdA5Pbiwx+VdhtgShhMGcLkJLV0B5O_Yi+_aCx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smarthost03.mail.zen.net.uk ([212.23.3.142]:56826 "EHLO
	smarthost03.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab0LVIZU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 03:25:20 -0500
In-Reply-To: <AANLkTikdA5Pbiwx+VdhtgShhMGcLkJLV0B5O_Yi+_aCx@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

On 22/12/2010 08:12, Linus Walleij wrote:
> 2010/12/21 Chris Ball <cjb@laptop.org>:
> 
>> Hi Linus,
>>
>> On Wed, Nov 03, 2010 at 10:22:50AM +0100, Linus Walleij wrote:
>>> +/*
>>> + *   mmc_host_clk_exit - shut down clock gating code
>>> + *   @host: host with potential clock to control
>>> + */
>>> +static inline void mmc_host_clk_exit(struct mmc_host *host)
>>> +{
>>> +     /*
>>> +      * Wait for any outstanding gate and then make sure we're
>>> +      * ungated before exiting.
>>> +      */
>>> +     if (cancel_work_sync(&host->clk_disable_work))
>>> +             mmc_host_clk_gate_delayed(host);
>>> +     if (host->clk_gated)
>>> +             mmc_host_clk_ungate(host);
>>> +     BUG_ON(host->clk_requests > 0);
>>> +}
>>
>> I just hit the BUG_ON() above, when doing "rmmod sdhci-pci" on my x86
>> laptop running today's linux-next.  There was *no* SD card inserted,
>> and hadn't been one inserted all boot.
> 
> Hm, it's a plain bug...
> 
> We make sure it's ungated the line above so clk_requests is always
> == 1.
> 
> It should be BUG_ON(host->clk_requests > 1)

Change to a WARN_ON() perhaps?

David
