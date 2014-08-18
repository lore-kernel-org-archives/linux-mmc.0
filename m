From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: sd: check card write-protect lock while resuming
Date: Mon, 18 Aug 2014 13:57:32 +0200
Message-ID: <CAPDyKFpFLoREZ=rYp8bQvJ7Fczq=HyLL90jv7Hjzai9xTNBNYg@mail.gmail.com>
References: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:62670 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaHRL5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 07:57:33 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so4241361qaq.39
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 04:57:32 -0700 (PDT)
In-Reply-To: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 18 August 2014 12:00, Barry Song <Barry.Song@csr.com> wrote:
> From: Minda Chen <Minda.Chen@csr.com>
>
> After suspending, unplug the sdcard, and set sd WP lock,
> insert it again, then resume the system. resume codes do
> not check the the sdcard write-proctect lock. now check
> it.
>
> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/mmc/core/sd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 0c44510..890557a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -910,6 +910,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         int err;
>         u32 cid[4];
>         u32 rocr = 0;
> +       bool oldro, ro;
>
>         BUG_ON(!host);
>         WARN_ON(!host->claimed);
> @@ -922,6 +923,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                 if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
>                         return -ENOENT;
>
> +               if (host->ops->get_ro) {
> +                       ro = host->ops->get_ro(host) ? true : false;
> +                       oldro = mmc_card_readonly(oldcard) ? true : false;
> +                       if (oldro ^ ro)
> +                               return -ENOENT;
> +               }

Seems like this code belongs better in mmc_sd_setup_card(). Could you
try moving it there.

Kind regards
Uffe

>                 card = oldcard;
>         } else {
>                 /*
> --
> 2.0.4
>
>
>
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
> New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
