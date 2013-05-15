From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmci: Add support for UHS cards
Date: Wed, 15 May 2013 16:10:09 +0200
Message-ID: <CA+20K0DP1xY1urAsxBFWcaN22AahJ3GVG2dxhACFArfwuZFDZw@mail.gmail.com>
References: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:49606 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758992Ab3EOOKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 10:10:10 -0400
Received: by mail-qe0-f53.google.com with SMTP id cz11so1247512qeb.40
        for <linux-mmc@vger.kernel.org>; Wed, 15 May 2013 07:10:09 -0700 (PDT)
In-Reply-To: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

2013/5/15 Ulf Hansson <ulf.hansson@stericsson.com>:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> UHS cards in mode SDR12|25 operates at 1.8V I/O voltage. This patchset
> adds support to handle the corresponding voltage switch from the default
> 2.7-3.6 I/O voltage to 1.8V.
>
> The first patch, "Fixup regulator handling for vqmmc" has recently been
> sent as a separate patch, since it is a pure bugfix. Nevertheless this
> patchset depends on this patch, thus I decided to fold it here as well.
>
> Host capabilities for SDR12 and SDR25 needs to be set to enable support,
> but that will be handled outside this patchset.
>
> Ulf Hansson (4):
>   mmc: mmci: Fixup regulator handling for vqmmc
>   mmc: mmci: Support signal voltage switch for UHS cards
>   mmc: mmci: Cache MMCIDATACTRL register
>   mmc: mmci: Add card_busy function to improve UHS card support
>
>  drivers/mmc/host/mmci.c |   94 +++++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/mmci.h |    4 ++
>  2 files changed, 90 insertions(+), 8 deletions(-)

Looks good! Please add my

Reviewed-by: Johan Rudholm <jrudholm@gmail.com>

to this patch set.

Kind regards, Johan
