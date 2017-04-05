From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] mmc: core: add mmc-card hardware reset enable support
Date: Wed, 5 Apr 2017 08:23:29 +0200
Message-ID: <7b238b63-9d23-91ef-b76f-82b4f3677de3@skidata.com>
References: <CGME20170404141714epcas5p495985819f877cc723ef217e9cefe89c1@epcas5p4.samsung.com>
 <1491315394-7568-1-git-send-email-richard.leitner@skidata.com>
 <ea610a5c-3857-14f8-3039-414bee724223@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2.skidata.com ([91.230.2.91]:45648 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdDEGXe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Apr 2017 02:23:34 -0400
In-Reply-To: <ea610a5c-3857-14f8-3039-414bee724223@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, dev@g0hl1n.net

On 04/05/2017 06:40 AM, Jaehoon Chung wrote:
> Hi,
> 
> On 04/04/2017 11:16 PM, Richard Leitner wrote:
>> Some eMMCs disable their hardware reset line (RST_N) by default. To enable
>> it the host must set the corresponding bit in ECSD. An example for such
>> a device is the Micron MTFCxGACAANA-4M.
>>
>> This patch adds a new mmc-card devicetree property to let the host enable
>> this feature during card initialization.
>>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc-card.txt |  3 +++
>>  drivers/mmc/core/mmc.c                             | 21 +++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
>> index a70fcd6..8590a40 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
>> @@ -12,6 +12,9 @@ Required properties:
>>  Optional properties:
>>  -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
>>                implementation, and that hpi should not be used
>> +-enable-hw-reset : some eMMC devices have disabled the hw reset functionality
>> +                   (RST_N_FUNCTION) by default. By adding this property the
>> +                   host will enable it during initialization.
> 
> As i know, RST_N_FUNCTION is controlled bit[1:0]
> 0x0 : RST_n disabled (by default)
> 0x1 : permanently enabled
> 0x2 : permanently disabled
> 
> I think that it needs to add the description about these..

Ok.

>>  
>>  Example:
>>  
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index b502601..518d0e3 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1520,9 +1520,16 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>  	int err;
>>  	u32 cid[4];
>>  	u32 rocr;
>> +	struct device_node *np;
>> +	bool enable_rst_n = false;
>>  
>>  	WARN_ON(!host->claimed);
>>  
>> +	np = mmc_of_find_child_device(host, 0);
>> +	if (np && of_device_is_compatible(np, "mmc-card"))
>> +		enable_rst_n = of_property_read_bool(np, "enable-hw-reset");
>> +	of_node_put(np);
>> +
>>  	/* Set correct bus mode for MMC before attempting init */
>>  	if (!mmc_host_is_spi(host))
>>  		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
>> @@ -1810,6 +1817,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * try to enable RST_N if requested
>> +	 * This is needed because some eMMC chips disable this function by
>> +	 * default.
>> +	 */
>> +	if (enable_rst_n) {
>> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +				 EXT_CSD_RST_N_FUNCTION, EXT_CSD_RST_N_ENABLED,
>> +				 card->ext_csd.generic_cmd6_time);
>> +		if (err && err != -EBADMSG)
>> +			pr_warn("%s: Enabling RST_N feature failed\n",
>> +				mmc_hostname(card->host));
>> +	}
> 
> If enabled hw-reset, it doesn't need to re-enable this bit.

Ok. I can add a check to prevent setting it, if it is set already.

> i didn't check the mmc-util..
> If mmc-util provides the changing this, the using mmc-util is better than this.

mmc-utils is providing a enable/disable hwreset feature. But as this
setting is required for my hardware to allow rebooting it, I thought it
would be better if it's in the kernel. So I/the hw doesn't have to
depend on userspace tools.

Nonetheless you're the experts, therefore if you say it shouldn't be in
the kernel/dt I'd be fine with that too. ;-)
