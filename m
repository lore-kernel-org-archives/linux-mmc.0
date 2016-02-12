From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: block: don't use parameter prefix if built
 as module"
Date: Fri, 12 Feb 2016 11:06:03 +0100
Message-ID: <CAPDyKFp+2SQhAuDt26CpDQnd-KwhWM3GffgQip7aj-QtuUUjEA@mail.gmail.com>
References: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
	<20160211171941.GA29378@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211171941.GA29378@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2016 at 18:19, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Feb 11, 2016 at 04:54:11PM +0100, Ulf Hansson wrote:
>> This reverts commit 829b6962f7e3cfc06f7c5c26269fd47ad48cf503.
>>
>> Revert this change as it causes a sysfs path to change and therefore
>> introduces and ABI regression. More precisely Android's vold is not being
>> able to access /sys/module/mmcblk/parameters/perdev_minors any more, since
>> the path becomes changed to: "/sys/module/mmc_block/..."
>>
>> Fixes: 829b6962f7e3 ("mmc: block: don't use parameter prefix if built as
>> module")
>> Reported-by: John Stultz <john.stultz@linaro.org>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Please also add a "cc: stable..." tag to the patch so it gets picked up
> in stable kernel releases.

Doesn't the Fixes tag take care of that?

Kind regards
Uffe
