From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: shorten the interval to wait
 SDHCI_PRESENT_STATE set after sending cmd
Date: Fri, 30 Sep 2011 18:01:52 -0400
Message-ID: <CANz0V+6mUaM-uvhi+yGD_43CSd-8aFhSSLcOczhanuXiP3OwSw@mail.gmail.com>
References: <1317268732-11653-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40674 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab1I3WBy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2011 18:01:54 -0400
Received: by wyg34 with SMTP id 34so1507484wyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 30 Sep 2011 15:01:53 -0700 (PDT)
In-Reply-To: <1317268732-11653-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

Hi,

2011/9/28 Barry Song <Barry.Song@csr.com>:
> From: Barry Song <Baohua.Song@csr.com>
>
> now we wait 1ms after every loop, in the worst case, 1ms will be wasted.
> that both decreases sd performance and increases cpu usage.
> This patch shorten the interval to 1us, then in the worst case, only 1us
> is wasted.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Cool! How much I/O perf did you gain?

A
