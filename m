From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: rtsx_pci: Enable support for erase/discard/trim requests
Date: Thu, 28 Jul 2016 00:02:52 +0200
Message-ID: <CAPDyKFrYrGCEKqheL=C8gRczCO2TPhCMHKayD0xm47WJ2OA=fQ@mail.gmail.com>
References: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrfsB7ChroiJ_z1Rq5ohaidrg=veSa0fWNi50V6BBB0Hw@mail.gmail.com> <cbf35b27-bb85-8bc0-a396-8183b6fa7c28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36914 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162617AbcG0WCz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 18:02:55 -0400
Received: by mail-wm0-f49.google.com with SMTP id i5so81528438wmg.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 15:02:55 -0700 (PDT)
In-Reply-To: <cbf35b27-bb85-8bc0-a396-8183b6fa7c28@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mauro Santos <registo.mailling@gmail.com>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, linux-mmc <linux-mmc@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Baolin Wang <baolin.wang@linaro.org>

On 27 July 2016 at 22:35, Mauro Santos <registo.mailling@gmail.com> wrote:
> On 27-07-2016 13:45, Ulf Hansson wrote:
>> Mauro, I have applied this for my next branch (based on 4.7), to allow
>> it to be easily tested.
>>
>> Just clone my tree below and build/replace your kernel.
>> git://git.linaro.org/people/ulf.hansson/mmc.git next
>>
>> Running fstrim and checking blkdiscard should be sufficient as test cases.
>>
>> Don't hesitate to ask if problems occurs!
>>
>> Kind regards
>> Uffe
>>
>
> I've tested both blkdiscard and fstrim (on ext4) and they both worked.
>
> I haven't noticed any errors or warnings on dmesg or complaints from
> blkdiscard/fstrim.
>
> If there are any more specific tests you would like me to do let me know.

Perhaps just run some dd operation to read and write some data to the
card, then I am happy. :)

Thanks a lot for your help in testing, I will apply a tested-by tag
from you, unless you object.

Kind regards
Uffe
