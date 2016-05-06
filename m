From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 01/13] usb: misc: usb3503: Clean up on driver unbind
Date: Fri, 06 May 2016 08:13:28 +0200
Message-ID: <572C3608.9060600@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-2-git-send-email-k.kozlowski@samsung.com>
 <d78e8151-ee37-a003-2f8f-bc5431906512@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:23253 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbcEFGNf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2016 02:13:35 -0400
In-reply-to: <d78e8151-ee37-a003-2f8f-bc5431906512@osg.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 05/05/2016 08:32 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof
> 
> Patch looks good to me, I just have a trivial comment below.
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> The driver should clean up after itself by unpreparing the clock when it
>> is unbound.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/usb/misc/usb3503.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
>> index b45cb77c0744..a464636675a6 100644
>> --- a/drivers/usb/misc/usb3503.c
>> +++ b/drivers/usb/misc/usb3503.c
>> @@ -330,6 +330,19 @@ static int usb3503_i2c_probe(struct i2c_client *i2c,
>>  	return usb3503_probe(hub);
>>  }
>>  
>> +static int usb3503_i2c_remove(struct i2c_client *i2c)
>> +{
>> +	struct usb3503 *hub;
>> +
>> +	hub = i2c_get_clientdata(i2c);
>> +	if (hub) {
>> +		if (hub->clk)
>> +			clk_disable_unprepare(hub->clk);
>> +	}
> 
> I think the following is simpler and easier to read:
> 
> if (hub && hub->clk)
> 	clk_disable_unprepare(hub->clk);
> 

Sure, thanks.

Best regards,
Krzysztof

>> +
>> +	return 0;
>> +}
>> +
>>  static int usb3503_platform_probe(struct platform_device *pdev)
>>  {
>>  	struct usb3503 *hub;
>> @@ -342,6 +355,19 @@ static int usb3503_platform_probe(struct platform_device *pdev)
>>  	return usb3503_probe(hub);
>>  }
>>  
>> +static int usb3503_platform_remove(struct platform_device *pdev)
>> +{
>> +	struct usb3503 *hub;
>> +
>> +	hub = platform_get_drvdata(pdev);
>> +	if (hub) {
>> +		if (hub->clk)
>> +			clk_disable_unprepare(hub->clk);
>> +	}
>> +
> 
> Ditto.
> 
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_PM_SLEEP
>>  static int usb3503_i2c_suspend(struct device *dev)
>>  {
>> @@ -395,6 +421,7 @@ static struct i2c_driver usb3503_i2c_driver = {
>>  		.of_match_table = of_match_ptr(usb3503_of_match),
>>  	},
>>  	.probe		= usb3503_i2c_probe,
>> +	.remove		= usb3503_i2c_remove,
>>  	.id_table	= usb3503_id,
>>  };
>>  
>> @@ -404,6 +431,7 @@ static struct platform_driver usb3503_platform_driver = {
>>  		.of_match_table = of_match_ptr(usb3503_of_match),
>>  	},
>>  	.probe		= usb3503_platform_probe,
>> +	.remove		= usb3503_platform_remove,
>>  };
>>  
>>  static int __init usb3503_init(void)
>>
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> 

