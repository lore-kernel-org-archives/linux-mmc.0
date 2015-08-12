From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH v1] mmc: sdhci-of-arasan: Add the support for
 sdhci-5.1
Date: Wed, 12 Aug 2015 07:07:37 +0200
Message-ID: <55CAD499.5070701@xilinx.com>
References: <1439279190-9556-1-git-send-email-shawn.lin@rock-chips.com>
 <55CA0C6F.7000002@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55CA0C6F.7000002@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+linux-mmc

On 08/11/2015 04:53 PM, Michal Simek wrote:
> On 08/11/2015 09:46 AM, Shawn Lin wrote:
>> This patch adds the compatible string in sdhci-of-arasan.c to
>> support sdhci-arasan5.1 version of controller. No documented
>> controller IP version is found in the TRM, so we use ths version
>> of command queueing engine integrated into this controller by arasan
>> to specify our controller.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v1:
>> - Remove redundant SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN for "arasan, sdhci-5.1" since
>>   SDHCI will check "host->max_clk == 0" and let driver get it from host->ops->get_max_clock.
>>
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 +-
>>  drivers/mmc/host/sdhci-of-arasan.c                     | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 7e94903..da541c3 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -9,7 +9,7 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>  
>>  Required Properties:
>>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> -                'arasan,sdhci-4.9a'
>> +                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>    - reg: From mmc bindings: Register location and length.
>>    - clocks: From clock bindings: Handles to clock inputs.
>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index ef5a7d2..75379cb 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -217,6 +217,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>>  
>>  static const struct of_device_id sdhci_arasan_of_match[] = {
>>  	{ .compatible = "arasan,sdhci-8.9a" },
>> +	{ .compatible = "arasan,sdhci-5.1" },
>>  	{ .compatible = "arasan,sdhci-4.9a" },
>>  	{ }
>>  };
>>
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> Thanks,
> Michal
> 
> 
