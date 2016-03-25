From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH] mmc: Provide tracepoints for request processing
Date: Fri, 25 Mar 2016 15:32:23 +0800
Message-ID: <CAMz4kuL6f9eZ2+nZBi5aE25W2hb4H3CLUw4uygpbr_gcqKaYWA@mail.gmail.com>
References: <05d6338bddae751c1755e7825d4179658e78cc71.1458819912.git.baolin.wang@linaro.org>
	<56F3F4F5.8050200@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36406 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbcCYHcY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2016 03:32:24 -0400
Received: by mail-yw0-f173.google.com with SMTP id g3so88102362ywa.3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2016 00:32:24 -0700 (PDT)
In-Reply-To: <56F3F4F5.8050200@fb.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, rostedt@goodmis.org, mingo@redhat.com, adrian.hunter@intel.com, yangbo.lu@freescale.com, akpm@linux-foundation.org, JBottomley@odin.com, lporzio@micron.com, jonathanh@nvidia.com, grundler@chromium.org, fabf@skynet.be, yunpeng.gao@intel.com, dan.j.williams@intel.com, rabin.vincent@axis.com, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, david@protonic.nl, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

On 24 March 2016 at 22:08, Jens Axboe <axboe@fb.com> wrote:
> On 03/24/2016 05:54 AM, Baolin Wang wrote:
>>
>> This patch provides some tracepoints for the lifecycle of a request from
>> fetching to completion to help with performance analysis of MMC subsystem.
>
>
> Most of these already exist as block layer trace points, why do we need mmc
> specific ones?

Currently the MMC core does not have any tracepoints for use with
ftrace. These are very useful as they provide a very low overhead
runtime controllable way of getting diagnostics from the system which
is capable of recording a great deal of information without impacting
system performance. We have tracepoints in the block layer so we can
do some trace of MMC but none in MMC itself so adding some where
appropriate would help people follow the activity of subsystem.

>
>
> --
> Jens Axboe
>

-- 
Baolin.wang
Best Regards
