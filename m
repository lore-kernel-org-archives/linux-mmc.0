From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v9 00/12] use nonblock mmc requests to minimize latency
Date: Sun, 28 Aug 2011 12:11:58 +0100
Message-ID: <20110828111158.GA26917@n2100.arm.linux.org.uk>
References: <1309539333-2606-1-git-send-email-per.forlin@linaro.org> <20110826161951.GA26197@n2100.arm.linux.org.uk> <4E57C9A3.8000208@ti.com> <CAJ0pr18vZkQop29_ReNU6rP+nMORaz2+FOa4P0rLTfihfDd6=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ0pr18vZkQop29_ReNU6rP+nMORaz2+FOa4P0rLTfihfDd6=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Santosh <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Ball <cjb@laptop.org>, linaro-dev@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Sourav Poddar <sourav.poddar@ti.com>, linux-arm-kernel@lists.infradead.org, Balaji T Krishnamoorthy <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Aug 28, 2011 at 12:50:54PM +0200, Per Forlin wrote:
> On 26 August 2011 18:28, Santosh <santosh.shilimkar@ti.com> wrote:
> > + Balaji,
> >
> > On Friday 26 August 2011 09:49 PM, Russell King - ARM Linux wrote:
> >>
> >> I'm not sure who's responsible for this, but the nonblocking MMC s=
tuff is
> >> broken on OMAPs HSMMC:
> >>
> >> mmcblk0: error -84 transferring data, sector 149201, nr 64, cmd re=
sponse
> >> 0x900, card status 0xb00
> >> mmcblk0: retrying using single block read
> >> ------------[ cut here ]------------
> >> WARNING: at /home/rmk/git/linux-2.6-rmk/lib/dma-debug.c:811
> >> check_unmap+0x1ac/0x764()
> >> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA =
memory
> >> it has not allocated [device address=3D0x0000000080933000] [size=3D=
20480 bytes]
> >> Modules linked in:
> >> Backtrace:
> >> [<c0017874>] (dump_backtrace+0x0/0x10c) from [<c02ce8ac>]
> >> (dump_stack+0x18/0x1c)
> >> =A0r7:c1abfcb8 r6:c0186248 r5:c037de51 r4:0000032b
> >> [<c02ce894>] (dump_stack+0x0/0x1c) from [<c0039ed4>]
> >> (warn_slowpath_common+0x58/0x70)
> >> [<c0039e7c>] (warn_slowpath_common+0x0/0x70) from [<c0039f90>]
> >> (warn_slowpath_fmt+0x38/0x40)
> >> =A0r8:c1abfd50 r7:00000000 r6:00005000 r5:00000000 r4:80933000
> >> [<c0039f58>] (warn_slowpath_fmt+0x0/0x40) from [<c0186248>]
> >> (check_unmap+0x1ac/0x764)
> >> =A0r3:c0367d55 r2:c037e24d
> >> [<c018609c>] (check_unmap+0x0/0x764) from [<c0186978>]
> >> (debug_dma_unmap_sg+0x100/0x134)
> >> [<c0186878>] (debug_dma_unmap_sg+0x0/0x134) from [<c0019770>]
> >> (dma_unmap_sg+0x24/0x7c)
> >> [<c001974c>] (dma_unmap_sg+0x0/0x7c) from [<c0207220>]
> >> (omap_hsmmc_post_req+0x48/0x54)
> >> [<c02071d8>] (omap_hsmmc_post_req+0x0/0x54) from [<c01fb644>]
> >> (mmc_start_req+0x9c/0x128)
> >> =A0r4:c1a76000
> >> [<c01fb5a8>] (mmc_start_req+0x0/0x128) from [<c02049fc>]
> >> (mmc_blk_issue_rw_rq+0x80/0x460)
> >> =A0r8:c1ab5c00 r7:00000001 r6:c1ab5824 r5:c1ab5824 r4:c1ab5c00
> >> [<c020497c>] (mmc_blk_issue_rw_rq+0x0/0x460) from [<c02050a8>]
> >> (mmc_blk_issue_rq+0x2cc/0x2fc)
> >> [<c0204ddc>] (mmc_blk_issue_rq+0x0/0x2fc) from [<c02056c4>]
> >> (mmc_queue_thread+0xa0/0x104)
> >> [<c0205624>] (mmc_queue_thread+0x0/0x104) from [<c0054f8c>]
> >> (kthread+0x88/0x90)
> >> [<c0054f04>] (kthread+0x0/0x90) from [<c003d9a4>] (do_exit+0x0/0x6=
18)
> >> =A0r7:00000013 r6:c003d9a4 r5:c0054f04 r4:c1a7bc7c
> >> ---[ end trace 3314ad56daf5d14f ]---
> >>
> >> Luckily thinks continue to work, but clearly releasing DMA mapping=
s which
> >> drivers don't own is bad news. =A0Unfortunately, I don't have the =
bandwidth
> >> to be able to investigate this at present - well, I could do but t=
hen I'd
> >> have to drop working on the OMAP4 vs generic suspend/resume code a=
nd learn
> >> about something I've no current clue about.
> >>
> > Please continue your help on generic suspend.
> >
> >> Can someone please investigate and fix whatever is broken.
> >>
> > Will find somebody to look at this issue.
> >
> I had a look at this and my guess is that the same mapped DMA memory
> is unmapped twice. First the memory is unmapped in
> omap_hsmmc_dma_cleanup() due to the mmc error, then later in
> omap_hsmmc_post_req(). Here is a patch to resolve that. I haven't had
> the chance to test it yet though.
>=20
> ---
>  drivers/mmc/host/omap_hsmmc.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 21e4a79..7f40767 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1011,6 +1011,7 @@ static void omap_hsmmc_dma_cleanup(struct
> omap_hsmmc_host *host, int errno)
>                         host->data->sg_len,
>                         omap_hsmmc_get_dma_dir(host, host->data));
>                 omap_free_dma(dma_ch);
> +               data->host_cookie =3D 0;
>         }
>         host->data =3D NULL;
>  }
> @@ -1576,8 +1577,10 @@ static void omap_hsmmc_post_req(struct mmc_hos=
t
> *mmc, struct mmc_request *mrq,
>         struct mmc_data *data =3D mrq->data;
>=20
>         if (host->use_dma) {
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_l=
en,
> -                            omap_hsmmc_get_dma_dir(host, data));
> +               if (data->host_cookie)
> +                       dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +                                    data->sg_len,
> +                                    omap_hsmmc_get_dma_dir(host, dat=
a));
>                 data->host_cookie =3D 0;
>=20
>=20
> I also checked the mmci code for this same issue and mmci doesn't hav=
e
> the same bug.
> MMCI works fine in 3.1-rc2 even though the code is "wrong". I propose
> this change.
> @@ -529,7 +529,7 @@ static void mmci_post_request(struct mmc_host
> *mmc, struct mmc_request *mrq,
>         if (chan) {
>                 if (err)
>                         dmaengine_terminate_all(chan);
> -               if (err || data->host_cookie)
> +               if (data->host_cookie)
>=20
> I'll post these patches as soon as I have managed to test them or
> sooner if I get a tested-by.

Looking at MMCI, are you sure all those DMA engine terminate calls are
correct?

=46or example, why are we terminating all DMA engine transfers in the
post request function?  Surely that should've already been taken care
of by the driver before it told the core that the request was completed=
=2E
If the post request function is called for the previous request, meanwh=
ile
the next request is in flight, terminating the DMA engine transfer will
cause invalid state in the driver.

Basically, this looks completely buggered.  I think you need to review
your changes with a thought to what happens logically with DMA and the
MMC host drivers whenever an error occurs.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
