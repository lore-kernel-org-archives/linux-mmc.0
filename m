From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] mmc: card: modify mmc_getgeo function
Date: Mon, 26 Sep 2011 15:13:33 +0200
Message-ID: <20110926131333.GA20550@pengutronix.de>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
 <m2ty8520fb.fsf@bob.laptop.org>
 <20110926082814.GA28149@pengutronix.de>
 <m2k48vtr12.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m2k48vtr12.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
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
Yeah, this is gcc 4.3.2. Is it too old to be supported?

Do you think of http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D48783? Th=
en
no, that is not the problem. The function is actually used:

00000028 <mmc_blk_getgeo>:
      28:       e3a03004        mov     r3, #4
      2c:       e3a02010        mov     r2, #16
      30:       e92d4010        push    {r4, lr}
      34:       e1a04001        mov     r4, r1
      38:       e5c13000        strb    r3, [r1]
      3c:       e5c12001        strb    r2, [r1, #1]
      40:       e590c050        ldr     ip, [r0, #80]   ; 0x50
      44:       e3a02040        mov     r2, #64 ; 0x40
      48:       e3a03000        mov     r3, #0
      4c:       e1cc04d8        ldrd    r0, [ip, #72]   ; 0x48
      50:       ebfffffe        bl      0 <__aeabi_uldivmod>
      54:       e1c400b2        strh    r0, [r4, #2]
      58:       e3a00000        mov     r0, #0
      5c:       e8bd8010        pop     {r4, pc}

I thought that the problem is more:

	> The kernel doesn't support 64-bit by 64-bit division at all then? =20
	Nope.  64-bit by 64-bit divides are grossly inefficient and should be
	avoided.

(taken from http://www.spinics.net/lists/arm/msg13532.html)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
