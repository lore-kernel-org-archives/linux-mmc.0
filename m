From: Richard Ash <richardashaudacity@googlemail.com>
Subject: Re: 'error -110 sending stop command' on Zynq platform
Date: Fri, 15 Apr 2016 17:04:52 +0100
Message-ID: <CACOFwak1k_pFMSTH91j5tNq0VRr5rCRHUwMPj2Z3bwgt4tFByg@mail.gmail.com>
References: <CACOFwa=KnacTNDvsTcMzj4_0YCu8uADp3hrxFG7RDK+jLDCing@mail.gmail.com>
	<CACOFwanA-Bx6GYaJLRUAfwgXSxDkX55yGUbFzCTMovCgSZmQ_A@mail.gmail.com>
	<CACOFwamDP=pa=C8veOOQQ-FOKhj_MbjBXgmGqKSToMBYEeMMJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33435 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcDOQEx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2016 12:04:53 -0400
Received: by mail-oi0-f46.google.com with SMTP id w85so128492201oiw.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2016 09:04:53 -0700 (PDT)
In-Reply-To: <CACOFwamDP=pa=C8veOOQQ-FOKhj_MbjBXgmGqKSToMBYEeMMJQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC / SD subsystem <linux-mmc@vger.kernel.org>

On 14 April 2016 at 14:52, Richard Ash
<richardashaudacity@googlemail.com> wrote:
> On 14 April 2016 at 14:20, Richard Ash
> <richardashaudacity@googlemail.com> wrote:
>> I have now repeated the test using kernel 4.5.1 from kernel.org, which
>> supports enough hardware to get a serial console and test the SD card.
>> I am seeing effectively the same error
>>
>>  mmcblk0: error -110 sending stop command, original cmd response
>> 0x900, card status 0x400e00
To complete this saga, I took the same card back to a zedboard (so
removing our custom hardware from the equation) and have reproduced
the exact same problem there, the same error. Does this indicate the
problem is not with the custom PCB design but with the SD card
firmware, or the Linux SDHCI driver?

Richard
