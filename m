From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Thu, 10 Sep 2015 13:45:13 -0700
Message-ID: <20150910204512.GJ4215@atomide.com>
References: <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
 <20150828190354.GZ4215@atomide.com>
 <55E3E9B1.8070908@ti.com>
 <20150831205829.GB4215@atomide.com>
 <20150831211450.GC4215@atomide.com>
 <55E5B730.9020409@ti.com>
 <20150901145002.GE4215@atomide.com>
 <55E5BC11.8090002@ti.com>
 <20150901150336.GF4215@atomide.com>
 <CAMAWPa-uf80P8026UH7kJsmzVO2K76HpuzRgpn9TadZS+12f5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMAWPa-uf80P8026UH7kJsmzVO2K76HpuzRgpn9TadZS+12f5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-mmc@vger.kernel.org

* Kevin Hilman <khilman@kernel.org> [150910 10:03]:
> On Tue, Sep 1, 2015 at 8:03 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [150901 07:57]:
> >> On 09/01/2015 05:50 PM, Tony Lindgren wrote:
> >> >>
> >> >>On -next, Above crash signature could be related to race
> >> >>"ARM: OMAP2+: omap-device: fix race deferred probe of omap_hsmmc vs omap_device_late_init"
> >> >>http://www.spinics.net/lists/linux-omap/msg121622.html
> >> >
> >> >Good point thanks, yes that's the case. MMC probing fails and then we hit this
> >> >separate issue while MMC is trying to probe. Applying your fix makes the
> >> >abort disappear, but naturally does not get MMC working again.
> >>
> >> you may need CONFIG_GPIO_PCF857X=y for dra7-evm
> >
> > This is a regression at least on omap4 as pointed out by Olof.
> 
> FWIW, this problem still exists in mainline[1], and note that it fails
> for omap2plus_defconfig which already has CONFIG_REGULATOR_PBIAS=y, so
> that is not the fix for this issue.

There are also the pbias regulator fixes pending.. And the .dts
fixes pending.. So looks like it's going to be few more days.

AFAIK, also the multi_v7_defconfig change is needed..

Regards,

Tony
 
> [1] http://kernelci.org/boot/omap4-panda-es/?mainline&omap2plus_defconfig&lab-khilman
