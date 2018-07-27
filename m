From: Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Fri, 27 Jul 2018 16:19:53 -0400
Message-ID: <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch> <24fffc2c52b58301c37d95fe5d1ad355@agner.ch>
 <3a970d5d-4f18-0167-ab22-2032e8bf743d@gmail.com> <4098188.Bd2NGYzoJE@dimapc>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="000000000000df8132057200d7f2"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4098188.Bd2NGYzoJE@dimapc>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

--000000000000df8132057200d7f2
Content-Type: text/plain; charset="UTF-8"

Kingston KE4CN3K6A.
Though I am pretty sure I've figured out the instability.
Brought it in to work and hooked it to a scope.
Couldn't find clock, but cmd and all eight bits are running at 1.2 volts.
Repeated the results with the bootloader, the original kernel, and my
mainline.
Also noticed that even on the slowest slew rate there is significant
ringing and overshoot of .15 volts.



On Fri, Jul 27, 2018, 15:52 Dmitry Osipenko <digetx@gmail.com> wrote:

> On Thursday, 26 July 2018 20:48:55 MSK Peter Geis wrote:
> > On 07/26/2018 01:36 PM, Stefan Agner wrote:
> > > On 26.07.2018 18:39, Peter Geis wrote:
> > >>>>>> I finally got around to testing this on the Ouya (Tegra 3).
> > >>>>>
> > >>>>> Thanks for testing!
> > >>>>>
> > >>>>>> I found that the "Got command interrupt 0x00010000 even though no
> > >>>>>> command operation was in progress." error occurred when the
> interface
> > >>>>>> is unstable.
> > >>>>>> I've had a lot of problems with sdmmc4 stability on the Ouya
> above 34
> > >>>>>> Mhz, probably due to the fact that they are using the internal cmd
> > >>>>>> and
> > >>>>>> clock pull-up resistors, against the TRM's instruction.
> > >>>>>> At 39Mhz, I saw the error this patch corrects.
> > >>>>>> With the patch, the error went away, but the interface is still
> > >>>>>> unstable under load.
> > >>>>>
> > >>>>> How does this instability manifest exactly?
> > >>>>
> > >>>> At the very edge of stability, you see write errors under heavy
> load.
> > >>>> As clock rate increases, the write errors occur more frequently.
> > >>>> At a certain point, you start getting read errors.
> > >>>> Following that you get constant io errors during card probing.
> > >>>> Eventually the emmc will fail to initialize, with errors 87 or 110.
> > >>>
> > >>> What mode are you running at actually? E.g. what is the ios file
> saying?
> > >>> cat /sys/kernel/debug/mmcX/ios
> > >>
> > >> This is the best functionality I've been able to get prior to the
> > >> patches:
> > >> root@ouya:~# cat /sys/kernel/debug/mmc0/ios
> > >> clock:          30000000 Hz
> > >> actual clock:   29142858 Hz
> > >> vdd:            21 (3.3 ~ 3.4 V)
> > >> bus mode:       2 (push-pull)
> > >> chip select:    0 (don't care)
> > >> power mode:     2 (on)
> > >> bus width:      3 (8 bits)
> > >> timing spec:    9 (mmc HS200)
> > >> signal voltage: 1 (1.80 V)
> > >> driver type:    0 (driver type B)
> > >
> > > Yeah HS200 is definilty not supported by the controller and really
> > > should not be used.
> > >
> > >> Now I am trying DDR, but even with the patches I'm not able to remain
> > >> stable above 17Mhz (34Mhz clock).
> > >>
> > >> I've also tried just straight mmc-hs mode, but even that makes no
> > >> difference.>
> > > So you tried timing spec 1 (mmc HS)?
> > >
> > > How did you exactly enable mmc-hs mode?
> >
> > cap-mmc-highspeed;
> >
> > > I suggest to *not set* vqmmc and apply patch 1. It will report that
> > > signaling voltage is 3.3V, but that did not really matter in our case.
> > > This was our baseline and always worked stable on mainline. I also
> would
> > > use that mode when tweaking pinmux etc...
> >
> > Will do, thanks.
> >
> > >>>> I've been tweaking the pull up/down values to try and improve the
> > >>>> stability, but without access to anything but the TRM it's a lot of
> > >>>> trial and error.
> > >>>
> > >>> Hm, maybe Marcel's recent fixes in our device tree are helpful?
> > >>> https://lkml.org/lkml/2018/7/22/165
> > >>>
> > >>> Also make sure to have a complete pinmux such that alternative pins
> for
> > >>> sdmmc4 are *not* muxed as sdmmc4.
> > >>
> > >> That was my first issue, which was preventing sdmmc4 from working at
> all.
> > >> Just double checked all of the spare function pins, they are all
> > >> assigned elsewhere.
> > >
> > > Ok.
> > >
> > >>>>>> Lowering down to 32Mhz, without the patch there are no errors.
> > >>>>>
> > >>>>> So the patch does not make it less stable right?
> > >>>>
> > >>>> No, it did not affect stability.
> > >>>> Although I'd conduct some performance testing to check for
> degradation.
> > >>>> Of course I'm nowhere near the limits of the controller, so it is
> > >>>> doubtful I'd see a hit.
> > >>>
> > >>> Ok, and this is with the complete patchset applied correct?
> > >>>
> > >>> Btw, what device tree are you using? Ouya is not upstream as far as I
> > >>> can tell?
> > >>
> > >> Indeed, I have the full patchset.
> > >>
> > >> Ouya is an old android game console that I've been working on getting
> > >> mainline working on.
> > >
> > > I know, I have one sitting here too. I only tried to tinker a bit at
> the
> > > very beginning...
> >
> > It runs Xubuntu very well now with mainline.
> > I've got most everything roughly supported with the exception of audio.
> >
> > >> I've written most of the device tree, with contributions from Matt
> > >> Merhar.
> > >> It's almost bit for bit a cardhu dev board, but with everything not
> > >> necessary to function removed.
> > >> They cut a lot of corners with the board design.
> > >> Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it
> > >> reported it was running mode 5.
> > >
> > > That is what we saw too. With Apalis/Colibri T30 L4T downstream kernel
> > > (which is 3.1 with quite some patches) 52MHz DDR worked fine,
> > > surprisingly even with ACMD23. However, speed is slightly slower than
> > > mainline 52MHz without ACMD23...
> >
> > I noticed the same thing, speed with the original kernel on the MMC was
> > worse at 52Mhz than it was at 34Mhz in HS-200 mode on mainline.
> > I'd be happy with it where it is, but the fact that it worked at 52Mhz
> > before makes me believe something isn't quite there yet.
> > I selected HS-200 mode just to force 1.8v mode.
>
> What's the card model your Ouya's eMMC has?
>
>
>
>
>

--000000000000df8132057200d7f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"color:rgb(85,85,85);font-family:lato,arial=
,sans-serif;font-size:16px">Kingston=C2=A0</span><span style=3D"font-size:1=
6px;color:rgb(85,85,85);font-family:lato,arial,sans-serif">KE4CN3K6A.</span=
><div dir=3D"auto"><font color=3D"#555555" face=3D"lato, arial, sans-serif"=
><span style=3D"font-size:16px">Though I am pretty sure I&#39;ve figured ou=
t the instability.</span></font></div><div dir=3D"auto"><font color=3D"#555=
555" face=3D"lato, arial, sans-serif"><span style=3D"font-size:16px">Brough=
t it in to work and hooked it to a scope.</span></font></div><div dir=3D"au=
to"><font color=3D"#555555" face=3D"lato, arial, sans-serif"><span style=3D=
"font-size:16px">Couldn&#39;t find clock, but cmd and all eight bits are ru=
nning at 1.2 volts.</span></font></div><div dir=3D"auto"><font color=3D"#55=
5555" face=3D"lato, arial, sans-serif"><span style=3D"font-size:16px">Repea=
ted the results with the bootloader, the original kernel, and my mainline.<=
/span></font></div><div dir=3D"auto"><font color=3D"#555555" face=3D"lato, =
arial, sans-serif"><span style=3D"font-size:16px">Also noticed that even on=
 the slowest slew rate there is significant ringing and overshoot of .15 vo=
lts.<br></span></font><div dir=3D"auto"><div dir=3D"auto"><span style=3D"co=
lor:rgb(85,85,85);font-family:lato,arial,sans-serif;font-size:16px"><br></s=
pan></div><div dir=3D"auto"><span style=3D"color:rgb(85,85,85);font-family:=
lato,arial,sans-serif;font-size:16px"><br></span></div></div></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Jul 27, 2018, 15:52 D=
mitry Osipenko &lt;<a href=3D"mailto:digetx@gmail.com">digetx@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thursday, 26 July 20=
18 20:48:55 MSK Peter Geis wrote:<br>
&gt; On 07/26/2018 01:36 PM, Stefan Agner wrote:<br>
&gt; &gt; On 26.07.2018 18:39, Peter Geis wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; I finally got around to testing this on the O=
uya (Tegra 3).<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; Thanks for testing!<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; I found that the &quot;Got command interrupt =
0x00010000 even though no<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; command operation was in progress.&quot; erro=
r occurred when the interface<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; is unstable.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; I&#39;ve had a lot of problems with sdmmc4 st=
ability on the Ouya above 34<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Mhz, probably due to the fact that they are u=
sing the internal cmd<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; and<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; clock pull-up resistors, against the TRM&#39;=
s instruction.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; At 39Mhz, I saw the error this patch corrects=
.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; With the patch, the error went away, but the =
interface is still<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; unstable under load.<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; How does this instability manifest exactly?<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; At the very edge of stability, you see write errors u=
nder heavy load.<br>
&gt; &gt;&gt;&gt;&gt; As clock rate increases, the write errors occur more =
frequently.<br>
&gt; &gt;&gt;&gt;&gt; At a certain point, you start getting read errors.<br=
>
&gt; &gt;&gt;&gt;&gt; Following that you get constant io errors during card=
 probing.<br>
&gt; &gt;&gt;&gt;&gt; Eventually the emmc will fail to initialize, with err=
ors 87 or 110.<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; What mode are you running at actually? E.g. what is the i=
os file saying?<br>
&gt; &gt;&gt;&gt; cat /sys/kernel/debug/mmcX/ios<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; This is the best functionality I&#39;ve been able to get prio=
r to the<br>
&gt; &gt;&gt; patches:<br>
&gt; &gt;&gt; root@ouya:~# cat /sys/kernel/debug/mmc0/ios<br>
&gt; &gt;&gt; clock:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 30000000 Hz<br>
&gt; &gt;&gt; actual clock:=C2=A0 =C2=A029142858 Hz<br>
&gt; &gt;&gt; vdd:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 21 (3.3 ~ 3.4 V=
)<br>
&gt; &gt;&gt; bus mode:=C2=A0 =C2=A0 =C2=A0 =C2=A02 (push-pull)<br>
&gt; &gt;&gt; chip select:=C2=A0 =C2=A0 0 (don&#39;t care)<br>
&gt; &gt;&gt; power mode:=C2=A0 =C2=A0 =C2=A02 (on)<br>
&gt; &gt;&gt; bus width:=C2=A0 =C2=A0 =C2=A0 3 (8 bits)<br>
&gt; &gt;&gt; timing spec:=C2=A0 =C2=A0 9 (mmc HS200)<br>
&gt; &gt;&gt; signal voltage: 1 (1.80 V)<br>
&gt; &gt;&gt; driver type:=C2=A0 =C2=A0 0 (driver type B)<br>
&gt; &gt; <br>
&gt; &gt; Yeah HS200 is definilty not supported by the controller and reall=
y<br>
&gt; &gt; should not be used.<br>
&gt; &gt; <br>
&gt; &gt;&gt; Now I am trying DDR, but even with the patches I&#39;m not ab=
le to remain<br>
&gt; &gt;&gt; stable above 17Mhz (34Mhz clock).<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; I&#39;ve also tried just straight mmc-hs mode, but even that =
makes no<br>
&gt; &gt;&gt; difference.&gt; <br>
&gt; &gt; So you tried timing spec 1 (mmc HS)?<br>
&gt; &gt; <br>
&gt; &gt; How did you exactly enable mmc-hs mode?<br>
&gt; <br>
&gt; cap-mmc-highspeed;<br>
&gt; <br>
&gt; &gt; I suggest to *not set* vqmmc and apply patch 1. It will report th=
at<br>
&gt; &gt; signaling voltage is 3.3V, but that did not really matter in our =
case.<br>
&gt; &gt; This was our baseline and always worked stable on mainline. I als=
o would<br>
&gt; &gt; use that mode when tweaking pinmux etc...<br>
&gt; <br>
&gt; Will do, thanks.<br>
&gt; <br>
&gt; &gt;&gt;&gt;&gt; I&#39;ve been tweaking the pull up/down values to try=
 and improve the<br>
&gt; &gt;&gt;&gt;&gt; stability, but without access to anything but the TRM=
 it&#39;s a lot of<br>
&gt; &gt;&gt;&gt;&gt; trial and error.<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; Hm, maybe Marcel&#39;s recent fixes in our device tree ar=
e helpful?<br>
&gt; &gt;&gt;&gt; <a href=3D"https://lkml.org/lkml/2018/7/22/165" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://lkml.org/lkml/2018/7/22/165<=
/a><br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; Also make sure to have a complete pinmux such that altern=
ative pins for<br>
&gt; &gt;&gt;&gt; sdmmc4 are *not* muxed as sdmmc4.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; That was my first issue, which was preventing sdmmc4 from wor=
king at all.<br>
&gt; &gt;&gt; Just double checked all of the spare function pins, they are =
all<br>
&gt; &gt;&gt; assigned elsewhere.<br>
&gt; &gt; <br>
&gt; &gt; Ok.<br>
&gt; &gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Lowering down to 32Mhz, without the patch the=
re are no errors.<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; So the patch does not make it less stable right?<=
br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; No, it did not affect stability.<br>
&gt; &gt;&gt;&gt;&gt; Although I&#39;d conduct some performance testing to =
check for degradation.<br>
&gt; &gt;&gt;&gt;&gt; Of course I&#39;m nowhere near the limits of the cont=
roller, so it is<br>
&gt; &gt;&gt;&gt;&gt; doubtful I&#39;d see a hit.<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; Ok, and this is with the complete patchset applied correc=
t?<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; Btw, what device tree are you using? Ouya is not upstream=
 as far as I<br>
&gt; &gt;&gt;&gt; can tell?<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Indeed, I have the full patchset.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Ouya is an old android game console that I&#39;ve been workin=
g on getting<br>
&gt; &gt;&gt; mainline working on.<br>
&gt; &gt; <br>
&gt; &gt; I know, I have one sitting here too. I only tried to tinker a bit=
 at the<br>
&gt; &gt; very beginning...<br>
&gt; <br>
&gt; It runs Xubuntu very well now with mainline.<br>
&gt; I&#39;ve got most everything roughly supported with the exception of a=
udio.<br>
&gt; <br>
&gt; &gt;&gt; I&#39;ve written most of the device tree, with contributions =
from Matt<br>
&gt; &gt;&gt; Merhar.<br>
&gt; &gt;&gt; It&#39;s almost bit for bit a cardhu dev board, but with ever=
ything not<br>
&gt; &gt;&gt; necessary to function removed.<br>
&gt; &gt;&gt; They cut a lot of corners with the board design.<br>
&gt; &gt;&gt; Last stable kernel was 3.2, but it ran fine at 52mhz, mind yo=
u it<br>
&gt; &gt;&gt; reported it was running mode 5.<br>
&gt; &gt; <br>
&gt; &gt; That is what we saw too. With Apalis/Colibri T30 L4T downstream k=
ernel<br>
&gt; &gt; (which is 3.1 with quite some patches) 52MHz DDR worked fine,<br>
&gt; &gt; surprisingly even with ACMD23. However, speed is slightly slower =
than<br>
&gt; &gt; mainline 52MHz without ACMD23...<br>
&gt; <br>
&gt; I noticed the same thing, speed with the original kernel on the MMC wa=
s<br>
&gt; worse at 52Mhz than it was at 34Mhz in HS-200 mode on mainline.<br>
&gt; I&#39;d be happy with it where it is, but the fact that it worked at 5=
2Mhz<br>
&gt; before makes me believe something isn&#39;t quite there yet.<br>
&gt; I selected HS-200 mode just to force 1.8v mode.<br>
<br>
What&#39;s the card model your Ouya&#39;s eMMC has?<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000df8132057200d7f2--
