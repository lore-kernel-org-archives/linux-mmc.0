From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v7 4/4] memstick: Add realtek USB memstick host driver
Date: Fri, 25 Apr 2014 15:06:18 +0800
Message-ID: <535A096A.3070603@realtek.com>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
 <1397199203-2235-5-git-send-email-rogerable@realtek.com>
 <20140416081352.GA4754@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140416081352.GA4754@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Lee Jones <lee.jones@linaro.org>, Oliver Neukum <oneukum@suse.de>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org


On 04/16/2014 04:13 PM, Lee Jones wrote:
> Hi Andrew,
>
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
> It seems Max and Alex are less than interested in this patch, so I'm
> going to apply it anyway. In your last review you mentioned that it
> looked good to your inexpert eye. Can I apply your Ack to that effect?
>
Hi Andrew,

Would you confirm the Ack for Lee?

Best regards,
Roger Tseng
