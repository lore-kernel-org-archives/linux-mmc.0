From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/3] MAINTAINERS: mmc: Cleanup MMC/SD/SDIO section and
 SDHCI driver section
Date: Mon, 16 Mar 2015 14:15:00 +0100
Message-ID: <CAPDyKFr=trW8oRASLpQfF+7o5b-yd++8iKch4g42mQjCi1qhfQ@mail.gmail.com>
References: <1426258115-11801-1-git-send-email-ulf.hansson@linaro.org>
	<86k2yiq7xa.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:36389 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbCPNPB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2015 09:15:01 -0400
Received: by qcto4 with SMTP id o4so42678860qct.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2015 06:15:00 -0700 (PDT)
In-Reply-To: <86k2yiq7xa.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>

On 15 March 2015 at 22:15, Chris Ball <chris@printf.net> wrote:
> Hi,
>
> On Fri, Mar 13 2015, Ulf Hansson wrote:
>> As Chris Ball has moved on to other assignments, he's no longer able to
>> help me maintain MMC. Let's remove him from the MMC sections in
>> MAINTAINERS and add him to CREDIT file.
>>
>> This also affects the SDHCI DRIVER section, since its state now becomes
>> orphan.
>>
>> Cc: Chris Ball <chris@printf.net>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  CREDITS     | 4 ++++
>>  MAINTAINERS | 6 +-----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/CREDITS b/CREDITS
>> index 96935df..843e176 100644
>> --- a/CREDITS
>> +++ b/CREDITS
>> @@ -187,6 +187,10 @@ N: Krishna Balasubramanian
>>  E: balasub@cis.ohio-state.edu
>>  D: Wrote SYS V IPC (part of standard kernel since 0.99.10)
>>
>> +N: Chris Ball
>> +E: chris@printf.net
>> +D: Former maintainer of the MMC/SD/SDIO subsystem.
>> +
>>  N: Dario Ballabio
>>  E: ballabio_dario@emc.com
>>  E: dario.ballabio@tiscalinet.it
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 582b4b4..50479c8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6547,10 +6547,8 @@ F:     drivers/mfd/
>>  F:   include/linux/mfd/
>>
>>  MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
>> -M:   Chris Ball <chris@printf.net>
>>  M:   Ulf Hansson <ulf.hansson@linaro.org>
>>  L:   linux-mmc@vger.kernel.org
>> -T:   git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>>  T:   git git://git.linaro.org/people/ulf.hansson/mmc.git
>>  S:   Maintained
>>  F:   drivers/mmc/
>> @@ -8650,10 +8648,8 @@ S:     Maintained
>>  F:   drivers/mmc/host/sdricoh_cs.c
>>
>>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
>> -M:   Chris Ball <chris@printf.net>
>>  L:   linux-mmc@vger.kernel.org
>> -T:   git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>> -S:   Maintained
>> +S:   Orphan
>>  F:   drivers/mmc/host/sdhci.*
>>  F:   drivers/mmc/host/sdhci-pltfm.[ch]
>
> Thanks Ulf:
>
> Acked-by: Chris Ball <chris@printf.net>
>
> I wonder what we should do about mmc-utils.  I could continue applying
> patches since they're infrequent.  But perhaps few people would know
> to send them to me -- any ideas?

It's great news!

I think we have two options.
1. Add a new file under the mmc documentation in the kernel and
describe the mmc utils git in there.
2. Move the code from mmc-utils into /tools directory in the kernel.

Kind regards
Uffe
