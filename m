From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: host: sh_mobile_sdhi: don't populate unneeded functions
Date: Fri, 9 Sep 2016 11:45:38 +0200
Message-ID: <CAPDyKFp5C_utY_MhVMB_fyM0QnA0Xns9_+qw5CWC3dQ-c24vug@mail.gmail.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
 <20160824093438.2478-3-wsa+renesas@sang-engineering.com> <CANqRtoTJWN52roRwJHh1cZrb2Jqf5OD-ffjKgiW4Y5jqCeVzhg@mail.gmail.com>
 <20160902052258.GA1601@katana> <CAPDyKFpVtYtL97YQskPazJPQSHkVuF5BEaaGH_HE=xfkYUq=Rg@mail.gmail.com>
 <20160905081823.GC1601@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35394 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbcIIJpl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2016 05:45:41 -0400
Received: by mail-wm0-f46.google.com with SMTP id w12so21727293wmf.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Sep 2016 02:45:40 -0700 (PDT)
In-Reply-To: <20160905081823.GC1601@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>

On 5 September 2016 at 10:18, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > It can be argued that this tag could be added:
>> >
>> > Fixes: 452e5eef6d311e ("mmc: tmio: Add UHS-I mode support")
>> >
>> > I don't know how well it applies, though, because the code has been
>> > modified a lot recently. But we can try.
>>
>> Please tell me if you would like me to drop any of the changes I
>> queued up in this series.
>>
>> Of course, I can also amend the change log, just tell me.
>
> If you could add the Fixes: tag, this would be welcome. Thanks, Ulf!
>

Thanks, done!

Kind regards
Uffe
