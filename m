From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: Add CMD23 capability to omap_hsmmc driver
Date: Tue, 8 Aug 2017 12:37:25 +0200
Message-ID: <CAPDyKFo7dyYFTBtwshqk7p46jUMr_2J55iC=NVi6-a0r2G_bcw@mail.gmail.com>
References: <20170808051815.24219-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808051815.24219-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 August 2017 at 07:18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> omap_hsmmc driver always relied on CMD12 to stop transmission.
> However if CMD12 is not issued at the correct timing, the card will
> indicate a out of range error. With certain cards in some of the
> DRA7 based boards, -EIO error is observed. By Adding CMD23 capability,
> the MMC core will send MMC_SET_BLOCK_COUNT command before
> MMC_READ_MULTIPLE_BLOCK/MMC_WRITE_MULTIPLE_BLOCK commands.
>
> commit a04e6bae9e6f12 ("mmc: core: check also R1 response for
> stop commands") exposed this bug in omap_hsmmc driver.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 04ff3c97a535..2ab4788d021f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2086,7 +2086,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         mmc->max_seg_size = mmc->max_req_size;
>
>         mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> -                    MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
> +                    MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE | MMC_CAP_CMD23;
>
>         mmc->caps |= mmc_pdata(host)->caps;
>         if (mmc->caps & MMC_CAP_8_BIT_DATA)
> --
> 2.11.0
>
