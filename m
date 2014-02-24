From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v4 1/3] mfd: Add realtek USB card reader driver
Date: Mon, 24 Feb 2014 10:56:19 +0800
Message-ID: <530AB4D3.4090103@realtek.com>
References: <1392199238-14500-1-git-send-email-rogerable@realtek.com>
 <1392199238-14500-2-git-send-email-rogerable@realtek.com>
 <20140214094427.GA7380@lee--X1> <5301A786.8040607@realtek.com>
 <20140217082222.GA17875@lee--X1> <5301D369.5010100@realtek.com>
 <20140217100211.GE17875@lee--X1> <5301E376.8010000@realtek.com>
 <20140217120326.GC20218@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140217120326.GC20218@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Chris Ball <chris@printf.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 02/17/2014 08:03 PM, Lee Jones wrote:
>>>>>>>> From: Roger Tseng <rogerable@realtek.com>
>>>>>>>>
>>>>>>>> Realtek USB card reader provides a channel to transfer command or data to flash
>>>>>>>> memory cards. This driver exports host instances for mmc and memstick subsystems
>>>>>>>> and handles basic works.
>>>>>>>>
>>>>>>>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>>>>>>>> ---
>>>>>>>>   drivers/mfd/Kconfig          |  10 +
>>>>>>>>   drivers/mfd/Makefile         |   1 +
>>>>>>>>   drivers/mfd/rtsx_usb.c       | 760 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>   include/linux/mfd/rtsx_usb.h | 628 +++++++++++++++++++++++++++++++++++
>>>>>>>>   4 files changed, 1399 insertions(+)
>>>>>>>>   create mode 100644 drivers/mfd/rtsx_usb.c
>>>>>>>>   create mode 100644 include/linux/mfd/rtsx_usb.h
>>>>>>>
>>>>>>> Applied again, thanks.
>>>>>>>
>>>>>> Would you also apply patch 2/3 and 3/3 that to make the device fully
>>>>>> operational for users? Or should they be applied by maintainers of
>>>>>> mmc/memstick subsystems?
>>>>>>
>>>>>> Chris, would you give some comment?
>>>>>
>>>>> I can apply them, but I need the other Maintainer Acks.
>>>>>
>>>>> If they are build orthogonal i.e. there are no build dependencies
>>>>> between them, it's probably better that they go into their associated
>>>>> trees separately.
>>>>>
>>>> I think it would be better to apply them together since the later
>>>> patches really depend on the 1st one,so now we are waiting for Acks
>>> >from mmc/memstick subsystems.
>>>
>>> When you say "depend on", do you mean as a build depenency, or won't
>>> run without the first patch applied?
>>
>> The later 2 patches actually invoke symbols defined in the first
>> patch and won't compile if it is not applied first. The Kconfig
>> changes for the later oness also specified this by "depends on".
>>
>> I'm not sure if this means "build dependency". Sorry for my unclear words.
>
> Yes, that sounds like a build dependency i.e. will not build without
> errors or warnings without the previous patch applied.
>
>>>> But there is no one specified for "memstick/host/" in MAINTAINERS.
>>>> Could anyone else Ack this?
>
> Andrew (CC'ed) has been Acking these thus far.
>
Hi Chris and Andrew,

Would you please help comment PATCH 2/3 and 3/3 (for mmc and memstick, 
respectively) or give Acks? Thus we can proceed with applying or 
revision if necessary.
