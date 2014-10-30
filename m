From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Thu, 30 Oct 2014 13:15:02 +0100
Message-ID: <2048776.ZjHxKvTX0Z@wuerfel>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <7275405.tTXMrp5n17@wuerfel> <54521813.9050308@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55607 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759059AbaJ3MPJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Oct 2014 08:15:09 -0400
In-Reply-To: <54521813.9050308@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On Thursday 30 October 2014 12:50:59 Adrian Hunter wrote:
> On 30/10/14 12:00, Arnd Bergmann wrote:
> > 
> > You also said that the flag is defined to mean that 64-bit DMA
> > is working and that you want to show the warning when the hardware
> > and the firmware disagree about this.  If you have an (at least)
> > 50% chance that the hardware is lying, you really shouldn't believe
> > it.
> 
> Just because there are two options does not mean they are each equally
> likely.
> 

Yes, that's why I said "at least". Presumably when the hardware and
firmware disagree about something, it's because the firmware developer
found a problem with the hardware and wants to work around that.

	Arnd
