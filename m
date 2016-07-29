From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: rtsx_pci: Enable support for erase/discard/trim requests
Date: Fri, 29 Jul 2016 11:33:13 +0200
Message-ID: <CAPDyKFoLF=GGmQOgO_xdjYPrEQjjaz0A2K21VdoaOExTLEDUBQ@mail.gmail.com>
References: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrfsB7ChroiJ_z1Rq5ohaidrg=veSa0fWNi50V6BBB0Hw@mail.gmail.com>
 <cbf35b27-bb85-8bc0-a396-8183b6fa7c28@gmail.com> <CAPDyKFrYrGCEKqheL=C8gRczCO2TPhCMHKayD0xm47WJ2OA=fQ@mail.gmail.com>
 <49a04ef7-63c7-80c9-b64b-dcec18ecf815@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37213 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcG2JdQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 05:33:16 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so143340555wmg.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jul 2016 02:33:15 -0700 (PDT)
In-Reply-To: <49a04ef7-63c7-80c9-b64b-dcec18ecf815@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mauro Santos <registo.mailling@gmail.com>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, linux-mmc <linux-mmc@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Baolin Wang <baolin.wang@linaro.org>

On 28 July 2016 at 01:07, Mauro Santos <registo.mailling@gmail.com> wrote:
> On 27-07-2016 23:02, Ulf Hansson wrote:
>> On 27 July 2016 at 22:35, Mauro Santos <registo.mailling@gmail.com> wrote:
>>> On 27-07-2016 13:45, Ulf Hansson wrote:
>>>> Mauro, I have applied this for my next branch (based on 4.7), to allow
>>>> it to be easily tested.
>>>>
>>>> Just clone my tree below and build/replace your kernel.
>>>> git://git.linaro.org/people/ulf.hansson/mmc.git next
>>>>
>>>> Running fstrim and checking blkdiscard should be sufficient as test cases.
>>>>
>>>> Don't hesitate to ask if problems occurs!
>>>>
>>>> Kind regards
>>>> Uffe
>>>>
>>>
>>> I've tested both blkdiscard and fstrim (on ext4) and they both worked.
>>>
>>> I haven't noticed any errors or warnings on dmesg or complaints from
>>> blkdiscard/fstrim.
>>>
>>> If there are any more specific tests you would like me to do let me know.
>>
>> Perhaps just run some dd operation to read and write some data to the
>> card, then I am happy. :)
>>
>
> Maybe I should have mentioned in my previous email, I have used the ext4
> formatted fs to write some files, if you want me to still test with dd
> let me know.
>
> I have tested it like this:
>
> - Filesystem was not mounted with the discard option.
> - Almost fill the card with files, determine md5sum for all files and
> reboot to make sure there are no cached files in ram
> - Delete half of the files, fstrim -v (trimmed space looks about right),
> check md5sum of remaining files - no problems here.
> - fsck -f filesystem - no problems detected.
>
> After this I have written more data to the card and checked the md5sums,
> but I already forgot the exact sequence, I was looking for any sign that
> using fstrim would delete more than it should have or that writing new
> files might for some reason corrupt the old files.
>
> I have confirmed that blkdiscard does work, the card returns zeros for
> the few sectors I've checked, but I haven't confirmed that fstrim is
> doing what it is supposed to do, the same applies to the case where the
> filesystem is mounted with the discard option (quick google search
> didn't return recipe for going from file->lba/sector or inode->lba/sector).
>
> That said, given that blkdiscard works I'm assuming fstrim (and the
> discard option) also work. I can check that if you want, but I would
> need some pointers on how to do it. I could also check fstrim on a well
> used f2fs formatted card where data should be all over the place by now.
>

Thanks for your report. I think this is good enough!

>> Thanks a lot for your help in testing, I will apply a tested-by tag
>> from you, unless you object.
>>
>
> No objections.

Great, applied!

Kind regards
Uffe
