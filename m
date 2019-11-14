From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
Date: Thu, 14 Nov 2019 13:53:27 +0100
Message-ID: <CAPDyKFpA6iYmTVt84CDics2pWdSnjwQhgW31aaH8sdDtXgyAnQ@mail.gmail.com>
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@denx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 8 Nov 2019 at 17:09, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 66e354d51ee9..74c6cfbf9172 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1421,7 +1421,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * Index 0 is card detect
>          * Old boardfiles were specifying 1 ms as debounce
>          */
> -       status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1, NULL);
> +       status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000, NULL);
>         if (status == -EPROBE_DEFER)
>                 goto fail_add_host;
>         if (!status) {
> --
> 2.23.0
>
