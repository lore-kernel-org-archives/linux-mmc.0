From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Allow the usage of mmc aliases
Date: Mon, 23 Sep 2013 15:27:12 -0600
Message-ID: <5240B230.6000605@wwwdotorg.org>
References: <1379903897-16019-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379903897-16019-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 09/22/2013 08:38 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> On embedded devices, there is often a combination of removable mmc
> devices (e.g. MMC/SD cards) and hard wired ones (e.g. eMMC).
> Depending on the hardware configuration, the 'mmcblkN' node might
> change if the removable device is available or not at boot time.
> 
> E.g. if the removable device is attached at boot time, it might
> become mmxblk0. And the hard wired one mmcblk1. But if the removable
> device isn't there at boot time, the hard wired one will become
> mmcblk0. This makes it somehow difficult to hard code the root device
> to the non-removable device and boot fast.
> 
> Allow the sdhci-esdhc-imx driver to retrieve the mmc aliases, so that we can 
> map via the device tree which mmcblk corresponds to the rootfs.

> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c

> -	devidx = find_first_zero_bit(dev_use, max_devices);
> +	devidx = find_next_zero_bit(dev_use, max_devices, card->host->devidx);

I'm not sure if this works; what if the SD card gets detected/removed
without recycling the device name/ID a few times before the fixed eMMC
is detected?

So, in the perfect case this will achieve what you want, but not in some
unusual cases. So I don't think it's a good idea to rely on this.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
