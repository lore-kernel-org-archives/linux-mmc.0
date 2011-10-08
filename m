From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: shorten the interval to wait
 SDHCI_PRESENT_STATE set after sending cmd
Date: Sat, 8 Oct 2011 16:00:09 +0800
Message-ID: <CAGsJ_4zZUQqYTenFGCvNV_pYG68bVizs_-MzOR7d5ckLMZP1zg@mail.gmail.com>
References: <1317268732-11653-1-git-send-email-Barry.Song@csr.com> <CANz0V+6mUaM-uvhi+yGD_43CSd-8aFhSSLcOczhanuXiP3OwSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39516 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab1JHIAa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Oct 2011 04:00:30 -0400
Received: by bkbzt4 with SMTP id zt4so5828587bkb.19
        for <linux-mmc@vger.kernel.org>; Sat, 08 Oct 2011 01:00:29 -0700 (PDT)
In-Reply-To: <CANz0V+6mUaM-uvhi+yGD_43CSd-8aFhSSLcOczhanuXiP3OwSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Cc: Barry Song <Barry.Song@csr.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

2011/10/1 Andrei E. Warkentin <andrey.warkentin@gmail.com>:
> Hi,
>
> 2011/9/28 Barry Song <Barry.Song@csr.com>:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> now we wait 1ms after every loop, in the worst case, 1ms will be wasted.
>> that both decreases sd performance and increases cpu usage.
>> This patch shorten the interval to 1us, then in the worst case, only 1us
>> is wasted.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>
> Cool! How much I/O perf did you gain?

A test was done by bonnie++ on csr prima2 with 2GB class 2 SD card.

before applying this patch:
Version 1.03e       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
SiRFPrima2     768M  2555  39  2737   0  3661   2  5947  91 13301   3 909.3   4

after applying this patch:
Version 1.03e       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
SiRFPrima2     768M  2611  40  2668   0  3675   2  5952  91 13302   3 952.2   4

>
> A
> -

-barry
