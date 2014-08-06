From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 1/2] mmc: read mmc alias from device tree
Date: Wed, 6 Aug 2014 12:43:10 -0700
Message-ID: <CAD=FV=WjfHC_yR=1QrTWz+K5zv02c4sixngfsy8sX5zhDd0ppw@mail.gmail.com>
References: <cover.1396384101.git.stefan@agner.ch>
	<5570bdf5ebb3aaae5a376634ecfbac9c2fd7b9f4.1396384101.git.stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5570bdf5ebb3aaae5a376634ecfbac9c2fd7b9f4.1396384101.git.stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stefan-XLVq0VzYD2Y@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Stefan,

On Tue, Apr 1, 2014 at 1:35 PM,  <stefan-XLVq0VzYD2Y@public.gmane.org> wrote:
> From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
>
> To get the SD/MMC host device ID, read the alias from the device
> tree.
>
> This is useful in case a SoC has multipe SD/MMC host controllers while
> the second controller should logically be the first device (e.g. if
> the second controller is connected to an internal eMMC). Combined
> with block device numbering using MMC/SD host device ID, this
> results in predictable name assignment of the internal eMMC block
> device.
>
> Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>

Yes, please.  It is very handy to have mmc devices be enumerated in a
predictable way.

Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
