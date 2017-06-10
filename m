From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-overo: Remove "vqmmc-supply" property
 from MMC dt node
Date: Sat, 10 Jun 2017 01:44:27 -0700
Message-ID: <20170610084426.GM3730@atomide.com>
References: <20170609084141.15582-1-kishon@ti.com>
 <CAPDyKFrZvnCPWUxDeewB=BTQPvuMnJ5tUg7CN=VK5=v+e+du4Q@mail.gmail.com>
 <275a0313-2cda-2328-e9e1-32bc91aca701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <275a0313-2cda-2328-e9e1-32bc91aca701@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170609 04:05]:
> Hi,
> 
> On Friday 09 June 2017 04:07 PM, Ulf Hansson wrote:
> > On 9 June 2017 at 10:41, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> commit 94647a30124e2c7 ("ARM: dts: omap3-overo: Enable WiFi/BT combo")
> >> while enabling WiFi/BT combo added regulator to trigger the nReset
> >> signal of the Bluetooth module in vqmmc-supply. However BT should be
> >> handled by UART. Moreover "vqmmc" is not a defined binding for
> >> omap_hsmmc. While "vqmmc" in mmc2 hasn't caused any issues so far,
> >> mmc2 will start to mis-behave once omap_hsmmc defines "vqmmc"
> >> binding.
> >>
> >> Remove "vqmmc-supply" property in mmc2 here.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > Okay, so I assume I also need to carry this in my immutable branch for
> > the omap driver changes. More precisely before the driver changes?
> 
> yeah, that's right!

As far as I can tell this regulator won't do anything right now so:

Acked-by: Tony Lindgren <tony@atomide.com>
