From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: fix swiotlb buffer is full
Date: Tue, 17 Oct 2017 10:02:50 +0200
Message-ID: <CAMuHMdXyY-gvQGn2UxhUDsdhdWUMmTA80z73PF14otvcKuTMaw@mail.gmail.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1508225421-25405-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1508225421-25405-2-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Shimoda-san,

CC iommu

On Tue, Oct 17, 2017 at 9:30 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> Since the commit de3ee99b097d ("mmc: Delete bounce buffer handling")
> deletes the bounce buffer handling, a request data size will be referred
> to max_{req,seg}_size instead of MMC_QUEUE_BOUNCESZ (64k bytes).
>
> In other hand, renesas_sdhi_internal_dmac.c will set very big value of
> max_{req,seg}_size because the max_blk_count is set to 0xffffffff.
> And then, "swiotlb buffer is full" happens because swiotlb can handle
> a memory size up to 256k bytes only (IO_TLB_SEGSIZE = 128 and
> IO_TLB_SHIFT = 11).
>
> So, this patch fixes the issue to set max_blk_count to 512. Then,
> the max_{req,seg}_size will be set to 256k bytes.
>
> Reported-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Thanks for your patch!

> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index f905f23..6c9b4b2 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -80,8 +80,9 @@
>         .scc_offset     = 0x1000,
>         .taps           = rcar_gen3_scc_taps,
>         .taps_num       = ARRAY_SIZE(rcar_gen3_scc_taps),
> -       /* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
> -       .max_blk_count  = 0xffffffff,
> +       /* The swiotlb can handle memory size up to 256 kbytes for now. */
> +       .max_blk_count  = 512,

Fixing this in the individual drivers feels like the wrong solution to me.

iommu: Is there a better (generic) way to handle this?

> +       /* Gen3 SDHI DMAC cannot handle scatter-gather. So, max_segs = 1 */
>         .max_segs       = 1,
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
