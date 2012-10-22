From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 4/4] sdio: pm: set device's power state after driver
 runtime suspended it
Date: Mon, 22 Oct 2012 08:49:15 +0800
Message-ID: <5084980B.9090004@intel.com>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com> <96495050.e1u1tibeG9@vostro.rjw.lan> <20121020071539.GB4798@localhost.localdomain> <1729978.qEmlCqSTY2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1729978.qEmlCqSTY2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 10/22/2012 03:57 AM, Rafael J. Wysocki wrote:
> On Saturday 20 of October 2012 15:15:41 Aaron Lu wrote:
>> On Fri, Oct 19, 2012 at 08:08:38PM +0200, Rafael J. Wysocki wrote:
>>> On Friday 19 of October 2012 01:39:25 Rafael J. Wysocki wrote:
>>>> On Friday 12 of October 2012 11:12:41 Aaron Lu wrote:
>>>>> In sdio bus level runtime callback function, after call the driver's
>>>>> runtime suspend callback, we will check if the device supports a
>>>>> platform level power management, and if so, a proper power state is
>>>>> chosen by the corresponding platform callback and then set.
>>>>>
>>>>> Platform level runtime wakeup is also set, if device is enabled for
>>>>> runtime wakeup by its driver, it will be armed the ability to generate
>>>>> a wakeup event by the platform.
>>>>>
>>>>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>>>>> ---
>>>>>  drivers/mmc/core/sdio_bus.c | 49 +++++++++++++++++++++++++++++++++++++++++++--
>>>>>  1 file changed, 47 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>>>>> index aaec9e2..d83dea8 100644
>>>>> --- a/drivers/mmc/core/sdio_bus.c
>>>>> +++ b/drivers/mmc/core/sdio_bus.c
>>>>> @@ -23,6 +23,7 @@
>>>>>  
>>>>>  #include "sdio_cis.h"
>>>>>  #include "sdio_bus.h"
>>>>> +#include "sdio.h"
>>>>>  #include "sdio_acpi.h"
>>>>>  
>>>>>  /* show configuration fields */
>>>>> @@ -194,10 +195,54 @@ static int sdio_bus_remove(struct device *dev)
>>>>>  }
>>>>>  
>>>>>  #ifdef CONFIG_PM
>>>>> +
>>>>> +static int sdio_bus_runtime_suspend(struct device *dev)
>>>>> +{
>>>>> +	int ret;
>>>>> +	sdio_power_t state;
>>>>> +
>>>>> +	ret = pm_generic_runtime_suspend(dev);
>>>>> +	if (ret)
>>>>> +		goto out;
>>>>> +
>>>>> +	if (!platform_sdio_power_manageable(dev))
>>>>> +		goto out;
>>>>> +
>>>>> +	platform_sdio_run_wake(dev, true);
>>>>> +
>>>>> +	state = platform_sdio_choose_power_state(dev);
>>>>> +	if (state == SDIO_POWER_ERROR) {
>>>>> +		ret = -EIO;
>>>>> +		goto out;
>>>>> +	}
>>>>> +
>>>>> +	ret = platform_sdio_set_power_state(dev, state);
>>>>> +
>>>>> +out:
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int sdio_bus_runtime_resume(struct device *dev)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	if (platform_sdio_power_manageable(dev)) {
>>>>> +		platform_sdio_run_wake(dev, false);
>>>>> +		ret = platform_sdio_set_power_state(dev, SDIO_D0);
>>>>> +		if (ret)
>>>>> +			goto out;
>>>>> +	}
>>>>> +
>>>>> +	ret = pm_generic_runtime_resume(dev);
>>>>> +
>>>>> +out:
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>
>>>> Most likely we will need to make analogous changes for other bus types that
>>>> don't support power management natively, like platform, SPI, I2C etc.  In all
>>>> of them the _runtime_suspend() and _runtime_resume() routine will look
>>>> almost exactly the same except for the platform_sdio_ prefix.
>>>>
>>>> For this reason, I think it would be better to simply define two functions
>>>> acpi_pm_runtime_suspend() and acpi_pm_runtime_resume() that will do all of
>>>> the ACPI-specific operations related to runtime suspend/resume.  Then, we
>>>> will be able to use these functions for all of the bus types in question
>>>> in the same way (we may also need to add analogous functions for system
>>>> suspend/resume handling).
>>>
>>> Something like in the (totally untested) patch below.
>>
>> Looks good to me.
>> I'll test the code and put it into v2 of the patchset with your
>> sign-off, is it OK?
> 
> I'd rather do it a bit differently in the signed-off version (I'm working
> on these patches, they should be ready around Tuesday), but if you can test

OK, thanks.

> it in its current form, that'd be useful too.

I was planning to test it some time later, so looks like I can directly
test your signed-off version :-)

Thanks,
Aaron

