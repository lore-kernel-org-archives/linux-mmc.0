From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 0/2] mmc-utils: RPMB support
Date: Tue, 12 Aug 2014 14:48:05 +0100
Message-ID: <86egwl7rai.fsf@void.printf.net>
References: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
	<CAPDyKFoE5Bxn_6wojSbECnUrzNQM4C1i++ye_ApkwovvJYsTFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46859 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbaHLNsJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Aug 2014 09:48:09 -0400
In-Reply-To: <CAPDyKFoE5Bxn_6wojSbECnUrzNQM4C1i++ye_ApkwovvJYsTFA@mail.gmail.com>
	(Ulf Hansson's message of "Tue, 12 Aug 2014 15:33:53 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Roman Pen <r.peniaev@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Tue, Aug 12 2014, Ulf Hansson wrote:
> On 21 July 2014 14:53, Roman Pen <r.peniaev@gmail.com> wrote:
>> This is simple RPMB support for 4 operations:
>>   write-key
>>   read-counter
>>   write-block
>>   read-block
>>
>> I did not attempt to implement multiple blocks read/write,
>> thus only 1 block (256 b) is supported right now.
>>
>> Also I had to take HMAC SHA256 implementation as 3rdparty to
>> sign RPMB messages.
>>
>> Roman Pen (2):
>>   mmc-utils: RPMB: add HMAC SHA256 support
>>   mmc-utils: RPMB: add support for 4 rpmb operations
>>
>>  3rdparty/hmac_sha/hmac_sha2.c | 544 ++++++++++++++++++++++++
>>  3rdparty/hmac_sha/hmac_sha2.h | 140 +++++++
>>  3rdparty/hmac_sha/sha2.c      | 949 ++++++++++++++++++++++++++++++++++++++++++
>>  3rdparty/hmac_sha/sha2.h      | 108 +++++
>>  Makefile                      |   8 +-
>>  mmc.c                         |  28 ++
>>  mmc.h                         |   6 +
>>  mmc_cmds.c                    | 419 +++++++++++++++++++
>>  mmc_cmds.h                    |   4 +
>>  9 files changed, 2204 insertions(+), 2 deletions(-)
>>  create mode 100644 3rdparty/hmac_sha/hmac_sha2.c
>>  create mode 100644 3rdparty/hmac_sha/hmac_sha2.h
>>  create mode 100644 3rdparty/hmac_sha/sha2.c
>>  create mode 100644 3rdparty/hmac_sha/sha2.h
>>
>> --
>> 2.0.0
>
> This seems like great stuff for mmc-utils. Chris, can you pick them up?

Thanks, pushed to mmc-utils.  I added the following text to the top of
each hmac_sha file:

+ * Since this code has been incorporated into a GPLv2 project, it is
+ * distributed under GPLv2 inside mmc-utils.  The original BSD license
+ * that the code was released under is included below for clarity.

.. since my understanding is that BSD code that's linked into a GPLv2
binary "becomes GPL" inside that project.

- Chris.
-- 
Chris Ball   <http://printf.net/>
