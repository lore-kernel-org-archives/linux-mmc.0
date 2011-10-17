From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Mon, 17 Oct 2011 11:19:37 +0300
Message-ID: <4E9BE519.2020908@intel.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com> <1317645214-12316-3-git-send-email-adrian.hunter@intel.com> <m2aa91eoe6.fsf@bob.laptop.org> <m262jpekox.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18181 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab1JQITj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 04:19:39 -0400
In-Reply-To: <m262jpekox.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 16/10/11 05:26, Chris Ball wrote:
> Hi,
> 
> On Sat, Oct 15 2011, Chris Ball wrote:
>> Card insertion detection after boot no longer works (nothing new appears
>> in dmesg), so I'm unable to use the reader.  Are you able to try to
>> figure this out?  I'm happy to try any patches you suggest.
> 
> If I boot with a card inserted, I still see repeated "irq while runtime
> suspended" messages for 80 seconds after boot, but the card *does* work.
> I don't see further "irq while runtime suspended" messages during or
> after I/O to the card at that point.
> 
> So, we have a problem of unexpected irqs while runtime suspended, and a
> problem of broken card detection when booted without a card inserted
> (on my laptop).

Unfortunately I do not have any information about the unexpected irqs.

Card detect will not work because the interrupt is masked while the
host controller is runtime suspended, on the grounds that the host
controller may be powered off and so cannot handle interrupts.  An
alternate mechanism is needed to enable the host controller to
wake-up from a card detect signal.

So Runtime PM needs to be opt-in.  I have sent a patch.
