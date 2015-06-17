From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 3.18 SDIO driver re-attach issue
Date: Wed, 17 Jun 2015 13:51:23 +0200
Message-ID: <CAPDyKFo+N1N5GVb0NE6rK_nNSmNuZqqYmNsrTQnfYnJG9NPBdA@mail.gmail.com>
References: <55786615.7020701@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34912 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbbFQLvY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jun 2015 07:51:24 -0400
Received: by qkbp125 with SMTP id p125so20229953qkb.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2015 04:51:23 -0700 (PDT)
In-Reply-To: <55786615.7020701@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, =?UTF-8?Q?Markku_Ahvenj=C3=A4rvi?= <markku.ahvenjarvi@nomovok.com>

On 10 June 2015 at 18:30, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> We are having an issue with 3.18 on an OMAP3517 and a TI WL1271
> Wifi SDIO card attached to an hsmmc port. The module is powered
> from the main 3.3/1.8V supply rails so cannot be powered down.
>
> The wifi driver is built as a module, and when the module is
> unloaded and then reloaded the driver attach fails. The issue
> is sdio_bus_probe() calls the sdio_set_block_size(, func, 0)
> which fails with -110 (ETIMEDOUT) on the second load.
>
> Is it possible we need to either ignore the error, or try and
> re-set the function when either the driver un-binds / if the
> first sdio_set_block_size(, func, 0) call happens?
>
> Currently we ignore the error and the wifi driver seems to be
> working with the device. If there is a better fix then we would
> like to know so it can be fixed properly up-stream.

I don't think it should fail. So instead of applying a workaround
(ignoring/re-setting/re-trying), I would rather try to find the reason
to *why* the error occurs.

Just a simple test you could do is to *not* call sdio_set_block_size()
the second time in ->probe(), and see if that will give you other
issues.

Kind regards
Uffe
