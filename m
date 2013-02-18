From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 00/13] mmc: core and driver DT and related development
Date: Mon, 18 Feb 2013 08:15:31 -0500
Message-ID: <87k3q5ahl8.fsf@octavius.laptop.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Fri, 15 Feb 2013 16:13:49 +0100")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Fri, Feb 15 2013, Guennadi Liakhovetski wrote:
> This is v4 of a patch-series, extending mmc subsystem device-tree usage 
> and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
> tmio_mmc drivers. Changes since v3 are described in respective patches. 
> Thanks to all who commented on v3.
>
> Guennadi Liakhovetski (13):
>   mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
>   mmc: detailed definition of CD and WP MMC line polarities in DT
>   mmc: provide a standard MMC device-tree binding parser centrally
>   mmc: (cosmetic) remove "extern" from function declarations
>   mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
>   mmc: tmio-mmc: define device-tree bindings
>   mmc: tmio-mmc: parse device-tree bindings
>   mmc: sh_mobile_sdhi: remove unused .pdata field
>   mmc: sh_mobile_sdhi: use managed resource allocations
>   mmc: tmio: remove unused and deprecated symbols
>   mmc: tmio: add support for the VccQ regulator
>   mmc: add DT bindings for more MMC capability flags
>   mmc: tmio: add barriers to IO operations

Thanks!  Pushed to mmc-next, will think about merging for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
