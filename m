From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: omap_hsmmc noisy/broken for suspend resume
Date: Fri, 18 Nov 2011 11:43:34 -0800
Message-ID: <4EC6B566.5030406@deeprootsystems.com>
References: <878vnwhpbr.fsf@ti.com> <CAGxe1ZFsTYt+8YyBuQZjUJ78d=19v9spFxrZkqYKiKgw0vpABg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZFsTYt+8YyBuQZjUJ78d=19v9spFxrZkqYKiKgw0vpABg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, svenkatr@ti.com, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Girish,

On 11/03/2011 09:21 PM, Girish K S wrote:
> On 3 November 2011 17:24, Kevin Hilman <khilman@ti.com> wrote:
>> Hello,
>>
>> Using Linus' master branch, I was testing PM functionality on OMAP3/4
>> and noticed that the MMC driver is now rather noisy during suspend on
>> OMAP3[1], but seems to work.
>>

[...]

>> / # echo mem > /sys/power/state
>> [  811.145507] PM: Syncing filesystems ... done.
>> [  811.150268] PM: Preparing system for mem sleep
>> [  811.155059] Freezing user space processes ... (elapsed 0.01 seconds) done.
>> [  811.179992] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
>> [  811.203460] PM: Entering mem sleep
>> [  811.207489] Suspending console(s) (use no_console_suspend to debug)
>> a[  811.225860] ------------[ cut here ]------------
>> [  811.225891] WARNING: at /work/kernel/omap/pm/drivers/mmc/core/core.c:453 mmc_wait_for_cmd+0x78/0x84()
>> [  811.225921] Modules linked in:
>> [  811.225952] [<c001a810>] (unwind_backtrace+0x0/0xf0) from [<c00525d0>] (warn_slowpath_common+0x4c/0x64)
>> [  811.225982] [<c00525d0>] (warn_slowpath_common+0x4c/0x64) from [<c0052604>] (warn_slowpath_null+0x1c/0x24)
>> [  811.226013] [<c0052604>] (warn_slowpath_null+0x1c/0x24) from [<c033a494>] (mmc_wait_for_cmd+0x78/0x84)
>> [  811.226043] [<c033a494>] (mmc_wait_for_cmd+0x78/0x84) from [<c033e7b8>] (mmc_switch+0x74/0x118)
>> [  811.226074] [<c033e7b8>] (mmc_switch+0x74/0x118) from [<c033b034>] (mmc_power_off+0xd8/0x108)
>
> The problem is caused by the card->poweroff_notify_state =
> MMC_POWERED_ON; statement in the mmc_card_init function
> it is set for the non eMMC4.5 devices. I will rectify this and soon
> send a patch for the same.

Is this the patch that fixes this issue:

	http://article.gmane.org/gmane.linux.kernel.mmc/10961

I found this by digging (since I'm not subscribed to linux-mmc), but it
would've been much more efficient if you Cc the original lists where the
issue was reported, and especially the person reporting the bug so it
can be tested by those reporting the problem.

I tested the above patch and verified it gets rid of all the noise in
the OMAP HS-MMC driver.

Chris, I see this is already in mmc-next.  Feel free to add:

Tested-by: Kevin Hilman <khilman@ti.com>

If you like.

Thanks,

Kevin
