From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v5 3/3] memstick: Add realtek USB memstick host driver
Date: Tue, 8 Apr 2014 21:10:13 +0800
Message-ID: <5343F535.5070408@realtek.com>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
 <1395744293-24398-4-git-send-email-rogerable@realtek.com>
 <533A3080.2020008@realtek.com>
 <20140401150654.fe27636428a62fdf9e0d2dc1@linux-foundation.org>
 <20140402151654.GA24060@lee--X1> <5343ADFA.7010703@realtek.com>
 <20140408113751.GG8888@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140408113751.GG8888@lee--X1>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Andrew Morton <akpm@linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 04/08/2014 07:37 PM, Lee Jones wrote:
>>>
>> Lee,
>>
>> When I prepare my next submission, I found a previous version of
>> this patch set(and only the 1/3 'mfd' part)  seems to be merged in
>> the following commit:
>>
>> commit e5744abb2fa3629aa5a94e21ca1eae32ff2fe00b
>> Merge: c29aa15 2d28ca7
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Mon Apr 7 10:24:18 2014 -0700
>>
>>      Merge tag 'mfd-for-linus-3.15' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
>>
>> Is there any chance to revert it? Or what can I do to help current
>> situation?
>
> What will happen if we don't revert it? Does it depend on something
> else?
>
No, it has no dependency error but only provides an unused mfd device 
and exports nothing functional to user.

I think it would be good to submit the diff between the merged 1/3 patch 
and the v6, along with full 2/3 and 3/3.

>> note: the merged commit:
>> commit 730876be256603b4ee7225a125467d97a7ce9060
>> Author: Roger Tseng <rogerable@realtek.com>
>> Date:   Wed Feb 12 18:00:36 2014 +0800
>>
>>      mfd: Add realtek USB card reader driver
>>
>>
>> Best regards,
>> Roger Tseng
>
