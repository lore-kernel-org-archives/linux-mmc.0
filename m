From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
	interaction
Date: Tue, 21 Feb 2012 11:06:18 +0000
Message-ID: <20120221110618.GJ22562@n2100.arm.linux.org.uk>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com> <20120220073941.GC22562@n2100.arm.linux.org.uk> <CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Randy Dunlap <rdunlap@xenotime.net>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 21, 2012 at 11:41:31AM +0100, Linus Walleij wrote:
> I remember this case very well and we designed for it, so it should
> be handled by pin control and GPIO thusly:
> 
> Example: use pins 1,2 as I2C, then convert them to GPIO for a while
> then back again:
> 
> // This call looks up a map containing pins 1,2 and reserve them
> p = pinctrl_get(dev, "i2c");
> if (IS_ERR(p))
>   ...
> pinctrl_enable(p);
> pinctrl_disable(p);
> // This will free up the pins again
> pinctrl_put(p);
> // So now we can do this...
> // NB: the GPIO driver calls pinctr_request_gpio() to check
> // that it can take these pins
> gpio_request(1, "gpio1"):
> gpio_request(2, "gpio2");
> // This will trigger a reset or something
> gpio_direction_output(1, 1);
> gpio_direction_output(2, 1);
> // Release pins again
> gpio_free(1);
> gpio_free(2);
> // Take them back for this function
> p = pinctrl_get(dev, "i2c");
> 
> It's a bit kludgy but works and makes sure the pins are only used
> for one thing at a time.

No.  The case which I'm thinking of is for the Assabet audio, where
we have the following situation.

We have the SSP bus [TXD,RXD,SFRM,SCLK] which is handled by the SSP core.
This is connected through a FPGA to a UDA1341 codec.  The UDA1341 codec
has DI,DO,WS,BCLK signals.  WS (which is effectively the LRCK and therefore
identifies the left and right channels) is connected through a flip-flop
in the FPGA which toggles at every SFRM pulse.

WS is held high for the left sample.  This is the default setting.
Unfortunately, some FPGA builds out there do not tristate the WS output
when the codec is powered off.

This leads to a high leakage current from the FPGA, into the UDA1341 codec
and into other devices.

The solution is to wait for SSP to finish, and while SSP is still enabled,
switch the pins from the SSP block to the GPIO block and toggle the SFRM
signal to flip the WS output before removing power.  When starting up,
with the pins under control of GPIO, power up and them toggle hte SFRM
signal to restore the WS state before giving it back to the SSP block.

However, here's the thing: SSP must be enabled at the point in time when
the pins are given or taken away from it, otherwise SFRM is indeterminant.
We can't allow gpio_request() to fail at the points where we toggle this
pin - failure is not really an option where causing hardware stress is
involved.  We can't allow the GPIO block to have the state of these pins
change state while the pins are given back to the GPIO block before the
GPIOs have been requested (glitches on the SFRM line will cause the state
of the FIFO to change.)

Another case where this kind of run-time switching needs to occur is the
PXA IrDA driver, where the pins need to be switched between their FIR and
SIR modes.
