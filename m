Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D523C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52FD61152
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 14:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhKKON5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:13:57 -0500
Received: from muru.com ([72.249.23.125]:55062 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhKKON5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Nov 2021 09:13:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 06D3980C3;
        Thu, 11 Nov 2021 14:11:44 +0000 (UTC)
Date:   Thu, 11 Nov 2021 16:11:05 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Pouiller <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bean Huo <beanhuo@micron.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Yang Li <abaci-bugfix@linux.alibaba.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mmc: core: extend mmc_fixup_device and transplant
 ti,wl1251 quirks from to be retired omap_hsmmc
Message-ID: <YY0keW4jKsfkHTNe@atomide.com>
References: <cover.1636564631.git.hns@goldelico.com>
 <CAPDyKFruL-b7VgkuTL+TH5apY_bgjUTBwinYeqM0Xk4cKWP0rg@mail.gmail.com>
 <59B1A46D-58CA-414A-B640-FFCD42241C9A@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59B1A46D-58CA-414A-B640-FFCD42241C9A@goldelico.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [211111 13:51]:
> 
> 
> > Am 11.11.2021 um 13:10 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
> > 
> > On Wed, 10 Nov 2021 at 18:17, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >> 
> >> 
> >> drivers/mmc/core/card.h       | 36 ++++++++++++++++++++
> >> drivers/mmc/core/quirks.h     | 64 +++++++++++++++++++++++++----------
> >> drivers/mmc/core/sdio.c       |  5 ++-
> >> drivers/mmc/host/omap_hsmmc.c | 36 --------------------
> >> 4 files changed, 87 insertions(+), 54 deletions(-)
> >> 
> > 
> > This looks good to me, I will queue it up as soon as rc1 is out, thanks!
> 
> Thanks!

Thanks for sorting this out!

Tony
