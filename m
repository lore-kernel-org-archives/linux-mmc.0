From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 11:20:46 -0800
Message-ID: <CANEJEGvpr3TB4PyfSOViy1D6avZQuKL7Km0DhnA5BiXDkYPV1w@mail.gmail.com>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
	<86ob321qw0.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58586 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaAWTUr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 14:20:47 -0500
Received: by mail-oa0-f43.google.com with SMTP id h16so2642540oag.16
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 11:20:47 -0800 (PST)
In-Reply-To: <86ob321qw0.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

On Thu, Jan 23, 2014 at 10:42 AM, Chris Ball <chris@printf.net> wrote:
> Hi Grant,
>
> On Thu, Jan 23 2014, Grant Grundler wrote:
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,7 +1,7 @@
>>  CC ?= gcc
>>  AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
>>  CFLAGS ?= -g -O2
>> -objects = mmc.o mmc_cmds.o
>> +objects = mmc.o mmc_cmds.o mmc_cmds-emmc5.o
>>
>>  CHECKFLAGS = -Wall -Werror -Wuninitialized -Wundef
>>
>> @@ -44,7 +44,7 @@ clean:
>>       $(MAKE) -C man clean
>
> The patch looks good, but doesn't apply because "$(MAKE) -C man clean"
> does not exist in mainline mmc-utils and never has.  Could you check
> for local patches (and ideally push them up to me too)?

Thanks Chris!

Yes - we have a  local Makefile patch. Do you mind pulling it directly
from our git repo since this is independent of the FFU support
changes?

You can directly pull into a local branch/review with:
    git fetch https://chromium.googlesource.com/chromiumos/third_party/mmc-utils
refs/changes/21/179621/2 && git cherry-pick FETCH_HEAD

cheers,
grant

>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <chris@printf.net>   <http://printf.net/>
