From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v4 1/3] mfd: Add realtek USB card reader driver
Date: Mon, 17 Feb 2014 14:09:10 +0800
Message-ID: <5301A786.8040607@realtek.com>
References: <1392199238-14500-1-git-send-email-rogerable@realtek.com>
 <1392199238-14500-2-git-send-email-rogerable@realtek.com>
 <20140214094427.GA7380@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140214094427.GA7380@lee--X1>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 02/14/2014 05:44 PM, Lee Jones wrote:
> On Wed, 12 Feb 2014, rogerable@realtek.com wrote:
>
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
> Applied again, thanks.
>
Would you also apply patch 2/3 and 3/3 that to make the device fully 
operational for users? Or should they be applied by maintainers of 
mmc/memstick subsystems?

Chris, would you give some comment?
