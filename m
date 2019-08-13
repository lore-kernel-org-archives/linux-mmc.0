From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Date: Tue, 13 Aug 2019 08:53:06 +0200
Message-ID: <20190813065306.tqz57hqeiofofbnz@M43218.corp.atmel.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
 <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
 <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
 <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com
Cc: adrian.hunter@intel.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 12, 2019 at 03:38:34PM +0000, Eugen.Hristev@microchip.com wrote:
> On 09.08.2019 09:23, Ludovic Desroches wrote:
> > On Thu, Aug 08, 2019 at 03:57:30PM +0300, Adrian Hunter wrote:
> >> On 8/08/19 3:42 PM, Ludovic Desroches wrote:
> >>> On Thu, Aug 08, 2019 at 10:35:43AM +0200, Eugen Hristev - M18282 wrote:
> >>>> From: Eugen Hristev <eugen.hristev@microchip.com>
> >>>>
> >>>> Add mmc capabilities for SDMMC0 for this board.
> >>>> With this enabled, eMMC connected card is detected as:
> >>>>
> >>>> mmc0: new DDR MMC card at address 0001
> >>>>
> >>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> >>>
> >>> I am interested to have the some insights about the use of sd-uhs-*
> >>> properties.
> >>>
> >>> Our IP can't deal with 1V8 by itself. It has a 1V8SEL signal which can
> >>> be used as the logic control input of a mux. So even if the IP claims
> >>> to support UHS modes, it depends on the board.
> >>>
> >>> Are the sd-uhs-* properties a way to deal with this? I tend to think no
> >>> as sdhci_setup_host() will set the caps depending on the content of the
> >>> capabilities register. Do we have to use the SDHCI_QUIRK_MISSING_CAPS
> >>> quirk or sdhci-caps/sdhci-caps-mask?
> >>
> >> There is "no-1-8-v" which it looks like sdhci-of-at91.c already supports:
> >>
> >>    sdhci_at91_probe() -> sdhci_get_of_property() -> sdhci_get_property()
> >>
> >>      	if (device_property_present(dev, "no-1-8-v"))
> >> 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> >>
> > 
> > Right, I forgot this property. Thanks.
> > 
> > Eugen, do you see cases we can't cover with this property?
> 
> Hi,
> 
> For current requirements and driver support, this should be enough.
> 
> I noticed one thing regarding SD-Cards, if I add property sd-uhs-sdr104 
> the class 10 uhs1 cards are detected as SDR104 . Without this property 
> they are detected as DDR50. Any idea why the difference ? The controller 
> does not claim to have SDR104 support ?  We should add it ?

With the mainline, our tree or both? In our tree, SDR104 is removed from
the capabilities.

Ludovic
