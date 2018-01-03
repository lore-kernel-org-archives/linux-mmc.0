From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] s3mci: mark debug_regs[] as static
Date: Wed, 3 Jan 2018 17:47:08 +0100
Message-ID: <CAPDyKFoxizZ5vJ4h_hSo=WaqzjMc7Zq59njuESTdeMaXCV1YQA@mail.gmail.com>
References: <20180103092705.1949763-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:37291 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeACQrJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 11:47:09 -0500
Received: by mail-io0-f195.google.com with SMTP id n14so2685709iob.4
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2018 08:47:09 -0800 (PST)
In-Reply-To: <20180103092705.1949763-1-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben-linux@fluff.org>, Heiner Kallweit <hkallweit1@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Sergio Prado <sergio.prado@e-labworks.com>, linux-arm-kernel@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 3 January 2018 at 10:26, Arnd Bergmann <arnd@arndb.de> wrote:
> The global array clashes with a newly added symbol of the same name:
>
> drivers/staging/ccree/cc_debugfs.o:(.data+0x0): multiple definition of `debug_regs'
> drivers/mmc/host/s3cmci.o:(.data+0x70): first defined here
>
> We should fix both, this one addresses the s3cmci driver by removing
> the symbol from the global namespace.
>
> Fixes: 9bdd203b4dc8 ("s3cmci: add debugfs support for examining driver and hardware state")

Seems like we need a stable tag as well, would you mind adding it in
the next re-spin?

> Fixes: b3ec9a6736f2 ("staging: ccree: staging: ccree: replace sysfs by debugfs interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 36daee1e6588..24b27e0957e7 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1421,7 +1421,7 @@ static const struct file_operations s3cmci_fops_state = {
>
>  #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
>
> -struct s3cmci_reg {
> +static struct s3cmci_reg {
>         unsigned short  addr;
>         unsigned char   *name;
>  } debug_regs[] = {

I am not very fond of these kind of declarations/definitions. How
about if we instead move the declaration of debug_regs[] to a separate
line? Moreover, should it be const?

static struct s3cmci_reg debug_regs[] = {

Kind regards
Uffe
