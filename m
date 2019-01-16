From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: remove block layer bounce buffering for MMC
Date: Wed, 16 Jan 2019 14:51:16 +0100
Message-ID: <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
References: <20190114095804.27978-1-hch@lst.de> <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
 <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 16, 2019 at 11:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).

Nah it's not THAT bounce buffer.

> Linus probably knows more here, but I have a vague recollection of
> the MMC bounce buffer code being needed mostly for performance
> reasons: when the scatterlist is discontiguous, that can result in
> a request being split up into separate MMC commands, which due
> to the lack of queued commands combined with the need for
> garbage collection on sub-page writes results in a huge slowdown
> compared to having larger bounce buffers all the time.
>
> We had discussed finding a different way to do this (separate
> from the bounce buffering), but I don't know if that ever happened,
> or if this is even the code that you are changing here.

Nope not the same code.

The term "bounce buffer" is sadly used as ambigously as
__underscores in front of function names.

That other "bounce buffer" was first deleted and then
reimplemented as a local hack in the SDHCI driver core
after it caused performance regressions on the i.MX and
some laptops, see commit:

commit bd9b902798ab14d19ca116b10bde581ddff8f905
mmc: sdhci: Implement an SDHCI-specific bounce buffer

That should be orthogonal to Christoph's changes in this
patch series.

Yours,
Linus Walleij
