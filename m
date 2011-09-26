From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: card: modify mmc_getgeo function
Date: Mon, 26 Sep 2011 14:09:08 +0100
Message-ID: <20110926130908.GH22455@n2100.arm.linux.org.uk>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org> <m2ty8520fb.fsf@bob.laptop.org> <20110926082814.GA28149@pengutronix.de> <m2k48vtr12.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m2k48vtr12.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, kernel@pengutronix.de, Girish K S <girish.shivananjappa@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 26, 2011 at 08:41:13AM -0400, Chris Ball wrote:
> Hi,
>=20
> On Mon, Sep 26 2011, Uwe Kleine-K=F6nig wrote:
> >> Thanks, pushed to mmc-next for 3.2 with a reworded commit message:
> > This (i.e. ee9e0e0 (mmc: card: Remove duplicated constants) in next=
)
> > makes gcc emit a reference to __aeabi_uldivmod in one of my nightly
> > builds which isn't defined.
> >
> > The final linking stage fails with:
> >
> > 	  LD      .tmp_vmlinux1
> > 	drivers/built-in.o: In function `mmc_blk_getgeo':
> > 	clkdev.c:(.text+0xd1528): undefined reference to `__aeabi_uldivmod=
'
> > 	make[2]: *** [.tmp_vmlinux1] Error 1
> > 	make[1]: *** [sub-make] Error 2
> > 	make: *** [all] Error 2
>=20
> Interesting, thanks.  It builds fine here on my (gcc-4.6) ARM toolcha=
ins.
> Looking online, I think you're hitting an old gcc-4.3 bug?

Check your setting of CONFIG_LBDAF - the return type from get_capacity
depends on this (which may be either unsigned long or u64).

Now, the thing about a constant division by (16*4) is that its relative=
ly
easy for gcc to spot that this is the same as a shift - and use a shift
instead of a divide for both the unsigned long and u64 cases.

However, the change may result in gcc no longer realizing that it's a
constant division by a power-of-2, and that optimization can be applied=
=2E

If you want to eliminate these constants, I'd suggest two definitions

	MMC_GEO_SECTORS
	MMC_GEO_HEADS

and just subsituting the '4' and '16' in the function with the appropri=
ate
symbolic constants.  That'd avoid causing this regression.
