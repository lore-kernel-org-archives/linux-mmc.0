From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4] mmc: Provide tracepoints for request processing
Date: Tue, 5 Apr 2016 19:18:51 +0800
Message-ID: <CAMz4kuLNiEKowkr_r+Tn4amgmP1zqY2FnjL_sxG0kJOSETxpPA@mail.gmail.com>
References: <5e5fca2076b5ae6307ef48b279c8f4fcf27de91b.1459393711.git.baolin.wang@linaro.org>
	<CAPDyKFqUktG+KHqCQ=YPmXarYy13SqfXm9ajBcRCSthiOmD6Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33514 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757835AbcDELSx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 07:18:53 -0400
Received: by mail-yw0-f170.google.com with SMTP id t10so12151095ywa.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2016 04:18:52 -0700 (PDT)
In-Reply-To: <CAPDyKFqUktG+KHqCQ=YPmXarYy13SqfXm9ajBcRCSthiOmD6Dg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com, Adrian Hunter <adrian.hunter@intel.com>, Yangbo Lu <yangbo.lu@freescale.com>, Andrew Morton <akpm@linux-foundation.org>, "JBottomley@Odin.com" <JBottomley@odin.com>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@fb.com>, Fabian Frederick <fabf@skynet.be>, Yunpeng Gao <yunpeng.gao@intel.com>, Dan Williams <dan.j.williams@intel.com>, Rabin Vincent <rabin.vincent@axis.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, David Jander <david@protonic.nl>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, linux-kernel@vger.kernel

On 5 April 2016 at 19:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 31 March 2016 at 05:16, Baolin Wang <baolin.wang@linaro.org> wrote:
>> This patch provides some tracepoints for the lifecycle of a mmc request from
>> starting to completion to help with performance analysis of MMC subsystem.
>>
>> Changes since v3:
>>  - Add "retries" and "re-tune state" in the trace print.
>>  - Move trace_mmc_request_start() to __mmc_start_request() function to avoid
>>  missing valuable information about which command/request is being sent.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Thanks, applied for next!
>
> I did some clean-up of the change log, as I think the history of the
> patch is not relevant in there. Next time, please provide the history
> as patch information (just add the text below "---" and end the
> message by adding yet another "---" and a newline.

Make sense. Thanks.

-- 
Baolin.wang
Best Regards
