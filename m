From: Rask Ingemann Lambertsen <rask@formelder.dk>
Subject: Dropping device tree pinmux nodes for GPIO usage (Was: [PATCH 3/5]
 arm64: dts: sun50i: add MMC nodes)
Date: Sun, 15 Jan 2017 16:59:32 +0100
Message-ID: <20170115155931.l5tjcdhbz6sj3wke@localhost>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
 <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Andre Przywara <andre.przywara@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans De Goede <hdegoede@redhat.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 03, 2017 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > +
> > +                       mmc0_default_cd_pin: mmc0_cd_pin@0 {
> > +                               pins = "PF6";
> > +                               function = "gpio_in";
> > +                               bias-pull-up;
> > +                       };
> 
> We are starting to drop pinmux nodes for gpio usage.

How do we get the equivalent of bias-pull-up/down and drive-strength if we
run across a pin that needs it?

-- 
Rask Ingemann Lambertsen
