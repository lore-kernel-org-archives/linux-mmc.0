From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] mmc: Provide tracepoints for request processing
Date: Fri, 25 Mar 2016 08:07:36 -0600
Message-ID: <56F54628.4000404@fb.com>
References: <05d6338bddae751c1755e7825d4179658e78cc71.1458819912.git.baolin.wang@linaro.org>
 <56F3F4F5.8050200@fb.com>
 <CAMz4kuL6f9eZ2+nZBi5aE25W2hb4H3CLUw4uygpbr_gcqKaYWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuL6f9eZ2+nZBi5aE25W2hb4H3CLUw4uygpbr_gcqKaYWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, rostedt@goodmis.org, mingo@redhat.com, adrian.hunter@intel.com, yangbo.lu@freescale.com, akpm@linux-foundation.org, JBottomley@odin.com, lporzio@micron.com, jonathanh@nvidia.com, grundler@chromium.org, fabf@skynet.be, yunpeng.gao@intel.com, dan.j.williams@intel.com, rabin.vincent@axis.com, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, david@protonic.nl, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 03/25/2016 01:32 AM, Baolin Wang wrote:
> On 24 March 2016 at 22:08, Jens Axboe <axboe@fb.com> wrote:
>> On 03/24/2016 05:54 AM, Baolin Wang wrote:
>>>
>>> This patch provides some tracepoints for the lifecycle of a request from
>>> fetching to completion to help with performance analysis of MMC subsystem.
>>
>>
>> Most of these already exist as block layer trace points, why do we need mmc
>> specific ones?
>
> Currently the MMC core does not have any tracepoints for use with
> ftrace. These are very useful as they provide a very low overhead
> runtime controllable way of getting diagnostics from the system which
> is capable of recording a great deal of information without impacting
> system performance. We have tracepoints in the block layer so we can
> do some trace of MMC but none in MMC itself so adding some where
> appropriate would help people follow the activity of subsystem.

But more than half of the trace points you added, those are DIRECTLY 
related to the block event. So what you are saying makes little sense. I 
see you resend it with the same trace points, I'll comment on that mail.

-- 
Jens Axboe
