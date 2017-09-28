From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH 1/2 v6] mmc: block: Convert RPMB to a character device
Date: Thu, 28 Sep 2017 14:00:44 +0800
Message-ID: <20170928140044.1de53a75@xhacker.debian>
References: <20170920080201.32438-1-linus.walleij@linaro.org>
        <b4a75994-1556-56ac-499c-8527988ee70f@intel.com>
        <CACRpkdabXNgCz+mtOOAZR1OqbCT0VgpxKT=FPh_99DTnsnCcSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:2944
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750914AbdI1GGV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 28 Sep 2017 02:06:21 -0400
In-Reply-To: <CACRpkdabXNgCz+mtOOAZR1OqbCT0VgpxKT=FPh_99DTnsnCcSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Tomas Winkler <tomas.winkler@intel.com>

On Wed, 27 Sep 2017 21:45:58 +0200 Linus Walleij wrote:

> On Wed, Sep 27, 2017 at 1:35 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > BUG when removing, fixed by reverting this patch.
> >
> > [  346.548512] mmc1: card 0001 removed
> > [  346.552782] BUG: unable to handle kernel NULL pointer dereference at 0000000000000070  
> 
> How did you achieve this? I need to reproduce it.
> 
> RPMB is only available on eMMC cards and I don't have a removable eMMC
> card since by definition they are soldered on.

Maybe unbind the sdhci host.
