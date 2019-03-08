From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: remove block layer bounce buffering for MMC v2
Date: Fri, 8 Mar 2019 10:43:48 +0100
Message-ID: <CAPDyKFrKkmzrH++g88JLxbLkJh3iTUXfjjuxysr0iEigjYA5ig@mail.gmail.com>
References: <20190212072528.13167-1-hch@lst.de> <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
 <20190308091853.GA14021@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308091853.GA14021@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 8 Mar 2019 at 10:18, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Feb 25, 2019 at 02:54:13PM +0100, Ulf Hansson wrote:
> > This looks good to me, however the lack of feedback/tests worries me a
> > bit. So, unless you think it's a bad idea, I intend to apply this when
> > v5.1 rc1 is out, which allows a lengthy test period in linux-next.
>
> Please don't rush to merge this.  Based on a talk to some folks I
> have an idea for a sg iterator that can hide the kmapping from
> the drivers, which should allow for some less scary driver code and
> clean this up a bit further.

Okay, I see. Thanks for letting me know!

Kind regards
Uffe
