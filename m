From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v3 1/3] mfd: Add realtek USB card reader driver
Date: Tue, 11 Feb 2014 17:40:34 +0800
Message-ID: <52F9F012.8030302@realtek.com>
References: <1391697307-23457-1-git-send-email-rogerable@realtek.com>
 <1391697307-23457-2-git-send-email-rogerable@realtek.com>
 <20140210113054.GE21522@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140210113054.GE21522@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Chris Ball <cjb@laptop.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 02/10/2014 07:30 PM, Lee Jones wrote:
>> From: Roger Tseng <rogerable@realtek.com>
>>
>> Realtek USB card reader provides a channel to transfer command or data to flash
>> memory cards. This driver exports host instances for mmc and memstick subsystems
>> and handles basic works.
>>
>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>> ---
>>   drivers/mfd/Kconfig          |  10 +
>>   drivers/mfd/Makefile         |   1 +
>>   drivers/mfd/rtsx_usb.c       | 760 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/rtsx_usb.h | 628 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 1399 insertions(+)
>>   create mode 100644 drivers/mfd/rtsx_usb.c
>>   create mode 100644 include/linux/mfd/rtsx_usb.h
>
> Applied with Greg's Ack.
>
Thanks. But I have to modify some places in PATCH 2/3 and 3/3 according 
to Ulf's suggestion. I will resend v4 later but currently I don't plan 
to change the 1/3 part(for mfd) in it.

Would you wait for and re-apply the v4 submission or give any advice?
