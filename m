From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Add Initial Support for AM654 SDHCI
 driver
Date: Mon, 10 Dec 2018 17:34:20 +0530
Message-ID: <94794998-2c22-1b7f-946c-7887116ee55b@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-4-faiz_abbas@ti.com>
 <2618ec91-09d1-26f3-361e-34a073b1e5ea@intel.com>
 <dfe6c97a-6383-c697-88e5-279f6ca8136e@ti.com>
 <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 07/12/18 7:02 PM, Adrian Hunter wrote:
> On 5/12/18 5:07 PM, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 05/12/18 7:12 PM, Adrian Hunter wrote:
>>> On 29/11/18 6:15 PM, Faiz Abbas wrote:
>>>> The host controllers on TI's AM654 SOCs are not compatible with
>>>> the phy and consumer model of the sdhci-of-arasan driver. It turns out
>>>> that for optimal operation at higher speeds, a special tuning procedure
>>>> needs to be implemented which involves configuration of platform
>>>> specific phy registers.
>>>>
>>>> Therefore, branch out to a new sdhci_am654 driver and add the phy
>>>> register space with all phy configurations to it. Populate AM654
>>>> specific callbacks to sdhci_ops and add SDHCI_QUIRKS wherever
>>>> applicable.
>>>>
>>>> Only add support for upto High Speed for SD card and upto DDR52 speed
>>>> mode for eMMC. Higher speeds will be added in subsequent patches.
>>>>
...
>>>> +
>>>> +	sdhci_am654->clk_ahb = devm_clk_get(dev, "clk_ahb");
>>>> +	if (IS_ERR(sdhci_am654->clk_ahb)) {
>>>> +		dev_err(dev, "clk_ahb clock not found.\n");
>>>> +		ret = PTR_ERR(sdhci_am654->clk_ahb);
>>>> +		goto err_pltfm_free;
>>>> +	}
>>>
>>> Did you intend not to enable clks?
>>
>> Yes. Clocks get enabled as a part of pm_runtime calls.
> 
> Ok, but that could use an explanatory comment.  Also why get a reference to
> clk_ahb if that reference is never used?
> 

You're right. It was being used in sdhci-of-arasan because other users
needed to call enable() and disable(). I missed out on removing it when
porting over. Will remove it and add the comment.

Thanks,
Faiz
