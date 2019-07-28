From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Sun, 28 Jul 2019 13:22:06 +0200
Message-ID: <319549e0-23b5-4a49-49ae-723da754f984@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <mbrugger@suse.com>, Scott Branden <sbranden@broadcom.com>, linux-gpio@vger.kernel.org, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Linus,
hi Michael,
hi Stephen,

Am 22.07.19 um 07:54 schrieb Stefan Wahren:
> This series adds minimal support for the new Raspberry Pi 4, so we are abl=
> e
> to login via debug UART.
>
> Patch 1-5:   Prepare platform and DTS for the new SoC BMC2711
> Patch 6-10:  Enable support for emmc2 on BCM2711
> Patch 11-12: Enable pinctrl for BCM2711
> Patch 13-17: Add Raspberry Pi 4 DTS support
> Patch 18:    Update MAINTAINERS
>
any comments on the clk / pinctrl parts or do you just wait for Rob's Ack?

Sorry to bother you, but i want to send a new version before my holidays.
