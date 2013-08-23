From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] mmc: lock: Use the kernel "KEYS" subsystem to get a
 card's password
Date: Fri, 23 Aug 2013 12:34:44 +0200
Message-ID: <CAPDyKFrZQPaRqwn9ou+ST6TjNpjZFpeP91sOndpLASiFJ73KjQ@mail.gmail.com>
References: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
	<1376407290-21477-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:33714 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab3HWKep (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 06:34:45 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so301376vcb.14
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 03:34:44 -0700 (PDT)
In-Reply-To: <1376407290-21477-2-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <acooper@broadcom.com>

Hi Al,

On 13 August 2013 17:21, Al Cooper <alcooperx@gmail.com> wrote:
> From: Al Cooper <acooper@broadcom.com>
>
> Use the kernel "KEYS" subsystem to get a password for a card based on
> the card's CID. This code was based on a patch set submitted by
> Anderson Briglia in 2006.
>
> refs #SWLINUX-2545
>
> Signed-off-by: Al Cooper <acooper@broadcom.com>
> ---
>  drivers/mmc/core/Kconfig |  8 +++++
>  drivers/mmc/core/core.c  | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.h  | 16 ++++++++-
>  3 files changed, 109 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 269d072..b0ba79d 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -26,3 +26,11 @@ config MMC_CLKGATE
>           support handling this in order for it to be of any use.
>
>           If unsure, say N.
> +
> +config MMC_LOCK
> +       bool "MMC/SD password based card lock/unlock"
> +       select KEYS
> +       help
> +         This will add the ability to lock/unlock SD and MMC cards.
> +
> +         If unsure, say N.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 49a5bca..510927f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/fault-inject.h>
>  #include <linux/random.h>
>  #include <linux/slab.h>
> +#include <linux/key-type.h>
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> @@ -2705,6 +2706,78 @@ void mmc_init_context_info(struct mmc_host *host)
>         init_waitqueue_head(&host->context_info.wait);
>  }
>
> +#ifdef CONFIG_MMC_LOCK
> +
> +int mmc_get_password(struct mmc_card *card, struct mmc_password *password)
> +{
> +       struct key *mmc_key;
> +       char key_desc[(sizeof(card->raw_cid) * 2) + 1];
> +
> +       /* Use the CID to uniquely identify the card */
> +       snprintf(key_desc, sizeof(key_desc), "%08x%08x%08x%08x",
> +                card->raw_cid[0], card->raw_cid[1],
> +                card->raw_cid[2], card->raw_cid[3]);
> +
> +       mmc_key = request_key(&mmc_key_type, key_desc,
> +                             "password");
> +       if (IS_ERR(mmc_key)) {
> +               dev_warn(&card->dev, "Error, request_key %ld\n",
> +                        PTR_ERR(mmc_key));
> +               return PTR_ERR(mmc_key);
> +       }
> +       dev_dbg(&card->dev, "Found matching key\n");
> +       memcpy(&password->password, mmc_key->payload.data,
> +              mmc_key->datalen);
> +       password->length = mmc_key->datalen;
> +       key_put(mmc_key);
> +
> +       return 0;
> +}
> +
> +
> +static int mmc_key_instantiate(struct key *key,
> +                              struct key_preparsed_payload *prep)
> +{
> +       char *payload;
> +
> +       if (prep->datalen <= 0 || prep->datalen > MMC_PASSWORD_MAX ||
> +           !prep->data) {
> +               pr_warn("Invalid data\n");
> +               return  -EINVAL;
> +       }
> +
> +       payload = kmalloc(prep->datalen, GFP_KERNEL);
> +       if (!payload)
> +               return -ENOMEM;
> +       memcpy(payload, prep->data, prep->datalen);
> +       key->payload.data = payload;
> +       key->datalen = prep->datalen;
> +       return 0;
> +}
> +
> +static int mmc_key_match(const struct key *key, const void *description)
> +{
> +       pr_debug("mmc_key_match: %s, %s\n",
> +                key->description, (char *)description);
> +       return strcmp(key->description, description) == 0;
> +}
> +
> +/*
> + * dispose of the data dangling from the corpse of a mmc key
> + */
> +static void mmc_key_destroy(struct key *key)
> +{
> +       kfree(key->payload.data);
> +}
> +
> +struct key_type mmc_key_type = {
> +       .name           = "mmc",
> +       .instantiate    = mmc_key_instantiate,
> +       .match          = mmc_key_match,
> +       .destroy        = mmc_key_destroy,
> +};
> +#endif /* CONFIG_MMC_LOCK */
> +
>  static int __init mmc_init(void)
>  {
>         int ret;
> @@ -2725,8 +2798,18 @@ static int __init mmc_init(void)
>         if (ret)
>                 goto unregister_host_class;
>
> +#ifdef CONFIG_MMC_LOCK
> +       ret = register_key_type(&mmc_key_type);
> +       if (ret)
> +               goto unregister_sdio_bus;
> +#endif /* CONFIG_MMC_LOCK */
> +

Please don't add "#ifdefs" around the code like this. Instead add
stubbed versions of the functions in case !CONFIG_MMC_LOCK.

>         return 0;
>
> +#ifdef CONFIG_MMC_LOCK

dito

> +unregister_sdio_bus:
> +       sdio_unregister_bus();
> +#endif /* CONFIG_MMC_LOCK */
>  unregister_host_class:
>         mmc_unregister_host_class();
>  unregister_bus:
> @@ -2739,6 +2822,9 @@ destroy_workqueue:
>
>  static void __exit mmc_exit(void)
>  {
> +#ifdef CONFIG_MMC_LOCK
> +       unregister_key_type(&mmc_key_type);
> +#endif /* CONFIG_MMC_LOCK */

dito

>         sdio_unregister_bus();
>         mmc_unregister_host_class();
>         mmc_unregister_bus();
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 5345d15..dcf516d 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -81,5 +81,19 @@ void mmc_add_card_debugfs(struct mmc_card *card);
>  void mmc_remove_card_debugfs(struct mmc_card *card);
>
>  void mmc_init_context_info(struct mmc_host *host);
> -#endif
>
> +/* Lock/Unlock functionality */
> +int mmc_unlock_card(struct mmc_card *card);
> +
> +#ifdef CONFIG_MMC_LOCK
> +#define MMC_PASSWORD_MAX 16
> +struct mmc_password {
> +       char password[MMC_PASSWORD_MAX];
> +       int length;
> +};
> +extern struct key_type mmc_key_type;
> +
> +int mmc_get_password(struct mmc_card *card, struct mmc_password *password);
> +#endif /* CONFIG_MMC_LOCK */
> +
> +#endif
> --
> 1.8.1.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
