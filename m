From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Tue, 31 Aug 2010 09:59:44 +0100
Message-ID: <4C7CC480.2040903@csr.com>
References: <cover.1266847842.git.david.vrabel@csr.com> <20100827192248.GJ20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100827192248.GJ20407@void.printf.net>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-mmc@vger.kernel.org

On 27/08/2010 20:22, Chris Ball wrote:
> Hi David,
> 
> On Mon, Feb 22, 2010 at 02:24:17PM +0000, David Vrabel wrote:
>> These patches add support for SDIO cards to the omap_hsmmc driver.
>> Power management changes to prevent SDIO cards from being turned off
>> and losing all state, and card interrupts.
>>
>> I've been unable to test these exact patches as I only have an N900 for 
>> testing and the N900 support in mainline is incomplete.
>>
>> Changes since v1:
>> - (hopefully) get all cards working again by removing a second call to
>>   read MMCi_STAT in the interrupt handler.
>> - flush posted writes after enabling/disabling SDIO interrupts.
>> - tweak the FIXME commit on disabling FCLK to better match what really
>>   going on (at least I think so anyway).
>>
>> David Vrabel (2):
>>   mmc: omap_hsmmc: don't turn SDIO cards off when idle
>>   mmc: omap_hsmmc: enable SDIO card interrupts
> 
> Looks like this patchset wasn't merged.  Mike Rapoport replied with a 
> fix for libertas.  Would you like to resubmit it?

I thought Madhu had picked this up and was going to submit it.

Regardless of whether that is the case, I think it needs to be submitted
by someone who can run mainline kernels (I can't) and ideally someone
who can test it with SDIO cards.

David
