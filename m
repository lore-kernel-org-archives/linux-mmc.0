From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Mon, 17 Aug 2015 11:47:08 +0200
Message-ID: <CAPDyKFqN9FxQNbwoiCj1A+BUUWHm_H8RXNhKVzUkV0xOUUdCFA@mail.gmail.com>
References: <55C8D73D.10709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35169 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbHQJrJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 05:47:09 -0400
Received: by iodt126 with SMTP id t126so145402526iod.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2015 02:47:08 -0700 (PDT)
In-Reply-To: <55C8D73D.10709@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Addy Ke <addy.ke@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 10 August 2015 at 18:54, Jaehoon Chung <jh80.chung@gmail.com> wrote:
> Dear, Ulf.
>
> Could you pull these patches into your repository?
>
> Best Regards,
> Jaehoon Chung

Thanks! Pulled into my next branch.

Kind regards
Uffe

>
> The following changes since commit 77a5f675e2d80469b93c3dea1913c0450c4942be:
>
>   mmc: block: add fixup of broken CMD23 for Sandisk card (2015-07-23 14:28:47 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2
>
> for you to fetch changes up to a4c8b2edf78584dc7148ce06208d0f12d3b04a1b:
>
>   mmc: dw_mmc: add quirk for broken data transfer over scheme (2015-08-11 01:33:32 +0900)
>
> ----------------------------------------------------------------
> Addy Ke (1):
>       mmc: dw_mmc: add quirk for broken data transfer over scheme
>
> Alexey Brodkin (1):
>       mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is used
>
> Heiko Stuebner (1):
>       mmc: dw_mmc: fix pio mode when internal dmac is enabled
>
> Jaehoon Chung (3):
>       mmc: dw_mmc: fix the wrong condition checking
>       mmc: dw_mmc: remove the unused blk_setting
>       mmc: dw_mmc: print the message for deprecated property
>
> Shawn Lin (1):
>       mmc: dw_mmc: Fix coding style issues
>
>  drivers/mmc/host/dw_mmc-rockchip.c |   3 +
>  drivers/mmc/host/dw_mmc.c          | 284 +++++++++++++++++++++++++------------
>  include/linux/mmc/dw_mmc.h         |   5 +-
>  3 files changed, 204 insertions(+), 88 deletions(-)
