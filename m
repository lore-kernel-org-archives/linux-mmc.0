From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: clean up the duplicate code
Date: Wed, 25 Sep 2013 21:52:45 -0400
Message-ID: <871u4c4adu.fsf@octavius.laptop.org>
References: <1368782263-10133-1-git-send-email-jackey.shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57824 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab3IZBwt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 21:52:49 -0400
In-Reply-To: <1368782263-10133-1-git-send-email-jackey.shen@amd.com> (Jackey
	Shen's message of "Fri, 17 May 2013 17:17:43 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jackey Shen <jackey.shen@amd.com>
Cc: linux-mmc@vger.kernel.org

Hi Jackey,

On Fri, May 17 2013, Jackey Shen wrote:
> clean up the duplicate micros:
> mmc_sd_card_uhs -> mmc_card_uhs
> mmc_sd_card_set_uhs -> mmc_card_set_uhs
>
> Signed-off-by: Jackey Shen <jackey.shen@amd.com>
> ---
>  drivers/mmc/core/bus.c            |    2 +-
>  drivers/mmc/host/rtsx_pci_sdmmc.c |    2 +-
>  include/linux/mmc/card.h          |    2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)

Sorry for the long delay -- pushed to mmc-next for 3.13 now, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
