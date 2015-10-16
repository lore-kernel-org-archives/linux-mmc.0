From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH] mmc_block: Allow more than 8 partitions per card
Date: Fri, 16 Oct 2015 12:31:01 -0700
Message-ID: <CALAqxLXH4q4G5mrK2ur+eBLR9YUcfo4zgS4PpmxCGOkoBqF2Eg@mail.gmail.com>
References: <1445020846-529-1-git-send-email-john.stultz@linaro.org>
	<56214A01.2030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38811 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbbJPTbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 15:31:03 -0400
Received: by igbdj2 with SMTP id dj2so21074880igb.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 12:31:01 -0700 (PDT)
In-Reply-To: <56214A01.2030906@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Android Kernel Team <kernel-team@android.com>, linux-mmc <linux-mmc@vger.kernel.org>

On Fri, Oct 16, 2015 at 12:03 PM, Austin S Hemmelgarn
<ahferroin7@gmail.com> wrote:
> On 2015-10-16 14:40, John Stultz wrote:
>>
>> From: Colin Cross <ccross@android.com>
>>
>> It is quite common for Android devices to utilize more
>> then 8 partitions on internal eMMC storage. This patch,
>> which has been carried for quite awhile in the AOSP common
>> tree is necessary in order to support such configurations,
>> so I wanted to submit it for consideration upstream.
>
> Isn't this what CONFIG_MMC_BLOCK_MINORS is for?  It does limit you to 256
> minors total, and therefore the number of supported MMC's is equal to
> 256/CONFIG_MMC_BLOCK_MINORS, but I've never heard of an Android device with
> support for more than 4 MMC/SD cards (including eMMC's), and I would
> seriously question anyone who has the need for more than 32 partitions on
> the root device for a phone/tablet/television.

So thanks, CONFIG_MMC_BLOCK_MINORS is something I wasn't aware of, and
it does seem to allow me to boot on my device w/o the proposed patch!

That said, my fairly old device does have 30-partitions now, and from
Linux Plumber's[1] it seems like Android devices are only going to
have more partitions in the future. So as Arnd commented, if the
proposed patch provides a less limited solution, it might still be
worth consideration.  I'll give it a day or so for folks to provide
any more commentary, and if no other objections are brought up, I'll
re-submit with an improve rational for the patch that includes this
info.

Thanks for the feedback!
-john

[1]: https://linuxplumbersconf.org/2015/ocw//system/presentations/3387/original/Android%20system,%20partitions%20and%20customization.pdf
