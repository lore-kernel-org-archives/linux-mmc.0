From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
Date: Fri, 27 Sep 2019 20:49:31 +0200
Message-ID: <CAPDyKFqTtGAygYPQ-qJuBaU2YU8CU-OgZJyWSmAQYYtq5xnpvg@mail.gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com> <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org> <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
 <20190923213925.GA19247@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923213925.GA19247@people.danlj.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael K. Johnson" <johnsonm@danlj.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 23 Sep 2019 at 23:39, Michael K. Johnson <johnsonm@danlj.org> wrote:
>
> On Wed, Sep 18, 2019 at 02:07:51PM +0300, Adrian Hunter wrote:
> > On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> > > I see that the first four patches made it into Linus's kernel
> > > yesterday. Is there any chance of this final patch that actually
> > > enables the hardware making it into another pull request still
> > > intended for 5.4?  Waiting on additional acked-by on Ben's work
> > > addressing all the review comments?
> ...
> > > On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>
> > >> Add support for the GL9750 and GL9755 chipsets.
> > >>
> > >> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> > >> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> > >> tuning flow for GL9750.
> > >
> >
> > It is OK by me:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Ulf,
>
> Sorry to be a bother... Is anything remaining for this work to make
> it into a second PR for 5.4 before the merge window closes?
>
> It would be really convenient for the microsd readers in
> current-generation thinkpads (for instance) to have hardware support out
> of the box without having to wait another kernel release cycle, if
> there's nothing otherwise remaining to change.  I confirmed that
> it currently applies cleanly on top of Linus's kernel.

I have applied this for fixes, so it will go in for 5.4, but perhaps I
need to defer my PR to after rc1 as I am still on the road.

Kind regards
Uffe
