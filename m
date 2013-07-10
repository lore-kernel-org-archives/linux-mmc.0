From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: use the generic config for omap2plus
 devices
Date: Wed, 10 Jul 2013 16:13:57 -0500
Message-ID: <20130710211356.GA2587@snafu>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <1373472384-13067-1-git-send-email-a-bindra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373472384-13067-1-git-send-email-a-bindra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: a-bindra@ti.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 21:36-20130710, a-bindra@ti.com wrote:
> From: Amarinder Bindra <a-bindra@ti.com>
> 
> OMAP's hs_mmc driver is used for MMC controller operation on many
> omap2plus SoCs (OMAP2430, OMAP3, 4, 5 and AM335x).
> 
> Considering that the device tree entries are already present for these,
> allow the driver to be built using the config ARCH_OMAP2PLUS rather
> than individually adding a config for each SoC to enable the
> support.
> 
> Use COMPILE_TEST to enable the build for other platforms.
> 
> Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
works for O5.

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
