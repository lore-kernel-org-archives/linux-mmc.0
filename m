From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 28 Jan 2014 11:48:10 +0100
Message-ID: <201401281148.10670.arnd@arndb.de>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <52E700F0.7040708@gmail.com>
 <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 28 January 2014, Ulf Hansson wrote:
> On 28 January 2014 01:59, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > On 27.01.2014 11:19, Ulf Hansson wrote:
> >> There is already a host capability that I think we could use to handle
> >> this. MMC_CAP_NONREMOVABLE, the corresponding DT binding string is
> >> "non-removable", and it may be set per host device.
> >>
> >> Using this cap means the mmc_rescan process that runs to detect new
> >> cards, will only be executed once and during boot. So, we need to make
> >> sure all resources and powers are provided to the card at this point.
> >> Otherwise the card will not be detected.
> >
> > I don't quite like this requirement, especially if you consider
> > multi-platform kernels where a lot of drivers is going to be provided as
> > modules. WLAN drivers are especially good candidates. This means that even
> > if the card is powered off at boot-up, if user (or init system) loads
> > appropriate module, which powers the chip on, MMC core must be able to
> > notice this.
> 
> To be able to detect the card, the WLAN driver doesn't have to be
> probed, only the "power controller" driver. I suppose this is were it
> becomes a bit tricky.
> 
> Somehow the mmc core needs to be involved in the probe process of the
> power controller driver. Could perhaps the power controller bus be
> located in the mmc core and thus the power controller driver needs to
> register itself by using a new API from the mmc core? Similar how SDIO
> func driver's register themselves.

I think there is another option, which does have its own pros and cons:
We could move all the power handling back into the sdio function driver
if we allow a secondary detection path using DT rather than the probing
of the SDIO bus. Essentially you'd have to list the class/vendor/device
ID for each function that cannot be autodetected in DT, and have the
SDIO core pretend that it found the device just by looking at the
device nodes, and register the struct sdio_func so it can be bound to
the driver. The driver then does all the power handling in a device
specific way. At some point the hardware gets registered at the 
mmc host, and the sdio core connects the bus state to the already present
sdio_func, possibly notifying the function driver that it has become
usable.

Obviously, this can only work for CAP_NONREMOVABLE devices, but those
are exactly the ones we are worried about here. The advantage is that
the power sequencing for a particular device can then be in device
specific code and can have an arbitrarily complex in the driver without
needing the mmc code to handle all possible corner cases.

	Arnd
