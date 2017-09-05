From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 5 Sep 2017 14:22:55 +0530
Message-ID: <06199a7e-456d-708d-6f2f-81f6bbfea2ba@ti.com>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
 <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
 <CAPDyKFqCZFM7UmHyQCm=DwwZXJvzUde3pW0HqARKrsgfgxSuaw@mail.gmail.com>
 <0c7e0705-d9c2-4499-54ba-cbd84589dc01@ti.com>
 <20170829115050.3axlr5uysmqlhvd2@earth> <20170829135822.GR6008@atomide.com>
 <20170829170920.xpgk5ywlvfgrtbqi@rob-hp-laptop>
 <20170829173913.GD6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829173913.GD6008@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ravikumar Kattekola <rk@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tuesday 29 August 2017 11:09 PM, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [170829 10:09]:
>> On Tue, Aug 29, 2017 at 06:58:23AM -0700, Tony Lindgren wrote:
>>> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170829 04:51]:
>>>> I would expect the conversion to look like the one done for UART,
>>>> see CONFIG_SERIAL_OMAP vs CONFIG_SERIAL_8250_OMAP. Both use the
>>>> same compatible value and you can choose using kernel configuration.
>>>
>>> That does not work unfortunately :( We are now stuck in a situation
>>> where two drivers are attempting to probe with the same compatible
>>> and we can't enable 8250_OMAP because of the user space breakage
>>> with the device names. And I'm actuallly thinking we should add a
>>> new compatible for 8250-omap to be able to start enabling it one
>>> board at a time.
>>
>> Is that the only problem? Presumably, the SD driver doesn't have a 
>> userspace facing issue.
> 
> No userspace issue with the sdhci-omap. But the sdhci-omap driver
> still has the issue of trying enable it for everything at once and
> expect everything to work. The sdhci-omap driver can already be
> used for boards that don't need power management for example, but
> will break things for devices running on batteries.
> 
>>> It's best to enable devices to use the new compatible as things are
>>> tested rather than hope for some magic "flag day" flip that might
>>> never happen. Having two days attempting to probe with the same
>>> binding just won't work.
>>
>> Aren't you just picking whether the flag day is in DT or the kernel? I 
>> guess you're assuming one kernel build and it would be switching all 
>> boards at one. 
> 
> Right, this would be risky and would take unnecessarily long
> to use the new driver on boards that can already use it. While
> power management won't work yet, I'd expect the sdhci-omap be
> faster on SoCs that can do ADMA.
> 
>>> So yeah, I agree with Kishon that we should stick with generic
>>> and sdhci bindings. And then we can start already using it for
>>> boards that can use it, then eventually when we're ready, start
>>> parsing also the legacy bindings and maybe drop the old driver.
>>
>> I assume there are some other common properties you would switch to in 
>> the transition?  You could make the legacy driver bail from probe based 
>> on presence or absence of other properties. Or you could just blacklist 
>> converted platforms in the legacy driver. The point is that the problems 
>> are solvable in the kernel.
> 
> Yes this could be done too. But let's enable it on per-board
> basis rather than attempt to flip it on at once.
> 
>> But if your really want a new compatible, I don't really care. It's 
>> only one device.
> 
> Both a new compatible or a check for some resource work just fine
> for me as long as the driver can be selected on per-board basis.

New compatible sounds simpler to me since it allows to select a driver per-MMC
instance. (SDIO support is not added/validated in sdhci-omap).

To summarize, we'll create new compatible and new bindings for sdhci-omap and
start enabling sdhci-omap on per-board basis. When all the TI platforms starts
to use sdhci-omap, omap-hsmmc will be removed at which point support for old
compatible and old dt bindings will be added to sdhci-omap.c. Does this sound
reasonable?

Thanks
Kishon
