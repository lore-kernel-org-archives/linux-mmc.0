From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/5] Some small cleanup for quirks
Date: Wed, 15 Feb 2017 11:43:06 +0100
Message-ID: <CAPDyKFqnVs=bwtGF0RrcW5-Xo_T9--DJfrkN4G7v4FYoVR0vxA@mail.gmail.com>
References: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33410 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdBOKnM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 05:43:12 -0500
Received: by mail-qk0-f177.google.com with SMTP id p22so55737210qka.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 02:43:12 -0800 (PST)
In-Reply-To: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 15 February 2017 at 09:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> I just see the we put them everywhere, so the legacy code
> should be improved a bit for maintainability, especially for
> the sdio quirks case. Just split them into small patches to be
> better reviewed but I don't mind to squash them up.:)
>
>
> Changes in v3:
> - remove __maybe_unused and clean up the header files
>
> Changes in v2:
> - add __maybe_unused to make it cleanly compiled standalone
>   suggested by Ulf
> - add inline for mmc_fixup_device
> - move INAND quirks together
>
> Shawn Lin (5):
>   mmc: core: change quirks.c to be a header file
>   mmc: core: move some sdio IDs out of quirks file
>   mmc: core: improve the quirks for sdio devices
>   mmc: core: move all quirks together into quirks.h
>   mmc: core: add mmc prefix for blk_fixups
>
>  drivers/mmc/core/Makefile    |   2 +-
>  drivers/mmc/core/block.c     |  83 +-----------------------
>  drivers/mmc/core/card.h      |   2 -
>  drivers/mmc/core/mmc.c       |  12 +---
>  drivers/mmc/core/quirks.c    |  85 -------------------------
>  drivers/mmc/core/quirks.h    | 148 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/sdio.c      |   3 +-
>  include/linux/mmc/sdio_ids.h |   7 ++
>  8 files changed, 161 insertions(+), 181 deletions(-)
>  delete mode 100644 drivers/mmc/core/quirks.c
>  create mode 100644 drivers/mmc/core/quirks.h
>
> --
> 1.9.1
>


Thanks, applied for next!

Kind regards
Uffe
