From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v7 4/4] memstick: Add realtek USB memstick host driver
Date: Wed, 30 Apr 2014 15:56:20 +0800
Message-ID: <5360ACA4.80503@realtek.com>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
 <1397199203-2235-5-git-send-email-rogerable@realtek.com>
 <20140428101010.GR6264@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140428101010.GR6264@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Andrew Morton <akpm@linux-foundation.org>, Lee Jones <lee.jones@linaro.org>, Oliver Neukum <oneukum@suse.de>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 04/28/2014 06:10 PM, Lee Jones wrote:
>> From: Roger Tseng <rogerable@realtek.com>
>>
>> Realtek USB memstick host driver provides memstick host support based on the
>> Realtek USB card reader MFD driver.
>>
>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>> ---
>>   drivers/memstick/host/Kconfig       |  10 +
>>   drivers/memstick/host/Makefile      |   1 +
>>   drivers/memstick/host/rtsx_usb_ms.c | 839 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 850 insertions(+)
>>   create mode 100644 drivers/memstick/host/rtsx_usb_ms.c
>
> Applied, thanks.
>
Greg,

Since all patches have been applied and the device is now supported by 
the new driver, would you remove the former staging one at 
drivers/staging/rts5139? Similar removal had been done for our PCIE 
devices in:

commit cd2112220b6b0a35fa12ba988a0dd837515dfaf8
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Oct 26 09:03:21 2012 -0700

     Staging: remove rts_pstor driver


Best regards,
Roger Tseng
