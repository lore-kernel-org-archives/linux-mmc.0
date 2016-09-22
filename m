From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Thu, 22 Sep 2016 13:51:59 +0200
Message-ID: <CAPDyKFr6G5114gh6ECKfZp_h6foyyUxZWE4ZSUHrOBVUZU-7tw@mail.gmail.com>
References: <772c300d-7d81-d933-f9c5-401cb3a3afcb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36985 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbcIVLwB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 07:52:01 -0400
Received: by mail-wm0-f44.google.com with SMTP id b130so144108446wmc.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2016 04:52:01 -0700 (PDT)
In-Reply-To: <772c300d-7d81-d933-f9c5-401cb3a3afcb@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 22 September 2016 at 12:57, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches into your mmc-next?
>
> The following changes since commit 6739115d4d319ba83d52f89e66b6a86cc021a2b5:
>
>   mmc: core: don't try to switch block size for dual rate mode (2016-09-22 10:17:54 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 2d25506534aec8a2e0980bf04b3e72b5b3c9f830:
>
>   mmc: dw_mmc: remove the deprecated "supports-highspeed" property (2016-09-22 19:53:38 +0900)
>
> ----------------------------------------------------------------
> Jaehoon Chung (1):
>       mmc: dw_mmc: remove the deprecated "supports-highspeed" property
>
> Shawn Lin (5):
>       mmc: dw_mmc: split out preparation of desc for IDMAC32 and IDMAC64
>       mmc: dw_mmc: avoid race condition of cpu and IDMAC
>       mmc: dw_mmc: fix misleading error print if failing to do DMA transfer
>       mmc: dw_mmc: use macro to define ring buffer size
>       mmc: dw_mmc: minor cleanup for dw_mci_adjust_fifoth
>
>  drivers/mmc/host/dw_mmc.c | 346 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------
>  1 file changed, 202 insertions(+), 144 deletions(-)
>
>
> Best Regards,
> Jaehoon Chung

Dear Jaehoon, thanks for the pull request. I have pulled it in to my
next branch.

Kind regards
Ulf Hansson
