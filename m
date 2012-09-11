From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 11 Sep 2012 15:26:32 -0500
Message-ID: <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com> <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com> <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard> <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net> <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org> <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org> <87k3w0y5yn.fsf@octavius.laptop.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46520 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2IKU0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 16:26:52 -0400
In-Reply-To: <87k3w0y5yn.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Huang Changming-R66093 <R66093@freescale.com>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


On Sep 11, 2012, at 9:44 AM, Chris Ball wrote:

> Hi,
> 
> On Tue, Sep 11 2012, Kumar Gala wrote:
>> In sdhci_add_host()
>> 
>> We have the following
>> 
>> ...
>>        mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>> 
>>        if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>>                host->flags |= SDHCI_AUTO_CMD12;
>> 
>>        /* Auto-CMD23 stuff only works in ADMA or PIO. */
>>        if ((host->version >= SDHCI_SPEC_300) &&
>>            ((host->flags & SDHCI_USE_ADMA) ||
>>             !(host->flags & SDHCI_USE_SDMA))) {
>>                host->flags |= SDHCI_AUTO_CMD23;
>>                DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
>>        } else {
>>                DBG("%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc));
>>        }
>> 
>> ...
>> 
>> I'm not clear what the difference is between mmc->caps & host->flags, but shouldn't we move setting MMC_CAP_CMD23 inside the 'Auto-CMD23' if check?
> 
> The main answer is:  No, because CMD23 is distinct from Auto-CMD23.
> 
> Multiblock transfers (CMD23) date back from MMC cards (which is why
> they're an MMC host capability) and can also be used in SDHCI.
> 
> Auto-CMD23 is a new feature in SDHCI 3.0 that reduces the overhead
> of sending CMD23.  It doesn't work if we're using SDMA, though.
> 
> As for capability vs. flags, the capability is more of an inherent
> property of the controller, and flags are runtime decisions on whether
> to use that capability, based on e.g. the presence of a quirk.
> 
> So, I think the code's correct as written.  Feel free to ask more
> questions if you're investigating a specific problem that you haven't
> mentioned yet.

Chris,

thanks for the info.  Do you know what's required on controller side to handle cards that support CMD23?

I'm trying to figure out if older controller's on FSL SoCs are missing some feature to allow CMD23 to work (vs Auto-CMD23).


- k