From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Mon, 16 Dec 2013 17:55:55 -0300
Message-ID: <52AF68DB.7090105@elopez.com.ar>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com> <1386880245-10192-3-git-send-email-dinguyen@altera.com> <201312142233.27143.arnd@arndb.de> <52AD1185.6090501@linaro.org> <20131215045116.23538.4@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131215045116.23538.4@quantum>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Mike et al,

El 15/12/13 01:51, Mike Turquette escribi=F3:
> clk_set_phase has been proposed before and now may be the time to add
> it. There are two things that need to be addressed:
>
> 1) what are the values for the phase? This needs to work for others t=
hat
> must set clk phase, so we need to consider all those requirements bef=
ore
> making a new function declaration in clk.h
>
> 2) is setting a clock's phase something done dynamically? Put another
> way, does the same clock has it's phase set multiple times while the
> system is running? For static configuration that only happens during
> initialization we do not need a new API. The clock driver can handle =
it
> privately. For dynamic operations though we likely need a new API.

We on sunxi also need this for our (not yet merged) MMC driver; we=20
currently have it implemented as an exported

void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 outpu=
t)

that takes the MMC clock (and only the MMC clock) and does the setup=20
(it's basically configuring two values, "sample" and "output", into the=
=20
clock register). I really don't know what does this do/why is it=20
required/when is it used; I'm cc'ing Hans and David who can hopefully=20
explain that part.

I also saw a similar requirement from the gmac people (on cc too), who=20
needed to set the phy type (or something like that) on one of the clock=
=20
registers; so I'm thinking maybe a generic "tune something" approach=20
that lets users configure some clock-dependent, arbitrary aspect of the=
=20
clock is the way forward. Otherwise, we're going to end up bloating the=
=20
clock framework with a lot of callback pointers that are going to be=20
used in one or two clocks out of potentially hundreds on the whole syst=
em.

Cheers,

Emilio
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
