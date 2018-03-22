From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: Export host capabilities to debugfs.
Date: Thu, 22 Mar 2018 11:19:45 +0100
Message-ID: <CAPDyKFotmS3ZxTCaYxuu7c-_KiLfNfz2GQMzmZn8JSOeSbgrbg@mail.gmail.com>
References: <1520257159-27699-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520257159-27699-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On 5 March 2018 at 14:39, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
> From: Abbas Raza <Abbas_Raza@mentor.com>
>
> This patch exports the host capabilities to debugfs
>
> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> [Harish: Added caps2, moved creation to mmc_add_host_debugfs]
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes in v4:
> - Moved the creation of nodes to mmc_add_host_debugfs
> - Exported caps2
> - Renamed host_caps to caps
>
> Changes in v3:
> - Removed typecasting of &host->caps to (u32 *)
>
> Changes in v2:
> - Changed Author
>
>  drivers/mmc/core/debugfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c51e0c0..d2275c5 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -243,6 +243,12 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
>                 goto err_node;
>
> +       if (!debugfs_create_x32("caps", S_IRUSR, root, &host->caps))
> +               goto err_node;
> +
> +       if (!debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2))
> +               goto err_node;
> +
>         if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
>                         &mmc_clock_fops))
>                 goto err_node;
> --
> 1.9.1
>
