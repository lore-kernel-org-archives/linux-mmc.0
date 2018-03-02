From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in /proc/partitions
Date: Fri, 2 Mar 2018 13:53:14 +0100
Message-ID: <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 27, 2018 at 12:33 PM, Harish Jenny K N
<harish_kandiga@mentor.com> wrote:

> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>
> Since RPMB area is accessible via special ioctl only and boot areas
> are unlikely to contain any partitions, exclude them all from listing
> in /proc/partitions. This will hide them from various user-level
> software (e.g. fdisk), thus avoiding unnecessary access attempts.
>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>

Makes sense to me, at least it makes the problem smaller not bigger.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> The main intention of the patch was to not have RPMB device in /proc/partitions.
> Boot partitions are also unlikely to have any partitioning, so it made sense to
> treat them the same way as RPMB and not list in /proc/partitions.
> Now I see that RPMB is converted to a character device and this change
> may not be required for RPMB.

It certainly does not hurt, even if this code path is not called
for the RPMB partition anymore (luckily).

On a general note, I do not feel the work with boot partitions or
the general purpose partitions is finished.

In a lecture I pointed out that:

dd if=/dev/sda of=sda.img

Gives an image of the whole device, and you can restore the
device by doing the inverse of that command.

For MMC devices,

dd if=/dev/mmcblk0 of=mmcblk0.img

does NOT have the same nice property. Instead, since the
special partitions are their own devices and not part of the main
device, they have to be backed up separately.

IMO this breaks the user contract of how a device vs a partition
works.

What we need to do is make the "special partitions" part of the
main block device and stop spawning these special block
devices for each boot partions or general partitions. In addition,
each of these boot partitions or general partitions will get their
own block queue and state container which is not cheap in
runtime memory footprint terms.

So what I want to do (unless someone beats me to it) it to come
up with some way making boot and general partitions part
of the main block device. Possibly the core kernel partitioning
code needs to be augmented. The tentative idea is to just
put the sectors representing these partitions after the main
block device and access them from there, with an offset.

That job isn't entirely trivial though.

Yours,
Linus Walleij
