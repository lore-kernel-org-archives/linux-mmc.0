From: Roman Peniaev <r.peniaev@gmail.com>
Subject: Re: [PATCH 0/2] mmc-utils: RPMB support
Date: Tue, 12 Aug 2014 23:01:22 +0900
Message-ID: <CACZ9PQVuJv+pup+f8Yu9TOkupvv11KOsRY0WZg223Cp9=7HfSQ@mail.gmail.com>
References: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
	<CAPDyKFoE5Bxn_6wojSbECnUrzNQM4C1i++ye_ApkwovvJYsTFA@mail.gmail.com>
	<86egwl7rai.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39566 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaHLOBX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 10:01:23 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so5827698wiv.15
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 07:01:22 -0700 (PDT)
In-Reply-To: <86egwl7rai.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ben Gardiner <bengardiner@nanometrics.ca>, linux-mmc <linux-mmc@vger.kernel.org>

Hello all.

Am I too late to change the second patch?
Few weeks ago I added support of multiple blocks read
and forgot to send new one :)

I do not want to send incremental patch.
Can you change the git history?

--
Roman


On Tue, Aug 12, 2014 at 10:48 PM, Chris Ball <chris@printf.net> wrote:
> Hi,
>
> On Tue, Aug 12 2014, Ulf Hansson wrote:
>> On 21 July 2014 14:53, Roman Pen <r.peniaev@gmail.com> wrote:
>>> This is simple RPMB support for 4 operations:
>>>   write-key
>>>   read-counter
>>>   write-block
>>>   read-block
>>>
>>> I did not attempt to implement multiple blocks read/write,
>>> thus only 1 block (256 b) is supported right now.
>>>
>>> Also I had to take HMAC SHA256 implementation as 3rdparty to
>>> sign RPMB messages.
>>>
>>> Roman Pen (2):
>>>   mmc-utils: RPMB: add HMAC SHA256 support
>>>   mmc-utils: RPMB: add support for 4 rpmb operations
>>>
>>>  3rdparty/hmac_sha/hmac_sha2.c | 544 ++++++++++++++++++++++++
>>>  3rdparty/hmac_sha/hmac_sha2.h | 140 +++++++
>>>  3rdparty/hmac_sha/sha2.c      | 949 ++++++++++++++++++++++++++++++++++++++++++
>>>  3rdparty/hmac_sha/sha2.h      | 108 +++++
>>>  Makefile                      |   8 +-
>>>  mmc.c                         |  28 ++
>>>  mmc.h                         |   6 +
>>>  mmc_cmds.c                    | 419 +++++++++++++++++++
>>>  mmc_cmds.h                    |   4 +
>>>  9 files changed, 2204 insertions(+), 2 deletions(-)
>>>  create mode 100644 3rdparty/hmac_sha/hmac_sha2.c
>>>  create mode 100644 3rdparty/hmac_sha/hmac_sha2.h
>>>  create mode 100644 3rdparty/hmac_sha/sha2.c
>>>  create mode 100644 3rdparty/hmac_sha/sha2.h
>>>
>>> --
>>> 2.0.0
>>
>> This seems like great stuff for mmc-utils. Chris, can you pick them up?
>
> Thanks, pushed to mmc-utils.  I added the following text to the top of
> each hmac_sha file:
>
> + * Since this code has been incorporated into a GPLv2 project, it is
> + * distributed under GPLv2 inside mmc-utils.  The original BSD license
> + * that the code was released under is included below for clarity.
>
> .. since my understanding is that BSD code that's linked into a GPLv2
> binary "becomes GPL" inside that project.
>
> - Chris.
> --
> Chris Ball   <http://printf.net/>
