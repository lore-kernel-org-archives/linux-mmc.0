From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v5 3/3] memstick: Add realtek USB memstick host driver
Date: Tue, 8 Apr 2014 16:06:18 +0800
Message-ID: <5343ADFA.7010703@realtek.com>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
 <1395744293-24398-4-git-send-email-rogerable@realtek.com>
 <533A3080.2020008@realtek.com>
 <20140401150654.fe27636428a62fdf9e0d2dc1@linux-foundation.org>
 <20140402151654.GA24060@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140402151654.GA24060@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org


On 04/02/2014 11:16 PM, Lee Jones wrote:
> On Tue, 01 Apr 2014, Andrew Morton wrote:
>
>> On Tue, 1 Apr 2014 11:20:32 +0800 Roger <rogerable@realtek.com> wrote:
>>
>>> On 03/25/2014 06:44 PM, rogerable@realtek.com wrote:
>>>> From: Roger Tseng <rogerable@realtek.com>
>>>>
>>>> Realtek USB memstick host driver provides memstick host support based on the
>>>> Realtek USB card reader MFD driver.
>>>>
>>>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>>>> ---
>>>>    drivers/memstick/host/Kconfig       |  10 +
>>>>    drivers/memstick/host/Makefile      |   1 +
>>>>    drivers/memstick/host/rtsx_usb_ms.c | 839 ++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 850 insertions(+)
>>>>    create mode 100644 drivers/memstick/host/rtsx_usb_ms.c
>>> Hi Andrew,
>>>
>>> Since I'll have to send next revision(v6, to modify patch 1/3) and
>>> you've commented v4, would you also comment or Ack the 3/3 of this one?
>>> This should save one revision for me to make any necessary change.
>>
>> It looks OK to my inexpert eye.  It would be better if Maxim and/or Alex
>> could review the code.  If that doesn't happen then I guess the best we
>> can do is to go ahead and merge it.  Have you worked out via which tree
>> the patches will be merged?
>
> I'll be happy to take the set if one of the subsystem experts would be
> kind enough to cast an eye over it.
>
> Maxim, Alex?
>
Lee,

When I prepare my next submission, I found a previous version of this 
patch set(and only the 1/3 'mfd' part)  seems to be merged in the 
following commit:

commit e5744abb2fa3629aa5a94e21ca1eae32ff2fe00b
Merge: c29aa15 2d28ca7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Apr 7 10:24:18 2014 -0700

     Merge tag 'mfd-for-linus-3.15' of 
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd

Is there any chance to revert it? Or what can I do to help current 
situation?

note: the merged commit:
commit 730876be256603b4ee7225a125467d97a7ce9060
Author: Roger Tseng <rogerable@realtek.com>
Date:   Wed Feb 12 18:00:36 2014 +0800

     mfd: Add realtek USB card reader driver


Best regards,
Roger Tseng
