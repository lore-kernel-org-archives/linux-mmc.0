From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
Date: Tue, 24 Jan 2012 22:23:11 +0100
Message-ID: <4F1F213F.9070106@stericsson.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk> <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk> <20120124160044.GM19798@mudshark.cambridge.arm.com> <20120124162328.GA8517@n2100.arm.linux.org.uk> <20120124172600.GO19798@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120124172600.GO19798@mudshark.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

On 01/24/2012 06:26 PM, Will Deacon wrote:
>
> Right. I took a quick look at the TRM for the PB1176, and I think we do have
> an interrupt for GPIO0, it's just on the other GIC. This patch should do the
> trick, but I'm not sure what I can do to tickle the GPIO stuff anyway:

For a simple test just insert/remove the MMC card and see it
add/remove the card (appear in console, and /proc/interrupts)

Or do you mean tickle GPIO0? That is more tricky I think...

Yours,
Linus Walleij
