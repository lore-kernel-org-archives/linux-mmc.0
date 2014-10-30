From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Thu, 30 Oct 2014 09:05:50 +0100
Message-ID: <2905300.MGH0Qn3mUo@wuerfel>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <5451E802.1010704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60322 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245AbaJ3IGA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Oct 2014 04:06:00 -0400
In-Reply-To: <5451E802.1010704@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On Thursday 30 October 2014 09:25:54 Adrian Hunter wrote:
> On 21/10/14 12:26, Adrian Hunter wrote:
> > Hi
> > 
> > Here are patches to add 64-bit ADMA support to the SDHCI driver.
> > 
> > The patchset starts with 3 minor fixes related to SDHCI ADMA,
> > then there are 8 preparatory patches, then 3 main patches, then
> > the mmc_test "Badly aligned" tests are extended slightly.
> 
> Hi Ulf
> 
> Can you take these?  Note that there was a V2 of
> "mmc: sdhci-acpi: Add 64-bit DMA support".  Also
> that patch is dependent (for functionality not
> compilation) on a patch in v3.18-rc2 so it is slightly
> preferable if you pull v3.18-rc2 first.

You still haven't addressed my comments about clearing
the SDHCI_USE_64_BIT_DMA flag if the platform finds that
hardware has set this bit incorrectly.

	Arnd
