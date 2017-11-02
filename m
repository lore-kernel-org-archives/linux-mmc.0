From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 1/2] mmc: renesas_sdhi: fix swiotlb buffer is full
Date: Thu, 2 Nov 2017 04:10:46 +0000
Message-ID: <TY1PR06MB0992CBE1B122C62BD5E1C227D85C0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1508225421-25405-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXyY-gvQGn2UxhUDsdhdWUMmTA80z73PF14otvcKuTMaw@mail.gmail.com>
	<20171019002412.GA14493@localhost.localdomain>
	<CAMuHMdUs+dLq8LJTJoUQEUzJAKXCfD0JBtVnHPyN6XdppVy5qQ@mail.gmail.com>
	<TY1PR06MB09928E11C2AFFD55EF68961CD8420@TY1PR06MB0992.apcprd06.prod.outlook.com>
	<TY1PR06MB09929A4BF1E2A5DBD54845DED8430@TY1PR06MB0992.apcprd06.prod.outlook.com>
	<20171101132639.GA24821@x230.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171101132639.GA24821-sHAKZZqAc8NKMcnDSFYBzAC/G2K4zDHf@public.gmane.org>
Content-Language: ja-JP
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

> From: Konrad Rzeszutek, Sent: Wednesday, November 1, 2017 10:27 PM
> 
> On Fri, Oct 20, 2017 at 03:18:55AM +0000, Yoshihiro Shimoda wrote:
> > Hi again!
> >
> > > From: Yoshihiro Shimoda, Sent: Thursday, October 19, 2017 8:39 PM
> > >
> > > Hi Geert-san, Konrad-san,
> > >
> > > > From: Geert Uytterhoeven, Sent: Thursday, October 19, 2017 5:34 PM
> > > >
> > > > Hi Konrad,
> > > >
> > > > On Thu, Oct 19, 2017 at 2:24 AM, Konrad Rzeszutek Wilk
> > > > <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org> wrote:
> > < snip >
> > > > >> > diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > > > >> > index f905f23..6c9b4b2 100644
> > > > >> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > > > >> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > > > >> > @@ -80,8 +80,9 @@
> > > > >> >         .scc_offset     = 0x1000,
> > > > >> >         .taps           = rcar_gen3_scc_taps,
> > > > >> >         .taps_num       = ARRAY_SIZE(rcar_gen3_scc_taps),
> > > > >> > -       /* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
> > > > >> > -       .max_blk_count  = 0xffffffff,
> > > > >> > +       /* The swiotlb can handle memory size up to 256 kbytes for now. */
> > > > >> > +       .max_blk_count  = 512,
> > > > >>
> > > > >> Fixing this in the individual drivers feels like the wrong solution to me.
> > > > >>
> > > > >> iommu: Is there a better (generic) way to handle this?
> > > > >
> > > > > Yes. See 7453c549f5f6485c0d79cad7844870dcc7d1b34d, aka swiotlb_max_segment
> > > >
> > > > Thanks for the pointer!
> > > >
> > > > While I agree this can be used to avoid the swiotlb buffer full issue,
> > > > I believe it is a suboptimal solution if the device actually uses an IOMMU.
> > > > It limits the mapping size if CONFIG_SWIOTLB=y, which is always the
> > > > case for arm/arm64 these days.
> > >
> > > I'm afraid but I misunderstood this API's spec when I read it at first.
> > > After I tried to use it, I found the API cannot be used for a workaround because
> > > this API returns total size of swiotlb.
> > >
> > > For example:
> > >  - The swiotlb_max_segment() returns 64M bytes from the API when a default setting.
> > >   - In this case, the maximum size per a map is 256k bytes.
> > >  - The swiotlb_max_segment() returns 128M bytes from the API when I added swiotlb=65536
> > >    into the kernel parameter on arm64.
> > >   - In this case, the maximum size per a map is still 256k bytes because
> > >     the swiotlb has hardcoded the size by the following code:
> > >      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/swiotlb.c?h=v4.14-rc5#n254
> > >
> > > So, how do we handle to resolve (or avoid) the issue?
> >
> > Anyway, I made v2 patches by using swiotlb related definitions. Would you check it?
> 
> Did I miss that email? As in was I cc-ed?

This was my fault. When I submitted v2 patches, I didn't include your email and iommu mailing list...

> > https://patchwork.kernel.org/patch/10018879/
> 
> Why not use IO_TLB_SEGSIZE << IO_TLB_SHIFT or alternatively
> swiotlb_max_segment?  See 5584f1b1d73e9

I already made such a patch as v2 and it was merged into mmc.git / fixes branch.

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=e90e8da72ad694a16a4ffa6e5adae3610208f73b

Best regards,
Yoshihiro Shimoda
