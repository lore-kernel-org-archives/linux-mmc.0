From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Date: Mon, 18 Feb 2019 19:19:13 +0530
Message-ID: <0c3b5570-c5ec-46c8-2548-8049100661d3@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215200244.GA15711@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215200244.GA15711@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On 16/02/19 1:32 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [190215 19:17]:
>> The following add driver patches for porting TI's am335x and am437x
>> devices to the sdhci-omap driver.
>>
>> This involves adding external DMA support to sdhci (first 3 patches from
>> Chunyan) plus some miscellaneous patches to take care of deviations of
>> the controllers from the sdhci model.
> 
> Good to see this happening :)
> 
> I think am437x should have also the ADMA as it's mostly
> omap4 based? See the old omap4 ADMA series at [0] below.
> 
> Are you seeing any improvment in SDIO card read/write speeds
> between external DMA and ADM BTW

am437 is using dmaengine even in the old omap_hsmmc driver. I haven't
tried to enable ADMA in am437x.

Thanks,
Faiz
