From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc/android-goldfish: remove incorrect __iomem annotation
Date: Tue, 1 Sep 2015 14:23:33 +0200
Message-ID: <CAPDyKFqAm5QBzBRSXQLy_chNLd63Y3cr9AKikxu-MrJQcJwyrg@mail.gmail.com>
References: <1439798966-16277-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35788 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbIAMXe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2015 08:23:34 -0400
Received: by wicge5 with SMTP id ge5so5216567wic.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2015 05:23:33 -0700 (PDT)
In-Reply-To: <1439798966-16277-1-git-send-email-hch@lst.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+linux-mmc
-Chris (don't maintain mmc no more)

On 17 August 2015 at 10:09, Christoph Hellwig <hch@lst.de> wrote:
> Make sparse happy:
>
> drivers/mmc/host/android-goldfish.c:535:56: sparse: incorrect type in argument 3 (different address spaces)
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Normally I like you to post mmc patces to the linux-mmc list. As this
is a trivial patch and the driver don't have a dedicated maintainer, I
am going to pick it up anyway.

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/android-goldfish.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index b1eac71..dca5518 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -118,7 +118,7 @@ struct goldfish_mmc_host {
>         struct mmc_host         *mmc;
>         struct device           *dev;
>         unsigned char           id; /* 16xx chips have 2 MMC blocks */
> -       void __iomem            *virt_base;
> +       void                    *virt_base;
>         unsigned int            phys_base;
>         int                     irq;
>         unsigned char           bus_mode;
> --
> 1.9.1
>
