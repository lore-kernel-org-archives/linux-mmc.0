From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: mmc: Move the mmc tree to kernel.org
Date: Tue, 18 Oct 2016 09:17:42 +0200
Message-ID: <CAPDyKFoUp70sP8LQWy7cKvoEU6dOw_72Ag5ciezd4Z6XCLnC1A@mail.gmail.com>
References: <1476708880-5333-1-git-send-email-ulf.hansson@linaro.org> <e4cfb009-07a3-972c-d93c-d777c5da3899@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32896 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbcJRHRp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 03:17:45 -0400
Received: by mail-qk0-f174.google.com with SMTP id n189so274639780qke.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2016 00:17:45 -0700 (PDT)
In-Reply-To: <e4cfb009-07a3-972c-d93c-d777c5da3899@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On 18 October 2016 at 05:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Ulf,
>
> On 2016/10/17 20:54, Ulf Hansson wrote:
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a009e00..e685724 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8164,7 +8164,7 @@ F:        include/linux/mfd/
>>  MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
>>  M:     Ulf Hansson <ulf.hansson@linaro.org>
>>  L:     linux-mmc@vger.kernel.org
>> -T:     git git://git.linaro.org/people/ulf.hansson/mmc.git
>> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>
>
> I cannot clone this tree, and I have tried some of my servers, although.
>
> remote: Total 5031043 (delta 4225582), reused 5030965 (delta 4225531)
> Resolving deltas: 100% (4225582/4225582), done.
> Checking connectivity... done.
> warning: remote HEAD refers to nonexistent ref, unable to checkout.

The reason for the error message was the default HEAD pointed to a
non-existent "master" branch.
As I can't change the default HEAD (because kernel.org's gitolite
server configurations don't allow it), I decided to publish a master
branch. That should resolve the problem, sorry for inconvenience!

BTW. In case your aren't familiar with using remote branches in git;
those are really convenient as you don't need to do a complete new
clone.
git remote add mmc http://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
git remote update

Kind regards
Uffe
