From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 1/2] mmc: read mmc alias from device tree
Date: Fri, 13 Mar 2015 13:08:55 -0700
Message-ID: <CAD=FV=VF55LhuALjRSGT7KuzEACnAM0A6ThuPjXBkxEcyWij5A@mail.gmail.com>
References: <cover.1396384101.git.stefan@agner.ch>
	<5570bdf5ebb3aaae5a376634ecfbac9c2fd7b9f4.1396384101.git.stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5570bdf5ebb3aaae5a376634ecfbac9c2fd7b9f4.1396384101.git.stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stefan-XLVq0VzYD2Y@public.gmane.org
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

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
> ---
>  drivers/mmc/core/host.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 49bc403..29f44cf 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -448,8 +448,8 @@ EXPORT_SYMBOL(mmc_of_parse);
>   */
>  struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  {
> -       int err;
>         struct mmc_host *host;
> +       int of_id = -1, id = -1;
>
>         host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
>         if (!host)
> @@ -459,12 +459,26 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         host->rescan_disable = 1;
>         idr_preload(GFP_KERNEL);
>         spin_lock(&mmc_host_lock);
> -       err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
> -       if (err >= 0)
> -               host->index = err;
> +
> +       if (dev->of_node)
> +               of_id = of_alias_get_id(dev->of_node, "mmc");

Not that there's much chance of such an old patch landing, but just in
case anyone finds this Dmitry points out that this causes a
"scheduling while atomic".  A fix is to move the "of_alias_get_id" up
above the spin_lock():

https://chromium-review.googlesource.com/#/c/259916/

-Doug
