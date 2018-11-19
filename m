From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5912/OMAP310
Date: Mon, 19 Nov 2018 20:04:18 +0200
Message-ID: <20181119180418.GD16897@darkstar.musicnaut.iki.fi>
References: <20181118201919.14401-1-aaro.koskinen@iki.fi>
 <ffdad271-943c-f4e7-8ec9-2af5769798a4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ffdad271-943c-f4e7-8ec9-2af5769798a4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Ladislav Michl <ladis@linux-mips.org>, linux-mmc@vger.kernel.org, Andrzej Zaborowski <balrogg@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 11:58:32AM +0200, Peter Ujfalusi wrote:
> On 2018-11-18 22:19, Aaro Koskinen wrote:
> > Tested on OMAP15XX/OMAP310 (Palm TE), OMAP1710 (Nokia 770)
> > and OMAP2420 (Nokia N810).
> 
> Do you know if the DMA is enabled for the MMC? It might not work via
> DMAengine.

DMA is enabled for MMC, and works OK on all of these devices.

A.
