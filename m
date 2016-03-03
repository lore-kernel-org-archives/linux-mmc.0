From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: block: don't use parameter prefix if built
 as module"
Date: Thu, 3 Mar 2016 14:37:04 +0100
Message-ID: <CAPDyKFpRNQuTE9c6Ux_Bj0FXMnL4EiVFkswNf7F+c254W0xM1Q@mail.gmail.com>
References: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
	<20160211171941.GA29378@kroah.com>
	<CAPDyKFp+2SQhAuDt26CpDQnd-KwhWM3GffgQip7aj-QtuUUjEA@mail.gmail.com>
	<20160212163216.GB5646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160212163216.GB5646@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 12 February 2016 at 17:32, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 12, 2016 at 11:06:03AM +0100, Ulf Hansson wrote:
>> On 11 February 2016 at 18:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Feb 11, 2016 at 04:54:11PM +0100, Ulf Hansson wrote:
>> >> This reverts commit 829b6962f7e3cfc06f7c5c26269fd47ad48cf503.
>> >>
>> >> Revert this change as it causes a sysfs path to change and therefore
>> >> introduces and ABI regression. More precisely Android's vold is not being
>> >> able to access /sys/module/mmcblk/parameters/perdev_minors any more, since
>> >> the path becomes changed to: "/sys/module/mmc_block/..."
>> >>
>> >> Fixes: 829b6962f7e3 ("mmc: block: don't use parameter prefix if built as
>> >> module")
>> >> Reported-by: John Stultz <john.stultz@linaro.org>
>> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >
>> > Please also add a "cc: stable..." tag to the patch so it gets picked up
>> > in stable kernel releases.
>>
>> Doesn't the Fixes tag take care of that?
>
> Not at all, never rely on that, please read
> Documentation/stable_kernel_rules.txt for how to properly tag a patch
> for a stable release.
>
> Sometimes I get bored and look at patches with only a fixes: tag on them
> to see how bad the maintainer is messing up and then do their work for
> them, but that's rare these days...

That's sounds like you do this entirely manually, I doubt you have
time for that? :-)

So, isn't it quite simple to automate this thing, as all the
information you need (ideally) is to know what commit is being fixed.
Right?

Kind regards
Uffe
