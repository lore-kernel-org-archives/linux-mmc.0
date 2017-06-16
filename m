From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6 v3] mmc: debugfs: No blocklayer = no card status and extcsd
Date: Fri, 16 Jun 2017 11:32:21 +0200
Message-ID: <CAPDyKFqbS0wLqQiPVPviPZ7o9WsGtQ2=46+e4NY_=MF2Gg6nDA@mail.gmail.com>
References: <20170608085403.11795-1-linus.walleij@linaro.org> <20170608085403.11795-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34487 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbdFPJcW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2017 05:32:22 -0400
Received: by mail-qt0-f177.google.com with SMTP id c10so55415856qtd.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2017 02:32:22 -0700 (PDT)
In-Reply-To: <20170608085403.11795-3-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 8 June 2017 at 10:53, Linus Walleij <linus.walleij@linaro.org> wrote:
> If we don't have the block layer enabled, we do not present card
> status and extcsd in the debugfs.
>
> Debugfs is not ABI, and maintaining files of no relevance for
> non-block devices comes at a high maintenance cost if we shall
> support it with the block layer compiled out.

Well, as a matter of fact the code is still there after these changes,
just in a different form.

I would rather set the arguments to why these changes are good, that
we want to minimize the number of users of the bif fat mmc lock, but
also to deal with mmc request through the regular I/O path as to avoid
starvation.

>
> The expected number of debugfs users utilizing these two
> debugfs files is already low as there is an ioctl() to get the
> same information using the mmc-tools, and of these few users
> the expected number of people using it on SDIO or combo cards
> are expected to be zero.

Yeah. I can have been thinking a bit more about this. So, perhaps this
is good first step, to not entirely remove the current debugfs nodes
for cards.

However, from maintenance point of view, this series doesn't really
make me more happy, rather the opposite. Some more comments below.

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - No changes just resending
> ---
>  drivers/mmc/core/debugfs.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index a1fba5732d66..b176932b8092 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -281,6 +281,8 @@ void mmc_remove_host_debugfs(struct mmc_host *host)
>         debugfs_remove_recursive(host->debugfs_root);
>  }
>
> +#if IS_ENABLED(CONFIG_MMC_BLOCK)
> +
>  static int mmc_dbg_card_status_get(void *data, u64 *val)
>  {
>         struct mmc_card *card = data;
> @@ -360,6 +362,32 @@ static const struct file_operations mmc_dbg_ext_csd_fops = {
>         .llseek         = default_llseek,
>  };
>
> +static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
> +{
> +       if (mmc_card_mmc(card) || mmc_card_sd(card)) {
> +               if (!debugfs_create_file("status", S_IRUSR, root, card,
> +                                        &mmc_dbg_card_status_fops))
> +                       return -EIO;
> +       }
> +
> +       if (mmc_card_mmc(card)) {
> +               if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
> +                                        &mmc_dbg_ext_csd_fops))
> +                       return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +#else /* !IS_ENABLED(CONFIG_MMC_BLOCK) */
> +
> +static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
> +{

So does this really work as expected?

Currently one can build the mmc block as a separate module. If that
module is inserted after the mmc core module attempts to register the
debugfs nodes, we would end up in this stub function, right?

In other words, those system that for some odd reason decide to insmod
the mmc block module at a later point, won't be given the debugfs
nodes?

> +       return 0;
> +}
> +
> +#endif
> +
>  void mmc_add_card_debugfs(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> @@ -382,15 +410,8 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>         if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
>                 goto err;
>
> -       if (mmc_card_mmc(card) || mmc_card_sd(card))
> -               if (!debugfs_create_file("status", S_IRUSR, root, card,
> -                                       &mmc_dbg_card_status_fops))
> -                       goto err;
> -
> -       if (mmc_card_mmc(card))
> -               if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
> -                                       &mmc_dbg_ext_csd_fops))
> -                       goto err;
> +       if (mmc_add_block_debugfs(card, root))
> +               goto err;
>
>         return;
>
> --
> 2.9.4
>

Kind regards
Uffe
