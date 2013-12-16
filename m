From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Mon, 16 Dec 2013 22:06:30 +0100
Message-ID: <52AF6B56.1020209@redhat.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com> <1386880245-10192-3-git-send-email-dinguyen@altera.com> <201312142233.27143.arnd@arndb.de> <52AD1185.6090501@linaro.org> <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab3LPVHa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Dec 2013 16:07:30 -0500
In-Reply-To: <52AF68DB.7090105@elopez.com.ar>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>
Cc: zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com, mark.rutland@arm.com, devicetree@vger.kernel.org, dinh.linux@gmail.com, heiko@sntech.de, pawel.moll@arm.com, bzhao@marvell.com, tgih.jun@samsung.com, Peter De Schrijver <pdeschrijver@nvidia.com>, linux-mmc@vger.kernel.org, dianders@chromium.org, rob.herring@calxeda.com, jh80.chung@samsung.com, alim.akhtar@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, Chen-Yu Tsai <wens@csie.org>

Hi,

On 12/16/2013 09:55 PM, Emilio L=F3pez wrote:
> Hi Mike et al,
>
> El 15/12/13 01:51, Mike Turquette escribi=F3:
>> clk_set_phase has been proposed before and now may be the time to ad=
d
>> it. There are two things that need to be addressed:
>>
>> 1) what are the values for the phase? This needs to work for others =
that
>> must set clk phase, so we need to consider all those requirements be=
fore
>> making a new function declaration in clk.h
>>
>> 2) is setting a clock's phase something done dynamically? Put anothe=
r
>> way, does the same clock has it's phase set multiple times while the
>> system is running? For static configuration that only happens during
>> initialization we do not need a new API. The clock driver can handle=
 it
>> privately. For dynamic operations though we likely need a new API.
>
> We on sunxi also need this for our (not yet merged) MMC driver; we cu=
rrently have it implemented as an exported
>
> void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 out=
put)
>
> that takes the MMC clock (and only the MMC clock) and does the setup =
(it's basically configuring two values, "sample" and "output", into the=
 clock register). I really don't know what does this do/why is it requi=
red/when is it used; I'm cc'ing Hans and David who can hopefully explai=
n that part.

I'm afraid I cannot explain that part, the MMC controller in the sunxi =
SoCs
is undocumented, so what we're doing there comes straight from the andr=
oid
kernel code. I do understand most of the bits of the sunxi-mci driver, =
but
this bit is black magic to me.

Regards,

Hans
