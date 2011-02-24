From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and card detection
Date: Thu, 24 Feb 2011 23:51:28 +0800
Message-ID: <20110224155126.GA1466@S2100-06.ap.freescale.net>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	<20110224081803.GA29530@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110224081803.GA29530@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 24, 2011 at 04:18:05PM +0800, Shawn Guo wrote:
> Hi Wolfram,
> 
> On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> > Take #3, changes:
> > 
> > * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> > * remove unconditional BROKEN_CARD_DETECTION (leftover)
> > * improved kernel-doc about unused GPIO
> > * added tags from Eric
> > 
> > Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> > chance to retest on mx51? What about the FSL guys? :)
> > 
> I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
> write-protect are working on mx25 3ds, but write-protect has some
> problem on babbage, and I need some time to figure it out.
> 
I just figured out why wp_gpio does not work on mx51.

+       if (cpu_is_mx25() || cpu_is_mx35()) {
+               /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
                host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
+               /* write_protect can't be routed to controller, use gpio */
+               sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
+       }

Would it make sense to do the same for mx51?  On babbage board,
SD1_WP is routed to controller, but SD2_WP is not, so we have to use
gpio for SD2 write_protect.

-- 
Regards,
Shawn
