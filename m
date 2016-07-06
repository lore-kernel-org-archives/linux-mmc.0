From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic numbers
Date: Wed, 6 Jul 2016 18:21:44 +0200
Message-ID: <CAPDyKFrTRwwQr0UkjiRVp4_kt1Zv8=LKj0gfBSTzVHdxLTm_WA@mail.gmail.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38520 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbcGFQVr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2016 12:21:47 -0400
Received: by mail-wm0-f42.google.com with SMTP id r201so199523358wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2016 09:21:46 -0700 (PDT)
In-Reply-To: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 2 July 2016 at 21:23, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi,
>
> this small patch series should make the sdhci-iproc platform data easier
> to read. Since i don't have the adequate hardware it's only compile tested.
>
> Stefan
>
> Stefan Wahren (2):
>   mmc: sdhci: add define for suspend/resume capability
>   mmc: sdhci-iproc: Use defines instead of magic numbers
>
>  drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
>  drivers/mmc/host/sdhci.h       |    1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> --
> 1.7.9.5
>

Thanks, applied for next!

Kind regards
Uffe
