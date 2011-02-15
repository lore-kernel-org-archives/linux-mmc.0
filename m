From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 16 Feb 2011 06:03:12 +0800
Message-ID: <20110215220311.GH10990@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165959.GC31103@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110214165959.GC31103@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: arnd@arndb.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 14, 2011 at 04:59:59PM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> > +	switch (mmc_resp_type(cmd)) {
> > +	case MMC_RSP_NONE:
> > +		break;
> > +	case MMC_RSP_R1:
> > +	case MMC_RSP_R1B:
> > +	case MMC_RSP_R3:
> > +		cmd->resp[0] = readl(host->base + HW_SSP_SDRESP0);
> > +		break;
> > +	case MMC_RSP_R2:
> > +		cmd->resp[3] = readl(host->base + HW_SSP_SDRESP0);
> > +		cmd->resp[2] = readl(host->base + HW_SSP_SDRESP1);
> > +		cmd->resp[1] = readl(host->base + HW_SSP_SDRESP2);
> > +		cmd->resp[0] = readl(host->base + HW_SSP_SDRESP3);
> 
> You really should be testing for MMC_RSP_PRESENT and MMC_RSP_136
> here.  The response types are made up of a bitfield which allows
> you to detect what's required rather than having to decode the
> response type itself.
> 
Please review the update.

        if (mmc_resp_type(cmd) & MMC_RSP_PRESENT) {
                if (mmc_resp_type(cmd) & MMC_RSP_136) {
                        cmd->resp[3] = readl(host->base + HW_SSP_SDRESP0);
                        cmd->resp[2] = readl(host->base + HW_SSP_SDRESP1);
                        cmd->resp[1] = readl(host->base + HW_SSP_SDRESP2);
                        cmd->resp[0] = readl(host->base + HW_SSP_SDRESP3);
                } else {
                        cmd->resp[0] = readl(host->base + HW_SSP_SDRESP0);
                }
        }

> > +		else if (stat & BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ)
> > +			data->error = -ENODATA;
> > +		else if (stat & BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
> > +			data->error = -EOVERFLOW;
> 
> Both of these have a common error code - -EIO.
> 
OK.  Thanks for teaching.

Regards,
Shawn
