From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
Date: Mon, 30 Apr 2018 11:13:45 +0200
Message-ID: <CACRpkdbzvnSHPQOZjs3WcL9pOMz3R0W9P9Gre5n_G40udTMUjQ@mail.gmail.com>
References: <20180422213126.32756-1-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180422213126.32756-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanho Min <chanho.min@lge.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Apr 22, 2018 at 11:31 PM, Lukasz Majewski <lukma@denx.de> wrote:

> From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
>
> On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
> that the imx53 rom boot code is unable to probe, resulting in
> reboot hanging. Add a device tree property to disable sleeping
> on suspend.
>
> For TQMa53 modules the exact commit to cause hang after reboot
> (v3.10 -> v3.11):
> commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC bus_ops")
>
> [The exact discussion can be found here:
> https://patchwork.kernel.org/patch/8881401/
> "i.MX53 restart via watchdog does not work"
>
> Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
(...)

>  Optional properties:
>  -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
>                implementation, and that hpi should not be used
> +-no-sleep-on-suspend : Do not put the card to sleep when suspending.
> +              There are boards with bootloaders that are unable
> +              to probe such card when rebooting.

As far as I understand this problem is not coming from the host
controller itself,
so it should not be tagged on to the host controller either. Rather the problem
is how the specific system has integrated the host controller, the problem is
in the fixture of this specific machine, as you say, in the i.MX53 ROM.

In that case, I would say use this:

if (of_machine_is_compatible("fsl,imx53")) {
   ..activate quirk...
}

Yours,
Linus Walleij
