From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH mmc 0/4] Cleanup fixes for tmio_mmc
Date: Tue, 5 May 2015 10:34:57 +0200
Message-ID: <CAPDyKFrzTpU2JcOm70W3uxN-fvU+BY0UMSQ_9R_-iC=7BACtRg@mail.gmail.com>
References: <1430089220.5802.17.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:32799 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756AbbEEIe6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:34:58 -0400
Received: by qgdy78 with SMTP id y78so77686530qgd.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:34:57 -0700 (PDT)
In-Reply-To: <1430089220.5802.17.camel@xylophone.i.decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@lists.codethink.co.uk

On 27 April 2015 at 01:00, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> Ian, these are some of your fixes for tmio_mmc that didn't make it
> upstream yet, plus an update to MAINTAINERS.  Assuming you're still
> intending to maintain it, please can you ack these?
>
> Ben.
>
> Ben Hutchings (1):
>   MAINTAINERS: Update Ian Molton's address for tmio_mmc driver
>
> Ian Molton (3):
>   mmc: TMIO: Ensure MFD cell is disabled on probe error path
>   mmc: TMIO: Fix I/O mapping leak on error using devm_ioremap()
>   mmc: TMIO: Use devm_request_irq()
>
>  MAINTAINERS                     |    2 +-
>  drivers/mmc/host/tmio_mmc.c     |   10 ++++++----
>  drivers/mmc/host/tmio_mmc_pio.c |    5 ++---
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> --
> 1.7.10.4
>

Thanks, applied.

I decided to apply patch 4 without Ian's ack, since a prefer a valid
email address. If Ian no longer are able to maintain this driver,
let's deal with that separately.

Kind regards
Uffe
