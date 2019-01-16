From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: remove block layer bounce buffering for MMC
Date: Wed, 16 Jan 2019 11:24:43 +0100
Message-ID: <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
References: <20190114095804.27978-1-hch@lst.de> <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).
>
> On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi everyone,
> >
> > this series converts the remaining MMC host drivers to properly kmap the
> > scatterlist entries it does PIO operations on, and then goes on to
> > remove the usage of block layer bounce buffering (which I plan to remove
> > eventually) from the MMC layer.
> >
> > As a bonus I've converted various drivers to the proper scatterlist
> > helpers so that at least in theory they are ready for chained
> > scatterlists.
> >
> > All the changes are compile tested only as I don't have any of the
> > hardware, so a careful review would be appreciated.
>
> Thanks for posting this. I will have a look as soon as I can, but
> first needs to catch up with things since the holidays.

Linus probably knows more here, but I have a vague recollection of
the MMC bounce buffer code being needed mostly for performance
reasons: when the scatterlist is discontiguous, that can result in
a request being split up into separate MMC commands, which due
to the lack of queued commands combined with the need for
garbage collection on sub-page writes results in a huge slowdown
compared to having larger bounce buffers all the time.

We had discussed finding a different way to do this (separate
from the bounce buffering), but I don't know if that ever happened,
or if this is even the code that you are changing here.

       Arnd
