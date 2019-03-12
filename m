From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add a new property
 disable-cqe-dcmd.
Date: Tue, 12 Mar 2019 18:10:56 +0100
Message-ID: <2038789.ZmMFo7ZELZ@diego>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
 <4793843.T1TZ7EF8k3@phil>
 <D7EF0176-0EBD-4401-83BE-E7F951F88CAA@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <D7EF0176-0EBD-4401-83BE-E7F951F88CAA@theobroma-systems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph =?ISO-8859-1?Q?M=FCllner?= <christoph.muellner@theobroma-systems.com>
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, Emil Renner Berthing <kernel@esmil.dk>, Viresh Kumar <viresh.kumar@linaro.org>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Tony Xie <tony.xie@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Randy Li <ayaka@soulik.info>, Vicente Bergas <vicencb@gmail.com>, robh+dt@kernel.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

Am Dienstag, 12. M=E4rz 2019, 15:46:44 CET schrieb Christoph M=FCllner:
> > On 12.03.2019, at 14:17, Heiko Stuebner <heiko@sntech.de> wrote:
> > =

> > Am Freitag, 8. M=E4rz 2019, 14:10:45 CET schrieb Christoph M=FCllner:
> >>> On 08.03.2019, at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrot=
e:
> >>> =

> >>> On 7/03/19 10:43 AM, Christoph Muellner wrote:
> >>>> This patch documents the new property disable-cqe-dcmd
> >>>> for the Arasan eMMC 5.1 driver.
> >>>> =

> >>>> Signed-off-by: Christoph Muellner
> >>>> <christoph.muellner@theobroma-systems.com> Signed-off-by: Philipp
> >>>> Tomsich <philipp.tomsich@theobroma-systems.com> ---
> >>>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
> >>>> 1 file changed, 4 insertions(+)
> >>>> =

> >>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >>>> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt index
> >>>> 1edbb049cccb..ec699bf98b7c 100644
> >>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >>>> =

> >>>> @@ -44,6 +44,10 @@ Optional Properties:
> >>>>    properly. Test mode can be used to force the controller to functi=
on.
> >>>>  =

> >>>>  - xlnx,int-clock-stable-broken: when present, the controller always
> >>>>  reports
> >>>>  =

> >>>>    that the internal clock is stable even when it is not.
> >>>> =

> >>>> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct comman=
ds
> >>>> (DCMDs) +    as part of the command queue engine (CQE). On controlle=
rs
> >>>> with a CQHCI, +    such as the Arasan eMMC 5.1 host controller, the
> >>>> driver has to enable DCMDs. +    This is done unless disable-cqe-dcmd
> >>>> is specified.
> > =

> > This needs a rewording please. See below for hw-description vs. driver,=
 so
> > the description should be centered around why this is a property of the=
 hw
> > [like faulty controller implementation or whatever]
> =

> I understand, that you prefer a HW-specific name for a property
> over one, that explains the actual effect.

Actually I think the property-name is just fine :-) .

The description might profit from a rewording though. Aka not driver-
centric but hw-centric, describing why some controllers may need the
option to disable these dcmds (controller bugs or whatever).


Heiko



> However, using disable-<feature> (which is always a directive for the dri=
ver
> and not a HW description) is not uncommon:
> =

> * disable-wp should be "no-wp-line-connection"
> * disable-over-current -> "no-over-current-line-connection"
> * srp-disable -> "not-existing-srp-implementation"
> * ...
> =

> But I don't mind using something else.
> Would "broken-cqe-dcmd" (like broken-cd or broken-flash-reset) be ok?
> Or other suggestions?
> =

> Also I'd like to mention, that my first implementation was
> "supports-cqe-dcmd". I guess that would be a good choice, if it would have
> been there
> from the beginning. Introducing it now, would silently disable DCMD
> for existing DTBs. Therefore I went on to "disable-cqe-dcmd".
> =

> >>> If "supports-cqe" is in mmc.txt, should "disable-cqe-dcmd" be there
> >>> also?
> >> =

> >> The file mmc.txt says on top:
> >> "These properties are common to multiple MMC host controllers".
> >> As my patchset introduces "disable-cqe-dcmd" just for sdhci-of-arasan,
> >> I would say it should not go into that file.
> >> =

> >> Also I wonder why "supports-cqe" is in mmc.txt, because
> >> only sdhci-tegra.c is evaluating that property.
> >> So I would expect it to be documented in
> >> Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> >> =

> >> However, I see that "disable-cqe-dcmd" could go into other drivers as
> >> well.
> >> But is this enough to document it in mmc.txt?
> > =

> > Devicetree is always about describing the hardware capabilites and never
> > about the actual nitty-gritty of driver implementation, aka it is not
> > meant
> > as a space for hardware-independent config-settings or such.
> > =

> > As for only tegra evaluating this, is probably because it is still so n=
ew,
> > like january 2019 and Rob explicitly suggested it becoming common [0],
> > which suggests that the disable-cqe-dcmds should probably also be commo=
n.
> So mmc.txt lists "standardised" names for properties to reduce the risk
> of having similar, but distinct names for different MMC drivers.
> So whenever you want to introduce a new property for a driver,
> check if there isn't already something defined in mmc.txt.
> =

> When seeing it this way, it clearly makes sense to have the property ther=
e.
> =

> Thanks,
> Christoph
