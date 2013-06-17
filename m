From: "Fernandes, Joel A" <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
Date: Mon, 17 Jun 2013 16:25:31 +0000
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9479@DLEE08.ent.ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
	<3940138.jZFEtfGGLz@wuerfel>
	<083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9395@DLEE08.ent.ti.com>
	<201306171819.57900.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <201306171819.57900.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: Monday, June 17, 2013 11:20 AM
> To: Fernandes, Joel A
> Cc: Tony Lindgren; Nori, Sekhar; Matt Porter; Grant Likely; Rob Herring; Vinod
> Koul; Mark Brown; Cousson, Benoit; Russell King; Rob Landley; Andrew Morton;
> Jason Kridner; Koen Kooi; Devicetree Discuss; Linux OMAP List; Linux ARM
> Kernel List; Linux DaVinci Kernel List; Linux Kernel Mailing List; Linux
> Documentation List; Linux MMC List; Linux SPI Devel List
> Subject: Re: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree
> binding
> 
> On Monday 17 June 2013, Fernandes, Joel A wrote:
> > [Joel] Thanks for the suggestion, I updated it and it looks like this now:
> >
> > Required properties:
> > - compatible : "ti,edma3"
> > - ti,hwmods: Name of the hwmods associated to the EDMA
> > - ti,edma-regions: Number of regions
> > - ti,edma-slots: Number of slots
> > - #dma-cells: Should be set to <1>
> >               Clients should use a single number per DMA channel request.
> 
> That still does not say what that number refers to.
> Is it a channel number, or a request line number, or something completely
> different?
 
[Joel] 
Ah! Will fix, it's a channel number.

Thanks,
Joel
