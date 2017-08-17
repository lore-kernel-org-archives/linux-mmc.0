From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] mmc: sdhci: Add quirk to indicate no CRC
 stripping in MMC_RSP_136
Date: Thu, 17 Aug 2017 10:50:38 +0530
Message-ID: <e7592ed0-dda2-6850-098e-7c6bba69df40@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-2-kishon@ti.com>
 <872c7194-3d48-47e5-6396-7189bf841a42@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <872c7194-3d48-47e5-6396-7189bf841a42-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On Tuesday 15 August 2017 12:57 PM, Adrian Hunter wrote:
> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
>> TI's implementation of sdhci controller used in DRA7 SoC's doesn't
>> strip CRC in responses with length 136 bits. Add quirk to indicate
>> the controller does not strip CRC in MMC_RSP_136. If this quirk is
>> set sdhci library shouldn't shift the response present in
>> SDHCI_RESPONSE register.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
>>  drivers/mmc/host/sdhci.h |  2 ++
>>  2 files changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ecd0d4350e8a..ece3751d2a25 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1182,14 +1182,25 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>  
>>  	if (cmd->flags & MMC_RSP_PRESENT) {
>>  		if (cmd->flags & MMC_RSP_136) {
>> -			/* CRC is stripped so we need to do some shifting. */
>> -			for (i = 0;i < 4;i++) {
>> -				cmd->resp[i] = sdhci_readl(host,
>> -					SDHCI_RESPONSE + (3-i)*4) << 8;
>> -				if (i != 3)
>> -					cmd->resp[i] |=
>> -						sdhci_readb(host,
>> -						SDHCI_RESPONSE + (3-i)*4-1);
>> +			if (!(host->quirks2 & SDHCI_QUIRK2_NO_CRC_STRIPPING)) {
> 
> This is about the 136-bit response so let's put that in the quirk name.  How about SDHCI_QUIRK2_RSP_136_HAS_CRC

Since omap seems to be the only platform that doesn't have CRC, I prefer adding
SDHCI_QUIRK2_RSP_136_NO_CRC. That way we can add the quirk only in sdhci-omap
instead of all the existing sdhci drivers.

> 
>> +				/*
>> +				 * CRC is stripped so we need to do some
>> +				 * shifting.
>> +				 */
>> +				for (i = 0; i < 4; i++) {
>> +					cmd->resp[i] =
>> +						sdhci_readl(host, SDHCI_RESPONSE
>> +							    + (3 - i) * 4) << 8;
>> +					if (i != 3)
>> +						cmd->resp[i] |=
>> +						sdhci_readb(host, SDHCI_RESPONSE
>> +							    + (3 - i) * 4 - 1);
>> +				}
>> +			} else {
>> +				for (i = 0; i < 4; i++)
>> +					cmd->resp[i] =
>> +					sdhci_readl(host, SDHCI_RESPONSE +
>> +						    (3 - i) * 4);
>>  			}
> 
> This is all very jammed up against the 80 column margin.  Please make a new patch to separate it into a new function sdhci_read_rsp_136() and then another patch to add the quirk.
> i.e. completely untested!

Sure. Thanks for the patch.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
