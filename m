From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/6] mmc: tmio/sdhi: clean up cruft
Date: Tue, 26 Apr 2016 18:25:22 +0200
Message-ID: <CAPDyKFqWYQCvM2Q__Km3R7AsUW=QAuaQ6CSD4ztmGt=ZSErhuA@mail.gmail.com>
References: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 26 April 2016 at 17:55, Wolfram Sang <wsa@the-dreams.de> wrote:
> Largely due to DT unification, some parts of the code became obsolete. Let's
> remove that, the code is complex enough still:
>
> * There are no boards anymore with named interrupt support. Drop support for
>   that (patches 2-4)
> * No need anymore for a public mmc/tmio.h header file. Merge it into the
>   private one (patch 5)
>
> Patches 1 and 6 are small cleanups found on the way :)
>
> Based on latest renesas-drivers which is based on v4.6-rc1 with my sdr50
> patches on top. Tested on a Renesas Lager board and build bot is happy, too
> (after finding some issues initially).
>
> Change since V1:
>
> * Drop a small cleanup touching SH board files, so we stay in the MMC realm.
>   I will do this as a seperate patch so this series won't get delayed.
>
> Please test, comment, apply...
>
>    Wolfram
>
>
> Wolfram Sang (6):
>   mmc: sh_mobile_sdhi: don't use array for DT configs
>   mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
>   mmc: tmio: remove now unneeded seperate irq handlers
>   mmc: tmio: simplify irq handler
>   mmc: tmio: merge distributed include files
>   mmc: sh_mobile_sdhi: simplify code for voltage switching
>
>  drivers/mmc/host/sh_mobile_sdhi.c | 75 ++++++++-------------------------------
>  drivers/mmc/host/tmio_mmc.h       | 59 +++++++++++++++++++++++++++---
>  drivers/mmc/host/tmio_mmc_dma.c   |  1 -
>  drivers/mmc/host/tmio_mmc_pio.c   | 55 ++++++----------------------
>  include/linux/mmc/tmio.h          | 73 -------------------------------------
>  5 files changed, 79 insertions(+), 184 deletions(-)
>  delete mode 100644 include/linux/mmc/tmio.h
>
> --
> 2.7.0
>

Thanks, applied for next!

Kind regards
Uffe
