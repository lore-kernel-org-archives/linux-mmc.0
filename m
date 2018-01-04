From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] [v2] s3mci: mark debug_regs[] as static
Date: Thu, 4 Jan 2018 12:45:13 +0100
Message-ID: <CAPDyKFrDx3++vX_5--kVZcM2RN07cf5MDZnO3NzmgzOtErqW6Q@mail.gmail.com>
References: <20180103224939.4104207-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103224939.4104207-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 January 2018 at 23:49, Arnd Bergmann <arnd@arndb.de> wrote:
> The global array clashes with a newly added symbol of the same name:
>
> drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
> drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here
>
> We should fix both, this one addresses the s3cmci driver by removing
> the symbol from the global namespace. While at it, this separates
> the declaration from the type definition and makes the variable const.
>
> Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")
> Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/s3cmci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 36daee1e6588..f77493604312 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1424,7 +1424,9 @@ static const struct file_operations s3cmci_fops_state = {
>  struct s3cmci_reg {
>         unsigned short  addr;
>         unsigned char   *name;
> -} debug_regs[] = {
> +};
> +
> +static const struct s3cmci_reg debug_regs[] = {
>         DBG_REG(CON),
>         DBG_REG(PRE),
>         DBG_REG(CMDARG),
> @@ -1446,7 +1448,7 @@ struct s3cmci_reg {
>  static int s3cmci_regs_show(struct seq_file *seq, void *v)
>  {
>         struct s3cmci_host *host = seq->private;
> -       struct s3cmci_reg *rptr = debug_regs;
> +       const struct s3cmci_reg *rptr = debug_regs;
>
>         for (; rptr->name; rptr++)
>                 seq_printf(seq, "SDI%s\t=0x%08x\n", rptr->name,
> --
> 2.9.0
>
