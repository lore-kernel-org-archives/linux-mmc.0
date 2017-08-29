From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/2] driver core: detach device's pm_domain after
 devres_release_all
Date: Tue, 29 Aug 2017 16:08:52 +0800
Message-ID: <ebd40b1d-c4a2-7e39-2841-88e60edddafe@rock-chips.com>
References: <1502786217-212887-1-git-send-email-shawn.lin@rock-chips.com>
 <1502786217-212887-2-git-send-email-shawn.lin@rock-chips.com>
 <20170829064231.GE12198@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:52948 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdH2IIz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2017 04:08:55 -0400
In-Reply-To: <20170829064231.GE12198@kroah.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Greg,

On 2017/8/29 14:42, Greg Kroah-Hartman wrote:
> On Tue, Aug 15, 2017 at 04:36:56PM +0800, Shawn Lin wrote:
>> Move dev_pm_domain_detach after devres_release_all to avoid
>> accessing device's registers with genpd been powered off.
> 
> So, what is this going to break that is working already today?  :)

Thanks for your comment!

The background of this patch is that:
(1) Some SoCs, including Rockchips' SoCs, couldn't support
accessing controllers' registers w/o clk and power domain enabled.
(2) Many common drivers use devm_request_irq to request irq for either
shared irq or non-shared irq.
(3) So we rely on devres_release_all to free irq automatically.

So the actually race condition is:
(1) Driver A probe failed or calling remove
(2) power domain is detached right now
(3) A irq triggerd cocurrently just before calling devm_irq_release..
(4) Driver A's ISR read its register .. panic..

The issue is exposed by enabing CONFIG_DEBUG_SHIRQ. Thus devres_free_irq
will try to call the ISR as it says: "It's a shared IRQ -- the driver
ought to be prepared for an IRQ event to happen even now it's being
freed". So it calls the driver's ISR w/o power domain enabled, which
hangup the system... This is theoretically help folks to make the code
robust enough to deal with shared case.

But, for no matter whether the irq is shared or non-shared, the race
condition is there. So we possible have two choices that
(1) Either using request_irq and free_irq directly
(2) Or moving dev_pm_domain_detach after devres_release_all which
makes sure we free the irq before powering off power domain.

However doesn't choice(1) imply that devm_request_irq shouldn't
exist? :) So I try to fix it like what this patch does.

> 
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---

...

> 
> Why is this set to true if you have a driver remove function, but not if
> you only have a bus remove function?  Why the difference?
> 
> 

Sorry, I will fix these all and always call dev_pm_domain_detach on the
error  path.

>> +		}
>>   		devres_release_all(dev);
>> +		if (do_pm_domain)
>> +			dev_pm_domain_detach(dev, true);
>>   		driver_sysfs_remove(dev);
>>   		dev->driver = NULL;
>>   		dev_set_drvdata(dev, NULL);
>> @@ -458,6 +476,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>   pinctrl_bind_failed:
>>   	device_links_no_driver(dev);
>>   	devres_release_all(dev);
>> +	if (do_pm_domain)
>> +		dev_pm_domain_detach(dev, true);
> 
> Can't you just always call this on the error path?
> 
>>   	driver_sysfs_remove(dev);
>>   	dev->driver = NULL;
>>   	dev_set_drvdata(dev, NULL);
>> @@ -818,6 +838,7 @@ int driver_attach(struct device_driver *drv)
>>   static void __device_release_driver(struct device *dev, struct device *parent)
>>   {
>>   	struct device_driver *drv;
>> +	bool do_pm_domain = false;
>>   
>>   	drv = dev->driver;
>>   	if (drv) {
>> @@ -855,15 +876,19 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>   
>>   		pm_runtime_put_sync(dev);
>>   
>> -		if (dev->bus && dev->bus->remove)
>> +		if (dev->bus && dev->bus->remove) {
>>   			dev->bus->remove(dev);
>> -		else if (drv->remove)
>> +		} else if (drv->remove) {
>> +			do_pm_domain = true;
> 
> Same question here about drivers and bus default functions.
> 
> thanks,
> 
> greg k-h
> 
> 
> 

