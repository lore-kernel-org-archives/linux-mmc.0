From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: renesas sdhi driver and DMA
Date: Tue, 10 Oct 2017 20:46:19 +0000
Message-ID: <SG2PR06MB11659A9EF153FF4A41575D3F8A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

> > [<bf9921e7>] (tmio_mmc_dma_callback) from [<bf908e1b>]
> (rzadma_tasklet+0x23/0x98)
>=20
> For SYS-DMAC, this is a callback called by the dmaengine core once the
> DMA is completed. My guess is you call it directly from an interrupt
> handler? It would be easier to talk over code here, I guess.
>=20
> > Is it now a requirement that I have to register my DMA channel
> > interrupts as devm_request_threaded_irq?
> >
> > Will that fix my issue?
>=20
> I can't say yet if this alone will do. Likely not. Can you share the
> code already?

The interrupt handler is starting a tasklet, and then the tasklet calls=20
the callback. I thought tasklets didn't run in an interrupt context?????


As a code snippet, here is the irq hander and the tasket. Of course I=20
can send the entire file if you want as well if you need to see more.


static void dma_irq_handle_channel(struct rzadma_channel *rzadmac)
{
	u32 chstat, chctrl;
	struct rzadma_engine *rzadma =3D rzadmac->rzadma;
	int channel =3D rzadmac->channel;

	chstat =3D rzadma_ch_readl(rzadmac, CHSTAT, 1);
	if (chstat & CHSTAT_ER) {
		dev_dbg(rzadma->dev, "CHSTAT_%d =3D %08X\n", channel, chstat);
		rzadma_ch_writel(rzadmac,
				CHCTRL_DEFAULT,
				CHCTRL, 1);
		goto schedule;
	}
	if (!(chstat & CHSTAT_END))
		return;

	chctrl =3D rzadma_ch_readl(rzadmac, CHCTRL, 1);
	dev_dbg(rzadma->dev,"2. chctrl_%d=3D%08X\n", channel, chctrl);
	rzadma_ch_writel(rzadmac,
			chctrl | CHCTRL_CLREND | CHCTRL_CLRRQ,
			CHCTRL, 1);
schedule:
	/* Tasklet irq */
	tasklet_schedule(&rzadmac->dma_tasklet);
}


static void rzadma_tasklet(unsigned long data)
{
	struct rzadma_channel *rzadmac =3D (void *)data;
	struct rzadma_engine *rzadma =3D rzadmac->rzadma;
	struct rzadma_desc *desc;
	unsigned long flags;

	/* Protection of critical section */
	spin_lock_irqsave(&rzadma->lock, flags);

	if (list_empty(&rzadmac->ld_active)) {
		/* Someone might have called terminate all */
		goto out;
	}

	desc =3D list_first_entry(&rzadmac->ld_active, struct rzadma_desc, node);

	if (desc->desc.callback)
		desc->desc.callback(desc->desc.callback_param);

	dma_cookie_complete(&desc->desc);

	if (list_empty(&rzadmac->ld_active)) {
		goto out;
	}else{
		list_move_tail(rzadmac->ld_active.next, &rzadmac->ld_free);
	}

	if (!list_empty(&rzadmac->ld_queue)) {
		desc =3D list_first_entry(&rzadmac->ld_queue, struct rzadma_desc,
					node);
		if (rzadma_xfer_desc(desc) < 0){
			dev_err(rzadma->dev, "%s: channel: %d couldn't xfer desc\n",
				 __func__, rzadmac->channel);
		}else{
			list_move_tail(rzadmac->ld_queue.next, &rzadmac->ld_active);
		}
	}
out:
	spin_unlock_irqrestore(&rzadma->lock, flags);
}



> Isn't it SYS-DMAC compatible (sigh)?

My first goal is to just get this DMA platform driver we made a couple=20
years ago working with DT (ie, you can't go passing in slave IDs anymore=20
via platform data structures).

Technically, it is working now (after I revert your patch), but I=20
probably have more things that have to change before I can think about=20
submitting it upstream for review.


Thank you!

Chris
