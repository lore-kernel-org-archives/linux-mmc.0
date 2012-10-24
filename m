From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v5] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Wed, 24 Oct 2012 01:39:24 -0700
Message-ID: <20121024083924.GA4118@lizard>
References: <1348639360-5757-1-git-send-email-r66093@freescale.com>
 <CAGxe1ZHuhpmfeokBLiNyVaj_JMQikwZdSDsoV11TPnB9Ea6bqA@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C1B3F5A@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34291 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757974Ab2JXImX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Oct 2012 04:42:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so218232pad.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Oct 2012 01:42:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C1B3F5A@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>

Sorry for the late reply, Huang.

On Tue, Oct 09, 2012 at 06:24:13AM +0000, Huang Changming-R66093 wrote:
[...]
> > > +static void esdhc_of_detect_limitation(struct platform_device *pdev,
> > > +       struct sdhci_pltfm_data *pdata) {

Wrong indentation. Should be one more tab, at least (or align to opening
brace).

> > > +       void __iomem *ioaddr;
> > > +       struct resource *iomem;
> > > +       u32 vvn;
> > > +
> > > +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       if (!iomem) {
> > > +               dev_warn(&pdev->dev, "failed to get resource\n");
> > > +               goto end;
> > > +       }
> > > +       if (resource_size(iomem) < 0x100)
> > > +               dev_warn(&pdev->dev, "Invalid iomem size!\n");
> > > +
> > > +       ioaddr = ioremap(iomem->start, resource_size(iomem));
> > > +       if (!ioaddr) {
> > > +               dev_warn(&pdev->dev, "failed to remap registers\n");
> > > +               goto end;
> > > +       }
> > > +
> > > +       /* P102x and P4080 has IP version VVN2.2, CMD23 is not
> > supported */
> > > +       vvn = in_be32(ioaddr + SDHCI_SLOT_INT_STATUS);
> > > +       vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> > > +       if (vvn == VENDOR_V_22)
> > > +               pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > > +
> > > +       iounmap(ioaddr);
> > > +end:
> > > +       return;

No need for the 'end' label.

> > > +}
> > > +
> > >  static struct sdhci_ops sdhci_esdhc_ops = {
> > >         .read_l = esdhc_readl,
> > >         .read_w = esdhc_readw,
> > > @@ -199,6 +231,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata =
> > > {
> > >
> > >  static int __devinit sdhci_esdhc_probe(struct platform_device *pdev)
> > > {
> > > +       esdhc_of_detect_limitation(pdev, &sdhci_esdhc_pdata);

I would rather prefer it to be in sdhci_ops (i.e. introduce
sdhci_ops->platform_init), so that way you wouldn't need to ioremap()
stuff by yourself. And make drivers/mmc/host/sdhci-pltfm.c call
platform_init after ioremap().

Then your detect_limitation() function would only need to check revision
and set additional quirks.

Thanks,
Anton.
