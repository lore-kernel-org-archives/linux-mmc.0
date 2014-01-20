From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 19:58:57 +0100
Message-ID: <201401201958.57997.arnd@arndb.de>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1390190215-22700-2-git-send-email-olof@lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, linux-mmc@vger.kernel.org, chris@printf.net, robh+dt@kernel.org, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

On Monday 20 January 2014, Olof Johansson wrote:
> 
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card

I wonder whether the reset line should use the generic reset controller binding
rather than the gpio binding. There has been a recent discussion about a
gpio-reset driver, which should generalize this at the reset level, and
it would make it possible to use reset controllers that are not gpio driven.
In general, any gpio can be used as a reset, but not every reset line can
be a gpio. I don't know whether anyone would use an internal reset-controller
for an external SDIO chip though, so maybe your approach is sufficient.

	Arnd
