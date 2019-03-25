From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: Add DTS property to disable DCMDs.
Date: Mon, 25 Mar 2019 14:54:16 +0100
Message-ID: <CAPDyKFrPBY14bvG7ZLON2xTTWEc2a1JjLdeDSkGmtdAZy5hokQ@mail.gmail.com>
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
 <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
 <CAPDyKFrDq-zBsqqe23hj4ynfYnrGxAr0tWxvYEJu8Kvh0i=h9A@mail.gmail.com> <2D2515D6-1E11-4EA3-B016-EC37A9E3091D@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2D2515D6-1E11-4EA3-B016-EC37A9E3091D@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@theobroma-systems.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>, Douglas Anderson <dianders@chromium.org>, Tony Xie <tony.xie@rock-chips.com>, Randy Li <ayaka@soulik.info>, Vicente Bergas <vicencb@gmail.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux
List-Id: linux-mmc@vger.kernel.org

On Mon, 25 Mar 2019 at 14:39, Christoph M=C3=BCllner
<christoph.muellner@theobroma-systems.com> wrote:
>
>
> > On 25.03.2019, at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
> > <christoph.muellner@theobroma-systems.com> wrote:
> >>
> >> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> >> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> >> which exposes a control register bit to enable the feature.
> >> The current implementation sets this bit unconditionally.
> >>
> >> This patch allows to suppress the feature activation,
> >> by specifying the property disable-cqe-dcmd.
> >>
> >> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-system=
s.com>
> >> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Applied for next, thanks!
> >
> > Perhaps both patch1 and patch2 should be tagged for stable? Then
> > please tell me and I can add a tag.
>
> Hi Ulf,
>
> yes tagging for stable would be nice.
> I guess, the following would fit:
>
> Fixes: 84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,=
sdhci-5.1")
>

Great, I have added that to both of the commits and a stable tag. Thanks!

[...]

Kind regards
Uffe
