From: ashish yadav <ashishyadav78@gmail.com>
Subject: Re: MMC/SD: Support for 4.41 Specification for 2.6.32 Linux Kernel
Date: Tue, 16 Dec 2014 11:48:51 +0530
Message-ID: <CAJKbuCY1DHzL-uTqW5fWvTAb8oE00pq0_fOq+4NQZyj1a04VSA@mail.gmail.com>
References: <CAJKbuCYsQtB7k=NyAt8s1Gn+PSUFr4vqzvmSQ2AFcaha5jLtWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39826 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbaLPGSx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Dec 2014 01:18:53 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so11133783wiw.13
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2014 22:18:51 -0800 (PST)
In-Reply-To: <CAJKbuCYsQtB7k=NyAt8s1Gn+PSUFr4vqzvmSQ2AFcaha5jLtWQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, chris@printf.net

Hi,

Can any one please look into this  & share info about MMC/SD 4.41
Specification for 2.6.32 Linux Kernel.


Thanks & Regards
    Ashish

On Mon, Dec 15, 2014 at 2:00 PM, ashish yadav <ashishyadav78@gmail.com> wrote:
> I want to support MMC 4.41 Specification for 2.6.32 Linux  Kernel Version.
>
> AFAIK, these support is not available in 2.6.32.
>
> Looking into 3.18 Kernel, I found following commit for MMC 4.41 Specification:
>
> 1. commit eb0d8f135b6730d6d0324a064664d1
> 21334290e7
>    Author: Jaehoon Chung <jh80.chung@samsung.com>
>     Date:   Tue Oct 18 01:26:42 2011 -0400
>
>     mmc: core: support HPI send command
>
>     HPI command is defined in eMMC4.41.
>     This feature is important for eMMC4.5 devices.
>
>     Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
>
>
>
> 2.  commit 211d4fe580735bab850d31f9e4c0a62b47a38bb2
>      Author: Venkatraman S <svenkatr@ti.com>
>     Date:   Tue Aug 7 19:24:45 2012 +0530
>
>     mmc: core: Add TRANsfer state to non-HPI state
>
>     HPI can be issued only in programming state to bring the card to
>     transfer state. If the card is already in transfer state, doing
>     a HPI is redundant.
>     Fix this by adding transfer state to the list of exceptions to
>     doing HPI and return without error.
>
>     Signed-off-by: Venkatraman S <svenkatr@ti.com>
>     Acked-by: Felipe Balbi <balbi@ti.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
>
>
> 3. commit 950d56acce5d401f477b91d0177605b543d63d07
>     Author: Jaehoon Chung <jh80.chung@samsung.com>
>     Date:   Mon Sep 17 08:42:02 2012 +0000
>
>     mmc: support BKOPS feature for eMMC
>
>     Enable eMMC background operations (BKOPS) feature.
>
>     If URGENT_BKOPS is set after a response, note that BKOPS are required.
>     Immediately run BKOPS if required.  Read/write operations should be
>     requested during BKOPS(LEVEL-1), then issue HPI to interrupt the
>     ongoing BKOPS and service the foreground operation.
>     (This patch only controls the LEVEL2/3.)
>
>     When repeating the writing 1GB data, at a certain time, performance is
>     decreased.  At that time, card triggers the Level-3 or Level-2.  After
>     running bkops, performance is recovered.
>
>     Future considerations:
>      * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>      * Interrupt ongoing BKOPS before powering off the card.
>      * How do we get BKOPS_STATUS value (periodically send ext_csd command)?
>      * If using periodic bkops, also consider runtime_pm control.
>
>     Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>     Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>     Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>     Reviewed-by: Maya Erez <merez@codeaurora.org>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
>
> Could you please let me know if above commits/patches are sufficient
> for  MMC 4.41 Specification (Background operation & HPI)  or I need
> more patches for same.
>
> Thanks & Regards
>    Ashish
