From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/8] sdhci: Use work structs instead of tasklets
Date: Sun, 20 Oct 2013 21:49:08 -0400
Message-ID: <874n8b9ywb.fsf@octavius.laptop.org>
References: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com>
	<1381940458-12628-4-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54948 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab3JUBtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 21:49:15 -0400
In-Reply-To: <1381940458-12628-4-git-send-email-jeremie.samuel.ext@parrot.com>
	(Jeremie Samuel's message of "Wed, 16 Oct 2013 18:20:53 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: linux-mmc@vger.kernel.org, =?utf-8?Q?Gr=C3=A9gor?= Boirie <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Hi Jeremie,

On Wed, Oct 16 2013, Jeremie Samuel wrote:
> The driver can happily live without an atomic context and tasklets,
> so turn the tasklets into the work structs.
>
> Tasklets handlers still grab irqsave spinlocks, but we'll deal
> with it in a separate patch.
>
> Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.
>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
> [..]
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 2b0f4f3..05cd76c 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -161,8 +161,8 @@ struct sdhci_host {
>  	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
>  	dma_addr_t align_addr;	/* Mapped bounce buffer */
> =20
> -	struct tasklet_struct card_tasklet;	/* Tasklet structures */
> -	struct tasklet_struct finish_tasklet;
> +	struct work_struct	card_detect_work;
> +	struct work_struct	finish_work;

More compile errors:

 =CE=BB git grep card_tasklet drivers/mmc/host =20
drivers/mmc/host/sdhci-bcm-kona.c: * to generate the CD IRQ handled in =
sdhci.c which schedules card_tasklet.
drivers/mmc/host/sdhci-dove.c:  tasklet_schedule(&host->card_tasklet);
drivers/mmc/host/sdhci-s3c.c:           tasklet_schedule(&host->card_ta=
sklet);
drivers/mmc/host/sdhci-spear.c: tasklet_schedule(&host->card_tasklet);

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
