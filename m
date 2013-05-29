From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V3 2/3] ARM: mmc: bcm281xx SDHCI driver
Date: Wed, 29 May 2013 16:25:36 +0200
Message-ID: <201305291625.37068.arnd@arndb.de>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
 <1369790016-13270-2-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1369790016-13270-2-git-send-email-csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
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
To: Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerry Huang <Chang-Ming.Huang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 29 May 2013, Christian Daudt wrote:
> +static int sdhci_bcm_kona_sd_reset(struct sdhci_host *host)
> +{

> +	/*
> +	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
> +	 * Back-to-Back writes to same register needs delay when SD bus clock
> +	 * is very low w.r.t AHB clock, mainly during boot-time and during card
> +	 * insert-removal.
> +	 */
> +	mdelay(1);
> +	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);

This is now called always without spinlocks held and interrupts enabled,
so it should really be msleep() not mdelay().

> +static void sdhci_bcm_kona_sd_init(struct sdhci_host *host)
> +{
> +	unsigned int val;
> +
> +	/* enable the interrupt from the IP core */
> +	val = sdhci_readl(host, KONA_SDHOST_COREIMR);
> +	val |= KONA_SDHOST_IP;
> +	sdhci_writel(host, val, KONA_SDHOST_COREIMR);
> +
> +	/* Enable the AHB clock gating module to the host */
> +	val = sdhci_readl(host, KONA_SDHOST_CORECTRL);
> +	val |= KONA_SDHOST_EN;
> +
> +	/*
> +	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
> +	 * Back-to-Back writes to same register needs delay when SD bus clock
> +	 * is very low w.r.t AHB clock, mainly during boot-time and during card
> +	 * insert-removal.
> +	 */
> +	mdelay(1);
> +	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);
> +}

Same here.

Looks good aside from that.

	Arnd
