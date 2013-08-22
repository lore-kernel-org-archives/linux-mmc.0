From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH V2] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Fri, 23 Aug 2013 01:06:42 +0200
Message-ID: <3264029.cracds40W5@flatron>
References: <1377067433-28373-1-git-send-email-yuvaraj.cd@samsung.com> <1382155.lZhuLK0WA6@amdc1227> <CAKuRcOL7Vs=1em8U6rx=ZBRU8j=0A-WiNK44JrFn6jtVRCns0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKuRcOL7Vs=1em8U6rx=ZBRU8j=0A-WiNK44JrFn6jtVRCns0w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>, Doug Anderson <dianders@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>
Cc: Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, kgene.kim@samsung.com, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thursday 22 of August 2013 12:24:58 Yuvaraj Kumar wrote:
> On Wed, Aug 21, 2013 at 4:00 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Hi Yuvaraj,
> > 
> > On Wednesday 21 of August 2013 12:13:53 Yuvaraj Kumar C D wrote:
> >> This patch adds the device tree node entries for exynos5420 SOC.
> >> Exynos5420 has a different version of DWMMC controller,so a new
> >> compatible string is used to distinguish it from the prior SOC's.
> > 
> > What are the difference between both versions? Is there a patch adding
> > the new compatible to the driver somewhere?
> 
> Exynos5250 has DWMMC controller of IP version 2.41a
> Exynos5420 has DWMMC controller of IP version 2.50a
> In addition Exynos5420 has Security Management Unit for eMMC.

OK. What about my second question?

> >> changes since V1:
> >>       1.disable node by status = disabled in SOC file
> >>       2.enable node by status = okay in board specific file
> > 
> > Ahh, so you fixed this already in this version, thanks. Haven't
> > noticed
> > this patch at first and commented on previous one. Sorry for the
> > noise.
> > 
> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >> ---
> >> 
> >>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    2 ++
> >>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   38
> >> 
> >> ++++++++++++++++++++ arch/arm/boot/dts/exynos5420.dtsi
> >> 
> >> |   36 +++++++++++++++++++ 3 files changed, 76 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> >> b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt index
> >> 6d1c098..84cd56f 100644
> >> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> >> 
> >> @@ -16,6 +16,8 @@ Required Properties:
> >>         specific extensions.
> >>       
> >>       - "samsung,exynos5250-dw-mshc": for controllers with Samsung
> >>       Exynos5250
> >> 
> >> specific extensions.
> >> +     - "samsung,exynos5420-dw-mshc": for controllers with Samsung
> >> Exynos5420 +       specific extensions.
> >> 
> >>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card
> >> 
> >> interface unit (ciu) clock. This property is applicable only for
> >> Exynos5 SoC's and diff --git
> >> a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> b/arch/arm/boot/dts/exynos5420-smdk5420.dts index bafba25..6e65278
> >> 100644
> >> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> >> @@ -31,6 +31,44 @@
> >> 
> >>               };
> >>       
> >>       };
> >> 
> >> +     dwmmc0@12200000 {
> >> +             status = "okay";
> >> +             num-slots = <1>;
> > 
> > You don't have to specify this property if there is only one slot.
> > Also are you sure that this is a board specific property?
> 
> Yes,If num-slots property is not defined dw_mmc driver assumes 1 slot
> is available.
> I think yes,its a board specific property as number of card slots is
> board dependent.
> 
> >> +             broken-cd;
> >> +             bypass-smu;
> > 
> > This property doesn't seem to be documented nor used anywhere.
> 
> Sorry. I missed to add in binding document.Will add in next version.

Is there a patch adding support for this property to the driver?

> >> +             supports-highspeed;
> > 
> > Is it a board specific property?
> > 
> >> +             fifo-depth = <0x80>;
> > 
> > Ditto.
> 
> Ideally this can be move to SOC specific dts.But I am just following
> ,already merged smdk5250 board
> dts convensions.

This means that Exynos5250 board dts files need to be fixed as well.

> >> +             card-detect-delay = <200>;
> >> +             samsung,dw-mshc-ciu-div = <3>;
> >> +             samsung,dw-mshc-sdr-timing = <0 4>;
> >> +             samsung,dw-mshc-ddr-timing = <0 2>;
> > 
> > Are the above three properties really board-specific?

Hmm?

Best regards,
Tomasz
