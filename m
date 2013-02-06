From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 06/13] mmc: tmio-mmc: define device-tree bindings
Date: Wed, 6 Feb 2013 22:24:20 +0000
Message-ID: <201302062224.20549.arnd@arndb.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
 <1360180020-18555-7-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1360180020-18555-7-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 06 February 2013, Guennadi Liakhovetski wrote:
> +* Toshiba Mobile IO SD/MMC controller
> +
> +The tmio-mmc driver doesn't probe its devices actively, instead its binding to
> +devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
> +driver. Those drivers supply the tmio-mmc driver with platform data, that either
> +describe hardware capabilities, known to them, or are obtained by them from
> +their own platform data or from their DT information. In the latter case all
> +compulsory and any optional properties, common to all SD/MMC drivers, as
> +described in mmc.txt, should or can be used. Additionally the following optional
> +bindings can be used. They set respective TMIO_MMC_* flags.
> +
> +Optional properties:
> +- toshiba,mmc-wrprotect-disable        : set TMIO_MMC_WRPROTECT_DISABLE flag
> +- toshiba,mmc-blksz-2bytes     : set TMIO_MMC_BLKSZ_2BYTES
> +- toshiba,mmc-has-idle-wait    : set TMIO_MMC_HAS_IDLE_WAIT

Please write the binding in a way that does not refer to a specific
implementation in Linux: The binding should describe the hardware
independent of details in the driver. In particular, I think you
should not refer to the TMIO_MMC_BLKSZ_2BYTES etc macros but describe
in text what the flags are about.

Regarding the toshiba,mmc-wrprotect-disable property, would it be
enough to just check the presence of the wp-gpios property?

TMIO_MMC_BLKSZ_2BYTES seems to be set unconditionally in
sh_mobile_sdhi_probe and nowhere else, so I'd assume we don't
actually need to provide this here, but can keep that knowledge
implicit based on whether we're talking to sh_mobile_sdhi
or another tmio_mmc variant.

For the other last one, is that actually board specific, or just
a feature of a given chip? If we can tell by the SoC, then I'd
suggest using separate "compatible" properties instead, and
put a bitmask of features into the .data field of the of match
table. For all I can tell, SH7372 does not set it, while SH73A0,
R8A7740 and R8A7779 always do.

	Arnd
