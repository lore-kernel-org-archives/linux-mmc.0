From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH 2/3] ARM: MXC: mxcmmc: Teach the driver SDIO operations
Date: Wed, 31 Mar 2010 18:41:36 +0200
Message-ID: <m2ke2d7436a1003310941t18aeab59qb41f96bc58618960@mail.gmail.com>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
	 <1269973921-29611-2-git-send-email-daniel@caiaq.de>
	 <20100331130339.GX2241@pengutronix.de>
	 <20100331132946.GH30807@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49071 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab0CaQlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2010 12:41:37 -0400
Received: by wwb17 with SMTP id 17so210746wwb.19
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2010 09:41:36 -0700 (PDT)
In-Reply-To: <20100331132946.GH30807@buzzloop.caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Volker Ernst <volker.ernst@txtr.com>, Jiri Kosina <jkosina@suse.cz>

2010/3/31 Daniel Mack <daniel@caiaq.de>:
> On Wed, Mar 31, 2010 at 03:03:39PM +0200, Sascha Hauer wrote:
>> On Tue, Mar 30, 2010 at 08:32:00PM +0200, Daniel Mack wrote:
>> > +static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enab=
le)
>> > +{
>> > + =A0 struct mxcmci_host *host =3D mmc_priv(mmc);
>> > + =A0 unsigned long flags;
>> > + =A0 u32 int_cntr;
>> > +
>> > + =A0 spin_lock_irqsave(&host->lock, flags);
>> > + =A0 host->use_sdio =3D enable;
>> > + =A0 int_cntr =3D readl(host->base + MMC_REG_INT_CNTR);
>> > +
>> > + =A0 if (enable)
>> > + =A0 =A0 =A0 =A0 =A0 int_cntr |=3D INT_SDIO_IRQ_EN;
>> > + =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 int_cntr &=3D ~INT_SDIO_IRQ_EN;
>> > +
>> > + =A0 writel(int_cntr, host->base + MMC_REG_INT_CNTR);
>> > + =A0 spin_unlock_irqrestore(&host->lock, flags);
>>
>> The other places where MMC_REG_INT_CNTR is touched should be protect=
ed
>> by this spinlock aswell.
> Hmm, all other place don't do a read/modify/write cycle, so I'd say t=
he
> don't need protection?

If you miss spinlocks around the unconditional writes they might
happen between your readl() and writel().

Best Regards,
Micha=B3 Miros=B3aw
