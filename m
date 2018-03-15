From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10] mmc: Export host capabilities to debugfs.
Date: Thu, 15 Mar 2018 11:12:54 +0100
Message-ID: <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
References: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org

On 13 March 2018 at 06:10, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
> This patch exports the host capabilities to debugfs
>
> This idea of sharing host capabilities over debugfs
> came up from Abbas Raza <Abbas_Raza@mentor.com>
> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>
> Changes in v10:
> - minor review comment addressed.
> - Added "Reviewed-by" line
>
> Changes in v9
> - More code cleanup as suggested by Andy Shevchenko.
>
> Changes in v8
> - Changes to use for_each_set_bit as suggested by Andy Shevchenko.
>
> Changes in v7
> - Moved additional capabilities also to caps file as mentioned by Ulf Hansson
> - compacting the code with macros
>
> Changes in v6:
> - Used DEFINE_SHOW_ATTRIBUTE
>
> Changes in v5:
> - Added parser logic in kernel by using debugfs_create_file  for caps and caps2 instead of debugfs_create_x32
> - Changed Author
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
>  drivers/mmc/core/debugfs.c | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c51e0c0..826d361 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -225,6 +225,110 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>         "%llu\n");
>
> +/*
> + * mmc_host_capabilities - MMC host capabilities
> + *
> + * This must be in sync with caps definitions in the mmc/host.h
> + */
> +static const char * const mmc_host_capabilities[] = {
> +       "4-bit transfers allowed",
> +       "Supports MMC high-speed timing",
> +       "Supports SD high-speed timing",
> +       "Can signal pending SDIO IRQs",
> +       "Talks only SPI protocols",
> +       "Needs polling for card-detection",
> +       "8 bit transfers allowed",
> +       "Suspends (e)MMC/SD at idle",
> +       "Nonremovable",
> +       "Waits while card is busy",
> +       "Allows erase/trim commands",
> +       "Supports DDR mode at 3.3V",
> +       "Supports DDR mode at 1.8V",
> +       "Supports DDR mode at 1.2V",
> +       "Can power off after boot",
> +       "CMD14/CMD19 bus width ok",
> +       "Supports UHS SDR12 mode",
> +       "Supports UHS SDR25 mode",
> +       "Supports UHS SDR50 mode",
> +       "Supports UHS SDR104 mode",
> +       "Supports UHS DDR50 mode",
> +       "Unknown (bit 21)",
> +       "Unknown (bit 22)",
> +       "Supports Driver Type A",
> +       "Supports Driver Type C",
> +       "Supports Driver Type D",
> +       "Unknown (bit 26)",
> +       "RW reqs can be completed within mmc_request_done()",
> +       "Supports Enable card detect wake",
> +       "Can send commands during data transfer",
> +       "CMD23 supported",
> +       "Supports Hardware reset"
> +};
> +
> +/*
> + * mmc_host_capabilities2 - MMC host additional capabilities
> + *
> + * This must be in sync with caps2 definitions in the mmc/host.h
> + */
> +static const char * const mmc_host_capabilities2[] = {
> +       "No access to Boot partition",
> +       "Unknown (bit 1)",
> +       "Can do full power cycle",
> +       "Unknown (bit 3)",
> +       "Unknown (bit 4)",
> +       "Supports HS200 1.8V SDR",
> +       "Supports HS200 1.2V SDR",
> +       "Unknown (bit 7)",
> +       "Unknown (bit 8)",
> +       "Unknown (bit 9)",
> +       "Card-detect signal active high",
> +       "Write-protect signal active high",
> +       "Unknown (bit 12)",
> +       "Unknown (bit 13)",
> +       "Can do complete power cycle of the card",
> +       "Supports HS400 1.8V",
> +       "Support HS400 1.2V",
> +       "SDIO IRQ - Nothread",
> +       "No physical write protect pin, assume always read-write",
> +       "Do not send SDIO commands during initialization",
> +       "Supports enhanced strobe",
> +       "Do not send SD commands during initialization",
> +       "Do not send (e)MMC commands during initialization",
> +       "Has eMMC command queue engine",
> +       "CQE can issue a direct command",
> +       "Unknown (bit 25)",
> +       "Unknown (bit 26)",
> +       "Unknown (bit 27)",
> +       "Unknown (bit 28)",
> +       "Unknown (bit 29)",
> +       "Unknown (bit 30)",
> +       "Unknown (bit 31)"
> +};

Honestly, I don't like this, but maybe other people do, then I am fine
with this approach.

If were to decide, I would just rather print the caps field in a
hexadecimal bit form and leave the translation to the user.

> +
> +static int mmc_caps_show(struct seq_file *s, void *unused)
> +{
> +       struct mmc_host *host = s->private;
> +       unsigned long caps = host->caps;
> +       unsigned long caps2 = host->caps2;
> +       int bit;
> +
> +       seq_puts(s, "MMC Host capabilities are:\n");
> +       seq_puts(s, "=============================================\n");
> +
> +       for_each_set_bit(bit, &caps, ARRAY_SIZE(mmc_host_capabilities))
> +               seq_printf(s, "%s\n", mmc_host_capabilities[bit]);
> +
> +       seq_puts(s, "=============================================\n");
> +       seq_puts(s, "MMC Host additional capabilities are:\n");
> +       seq_puts(s, "=============================================\n");
> +
> +       for_each_set_bit(bit, &caps2, ARRAY_SIZE(mmc_host_capabilities2))
> +               seq_printf(s, "%s\n", mmc_host_capabilities2[bit]);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(mmc_caps);
> +
>  void mmc_add_host_debugfs(struct mmc_host *host)
>  {
>         struct dentry *root;
> @@ -243,6 +347,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
>                 goto err_node;
>
> +       if (!debugfs_create_file("caps", 0400, root, host, &mmc_caps_fops))
> +               goto err_node;
> +
>         if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
>                         &mmc_clock_fops))
>                 goto err_node;
> --
> 1.9.1
>

Kind regards
Uffe
