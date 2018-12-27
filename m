From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Date: Thu, 27 Dec 2018 12:22:55 +0000
Message-ID: <20181227122254.GB26090@n2100.armlinux.org.uk>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
 <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
 <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, BOUGH CHEN <haibo.chen@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 27, 2018 at 10:01:24AM +0200, Adrian Hunter wrote:
> On 20/12/18 9:49 AM, BOUGH CHEN wrote:
> > i.MX6ULL has errata ERR010450, point out that due to SOC I/O
> > timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
> > clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
> > DDR50 mode, the clock rate can't exceed 45MHz.
> > 
> > This patch add this limit for imx6ull.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> Apart from the kbuild test robot complaints (do they need to be fixed?):
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Nacked-by: Russell King <rmk+kernel@armlinux.org.uk>

The kbuild test robot complaints do need to be fixed first.  They're
confusing because GCC produces quite a lot of garbage in its error
messages now.  If you look at the patch, there's a hunk that has:

+       if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+               if (imx_data->is_ddr)
+                       clock = clock > 45000000 ? 45000000 : clock;
+               else
+                       clock = clock > 150000000 ? 150000000 : clock;
+

which is missing a closing brace.  This patch could not have been
build tested before it was mailed to the list, and the test robot
is highlighting that fact.

It may also be a good idea to encourage a different approach to the
above anyway:

	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
		unsigned long max_clock;

		max_clock = imx_data->is_ddr ? 45000000 : 150000000;

		clock = max(clock, max_clock);
	}

rather than open-coding the max() stuff in the driver.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
