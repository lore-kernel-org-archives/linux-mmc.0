From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v3] davinci: Add wl1271/wlan support for AM18x
Date: Fri, 29 Jul 2011 11:51:46 -0700
Message-ID: <4E330142.6040809@boundarydevices.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>	<1311886373-3060-1-git-send-email-ido@wizery.com>	<4E31D17D.6050000@boundarydevices.com> <20110728220643.GG1985@WorkStation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:55658 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752417Ab1G2Sv4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2011 14:51:56 -0400
In-Reply-To: <20110728220643.GG1985@WorkStation>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>
Cc: linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org

On 7/28/2011 3:06 PM, Ido Yariv wrote:
> Hi Troy,
> 
> On Thu, Jul 28, 2011 at 02:15:41PM -0700, Troy Kisky wrote:
>>> +	if (power_on) {
>>> +		/* Power up sequence required for wl127x devices */
>>> +		gpio_set_value(DA850_WLAN_EN, 1);
>>> +		usleep_range(15000, 15000);
>>> +		gpio_set_value(DA850_WLAN_EN, 0);
>>> +		usleep_range(1000, 1000);
>>> +		gpio_set_value(DA850_WLAN_EN, 1);
>>> +		msleep(70);
>>
>> Why turn on, then off, and then back on?
>> Isn't off, then back on sufficient?
> 
> Unfortunately, no. This is a required power up sequence for some
> hardware revisions of the 1271 chip.

That's too bad.

> 
>> Also, why not use regulator API like panda board does?
> 
> Unlike omap_hsmmc, davinci's MMC host driver does not toggle any
> regulators. To keep things simple, a set_power callback function was
> added to the mmc host as part of this patch series.
> I've considered adding regulator support instead, but found it to be
> a bit over-complicated for this task. In addition, it would require
> either modifying the fixed regulator or adding a new one in order to
> support the above power sequence.

Yes, that is more effort. I'm fine with your method, but with all
the consolidation effort that's being expended currently, it would
be nice if all boards could use a common method to power up sdio cards.
It might make a device tree implementation for this driver easier too,
though I am certainly no expert there.


> 
> Thanks for your review,
> Ido.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

