From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: mmc: dw_mmc: fixed compile error when disable CONFIG_MMC_DW_IDMAC
Date: Fri, 17 Feb 2012 10:17:20 +0900
Message-ID: <000301cced11$e5d4d7a0$b17e86e0$%jun@samsung.com>
References: <4F3C67BA.7040309@samsung.com> <20120216232211.GA1955@balrog>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51167 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab2BQBR0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2012 20:17:26 -0500
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZI00613JKGSOK0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 10:17:21 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZI00JIHJKWDY50@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 10:17:21 +0900 (KST)
In-reply-to: <20120216232211.GA1955@balrog>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'James Hogan' <james@albanarts.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

James Hogan <james@albanarts.com> wrote:
> On Thu, Feb 16, 2012 at 11:19:38AM +0900, Jaehoon Chung wrote:
> > When disable CONFIG_MMC_DW_IDMAC, can see the compiler error.
> > Because in dw_mci_post_req(), called the dw_mci_get_dma_dir().
> > But that function is in #ifdef CONFIG_MMC_DW_IDMAC.
> >
> > I think that function is generic function.
> > Not need the CONFIG_MMC_DW_IDMAC.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I've also tested and confirmed that this fixes a compiler error
> introduced in 3ec7699d3bb1b0ee7f6e8588974a209d47fc64b2 ("mmc: dw_mmc:
> Add support for pre_req and post_req"), however that patch also seems to
> have regressed by disabled DMA when not using the internal DMAC.
> 
> Specifically dw_mci_pre_dma_transfer() returns -ENOSYS when not using
> internal DMAC, which makes dw_mci_submit_data_dma() now return early:
> 
> +       sg_len = dw_mci_pre_dma_transfer(host, data, 0);
> +       if (sg_len < 0)
> +               return sg_len;
> 
> I think that 3ec7699d3bb1b0ee7f6e8588974a209d47fc64b2 should be
> removed/reverted until it is fixed.

Thank you for investigation.
It could be fixed.

Best regards,
Seungwon Jeon.
> 
> Regards
> James
> 
> > ---
> >  drivers/mmc/host/dw_mmc.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index f9457e5..692c3ba 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -295,7 +295,6 @@ static void dw_mci_stop_dma(struct dw_mci *host)
> >  	}
> >  }
> >
> > -#ifdef CONFIG_MMC_DW_IDMAC
> >  static int dw_mci_get_dma_dir(struct mmc_data *data)
> >  {
> >  	if (data->flags & MMC_DATA_WRITE)
> > @@ -304,6 +303,7 @@ static int dw_mci_get_dma_dir(struct mmc_data *data)
> >  		return DMA_FROM_DEVICE;
> >  }
> >
> > +#ifdef CONFIG_MMC_DW_IDMAC
> >  static void dw_mci_dma_cleanup(struct dw_mci *host)
> >  {
> >  	struct mmc_data *data = host->data;
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

