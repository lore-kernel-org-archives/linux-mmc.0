From: Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
Date: Mon, 18 Nov 2019 20:05:09 +0100
Message-ID: <2db7a63f-a091-db8d-3414-cac289011878@fivetechno.de>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <2766673.iMURPl8gB5@phil>
 <69472c06-8b21-c3d8-acad-1a0a292c0fa2@fivetechno.de>
 <3460135.SDF8zhHPq4@diego>
 <CAD=FV=VnjyQJpRcW6P1f4+ZrSOzAe2Cnoej=it4aCz+F_ozukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VnjyQJpRcW6P1f4+ZrSOzAe2Cnoej=it4aCz+F_ozukw@mail.gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Tony Xie <tony.xie@rock-chips.com>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Vicente Bergas <vicencb@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Randy Li <ayaka@soulik.info>, Kishon
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

Am 18.11.19 um 17:08 schrieb Doug Anderson:
> Hi,
> 
> 
> On Fri, Nov 15, 2019 at 3:19 AM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Hi Markus,
>>
>> Am Freitag, 15. November 2019, 11:37:58 CET schrieb Markus Reichl:
>> > Am 14.11.19 um 14:10 schrieb Heiko Stuebner:
>> > > $subject is missing the [PATCH] prefix
>> > will fix.
>>
>> no need to resend just for this ... just to keep in mind for future patches ;-)
>>
>>
>> > > Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
>> > >> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
>> > >>
>> > >> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
>> > >> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
>> > >> mmc1: "running CQE recovery", even hangs with damaged fs,
>> > >> when running under heavy load, e.g. compiling kernel.
>> > >> Both run fine with HS200.
>> > >>
>> > >> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
>> > >> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3
>> > >
>> > > I'm hoping for some input from other people in Cc but your mail headers
>> > > also referenced the drive-impendance series from Christoph [0], which
>> > > it seems we need to poke the phy maintainer again.
>> > >
>> > > Did you check if changing the impedance helped (like the signal dampening
>> > > Philipp described in one of the replies there).
>> >
>> > checked with
>> >
>> > &emmc_phy {
>> > +       drive-impedance-ohm = <33>;
>> >
>> > gives no improvement:
>>
>> That is sad ... I guess we really should disable hs400 then ...
>> that may give others more incentive to dive deeper ;-)
> 
> Just out of curiosity, is the problem with the strobe line, or with
> hs400?  Have you tried using the solution from "rk3399-gru.dtsi"?
> Namely:
> 
>         /*
>          * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
>          * same (or nearly the same) performance for all eMMC that are intended
>          * to be used.
>          */
>         assigned-clock-rates = <150000000>;
> 
> IIRC hs400 on rk3399 was a bit iffy but running at 150 MHz made it
> much more reliable and still gave you 300 MB/s transfer rate (so much
> better than hs200).  In reality many eMMC chips can't do > 300 MB/s
> anyway.
> 
I tried 150000000 and 100000000, but it did not help.

Gruß,
--
Markus

> -Doug
> 
