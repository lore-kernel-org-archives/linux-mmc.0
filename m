From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/7] mmc: sdhci: Add quirk to indicate no CRC
 stripping in MMC_RSP_136
Date: Thu, 17 Aug 2017 09:31:50 +0300
Message-ID: <f85729ab-09c2-1e88-626b-caca57cef702@intel.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-2-kishon@ti.com>
 <872c7194-3d48-47e5-6396-7189bf841a42@intel.com>
 <e7592ed0-dda2-6850-098e-7c6bba69df40@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbdHQGiT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Aug 2017 02:38:19 -0400
In-Reply-To: <e7592ed0-dda2-6850-098e-7c6bba69df40@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 17/08/17 08:20, Kishon Vijay Abraham I wrote:
> Hi Adrian,
> 
> On Tuesday 15 August 2017 12:57 PM, Adrian Hunter wrote:
>> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
>>> TI's implementation of sdhci controller used in DRA7 SoC's doesn't
>>> strip CRC in responses with length 136 bits. Add quirk to indicate
>>> the controller does not strip CRC in MMC_RSP_136. If this quirk is
>>> set sdhci library shouldn't shift the response present in
>>> SDHCI_RESPONSE register.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>  2 files changed, 21 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index ecd0d4350e8a..ece3751d2a25 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1182,14 +1182,25 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>  
>>>  	if (cmd->flags & MMC_RSP_PRESENT) {
>>>  		if (cmd->flags & MMC_RSP_136) {
>>> -			/* CRC is stripped so we need to do some shifting. */
>>> -			for (i = 0;i < 4;i++) {
>>> -				cmd->resp[i] = sdhci_readl(host,
>>> -					SDHCI_RESPONSE + (3-i)*4) << 8;
>>> -				if (i != 3)
>>> -					cmd->resp[i] |=
>>> -						sdhci_readb(host,
>>> -						SDHCI_RESPONSE + (3-i)*4-1);
>>> +			if (!(host->quirks2 & SDHCI_QUIRK2_NO_CRC_STRIPPING)) {
>>
>> This is about the 136-bit response so let's put that in the quirk name.  How about SDHCI_QUIRK2_RSP_136_HAS_CRC
> 
> Since omap seems to be the only platform that doesn't have CRC, I prefer adding
> SDHCI_QUIRK2_RSP_136_NO_CRC. That way we can add the quirk only in sdhci-omap
> instead of all the existing sdhci drivers.

Except that it is the way I described.  All the others strip the CRC and we
have to shift to pretend it is still there.

> 
>>
>>> +				/*
>>> +				 * CRC is stripped so we need to do some
>>> +				 * shifting.
>>> +				 */
>>> +				for (i = 0; i < 4; i++) {
>>> +					cmd->resp[i] =
>>> +						sdhci_readl(host, SDHCI_RESPONSE
>>> +							    + (3 - i) * 4) << 8;
>>> +					if (i != 3)
>>> +						cmd->resp[i] |=
>>> +						sdhci_readb(host, SDHCI_RESPONSE
>>> +							    + (3 - i) * 4 - 1);
>>> +				}
>>> +			} else {
>>> +				for (i = 0; i < 4; i++)
>>> +					cmd->resp[i] =
>>> +					sdhci_readl(host, SDHCI_RESPONSE +
>>> +						    (3 - i) * 4);
>>>  			}
>>
>> This is all very jammed up against the 80 column margin.  Please make a new patch to separate it into a new function sdhci_read_rsp_136() and then another patch to add the quirk.
>> i.e. completely untested!
> 
> Sure. Thanks for the patch.
> 
> Thanks
> Kishon
> 

