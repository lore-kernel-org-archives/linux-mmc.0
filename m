From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7] mmc: Cleanup and modernize PM callbacks
Date: Mon, 27 Oct 2014 14:48:17 +0100
Message-ID: <CAPDyKFpfeRrj5NVw5i4j6qCQy3OcYgZoL1QOCkLYOabi47gSgg@mail.gmail.com>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:57236 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbaJ0NsV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 09:48:21 -0400
Received: by mail-qg0-f45.google.com with SMTP id z107so2037399qgd.4
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 06:48:17 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

On 14 October 2014 13:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This patchset cleanup and modernize how to set up PM callbacks for the
> mmc_driver in the mmc core. There shouldn't be any functional changes.
>
>
> Ulf Hansson (7):
>   mmc: core: Remove superfluous ifdefs for SDIO bus' PM callbacks
>   mmc: core: Don't export the to_sdio_driver macro
>   mmc: core: Convert the mmc_driver to use the modern PM ops
>   mmc: core: Convert mmc_driver to device_driver
>   mmc: msm_sdcc: Use platform_set|get_drvdata
>   mmc: block: Use dev_set|get_drvdata()
>   mmc: core: Remove unused mmc_list_to_card() macro
>
>  drivers/mmc/card/block.c      | 55 ++++++++++++++++++++++---------------------
>  drivers/mmc/card/mmc_test.c   | 18 ++++++++------
>  drivers/mmc/core/bus.c        | 55 ++++++++++---------------------------------
>  drivers/mmc/core/sdio_bus.c   | 14 +++--------
>  drivers/mmc/host/msm_sdcc.c   |  6 ++---
>  include/linux/mmc/card.h      | 20 ++--------------
>  include/linux/mmc/sdio_func.h |  2 --
>  7 files changed, 59 insertions(+), 111 deletions(-)
>
> --
> 1.9.1

I haven't got any complaints about this patchset, thus I decided to
apply it for next.

Kind regards
Uffe
