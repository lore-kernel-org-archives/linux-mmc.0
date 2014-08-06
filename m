From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 2/2] mmc: use SD/MMC host ID for block device name ID
Date: Wed, 6 Aug 2014 12:50:31 -0700
Message-ID: <CAD=FV=Va=V4xGqQM9kMFFdQDyYNWDEh_cXJW=b3iYGRrJiH9DQ@mail.gmail.com>
References: <cover.1396384101.git.stefan@agner.ch>
	<2f6ac51155f9d34791b274b5102d15a997ff8b99.1396384101.git.stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2f6ac51155f9d34791b274b5102d15a997ff8b99.1396384101.git.stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stefan-XLVq0VzYD2Y@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Stefan,

On Tue, Apr 1, 2014 at 1:35 PM,  <stefan-XLVq0VzYD2Y@public.gmane.org> wrote:
> From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
>
> By using the SD/MMC host device ID as a starting point for block
> device numbering, one can reliably predict the first block device
> name (at least for the first controller). This is especially useful
> for SoCs with multiple SD/MMC host controller, where the controller
> with index 0 is connected to a eMMC device.
>
> Usually the first controller gets the first block device name ID,
> however this is not guaranteed. Also if the first controller is
> aliased as second controller and visa-versa (using device tree
> aliases), the block device name ID assignation is not ordered by
> the SD/MMC host device ID (since mmc_rescan is called in order of
> the memory mapped pheripherial addresses).
>
> Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
> ---
>  drivers/mmc/card/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

As Stephen points out, "mmcblk" IDs for SD cards are not actually
guaranteed.  Also UUID is a better API for things to use.

That being said, your patch helps me a lot when doing development.  As
you said, I'm guaranteed that if eMMC is no-removable and enumerated
at boot that it will be a predictable ID and I can use it in my
scripts.  Also this helps keep me from having to do lots of extra
thinking to figure out whether I happened to have an SD card plugged
in at boot or I didn't.

I'd love to see this land.

Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
