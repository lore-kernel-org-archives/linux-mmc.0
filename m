From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/1] mmc: core: Further fix thread wake-up
Date: Tue, 20 Dec 2016 18:41:04 +0100
Message-ID: <3356533.yTje0Ng7LW@amdc3058>
References: <1482155854-24963-1-git-send-email-adrian.hunter@intel.com>
 <1482155854-24963-2-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpB+dWJ55E_DncKv5q0TBqXyYRcg0eEHWcVsQ+8x1TPnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32779 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbcLTRlI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 12:41:08 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OIH02F6TVSH8A40@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Dec 2016 02:41:06 +0900 (KST)
In-reply-to: <CAPDyKFpB+dWJ55E_DncKv5q0TBqXyYRcg0eEHWcVsQ+8x1TPnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>


Hi,

On Tuesday, December 20, 2016 11:56:23 AM Ulf Hansson wrote:
> On 19 December 2016 at 14:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > Commit e0097cf5f2f1 ("mmc: queue: Fix queue thread wake-up") did not go far
> > enough. mmc_wait_for_data_req_done() still contains some problems and can
> > be further simplified.  First it should not touch
> > context_info->is_waiting_last_req because that is a wake-up control used by
> > the owner of the context. Secondly, it should always return when one of its
> > wake-up conditions is met because, again, that is contolled by the owner of
> > the context.
> >
> > While the current block driver does not have an issue, these problems were
> > exposed during testing of the Software Command Queue patches.

This sentence no longer seems to be true..

> > Fixes: e0097cf5f2f1 ("mmc: queue: Fix queue thread wake-up")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks, applied for fixes!

Seems that I'm late but FWIW for the patch content:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

