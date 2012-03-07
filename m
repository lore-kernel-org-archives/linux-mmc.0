From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
Date: Wed, 07 Mar 2012 15:28:06 +0530
Message-ID: <4F57312E.4080104@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com> <4F476228.7060607@ti.com> <4F54714E.6080805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4F54714E.6080805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, balajitk@ti.com, svenkatr@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Monday 05 March 2012 01:24 PM, Rajendra Nayak wrote:
> On Friday 24 February 2012 03:40 PM, Rajendra Nayak wrote:
>> Chris,
>>
>> On Thursday 23 February 2012 04:56 PM, Rajendra Nayak wrote:
>>> Re-sending as these patches did not make it to the lists due to
>>> issues with my 'git send-email'
>>>
>>> This series mainly cleans up all instances of hardcoding's in
>>> the driver based on pdev->id. This is cleanup leading to the
>>> DT adaptation of omap_hsmmc driver.
>>>
>>> v2 mainly has some minor changes to get rid of a debug print
>>> which was still using host->id and getting rid of 'id' field
>>> entirely from omap_hsmmc_host struct.
>>>
>>> The series is tested on OMAP4SDP, OMAP4panda, OMAP3beagle and
>>> OMAP2430SDP
>>> boards.
>>
>> This series is reviewed/tested and acked by Balaji and Venkat.
>> Care to pull this in for 3.4?
>>
>> I have one other cleanup patch on top of this series to make all
>> remaining pr_* prints in the driver to dev_* [1].
>> It would be great if you could pick that up as well.
>>
>> These patches are cleanups leading to the DT conversion of omap_hsmmc
>> driver.
>
> Chris, Ping. I am basing my DT support patches on top of these cleanups.
> Would be great if you can have a look and pull them in.

Chris, just realized the last two requests from me to get this merged
weren't addressed to you directly, but instead you were copied.
Resending with you in 'To', hope this lands in your inbox :)

regards,
Rajendra

>
>>
>> regards,
>> Rajendra
>>
>> [1] http://marc.info/?l=linux-mmc&m=132999677405098&w=3
>>
>>>
>>> regards,
>>> Rajendra
>>>
>>> Balaji T K (3):
>>> mmc: omap_hsmmc: use platform_get_resource_byname for tx/rx DMA
>>> channels
>>> mmc: omap_hsmmc: remove unused .set_sleep function
>>> mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag to remove
>>> host->id based hardcoding
>>>
>>> Rajendra Nayak (3):
>>> mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power function
>>> mmc: omap_hsmmc: Get rid of omap_hsmmc_4_set_power function
>>> mmc: omap_hsmmc: Don't expect MMC1 to always have vmmc supply
>>>
>>> arch/arm/plat-omap/include/plat/mmc.h | 2 -
>>> drivers/mmc/host/omap_hsmmc.c | 175 +++------------------------------
>>> 2 files changed, 16 insertions(+), 161 deletions(-)
>>>
>>
>

