From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v3 2/3] mmc: Add realtek USB sdmmc host driver
Date: Tue, 11 Feb 2014 17:27:30 +0800
Message-ID: <52F9ED02.6000604@realtek.com>
References: <1391697307-23457-1-git-send-email-rogerable@realtek.com>	<1391697307-23457-3-git-send-email-rogerable@realtek.com>
 <201402110748.s1B7miQ8010938@rtits1.realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <201402110748.s1B7miQ8010938@rtits1.realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 02/10/2014 10:58 PM, Ulf Hansson wrote:
> On 6 February 2014 15:35,  <rogerable@realtek.com> wrote:
>> From: Roger Tseng <rogerable@realtek.com>
>>
>> Realtek USB SD/MMC host driver provides mmc host support based on the Realtek
>> USB card reader MFD driver.
>>
>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>> ---
>>   drivers/mmc/host/Kconfig          |    7 +
>>   drivers/mmc/host/Makefile         |    1 +
>>   drivers/mmc/host/rtsx_usb_sdmmc.c | 1500 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1508 insertions(+)
>>   create mode 100644 drivers/mmc/host/rtsx_usb_sdmmc.c
[snip]
>> +#ifdef CONFIG_PM_RUNTIME
>
> There are stubs for pm_runtime* functions, thus the ifdefs can be removed.
> Please go though the complete patch and remove all instances.
>
>> +               pm_runtime_put(sdmmc_dev(host));
>
> I don't know so much about USB mmc hosts hardware, but I just wanted
> to find out if I have understood this correct.
>
> You can't do fine grained power management of the USB parent device,
> since it needs to be runtime resumed to be able keep the power the
> card? Once it becomes runtime suspended, the power to the card will
> thus also be dropped?
>
Yes, and to keep some internal state of the controller.

[snip]
>> +#ifdef CONFIG_PM
>
> I suppose this should be CONFIG_PM_SLEEP?
>
...
>> +       err = mmc_suspend_host(mmc);
>
> This won't compile. The mmc_suspend_host API has been removed.
>
...
>> +       return mmc_resume_host(mmc);
>
> This won't compile. The mmc_resume_host API has been removed.
>
...
>> +static struct platform_driver rtsx_usb_sdmmc_driver = {
>> +       .probe          = rtsx_usb_sdmmc_drv_probe,
>> +       .remove         = rtsx_usb_sdmmc_drv_remove,
>> +       .id_table       = rtsx_usb_sdmmc_ids,
>> +       .suspend        = rtsx_usb_sdmmc_suspend,
>> +       .resume         = rtsx_usb_sdmmc_resume,
>
> Please use the modern pm_ops instead of the legacy suspend/resume callbacks.
> I suggest you then also switch to use the SIMPLE_DEV_PM_OPS macro.

I just missed the removal of mmc_suspend|resume_host.

I'll remove all these unnecessary mmc host pm things as done in commit 
ff71c4bcb0af2730d047989e485303ae4e1ce794 for drivers of our PCIe devices.

Thanks for pointing this out.

> Kind regards
> Ulf Hansson
