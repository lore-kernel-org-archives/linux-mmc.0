From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 15 Mar 2019 16:23:26 -0700
Message-ID: <CAD=FV=XLuPWKjQBMLApRQxk0K30p_TPcztB7g_1DB7iRA9BGRQ@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com> <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 4:00 PM Marek Vasut <marex@denx.de> wrote:
>
> > Completely agree here - we need a dt solution that allows us to
> > specify ordering.
>
> Nope, ordering would be a policy and does not describe hardware, thus it
> shouldn't be in the DT. Use UUID or PARTUUID, they apply both to raw FS
> (fsuuid) and to partitions (part uuid). Linux kernel can mount FS using
> PARTUUID, to support UUID you need initramfs.

Two thoughts about that:

1. Some amount of policy is allowed in device tree.  At some point in
time there was a big discussion about the need for a separate "config
tree" that was totally parallel to the device tree so we could put
policy stuff in that.  Nobody wanted that and (as I recall) it was
agreed that in some cases policy could go there if that policy
expressed policy that was the generic intent of how the board ought to
be run.  I believe this is how things like the assigned-clocks is
justified.

2. In some cases this number does describe the hardware.  You look at
the hardware reference manual and see that there are 3 MMC
controllers: 0, 1, and 2.  In such cases it seems like it's an OK
description of the hardware to encode this info into the DTS.

...from what I recall, one big objection is for SoCs that didn't just
have numbers for their controllers.  AKA I think some SoCs might call
their controllers the "eMMC" controller, the "SD" controller, and the
"SDIO" controller.  They may be nearly the same hardware, but perhaps
the SoC allows for a GPIO interrupt on the SDIO controller and perhaps
the eMMC controller exposes the strobe line or has an 8-bit wide
datapath.  In this case making up numbers does become a bit more
arbitrary and folks didn't like it.

IIRC there was general consensus that it'd be OK to somehow specify a
string (AKA non-numeric) name for different SD controllers.  I don't
have pointers to that conversation offhand and it's possible I
imagined it.


-Doug
