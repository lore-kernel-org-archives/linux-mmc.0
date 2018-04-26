From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 05/12] mmc: sdhci: Disable HS200/HS400 mode if
 controller can't support 1.8v
Date: Thu, 26 Apr 2018 13:40:01 +0300
Message-ID: <b8e326e1-cf24-63ca-0b9c-82e7efe61884@intel.com>
References: <20180425120937.29867-1-kishon@ti.com>
 <20180425120937.29867-6-kishon@ti.com>
 <6bdf4feb-bc12-3779-3de6-e08af1d4f518@intel.com>
 <7b877764-22f3-e13b-a8da-1e0b997b4b74@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7b877764-22f3-e13b-a8da-1e0b997b4b74@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 26/04/18 13:08, Kishon Vijay Abraham I wrote:
> Hi Adrian,
> 
> On Thursday 26 April 2018 02:25 PM, Adrian Hunter wrote:
>> On 25/04/18 15:09, Kishon Vijay Abraham I wrote:
>>> Though MMC controller can indicate HS200/HS400 mode capability (by
>>> using "mmc-hs200-1_8v"/"mmc-hs400-1_8v" dt property), if the IO lines
>>> in the board is connected to 3.3v supply, HS200/HS400 mode cannot be
>>> supported. Such boards have "no-1-8-v" property in their dts file.
>>> Disable HS200/HS400 mode for boards which have "no-1-8-v" set.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 1 +
>>>  include/linux/mmc/host.h | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 2ededa7f43df..b5f047b5f3ae 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>  	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>>>  		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>>>  				 SDHCI_SUPPORT_DDR50);
>>> +		mmc->caps2 &= ~MMC_CAP2_HSX00_1_8V;
>>
>> Seems weird for sdhci to clear flags it never set.  Also couldn't we
>> reasonably expect dt properties to be consistent?  Is this really about
>> setting SDHCI_QUIRK2_NO_1_8_V in your driver and expecting it to override
>> other dt properties?  Although that still begs the question why anyone would
>> set dt properties that the hardware doesn't support?  I guess you should
>> also clear MMC_CAP2_HS400_ES.
> 
> The SoC might support a specific mode like HS200. So the SoC specific dtsi file
> might have dt properties for HS200 mode set. But the board which uses the SoC
> might be modeled in a way a particular mode cannot be used (like IO lines not
> connected to 1.8v). One option is to use /delete-property/ in the board dts
> file. But since "no-1-8-v" property already indicates HS200 mode cannot be
> supported, having a /delete-property/ might be redundant.
> 
> I can reset caps2 in sdhci-omap after invoking mmc_of_parse if you feel that
> makes more sense.

Just add the explanation to the commit message, add a comment to the code,
and also clear MMC_CAP_1_8V_DDR and MMC_CAP2_HS400_ES and MMC_CAP_UHS_*.
