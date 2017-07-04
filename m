From: Stefan Roese <sr@denx.de>
Subject: Re: SDIO "SD2" vs. SD-card "SD3" interface on BayTrail
Date: Tue, 4 Jul 2017 16:12:57 +0200
Message-ID: <05ba15dc-b7b0-0760-ee0b-67fec71e9736@denx.de>
References: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
 <1499176431.22624.255.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:41730 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbdGDONR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Jul 2017 10:13:17 -0400
In-Reply-To: <1499176431.22624.255.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>

Hi Andy,

On 04.07.2017 15:53, Andy Shevchenko wrote:
> On Tue, 2017-07-04 at 14:53 +0200, Stefan Roese wrote:
>> Hi,
>>
>> we are currently investigating, if its possible to connect a SDIO
>> device (WLAN module) to the SD-card interface "SD3" of the BayTrail
>> SoC instead of the SDIO interface "SD2". The BayTrail manual states,
>> that the SDIO interface is capable of connecting SDIO devices. Is
>> this also possible for the SD-card interface "SD3", even if its not
>> explicitly mentioned in the manual? If not, why is this not possible?
>>
>> Any insight on this would be really helpful.
> 
> Hmm... I have no documentation for SD/SDIO/eMMC for BayTrail except the
> public one. Internally I found some charts that shows similarities
> between two. So, taking that into consideration I would suggest to try
> it out on real hardware (MinnowBoard MAX, for example), only impediment
> I can see is the absence of support in the drivers in Linux OS. If you
> need it only in U-Boot, you perhaps may fix it easily.

Its not only for U-Boot unfortunately. Do you think, a quick test in 
Linux should be possible by simply swapping the PCI device IDs in
sdhci-pci.core.c (PCI_DEVICE_ID_INTEL_BYT_SDIO vs.
PCI_DEVICE_ID_INTEL_BYT_SD)?

Thanks,
Stefan
