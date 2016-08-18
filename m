From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PACTH v3] mmc: sdhci: Do not allow tuning procedure to be
 interrupted
Date: Thu, 18 Aug 2016 16:46:49 +0300
Message-ID: <8a26e2a2-23c2-cf21-7fa4-ef47eaff68a3@intel.com>
References: <1471382729-28472-1-git-send-email-robert.foss@collabora.com>
 <eee256ca-3366-b25c-0936-0a80b1510325@intel.com>
 <0c1a3043-9ed1-9d01-0f07-231d6ece874f@collabora.com>
 <20160817221146.GA9714@cfreeman-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160817221146.GA9714@cfreeman-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Freeman <cfreeman@nvidia.com>, Robert Foss <robert.foss@collabora.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, Kevin Cernekee <cernekee@chromium.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 18/08/16 01:12, Christopher Freeman wrote:
> On 08-17 01:31 PM, Robert Foss wrote:
>>
>>
>> On 2016-08-17 06:47 AM, Adrian Hunter wrote:
>>> On 17/08/16 00:25, robert.foss@collabora.com wrote:
>>>> From: Christopher Freeman <cfreeman@nvidia.com>
>>>>
>>>> wait_event_interruptible_timeout() will return early if the blocked
>>>> process receives a signal, causing the driver to abort the tuning
>>>> procedure and possibly leaving the controller in a bad state.  Since the
>>>> tuning command is expected to complete quickly (<50ms) and we've set a
>>>> timeout, use wait_event_timeout() instead.
>>>>
>>>> Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
>>>> Tested-by: Robert Foss <robert.foss@collabora.com>
>>>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>>>> Reviewed-by: Benson Leung <bleung@chromium.org>
>>>
>>> The mmc block queues are kernel threads which I would expect ignore signals,
>>> so I am curious how you hit this?
>>
>> The issue was discovered on (tegra2?) hardware that is sensitive to
>> being interrupted during tuning and having the controller left in a
>> sensitive state.
>>
>> @Christopher Freeman: Maybe you can provide us with some additional details?
>>
> 
> It was found with Tegra 210.  The signalling was an issue because tuning was
> kicked off from an ioctl to the wifi device on the controller.
> 
> FWIW, this issue was particular to the wifi driver (bcmdhd) and the android
> tree.   It in part depends on the way the wifi driver is able to reset the
> sdio device via a routine that's not present in mainline: sdio_reset_comm.
> I believe the wifi driver would power on the wifi chip and trigger tuning in
> the aforementioned ioctl.  Process that sent the ioctl was some network or wifi
> manager service on Android.
> 
> Let me know if you would like any more details.

Thanks for the explanation.

> 
>>>
>>> In any case:
>>>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>
> 
