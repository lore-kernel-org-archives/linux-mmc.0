From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: SDIO "SD2" vs. SD-card "SD3" interface on BayTrail
Date: Tue, 04 Jul 2017 16:53:51 +0300
Message-ID: <1499176431.22624.255.camel@linux.intel.com>
References: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62236 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbdGDNxy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Jul 2017 09:53:54 -0400
In-Reply-To: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Roese <sr@denx.de>, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>

On Tue, 2017-07-04 at 14:53 +0200, Stefan Roese wrote:
> Hi,
> 
> we are currently investigating, if its possible to connect a SDIO
> device (WLAN module) to the SD-card interface "SD3" of the BayTrail
> SoC instead of the SDIO interface "SD2". The BayTrail manual states, 
> that the SDIO interface is capable of connecting SDIO devices. Is
> this also possible for the SD-card interface "SD3", even if its not
> explicitly mentioned in the manual? If not, why is this not possible?
> 
> Any insight on this would be really helpful.

Hmm... I have no documentation for SD/SDIO/eMMC for BayTrail except the
public one. Internally I found some charts that shows similarities
between two. So, taking that into consideration I would suggest to try
it out on real hardware (MinnowBoard MAX, for example), only impediment
I can see is the absence of support in the drivers in Linux OS. If you
need it only in U-Boot, you perhaps may fix it easily.

P.S. Adrian on vacation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
