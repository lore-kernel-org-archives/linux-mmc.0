From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Thu, 30 Oct 2014 14:55:44 +0200
Message-ID: <54523550.5010002@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <7275405.tTXMrp5n17@wuerfel> <54521813.9050308@intel.com> <2048776.ZjHxKvTX0Z@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11133 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759814AbaJ3M5O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Oct 2014 08:57:14 -0400
In-Reply-To: <2048776.ZjHxKvTX0Z@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 30/10/14 14:15, Arnd Bergmann wrote:
> On Thursday 30 October 2014 12:50:59 Adrian Hunter wrote:
>> On 30/10/14 12:00, Arnd Bergmann wrote:
>>>
>>> You also said that the flag is defined to mean that 64-bit DMA
>>> is working and that you want to show the warning when the hardware
>>> and the firmware disagree about this.  If you have an (at least)
>>> 50% chance that the hardware is lying, you really shouldn't believe
>>> it.
>>
>> Just because there are two options does not mean they are each equally
>> likely.
>>
> 
> Yes, that's why I said "at least". Presumably when the hardware and
> firmware disagree about something, it's because the firmware developer
> found a problem with the hardware and wants to work around that.

No, the capability bit could be set by firmware and the DMA restriction
could be broken software, which would make the situation quite different.

sdhci.c will also accept the capabilities bits coming from another source.

Nevertheless, the programming is for non-broken hardware and the
SDHCI_QUIRK2_BROKEN_64_BIT_DMA will suffice otherwise.

