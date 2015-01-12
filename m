From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 0/3] mmc: core: hw_reset changes
Date: Mon, 12 Jan 2015 16:11:40 +0100
Message-ID: <CAPDyKFqqwwRpi-kgMcQ6-v_bBUQDey6yY+aE46yj4EhUg3nLeA@mail.gmail.com>
References: <1421073486-10903-1-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:41203 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbbALPLk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 10:11:40 -0500
Received: by mail-qg0-f44.google.com with SMTP id q107so17952211qgd.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 07:11:40 -0800 (PST)
In-Reply-To: <1421073486-10903-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

On 12 January 2015 at 15:38, Johan Rudholm <johan.rudholm@axis.com> wrote:
> Make the mmc_hw_reset routine more generic, by putting the (e)MMC-
> specific stuff in the new bus_ops->reset in mmc.c. Add a
> bus_ops->reset for SD cards, allowing them to be restarted when
> errors occur.
>
> For MMC cards, always check if the reset was sucessful. This allows
> us to remove the mmc_hw_reset_check() interface.
>
> As I don't have an eMMC device myself, much less one with a reset line,
> I'd be very happy if someone could help me test the code with an eMMC?
>
> v7:
>  - Rename bus_ops->hw_reset to reset
>  - Move the send_status check to mmc.c
>  - Put the changes concerning mmc_hw_reset_check in a separate patch
>
> v6:
>  - Always perform the mmc_send_status reset check, which allows us to
>    have only one interface to the card reset functions
>  - Because of this, add the bus_ops->hw_reset to sd.c instead of
>    falling back to a power_cycle
>
> v5:
>  - Move the mmc_test-specific code to mmc_test.c
>  - Fall back to a power_cycle if the bus_ops->hw_reset is missing
>  - Because of this, skip the bus_ops->hw_reset in sd.c
>
> v4:
>  - Rebase onto next
>
> v3:
>  - Keep mmc_can_reset
>  - Always set bus_mode = MMC_BUSMODE_PUSHPULL in mmc_set_initial_state()
>
> v2:
>  - Call the new bus_ops member hw_reset instead of power_reset
>  - Create mmc_set_initial_state and call it from mmc_mmc_hw_reset
>    instead of mmc_power_up
>  - Keep "mmc_hw_reset" naming
>
> Johan Rudholm (3):
>   mmc: core: always check status after reset
>   mmc: core: refactor the hw_reset routines
>   mmc: sd: add reset bus_ops callback
>
>  drivers/mmc/card/mmc_test.c |   18 +++++--------
>  drivers/mmc/core/core.c     |   59 +++++++-----------------------------------
>  drivers/mmc/core/core.h     |    1 +
>  drivers/mmc/core/mmc.c      |   41 +++++++++++++++++++++++++++++
>  drivers/mmc/core/sd.c       |    7 +++++
>  include/linux/mmc/core.h    |    1 -
>  6 files changed, 66 insertions(+), 61 deletions(-)
>
> --
> 1.7.2.5
>

Thanks! Applied for next.

Kind regards
Uffe
