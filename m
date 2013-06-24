From: "Fernandes, Joel A" <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v12 05/11] edma: config: Enable config options for EDMA
Date: Mon, 24 Jun 2013 21:09:58 +0000
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4EE5A1@DLEE08.ent.ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<201306242228.23297.arnd@arndb.de>
	<CAD=GYpYwswOYGHRzZ6SeKD+sEfi-7s3HuqKr7G0OXQWFCA_EtQ@mail.gmail.com>
	<201306242307.35840.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <201306242307.35840.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: Monday, June 24, 2013 4:08 PM
> To: Joel A Fernandes
> Cc: Nori, Sekhar; Fernandes, Joel A; Tony Lindgren; Matt Porter; Grant Likely;
> Rob Herring; Vinod Koul; Mark Brown; Cousson, Benoit; Russell King; Rob
> Landley; Andrew Morton; Jason Kridner; Koen Kooi; Devicetree Discuss; Linux
> OMAP List; Linux ARM Kernel List; Linux DaVinci Kernel List; Linux Kernel
> Mailing List; Linux Documentation List; Linux MMC List; Linux SPI Devel List
> Subject: Re: [PATCH v12 05/11] edma: config: Enable config options for EDMA
> 
> On Monday 24 June 2013, Joel A Fernandes wrote:
> > >> Yes sure, right now they are defined  as follows in include/linux/edma.h:
> > >>
> > >> #if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
> bool
> > >> edma_filter_fn(struct dma_chan *, void *); #else static inline bool
> > >> edma_filter_fn(struct dma_chan *chan, void *param) { return false;
> > >> } #endif
> > >
> > > It's best to just define the filter function in the platform code
> > > and pass a pointer to it through platform data. The way you do it
> > > above makes the slave drivers inherently nonportable.
> >
> > But with DT-only platforms, can you really do that?
> 
> The nice thing about this is that with a DT-only platform, the filter function will
> automatically go away: you have no platform_data, which means that if you
> are using dma_request_slave_channel_compat, you just pass NULL as the filter
> and the filter-data, same as just calling dma_request_slave_channel.
> 
 
[Joel] Ah yes! Thanks for that. Right, edma_filter_fn is not passed explicitly for DT case.

Thanks,
Joel
