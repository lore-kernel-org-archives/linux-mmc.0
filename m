From: =?utf-8?B?5pWs6ZSQ?= <micky_ching@realsil.com.cn>
Subject: Re: [PATCH v4 1/6] mfd: rtsx: add func to split u32 into register
Date: Mon, 8 Dec 2014 09:49:29 +0000
Message-ID: <54857429.5060108@realsil.com.cn>
References: <cover.1417758564.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1417758564.git.micky_ching@realsil.com.cn>
 <20141208084941.GC3951@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20141208084941.GC3951@x1>
Content-Language: zh-CN
Content-ID: <B729F5F28621554F831E05B742781600@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, =?utf-8?B?546L54Kc?= <wei_wang@realsil.com.cn>, "rogerable@realtek.com" <rogerable@realtek.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org


On 12/08/2014 04:49 PM, Lee Jones wrote:
>> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx_pci.h
>> >index 74346d5..9234449 100644
>> >--- a/include/linux/mfd/rtsx_pci.h
>> >+++ b/include/linux/mfd/rtsx_pci.h
>> >@@ -558,6 +558,7 @@
>> >  #define SD_SAMPLE_POINT_CTL		0xFDA7
>> >  #define SD_PUSH_POINT_CTL		0xFDA8
>> >  #define SD_CMD0				0xFDA9
>> >+#define   SD_CMD_START			0x40
> This is a different format at the others in the group on two counts;
> firstly you have 3 whitespace characters after the #define and
> secondly all of the other hex digits in the set are 4 a breast.
> Please add the leading zeros to conform to this format.
>
Hi lee,

This format is more readable, add 2 space means this value is
in groups under register SD_CMD0, and each register value is u8 type,
so use 2 hex digits is right.

The original file make register address and its related value separated,
and group register together.

But I like to write register address and value together,
add 2 space for value to indicate this value is related to above register.

If we add new address/value, I recommend write register define format as 
below:

#define REGISTER        addr
#define   REG_VAL1      val1
#define   REG_VAL2      val2

regards.
micky.
