From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: mmc: Add CONFIG_MMC_BLOCK_MAX_SPEED
Date: Mon, 22 Feb 2016 09:25:14 -0800
Message-ID: <56CB447A.3070900@android.com>
References: <1454617771-9842-1-git-send-email-salyzyn@android.com>
 <20160222064551.GA23884@amd> <56CB318D.7070403@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CB318D.7070403@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luca Porzio <lporzio@micron.com>, yalin wang <yalin.wang2010@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Decided to switch to CONFIG_MMC_SIMULATE_MAX_SPEED (and now the thread 
has a new title) so as not to disturb the debugfs gohds. Added some 
documentation to help the cause.

Outstanding will be whether to move this up to the block layer, or let 
it lay in the mmc driver where we can continue to refine the speed and 
behavior simulation model.

Sincerely -- Mark Salyzyn

On 02/22/2016 08:04 AM, Mark Salyzyn wrote:
> On 02/21/2016 10:45 PM, Pavel Machek wrote:
>> Hi!
>>
>> On Thu 2016-02-04 12:29:07, Mark Salyzyn wrote:
>>> When CONFIG_MMC_BLOCK_MAX_SPEED is enabled, Expose max_read_speed,
>>> max_write_speed and cache_size controls to simulate a slow eMMC device.
>>> The boot default values for each respectively are
>>> CONFIG_MMC_BLOCK_MAX_READ_SPEED, CONFIG_MMC_BLOCK_MAX_WRITE_SPEED and
>>> CONFIG_MMC_BLOCK_CACHE_SIZE respectively; and if not defined are
>>> 0 (off), 0, (off) and 4 MB also respectively.
>> Extra , after 0.
>
> Yes :-)
>> Dunno. At minimum, I'd call the option something like
>> "MMC_DEBUG_MAX_SPEED" and the speeds should be really controlled via
>> /sys or something...
>
> Are controlled by sys.  Concern over DEBUG_MAX_SPEED is the sys nodes 
> changing name to debug_max_read_speed, etc, which would in turn result 
> in a move to debugfs instead. Will have to think about all the side 
> effects of such a move.
>
>> ...and ... is there reason to limit it to mmc devices? Making
>> harddrive slow would make it useful for testing, too...
>
> The speed limit at this layer is not the same as in the block layer, 
> the two methods would 'join' at the same value when one does sustained 
> I/O most likely, but not at the random patterns we have experienced on 
> the devices. We would like additional wiggle room to simulate eMMC 
> stalls due to load leveling and other behaviors in the future. If we 
> moved up a layer we would have to simulate head seek and rotational 
> latency opening a can of worms we would feel best if left closed. View 
> it as a political decision.
>>
>> ...and you have the /sys interface. Drop the config options?
>
> I needed a start up default value for boot-time simulations. If just 
> sys options, we would be applying the values far too late in the 
> operation. I expect some other folks using this simulation would like 
> to forgo an extended boot time, to have them set/reset under 
> programmed control. I was covering two bases.
>> Best regards,
>>                                     Pavel
> Sincerely -- Mark Salyzyn
