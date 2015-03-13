From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: mmc: Cleanup MMC/SD/SDIO section and
 SDHCI driver section
Date: Fri, 13 Mar 2015 15:46:57 +0100
Message-ID: <CAPDyKFrH8uke_pVugPXy8T4SxsQxXJTsvqbEfjvxVyy_-+e8Fg@mail.gmail.com>
References: <1426251120-10966-1-git-send-email-ulf.hansson@linaro.org>
	<1426254535.11459.7.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426254535.11459.7.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 13 March 2015 at 14:48, Joe Perches <joe@perches.com> wrote:
> On Fri, 2015-03-13 at 13:52 +0100, Ulf Hansson wrote:
>> As Chris Ball has moved on to other assignments, he's no longer able to
>> help me maintain MMC. Let's remove him from the MMC sections.
>>
>> This also affects the SDHCI DRIVER section, since its state now becomes
>> orphan.
>
> Maybe add a CREDITS entry for Chris ?

Indeed we should! Updated patch is on it's way.

Kind regards
Uffe

>
>> Cc: Chris Ball <chris@printf.net>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
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
>>
>
>
>
