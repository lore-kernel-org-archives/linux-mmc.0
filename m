From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Date: Tue, 17 Sep 2019 14:33:17 +0100
Message-ID: <20190917133317.GQ25745@shell.armlinux.org.uk>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
 <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: dann frazier <dann.frazier@canonical.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will.deacon@arm.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 10:24:57AM -0300, Fabio Estevam wrote:
> Hi Russell,
> 
> On Tue, Sep 17, 2019 at 10:10 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
> > Will suggested reverting bd2e75633c80 ("dma-contiguous: use fallback
> > alloc_pages for single pages") which has been implicated in the same
> > problem here:
> >
> > https://www.spinics.net/lists/arm-kernel/msg750623.html
> 
> It seems that the final fix was:
> https://lore.kernel.org/patchwork/patch/1121600/
> 
> Does it work for you if we follow the same idea?
> 
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1105,6 +1105,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
> 
>         esdhc_init(pdev, host);
> 
> +       sdhci_enable_v4_mode(host);
>         sdhci_get_of_property(pdev);
> 
>         pltfm_host = sdhci_priv(host);

That attempts to set bit 12 of the host control register 2 (0x3e).
The LX2160A documentation states that bit 28 of 0x3c (they're 32-bit
wide registers there) is "reserved".

So, you're asking for a documented reserved bit to be set...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
