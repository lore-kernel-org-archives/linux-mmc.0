From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Fri, 6 May 2016 13:44:59 +0800
Message-ID: <20160506054459.GA32359@shlinux2.ap.freescale.net>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160505224240.GA31429@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, hverkuil@xs4all.nl, tjakobi@math.uni-bielefeld.de, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Thu, May 05, 2016 at 05:42:40PM -0500, Rob Herring wrote:
> On Thu, May 05, 2016 at 02:34:13PM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > This is a different, second try to fix usb3503+lan on Odroid U3 board
> > if it was initialized by bootloader (e.g. for TFTP boot).
> > 
> > First version:
> > http://www.spinics.net/lists/linux-usb/msg140042.html
> > 
> > 
> > Problem
> > =======
> > When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
> > the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
> > is required, e.g. by suspend to RAM. The actual TFTP boot does
> > not have to happen. Just "usb start" from U-Boot is sufficient.
> > 
> > From the schematics, the regulator is a supply only to LAN, however
> > without toggling it off/on, the usb3503 hub won appear neither.
> > 
> > 
> > Solution
> > ========
> > This is very similar to the MMC pwrseq behavior so the idea is to:
> > 1. Move MMC pwrseq drivers to generic place,
> 
> You can do that, but I'm going to NAK any use of pwrseq bindings outside 
> of MMC. I think it is the wrong way to do things. The DT should describe 
> the devices. If they happen to be "simple" then the core can walk the 
> tree and do any setup. For example, look for "reset-gpios" and toggle 
> that GPIO. There is no need for a special node.
> 

Oh, I am doing the same thing like this patch set doing. Then, how can
we let things be generic like you mention at [1] if without common
pwrseq driver/library? The properties like "reset-gpios" under
USB child node seems can only be handled by USB driver.

> > 2. Extend the pwrseq-simple with regulator toggling,
> > 3. Add support to USB hub and port core for pwrseq,
> 
> We discussed this for USB already[1] and is why we defined how to add 
> USB child devices. The idea is not to add pwrseq to that.
> 
> Rob
> 
> [1] http://www.spinics.net/lists/linux-usb/msg134082.html

[1] http://www.spinics.net/lists/linux-usb/msg137312.html

-- 

Best Regards,
Peter Chen
