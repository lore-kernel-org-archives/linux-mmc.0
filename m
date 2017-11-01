From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: fix swiotlb buffer is full
Date: Wed, 1 Nov 2017 09:26:39 -0400
Message-ID: <20171101132639.GA24821@x230.dumpdata.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1508225421-25405-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXyY-gvQGn2UxhUDsdhdWUMmTA80z73PF14otvcKuTMaw@mail.gmail.com>
 <20171019002412.GA14493@localhost.localdomain>
 <CAMuHMdUs+dLq8LJTJoUQEUzJAKXCfD0JBtVnHPyN6XdppVy5qQ@mail.gmail.com>
 <TY1PR06MB09928E11C2AFFD55EF68961CD8420@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <TY1PR06MB09929A4BF1E2A5DBD54845DED8430@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR06MB09929A4BF1E2A5DBD54845DED8430@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Konrad Rzeszutek Wilk <konrad@darnok.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 20, 2017 at 03:18:55AM +0000, Yoshihiro Shimoda wrote:
> Hi again!
> 
> > From: Yoshihiro Shimoda, Sent: Thursday, October 19, 2017 8:39 PM
> > 
> > Hi Geert-san, Konrad-san,
> > 
> > > From: Geert Uytterhoeven, Sent: Thursday, October 19, 2017 5:34 PM
> > >
> > > Hi Konrad,
> > >
> > > On Thu, Oct 19, 2017 at 2:24 AM, Konrad Rzeszutek Wilk
> > > <konrad@darnok.org> wrote:
> < snip >
> > > >> > diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > > >> > index f905f23..6c9b4b2 100644
> > > >> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > > >> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > > >> > @@ -80,8 +80,9 @@
> > > >> >         .scc_offset     = 0x1000,
> > > >> >         .taps           = rcar_gen3_scc_taps,
> > > >> >         .taps_num       = ARRAY_SIZE(rcar_gen3_scc_taps),
> > > >> > -       /* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
> > > >> > -       .max_blk_count  = 0xffffffff,
> > > >> > +       /* The swiotlb can handle memory size up to 256 kbytes for now. */
> > > >> > +       .max_blk_count  = 512,
> > > >>
> > > >> Fixing this in the individual drivers feels like the wrong solution to me.
> > > >>
> > > >> iommu: Is there a better (generic) way to handle this?
> > > >
> > > > Yes. See 7453c549f5f6485c0d79cad7844870dcc7d1b34d, aka swiotlb_max_segment
> > >
> > > Thanks for the pointer!
> > >
> > > While I agree this can be used to avoid the swiotlb buffer full issue,
> > > I believe it is a suboptimal solution if the device actually uses an IOMMU.
> > > It limits the mapping size if CONFIG_SWIOTLB=y, which is always the
> > > case for arm/arm64 these days.
> > 
> > I'm afraid but I misunderstood this API's spec when I read it at first.
> > After I tried to use it, I found the API cannot be used for a workaround because
> > this API returns total size of swiotlb.
> > 
> > For example:
> >  - The swiotlb_max_segment() returns 64M bytes from the API when a default setting.
> >   - In this case, the maximum size per a map is 256k bytes.
> >  - The swiotlb_max_segment() returns 128M bytes from the API when I added swiotlb=65536
> >    into the kernel parameter on arm64.
> >   - In this case, the maximum size per a map is still 256k bytes because
> >     the swiotlb has hardcoded the size by the following code:
> >      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/swiotlb.c?h=v4.14-rc5#n254
> > 
> > So, how do we handle to resolve (or avoid) the issue?
> 
> Anyway, I made v2 patches by using swiotlb related definitions. Would you check it?

Did I miss that email? As in was I cc-ed?

> https://patchwork.kernel.org/patch/10018879/

Why not use IO_TLB_SEGSIZE << IO_TLB_SHIFT or alternatively
swiotlb_max_segment?  See 5584f1b1d73e9
