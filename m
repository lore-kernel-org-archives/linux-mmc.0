From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 1 Oct 2015 11:54:24 +0200
Message-ID: <CAPDyKFpis8XnvrppHq7q_7DQeN2UiEpykNTJ=1iJJ9AGOHTW6Q@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<1443622064-14362-4-git-send-email-heiko@sntech.de>
	<CAPDyKFrTNF6RUWs6UdBGoyrp+zzrLf8qAHgBL4xV6fjK_HM_yw@mail.gmail.com>
	<17200614.QxCe8zAb7I@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <17200614.QxCe8zAb7I@diego>
Sender: linux-clk-owner@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 30 September 2015 at 16:55, Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
>> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de> wrot=
e:
>> > From: Douglas Anderson <dianders@chromium.org>
>> >
>> > This adds logic to the MMC core to set VQMMC.  This is expected to=
 be
>> > called by MMC drivers like dw_mmc as part of (or instead of) their
>> > start_signal_voltage_switch() callback.
>> >
>> > A few notes:
>> >
>> > * When setting the signal voltage to 3.3V we do our best to make V=
QMMC
>> >
>> >   and VMMC match.  It's been reported that this makes some old car=
ds
>> >   happy since they were tested back in the day before UHS when VQM=
MC
>> >   and VMMC were provided by the same regulator.  A nice side effec=
t of
>> >   this is that we don't end up on the hairy edge of VQMMC (2.7V),
>> >   which some EEs claim is a little too close to the minimum for
>> >   comfort.
>> >   This is done in two steps. At first we try to find a VQMMC withi=
n
>> >   a 0.3V tolerance of VMMC and if this is not supported by the
>> >   supplying regulator we try to find a suitable voltage within the
>> >   whole 2.7V-3.6V area of the spec.
>> >
>> > * The two step approach is currently necessary, as the used
>> >
>> >   regulator_set_voltage_triplet(min, target, max) uses a simple
>> >
>> >   implementation that just tries two basic steps:
>> >         regulator_set_voltage(target, max);
>> >         regulator_set_voltage(min, target);
>> >
>> >   So with only one step with 2.7-3.6V borders, if a suitable volta=
ge
>> >   is a bit below VMMC, we would directly get the lowest 2.7V
>> >   which some boards (like Rockchips) don't like at all.
>> >
>> > * When setting the signal voltage to 1.8V or 1.2V we aim for that
>> >
>> >   specific voltage instead of picking the lowest one in the range.
>> >
>> > * We very purposely don't print errors in mmc_regulator_set_vqmmc(=
).
>> >
>> >   There are cases where the MMC core will try several different
>> >   voltages and we don't want to pollute the logs.
>> >
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> This looks good to me!
>
> very cool :-)
>
>
>> Once all are happy with the patches, can we take the mmc patches via
>> my mmc tree or does it all have to go together?
>
> The clock changes of course only touch internals of the phase-clocks,=
 so
> should have no problem going through another tree.

What happens if I take mmc and dt changes, wouldn't I need the clock
patches as well?

>
> For the devicetree part I'm unsure. If the boards enable the tuning-r=
elated
> settings without the new voltage handling, 2.7V gets set on all Rockc=
hip
> boards which doesn't work on those at all.
>
> So either the dts patches would need to go into your tree, I would ne=
ed a
> stable branch or we could simply postpone dts changes for the next cy=
cle.
>

Kind regards
Uffe
