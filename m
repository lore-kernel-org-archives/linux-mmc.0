From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] Revert "mmc: dw_mmc: Add check for IDMAC configuration"
Date: Tue, 11 Sep 2012 12:41:03 +0530
Message-ID: <CAGxe1ZExbV9Mhv6_m8EQQAojTtog+SCZKo-WxskvKAAzkfjHKA@mail.gmail.com>
References: <00d801cd8fc4$738f8540$5aae8fc0$%jun@samsung.com>
	<CAGxe1ZEo68n2QjacyeTd=L7+qB0zPzAL3NUE4Py0_rUVa2VcMQ@mail.gmail.com>
	<00dd01cd8fe0$b95d2cf0$2c1786d0$%jun@samsung.com>
	<CAGxe1ZFDoxp+QVA77VyGxBEYGqH5_iQ5dnwugychtXViqjc5ig@mail.gmail.com>
	<00e501cd8fe8$26a8e540$73faafc0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41271 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab2IKHLF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 03:11:05 -0400
Received: by vbbff1 with SMTP id ff1so210313vbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Sep 2012 00:11:03 -0700 (PDT)
In-Reply-To: <00e501cd8fe8$26a8e540$73faafc0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, James Hogan <James.Hogan@imgtec.com>

On 11 September 2012 12:09, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Tuesday, September 11, 2012, Girish K S <girish.shivananjappa@linaro.org> wrote:
>> On 11 September 2012 11:16, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> > On Tuesday, September 11, 2012, Girish K S <girish.shivananjappa@linaro.org> wrote:
>> >> On 11 September 2012 07:53, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >> > This reverts commit 94c6cee91(Add check for IDMAC configuration).
>> >> > Synopsys says that only if internal dmac is not present, optional
>> >> > external dma interface is present. When internal dmac is present,
>> >> > '0' value in DMA_INTERFACE of HCON is reasonable. DMA_INTERFACE
>> >> > indicates external dma interface. And idmac initialization is
>> >> > prohibited now. So, let's revert this commit.
>> >>
>> >> There is no register, or a field in any register which says IDMAC present.
>> >> I can see only use_idmac bit field in CTRL register.
>> >> So in first place how will i know whether IDMAC is present? Have you
>> >> assumed that IDMAC is present.
>> >> I would like to know without assuming, whether  IDMAC is present.
>> >> If i have missed out something let me know.  i will check and revert back
>> > There is no way to see the presence of idmac from host controller on the runtime.
>> > But enabling idmac is not selected in the menuconfig just with assuming its presence.
>> > User can find the support of idmac from manual at least, I  know the lack of this information in
>> manual though.
>> I cannot find any line in the manual saying "Support IDMAC". Keeping
>> this in mind and the with the literal meaning what the HCON field
>> DMA_INTERFACE means, the above patch was made.
>> i had posted a patch for adding quirk to this (was waiting for some dt
>> patches to be accepted to resend it). Once that patch gets merged it
>> will be helpful for the user to use it comfortably. If QUIRK is
>> enabled it means there is IDMAC and the driver user is intentionally
>> enabling it.
> I mentioned the lack of description of feature in manual.
> When we consider the real meaning of DMA_INTERFACE, '0' value doen't indicate the absence of idmac.
> So, we cannot decide  the support of idmac with the DMA_INTERFACE.
>
> Do you mean this patch:"mmc: dwmmc: Add quirk for broken Hardware Config"?
> HCON register in the original Synopsys doesn't include information of internal dmac.
> Do you think it's also broken?
As per the current available information from the manual i think the
HCON is broken.
May be the synopsys is the right person to clarify this.
>
> Thanks,
> Seungwon Jeon
>>
>> >
>> > Thanks,
>> > Seungwon Jeon
>> >
>> >>
>> >> >
>> >> > CC: Girish K S <girish.shivananjappa@linaro.org>
>> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> >> > ---
>> >> >  drivers/mmc/host/dw_mmc.c |   15 ++-------------
>> >> >  1 files changed, 2 insertions(+), 13 deletions(-)
>> >> >
>> >> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> >> > index 36f98c0..dcbe9aa 100644
>> >> > --- a/drivers/mmc/host/dw_mmc.c
>> >> > +++ b/drivers/mmc/host/dw_mmc.c
>> >> > @@ -405,23 +405,11 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>> >> >  static int dw_mci_idmac_init(struct dw_mci *host)
>> >> >  {
>> >> >         struct idmac_desc *p;
>> >> > -       int i, dma_support;
>> >> > +       int i;
>> >> >
>> >> >         /* Number of descriptors in the ring buffer */
>> >> >         host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
>> >> >
>> >> > -       /* Check if Hardware Configuration Register has support for DMA */
>> >> > -       dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
>> >> > -
>> >> > -       if (!dma_support || dma_support > 2) {
>> >> > -               dev_err(&host->dev,
>> >> > -                       "Host Controller does not support IDMA Tx.\n");
>> >> > -               host->dma_ops = NULL;
>> >> > -               return -ENODEV;
>> >> > -       }
>> >> > -
>> >> > -       dev_info(&host->dev, "Using internal DMA controller.\n");
>> >> > -
>> >> >         /* Forward link the descriptor list */
>> >> >         for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
>> >> >                 p->des3 = host->sg_dma + (sizeof(struct idmac_desc) * (i + 1));
>> >> > @@ -1895,6 +1883,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>> >> >         /* Determine which DMA interface to use */
>> >> >  #ifdef CONFIG_MMC_DW_IDMAC
>> >> >         host->dma_ops = &dw_mci_idmac_ops;
>> >> > +       dev_info(&host->dev, "Using internal DMA controller.\n");
>> >> >  #endif
>> >> >
>> >> >         if (!host->dma_ops)
>> >> > --
>> >> > 1.7.0.4
>> >> >
>> >> >
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
