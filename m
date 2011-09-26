From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: card: modify mmc_getgeo function
Date: Mon, 26 Sep 2011 14:19:58 +0100
Message-ID: <20110926131958.GK22455@n2100.arm.linux.org.uk>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org> <m2ty8520fb.fsf@bob.laptop.org> <20110926082814.GA28149@pengutronix.de> <m2k48vtr12.fsf@bob.laptop.org> <20110926131333.GA20550@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110926131333.GA20550@pengutronix.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, kernel@pengutronix.de, Girish K S <girish.shivananjappa@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 26, 2011 at 03:13:33PM +0200, Uwe Kleine-K=F6nig wrote:
> 00000028 <mmc_blk_getgeo>:
>       28:       e3a03004        mov     r3, #4
>       2c:       e3a02010        mov     r2, #16
>       30:       e92d4010        push    {r4, lr}
>       34:       e1a04001        mov     r4, r1
>       38:       e5c13000        strb    r3, [r1]
>       3c:       e5c12001        strb    r2, [r1, #1]
>       40:       e590c050        ldr     ip, [r0, #80]   ; 0x50
>       44:       e3a02040        mov     r2, #64 ; 0x40
>       48:       e3a03000        mov     r3, #0
>       4c:       e1cc04d8        ldrd    r0, [ip, #72]   ; 0x48
>       50:       ebfffffe        bl      0 <__aeabi_uldivmod>
>       54:       e1c400b2        strh    r0, [r4, #2]

Yes, this is just silly.  A 64-bit by 64-bit division by a power-of-2
value to ultimately store a 16-bit value.

Even truncating the output from get_capacity() would be better and no
less (in)correct (it may look weird but what the assembly shows is that
it really doesn't matter).  u64 / 64 will give the same 16-bit result a=
s
u64-truncated-to-u32 / 64.
