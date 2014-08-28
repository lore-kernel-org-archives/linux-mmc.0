From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: tmio: ensure that the clock has been stopped
 before set_clock
Date: Thu, 28 Aug 2014 09:13:34 +0200
Message-ID: <CAPDyKFqUdC5a72rgDPk4HnQJoMe9qkfMPTFnFG+wXuSjMB2jbw@mail.gmail.com>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFrzr_tjLFqZ1nQg63Zfr0xRAf71HWAmge6DcMzTkwCLiQ@mail.gmail.com>
	<87bnr5ic6h.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFo2rv-33cgEx+uGnpkDfDDTQfSmLOiAA3Eb=mrfeRab9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:60300 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965025AbaH1HNf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Aug 2014 03:13:35 -0400
Received: by mail-la0-f50.google.com with SMTP id mc6so409508lab.9
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2014 00:13:34 -0700 (PDT)
In-Reply-To: <CAPDyKFo2rv-33cgEx+uGnpkDfDDTQfSmLOiAA3Eb=mrfeRab9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 28 August 2014 09:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 28 August 2014 04:24, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> This patch ensures that the clock has been stopped before
>> it calls tmio_mmc_set_clock().
>> The clock settings might be failed without this patch
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>> v3 -> v4
>>
>>  - based on latest git://git.linaro.org/people/ulf.hansson/mmc.git#next
>>
>>  drivers/mmc/host/tmio_mmc_pio.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
>> index ba45413..7289331 100644
>> --- a/drivers/mmc/host/tmio_mmc_pio.c
>> +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -924,12 +924,14 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 tmio_mmc_clk_stop(host);
>>                 break;
>>         case MMC_POWER_UP:
>> +               tmio_mmc_clk_stop(host);
>
> I don't think this is needed. Let me elaborate on why.
>
> There two scenarios for when you may come down this path.
>
> Either after ->probe() or after a MMC_POWER_OFF has been handled. In
> both scenarios, tmio_mmc_clk_stop(host) has already been invoked.
>
> Well, actually in the ->probe() we invoke tmio_mmc_clk_stop() and then
> tmio_mmc_reset(), should those maybe be done in reverse order to make
> sure the clock is stopped?
>
>>                 tmio_mmc_set_clock(host, ios->clock);
>>                 tmio_mmc_power_on(host, ios->vdd);
>>                 tmio_mmc_clk_start(host);
>>                 tmio_mmc_set_bus_width(host, ios->bus_width);
>>                 break;
>>         case MMC_POWER_ON:
>> +               tmio_mmc_clk_stop(host);
>>                 tmio_mmc_set_clock(host, ios->clock);
>>                 tmio_mmc_clk_start(host);
>>                 tmio_mmc_set_bus_width(host, ios->bus_width);
>> @@ -1199,6 +1201,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>>         tmio_mmc_clk_update(host);
>>
>>         if (host->clk_cache) {
>> +               tmio_mmc_clk_stop(host);
>
> This should also not be needed.
>
> To get runtime PM resumed, you must first be runtime PM suspended. In
> the runtime PM suspend callback we have already invoked
> tmio_mmc_set_clock().

/s /tmio_mmc_set_clock() / tmio_mmc_clk_stop()

>
> Well, again it may depend on if tmio_mmc_reset() should be followed by
> a tmio_mmc_clk_stop(), which isn't the case right now.
>
>>                 tmio_mmc_set_clock(host, host->clk_cache);
>>                 tmio_mmc_clk_start(host);
>>         }
>> --
>> 1.7.9.5
>>
>
> Finally, another question - somewhat related to clocks but not so much
> to this patch.
>
> Shouldn't tmio_mmc_set_clock() when requested rate is 0, actually
> invoke tmio_mmc_clk_stop()? How will otherwise the clock be stopped?
>
> Kind regards
> Uffe
