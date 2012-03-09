From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use device
 tree
Date: Fri, 09 Mar 2012 14:51:06 +0530
Message-ID: <4F59CB82.9050607@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-2-git-send-email-rnayak@ti.com> <20120309054213.9E69C3E0901@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39617 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab2CIJVQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 04:21:16 -0500
Received: by yenm8 with SMTP id m8so874866yen.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Mar 2012 01:21:14 -0800 (PST)
In-Reply-To: <20120309054213.9E69C3E0901@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, balajitk@ti.com, linux-arm-kernel@lists.infradead.org

Hi Grant,

On Friday 09 March 2012 11:12 AM, Grant Likely wrote:
> On Thu, 23 Feb 2012 17:31:27 +0530, Rajendra Nayak<rnayak@ti.com>  wrote:
>> Define dt bindings for the ti-omap-hsmmc, and adapt
>> the driver to extract data (which was earlier passed as
>> platform_data) from device tree.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   31 +++++++++
>>   drivers/mmc/host/omap_hsmmc.c                      |   68 ++++++++++++++++++++
>>   2 files changed, 99 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> new file mode 100644
>> index 0000000..e4fa8f0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -0,0 +1,31 @@
>> +* TI Highspeed MMC host controller for OMAP
>> +
>> +The Highspeed MMC Host Controller on TI OMAP family
>> +provides an interface for MMC, SD, and SDIO types of memory cards.
>> +
>> +Required properties:
>> +- compatible:
>> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers
>> + Should be "ti,omap4-hsmmc", for OMAP4 controllers
>> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
>> +- reg : should contain hsmmc registers location and length
>> +
>> +Optional properties:
>> +ti,dual-volt: boolean, supports dual voltage cards
>> +<supply-name>-supply: phandle to the regulator device tree node
>> +"supply-name" examples are "vmmc", "vmmc_aux" etc
>> +ti,bus-width: Number of data lines, default assumed is 1 if the property is missing.
>> +cd-gpios: GPIOs for card detection
>> +wp-gpios: GPIOs for write protection
>> +ti,non-removable: non-removable slot (like eMMC)
>
> Binding looks okay.  A couple comments below...
>
> [...]
>> +static const struct of_device_id omap_mmc_of_match[];
>
> If you move the omap_mmc_of_match[] table up to here then there is no
> need for the forward declaration.
>
>> +
>>   static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>   {
>>   	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
>> @@ -1725,6 +1768,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>   	struct omap_hsmmc_host *host = NULL;
>>   	struct resource *res;
>>   	int ret, irq;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_device(omap_mmc_of_match,&pdev->dev);
>> +	if (match) {
>> +		pdata = of_get_hsmmc_pdata(&pdev->dev);
>> +		if (match->data)
>> +			pdata->reg_offset = *(u16 *)match->data;
>
> Blech on the ugly cast.  It is slightly safer to do thusly:
>
> 	u16 *offsetp = match->data;
> 	pdata->reg_offset = *offsetp

thanks for the review. I'll repost with these changes.

regards,
Rajendra

>
>> +	}
>>
>>   	if (pdata == NULL) {
>>   		dev_err(&pdev->dev, "Platform Data is missing\n");
>> @@ -2120,12 +2171,29 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>>   	.runtime_resume = omap_hsmmc_runtime_resume,
>>   };
>>
>> +#if defined(CONFIG_OF)
>> +static u16 omap4_reg_offset = 0x100;
>> +
>> +static const struct of_device_id omap_mmc_of_match[] = {
>> +	{
>> +		.compatible = "ti,omap2-hsmmc",
>> +	},
>> +	{
>> +		.compatible = "ti,omap4-hsmmc",
>> +		.data =&omap4_reg_offset,
>> +	},
>> +	{},
>> +}
>> +MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>> +#endif
>> +
>>   static struct platform_driver omap_hsmmc_driver = {
>>   	.remove		= omap_hsmmc_remove,
>>   	.driver		= {
>>   		.name = DRIVER_NAME,
>>   		.owner = THIS_MODULE,
>>   		.pm =&omap_hsmmc_dev_pm_ops,
>> +		.of_match_table = of_match_ptr(omap_mmc_of_match),
>>   	},
>>   };
>>
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev@lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
>

