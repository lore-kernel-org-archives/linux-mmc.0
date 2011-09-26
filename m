From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: card: modify mmc_getgeo function
Date: Mon, 26 Sep 2011 08:41:13 -0400
Message-ID: <m2k48vtr12.fsf@bob.laptop.org>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2ty8520fb.fsf@bob.laptop.org>
	<20110926082814.GA28149@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110926082814.GA28149@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Mon, 26 Sep 2011 10:28:14 +0200")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Sep 26 2011, Uwe Kleine-K=C3=B6nig wrote:
>> Thanks, pushed to mmc-next for 3.2 with a reworded commit message:
> This (i.e. ee9e0e0 (mmc: card: Remove duplicated constants) in next)
> makes gcc emit a reference to __aeabi_uldivmod in one of my nightly
> builds which isn't defined.
>
> The final linking stage fails with:
>
> 	  LD      .tmp_vmlinux1
> 	drivers/built-in.o: In function `mmc_blk_getgeo':
> 	clkdev.c:(.text+0xd1528): undefined reference to `__aeabi_uldivmod'
> 	make[2]: *** [.tmp_vmlinux1] Error 1
> 	make[1]: *** [sub-make] Error 2
> 	make: *** [all] Error 2

Interesting, thanks.  It builds fine here on my (gcc-4.6) ARM toolchain=
s.
Looking online, I think you're hitting an old gcc-4.3 bug?

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
