From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] sdhci: arasan: Add runtime PM support
Date: Tue, 10 Apr 2018 15:02:46 +0200
Message-ID: <98f0c8c1-3f85-8775-f6cd-9097fb254446@xilinx.com>
References: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
 <29f0aae5-3cee-8a37-f5aa-3830f466a759@intel.com>
 <b02c6970-f4f5-53af-2834-710ff3b7cbaa@xilinx.com>
 <c8a29949-c220-1319-02f4-c5b0b9601dc8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c8a29949-c220-1319-02f4-c5b0b9601dc8@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, naranimanish@gmail.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Manish Narani <mnarani@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

On 10.4.2018 14:17, Adrian Hunter wrote:
> On 10/04/18 15:06, Michal Simek wrote:
>> Hi Adrian,
>>
>> On 10.4.2018 13:42, Adrian Hunter wrote:
>>> On 29/03/18 08:48, naranimanish@gmail.com wrote:
>>>> From: Manish Narani <mnarani@xilinx.com>
>>>>
>>>> This patch adds runtime PM support in Arasan SD driver.
>>>>
>>>> Signed-off-by: Manish Narani <mnarani@xilinx.com>
>>>
>>> Just a couple of comments about style.
>>>
>>>> ---
>>>>  drivers/mmc/host/sdhci-of-arasan.c | 83 +++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 81 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>>> index c33a5f7..47196b5 100644
>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>> @@ -23,6 +23,7 @@
>>>>  #include <linux/mfd/syscon.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/of_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>>  #include <linux/phy/phy.h>
>>>>  #include <linux/regmap.h>
>>>>  #include <linux/of.h>
>>>> @@ -349,6 +350,75 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>>>>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>  };
>>>>  
>>>> +#ifdef CONFIG_PM
>>>> +/**
>>>> + * sdhci_arasan_runtime_suspend - Suspend method for the driver
>>>> + * @dev:	Address of the device structure
>>>> + * Returns 0 on success and error value on error
>>>> + *
>>>> + * Put the device in a low power state.
>>>> + */
>>>
>>> Kernel style is not to put kerneldoc on callback functions.
>>
>> I have never read that there are some sort of list of functions which
>> shouldn't be covered by kernel-doc.
>> What's the problem with using kerneldoc format here? Maybe I am not
>> getting your comments.
> 
> It is not a list of functions.  It is any implementation of a well-known
> callback. i.e. we already know what ->runtime_suspend() is for, so we don't
> need untold numbers of drivers describing it in comments.
> 

Personally in general I can't see any issue with it especially for
people who has no idea how these callbacks are working but I understand
your concern here especially when there is anything specific written in
connection to this device.

Thanks,
Michal
