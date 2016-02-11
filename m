From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] Revert "mmc: block: don't use parameter prefix if built
 as module"
Date: Thu, 11 Feb 2016 13:52:26 -0800
Message-ID: <CALAqxLWueU+bAsfGj0farfhB8JbMCqrt_Ji_3MkE9VvK2gvKgg@mail.gmail.com>
References: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFp=yU1uSHxpPXO5rq4VGZc2VtJepgYNfzSoomgED4g5mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp=yU1uSHxpPXO5rq4VGZc2VtJepgYNfzSoomgED4g5mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 11, 2016 at 7:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 11 February 2016 at 16:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
> John, I noticed your regression report. Thanks!
>
> I decided to send this patch and I have already queued it for fixes.
>
> Sorry for not thinking clear when I applied the earlier patch.

Don't worry, those sorts of changes are subtle. I've seen a lot of
funny sysfs path breakage recently, but usually they are in paths that
are device specific (often related to the paths I think changed in the
dts - ie: lots of paths now have .../soc/... in them), so its not too
hard to just fix it for the device.

This one was more painful because it was generic path across all
devices. So I'm just glad to have caught it before the new behavior
became established and we'd be a bit stuck having to support both.

thanks
-john
