From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH] drivers: mmc: bfin_sdh: fix build error
Date: Mon, 6 Aug 2012 17:27:40 +0800
Message-ID: <CAA_GA1c3w_6Oq7dR+0Exw-warJyL9dr2PKyT6nrkWrDfx=MCKQ@mail.gmail.com>
References: <1343631782-24207-1-git-send-email-lliubbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37225 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab2HFJ1m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 05:27:42 -0400
Received: by wgbdr13 with SMTP id dr13so2545355wgb.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Aug 2012 02:27:41 -0700 (PDT)
In-Reply-To: <1343631782-24207-1-git-send-email-lliubbo@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: adrian.hunter@intel.com, ludovic.desroches@atmel.com, rmk+kernel@arm.linux.org.uk, g.liakhovetski@gmx.de, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, Bob Liu <lliubbo@gmail.com>, linux-mmc@vger.kernel.org

Hi Chris,

Would you please take a look at this patch?
Since without this patch, regression test for blackfin will fail:
http://kisskb.ellerman.id.au/kisskb/matrix/

Thank you!

On Mon, Jul 30, 2012 at 3:03 PM, Bob Liu <lliubbo@gmail.com> wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> Descriptor array structure has been moved into blackfin dma.h head file.
> This patch fix below error:
>
> drivers/mmc/host/bfin_sdh.c:52:8: error: redefinition of 'struct
> dma_desc_array'
> make[4]: *** [drivers/mmc/host/bfin_sdh.o] Error 1
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Bob Liu <lliubbo@gmail.com>
> ---
>  drivers/mmc/host/bfin_sdh.c |   13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
> index 0366617..a17dd73 100644
> --- a/drivers/mmc/host/bfin_sdh.c
> +++ b/drivers/mmc/host/bfin_sdh.c
> @@ -49,13 +49,6 @@
>  #define bfin_write_SDH_CFG             bfin_write_RSI_CFG
>  #endif
>
> -struct dma_desc_array {
> -       unsigned long   start_addr;
> -       unsigned short  cfg;
> -       unsigned short  x_count;
> -       short           x_modify;
> -} __packed;
> -
>  struct sdh_host {
>         struct mmc_host         *mmc;
>         spinlock_t              lock;
> --
> 1.7.9.5
>

-- 
Regards,
--Bob
