From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Acer ES1-432 eMMC not detected, mmc_select_hs200 fails
Date: Wed, 15 Feb 2017 09:00:49 +0200
Message-ID: <ce5edf5a-40ba-eedd-2f93-7c941ca94134@intel.com>
References: <CAD8Lp46nvb0cL-7gJXh1XPL0gvGM=-uRcm93dv1s2chks4gZuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19367 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdBOHGM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Feb 2017 02:06:12 -0500
In-Reply-To: <CAD8Lp46nvb0cL-7gJXh1XPL0gvGM=-uRcm93dv1s2chks4gZuQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, linux-mmc@vger.kernel.org
Cc: Chris Chiu <chiu@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>

On 14/02/17 21:25, Daniel Drake wrote:
> On the Acer ES1-432 (Apollo Lake), the eMMC storage is not detected.
> Errors like these appear in dmesg:
> 
>  mmc0: starting CMD13 arg 00010000 flags 00000195
>  sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x000a8001
>  mmc0: req failed (CMD13): -84, retrying...
>  sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x000a8001
>  mmc0: req failed (CMD13): -84, retrying...
>  sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x000a8001
>  mmc0: req failed (CMD13): -84, retrying...
>  sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x000a8001
>  mmc0: req done (CMD13): -84: 00000000 00000000 00000000 00000000
>  mmc0: mmc_select_hs200 failed, error -84
>  mmc0: error -84 whilst initialising MMC card
> 
> Full dmesg attached (with MMC_DEBUG logs).
> 
> We have reproduced this on Linux 4.8 and 4.9.
> 
> If we add a PCI quirk for SDHCI_QUIRK2_BROKEN_HS200 then the eMMC is usable.
> 
> Any ideas or debugging suggestions? We would like to get this fixed
> and I don't think a PCI quirk is the right answer.

Upstream we no longer check for CRC errors after the HS200 switch.
Here is the relevant patch which will be in v4.10

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ef3d232245ab7a1bf361c52449e612e4c8b7c5ab


