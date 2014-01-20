From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH V3] mmc: sdhci-pci: Fix BYT sd card getting stuck in runtime suspend
Date: Mon, 20 Jan 2014 15:38:20 +0000
Message-ID: <86eh424qab.fsf@void.printf.net>
References: <1386764492-26444-1-git-send-email-adrian.hunter@intel.com>
	<52D39684.2020608@intel.com> <52D39A7C.4070002@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58286 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbaATPiV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jan 2014 10:38:21 -0500
In-Reply-To: <52D39A7C.4070002@intel.com> (Adrian Hunter's message of "Mon, 13
	Jan 2014 09:49:16 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Jan 13 2014, Adrian Hunter wrote:
> A host controller for a SD card may need a GPIO
> for card detect in order to wake up from runtime
> suspend when a card is inserted.  If that GPIO is
> not configured, then the host controller will not
> wake up.  Fix that for the affected devices by not
> enabling runtime PM unless the GPIO is successfully
> set up.
>
> This affects BYT sd card host controller which had
> runtime PM enabled from v3.11.  For completeness,
> the MFD sd card host controller is flagged also.
>
> The original patch before rebasing (see link below)
> was tested on v3.11.10 and v3.12.4 although the
> patch applied with some offsets and fuzz.  The
> original patch is here:
>
>     http://marc.info/?l=linux-mmc&m=138676702327057) was tested on v3.11.10 and v3.12.4
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> V3: Update comments to reflect that the original patch
> applies to stable trees whereas the rebased patch does
> not.
>
> V2: Rebased

Thanks, pushed v3 to mmc-next for 3.14.  Looks like you lost the
stable@ tag in v3 (and have a mispaste after the URL), so I added
it back and cleared up the text.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
