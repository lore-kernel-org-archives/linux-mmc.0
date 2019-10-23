From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Date: Wed, 23 Oct 2019 15:12:57 +0100
Message-ID: <20191023141257.GA25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, mad skateman <madskateman@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christian Zigotzky <info@xenosoft.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 08:52:33AM -0500, Rob Herring wrote:
> On Wed, Oct 23, 2019 at 1:41 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > On Wed, 2019-10-23 at 16:42 +1100, Michael Ellerman wrote:
> > >
> > > Right, it seems of_dma_is_coherent() has baked in the assumption that
> > > devices are non-coherent unless explicitly marked as coherent.
> > >
> > > Which is wrong on all or at least most existing powerpc systems
> > > according to Ben.
> >
> > This is probably broken on sparc(64) as well and whatever else uses
> > DT and is an intrinsicly coherent architecture (did we ever have
> > DT enabled x86s ? Wasn't OLPC such a beast ?).
> 
> Only if those platforms use one of the 5 drivers that call this function:
> 
> drivers/ata/ahci_qoriq.c:       qoriq_priv->is_dmacoherent =
> of_dma_is_coherent(np);
> drivers/crypto/ccree/cc_driver.c:       new_drvdata->coherent =
> of_dma_is_coherent(np);
> drivers/iommu/arm-smmu-v3.c:    if (of_dma_is_coherent(dev->of_node))
> drivers/iommu/arm-smmu.c:       if (of_dma_is_coherent(dev->of_node))
> drivers/mmc/host/sdhci-of-esdhc.c:      if (of_dma_is_coherent(dev->of_node))
> 
> Curious that a PPC specific driver (ahci_qoriq) calls it...

Maybe because it is not PPC specific:

arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:
compatible = "fsl,lx2160a-ahci";

drivers/ata/ahci_qoriq.c:       { .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
