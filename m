From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Fri, 5 Feb 2016 08:59:11 +0100
Message-ID: <CAPDyKFof_WkW5tJF-FLdANM0_-oR3UJoZDWT7t9QKzxokaXSEw@mail.gmail.com>
References: <56B40BC0.7040301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34701 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcBEH7M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2016 02:59:12 -0500
Received: by mail-yw0-f171.google.com with SMTP id h129so45207660ywb.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Feb 2016 23:59:12 -0800 (PST)
In-Reply-To: <56B40BC0.7040301@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 5 February 2016 at 03:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> Could you pull these patches into your repository (next branch)?
>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit b22c960a4f2da77f4abedfa56c6b6ac14ada0656:
>
>   mmc: core: report tuning command execution failure reason (2016-02-04 11:48:36 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 03c35ab249f965923f570d9771eac57113162b31:
>
>   mmc: dw_mmc: fix num_slots setting (2016-02-05 00:53:50 +0900)
>
> ----------------------------------------------------------------
> Jaehoon Chung (1):
>       mmc: dw_mmc: remove the prepare_command hook
>
> Shawn Lin (6):
>       mmc: dw_mmc: add hw_reset support
>       mmc: dw_mmc: remove struct block_settings
>       mmc: dw_mmc: remove DW_MCI_QUIRK_BROKEN_CARD_DETECTION quirk
>       mmc: dw_mmc: fix err handle of dw_mci_probe
>       mmc: dw_mmc: remove repetitive clear interrupt
>       mmc: dw_mmc: fix num_slots setting
>
>  drivers/mmc/host/dw_mmc-exynos.c   | 31 ++++--------
>  drivers/mmc/host/dw_mmc-pltfm.c    | 19 +-------
>  drivers/mmc/host/dw_mmc-rockchip.c |  7 ---
>  drivers/mmc/host/dw_mmc.c          | 99 +++++++++++++++++++++-----------------
>  drivers/mmc/host/dw_mmc.h          |  6 ++-
>  include/linux/mmc/dw_mmc.h         | 12 +----
>  6 files changed, 72 insertions(+), 102 deletions(-)

Thanks Jaehoon, I have pulled them in to my next branch!

Kind regards
Uffe
