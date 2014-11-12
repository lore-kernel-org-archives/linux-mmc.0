From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: core: power-on sdio card correctly.
Date: Wed, 12 Nov 2014 09:27:34 +0100
Message-ID: <CAPDyKFozfA2VV+xrzYWona7G8Bdro=VGphM+A=L9ar9tsXr1DA@mail.gmail.com>
References: <20141112035217.18267.43304.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:40830 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbaKLI1f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Nov 2014 03:27:35 -0500
Received: by mail-qg0-f50.google.com with SMTP id a108so8324202qge.23
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2014 00:27:34 -0800 (PST)
In-Reply-To: <20141112035217.18267.43304.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chris Ball <chris@printf.net>, GTA04 owners <gta04-owner@goldelico.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 November 2014 04:55, NeilBrown <neilb@suse.de> wrote:
> These two patches replace my previous patch
>   [PATCH 2/2] mmc: core: reset sdio card properly on resume.
>
> The only change is to use host->card->ocr instead of
> host->ocr_avail, as recommend by Ulf.
>
> These restore my libertas  wifi device properly on system
> resume.
>
> (I'm still hoping for a reply to my other patch:
>    [PATCH 1/2] mmc: core: allow a reset gpio to be configured.

Working on a reply. Get back to you soon. :-)

> )
>
> Thanks,
> NeilBrown
>
> ---
>
> NeilBrown (2):
>       mmc: core: use card->ocr when negotiating voltage setting in mmc_sdio_power_restore
>       mmc: core: reset sdio card properly on resume.

Thanks! Applied for next!

Kind regards
Uffe

>
>
>  drivers/mmc/core/sdio.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> --
> Signature
>
