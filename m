From: Linus WALLEIJ <linus.walleij@stericsson.com>
Subject: RE: [PATCH 07/12] mmci: pass power_mode to the translate_vdd callback
Date: Thu, 24 Jun 2010 10:56:09 +0200
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025FD0D483@EXDCVYMBSTM006.EQ1STM.local>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
	<AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
	<20100624082746.GA12453@bnru01.bnr.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100624082746.GA12453@bnru01.bnr.st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>, Linus Walleij <linus.ml.walleij@gmail.com>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

[Rabin]

> On Wed, Jun 23, 2010 at 00:03:47 +0200, Linus Walleij wrote:
> > 2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:
> > > @@ -17,7 +17,8 @@
> > > =A0* mmc/host.h
> > > =A0* @translate_vdd: a callback function to translate a MMC_VDD_*
> > > =A0* mask into a value to be binary or:ed and written into the
> > > - * MMCIPWR register of the block
> > > + * MMCIPWR register of the block. =A0May also control external power
> > > + * based on the power_mode.
> >
> > Actually this callback is named like that for a reason: it is to be
> used
> > to translate the MMC_VDD_* into a u8:4 bitmask for the MMCIPWR
> > register, 4 bits possibly routed out of the PL180 block on some
> > designs (never seen in practice, but could be used in theory).
> >
> > So it translates a voltage into a 4-bit bitmask, hence the name.
> >
> > Now the semantics are altered to have other side-effects in
> > the platform, so the function should be renamed, something like
> > platform_vdd_handler() would be more appropriate.
> >
> =

> This is already inside platform data, so how about just -
> >vdd_handler()?
> Or ->set_power(), like some other drivers?

Any of these look good to me atleast.

But now another thing I came to think of (the fun never
ends):

Since the ux500 also have a regulator for this and since
that mechanism is mutually exclusive in the code (since the
semantics implied that it was only a voltage translation
function) you should also remove the condition that this
only gets called in case there is no regulator.

> Note that we'd also like to use this to do the board-specific settings
> for the *DIREN and FBCLK bits, which replace the Voltage bits on some
> ST
> variants, like so:
> =

> +static u32 mop500_sdi0_translate_vdd(struct device *dev, unsigned int
> vdd,
> +				     unsigned char power_mode)
> +{
> +	if (power_mode =3D=3D MMC_POWER_UP)
> +		gpio_set_value(gpio_sdmmc_en, 1);
> +	else if (power_mode =3D=3D MMC_POWER_OFF)
> +		gpio_set_value(gpio_sdmmc_en, 0);
> +
> +	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
> +	       MCI_DATA2DIREN | MCI_DATA31DIREN;
> +}

OK just update the kerneldoc to reflect the fact that the platform
can OR on any *custom* bits it like to the PWR register in this
function.

Side notice: some of bits are for the ST version only, when you
patch in the latter, can you take this opportunity to also
rename MCI_FBCLKEN to MCI_ST_FBCLKEN and so on for all stuff
that is ST-specific? I think I am the sinner here, we had no
convention for how to do this naming when we first began
modifying this driver. It should be crystal clear that all
custom extensions are named MCI_<VENDOR>_FOO.

As a consequence, anything that is OR:ed into from the
vdd_handler() should typically be MCI_<VENDOR>_FOO, and
it will be clear why it's there.

Yours,
Linus Walleij
