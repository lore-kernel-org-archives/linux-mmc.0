From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: + sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers.patch added to -mm tree
Date: Mon, 28 Sep 2009 16:05:12 -0700 (PDT)
Message-ID: <812485.11160.qm@web28310.mail.ukl.yahoo.com>
References: <200909132245.n8DMj6l2007798@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web28310.mail.ukl.yahoo.com ([87.248.110.129]:44768 "HELO
	web28310.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753230AbZI1XFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Sep 2009 19:05:10 -0400
In-Reply-To: <200909132245.n8DMj6l2007798@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, Pierre Ossman <pierre@ossman.eu>
Cc: linux-mmc@vger.kernel.org, Michael Buesch <mb@bu3sch.de>

akpm@linux-foundation.org wrote:
> ------------------------------------------------------
> Subject: sdio: pass whitelisted cis funce tuples to sdio drivers
> From: Albert Herranz <albert_herranz@yahoo.es>
> 
> Some manufacturers provide vendor information in non-vendor specific CIS
> tuples.  For example, Broadcom uses an Extended Function tuple to provide
> the MAC address on some of their network cards, as in the case of the
> Nintendo Wii WLAN daughter card.
> 
> This patch allows passing whitelisted FUNCE tuples unknown to the SDIO
> core to a matching SDIO driver instead of rejecting them and failing.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/core/sdio_cis.c |   65 +++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff -puN drivers/mmc/core/sdio_cis.c~sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers drivers/mmc/core/sdio_cis.c
> --- a/drivers/mmc/core/sdio_cis.c~sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers
> +++ a/drivers/mmc/core/sdio_cis.c
> @@ -98,6 +98,22 @@ static const unsigned char speed_val[16]
>  static const unsigned int speed_unit[8] =
>      { 10000, 100000, 1000000, 10000000, 0, 0, 0, 0 };
>  
> +/* FUNCE tuples with these types get passed to SDIO drivers */
> +static const unsigned char funce_type_whitelist[] = {
> +    4 /* CISTPL_FUNCE_LAN_NODE_ID used in Broadcom cards */
> +};
> +
> +static int cistpl_funce_whitelisted(unsigned char type)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(funce_type_whitelist); i++) {
> +        if (funce_type_whitelist[i] == type)
> +            return 1;
> +    }
> +    return 0;
> +}
> +
>  static int cistpl_funce_common(struct mmc_card *card,
>                     const unsigned char *buf, unsigned size)
>  {
> @@ -120,6 +136,10 @@ static int cistpl_funce_func(struct sdio
>      unsigned vsn;
>      unsigned min_size;
>  
> +    /* let SDIO drivers take care of whitelisted FUNCE tuples */
> +    if (cistpl_funce_whitelisted(buf[0]))
> +        return -EILSEQ;
> +
>      vsn = func->card->cccr.sdio_vsn;
>      min_size = (vsn == SDIO_SDIO_REV_1_00) ? 28 : 42;
>  
> @@ -154,13 +174,12 @@ static int cistpl_funce(struct mmc_card 
>      else
>          ret = cistpl_funce_common(card, buf, size);
>  
> -    if (ret) {
> +    if (ret && ret != -EILSEQ) {
>          printk(KERN_ERR "%s: bad CISTPL_FUNCE size %u "
>                 "type %u\n", mmc_hostname(card->host), size, buf[0]);
> -        return ret;
>      }
>  
> -    return 0;
> +    return ret;
>  }
>  
>  typedef int (tpl_parse_t)(struct mmc_card *, struct sdio_func *,
> @@ -253,21 +272,12 @@ static int sdio_read_cis(struct mmc_card
>          for (i = 0; i < ARRAY_SIZE(cis_tpl_list); i++)
>              if (cis_tpl_list[i].code == tpl_code)
>                  break;
> -        if (i >= ARRAY_SIZE(cis_tpl_list)) {
> -            /* this tuple is unknown to the core */
> -            this->next = NULL;
> -            this->code = tpl_code;
> -            this->size = tpl_link;
> -            *prev = this;
> -            prev = &this->next;
> -            printk(KERN_DEBUG
> -                   "%s: queuing CIS tuple 0x%02x length %u\n",
> -                   mmc_hostname(card->host), tpl_code, tpl_link);
> -        } else {
> +        if (i < ARRAY_SIZE(cis_tpl_list)) {
>              const struct cis_tpl *tpl = cis_tpl_list + i;
>              if (tpl_link < tpl->min_size) {
>                  printk(KERN_ERR
> -                       "%s: bad CIS tuple 0x%02x (length = %u, expected >= %u)\n",
> +                       "%s: bad CIS tuple 0x%02x"
> +                       " (length = %u, expected >= %u)\n",
>                         mmc_hostname(card->host),
>                         tpl_code, tpl_link, tpl->min_size);
>                  ret = -EINVAL;
> @@ -275,7 +285,30 @@ static int sdio_read_cis(struct mmc_card
>                  ret = tpl->parse(card, func,
>                           this->data, tpl_link);
>              }
> -            kfree(this);
> +            /*
> +             * We don't need the tuple anymore if it was
> +             * successfully parsed by the SDIO core or if it is
> +             * not going to be parsed by SDIO drivers.
> +             */
> +            if (!ret || ret != -EILSEQ)
> +                kfree(this);
> +        } else {
> +            /* unknown tuple */
> +            ret = -EILSEQ;
> +        }
> +
> +        if (ret == -EILSEQ) {
> +            /* this tuple is unknown to the core or whitelisted */
> +            this->next = NULL;
> +            this->code = tpl_code;
> +            this->size = tpl_link;
> +            *prev = this;
> +            prev = &this->next;
> +            printk(KERN_DEBUG
> +                   "%s: queuing CIS tuple 0x%02x length %u\n",
> +                   mmc_hostname(card->host), tpl_code, tpl_link);
> +            /* keep on analyzing tuples */
> +            ret = 0;
>          }
>  
>          ptr += tpl_link;

Are there any comments/objections to this patch?

Thanks,
Albert

PS: This patch is a pre-requisite for the support of sdio-based soft-mac b43 cards already merged in 2.6.32-rc1.


      
