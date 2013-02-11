From: Chris Ball <cjb@laptop.org>
Subject: Re: Control drive strength in software
Date: Mon, 11 Feb 2013 12:55:54 -0500
Message-ID: <87pq06pwet.fsf@octavius.laptop.org>
References: <510FB2CC.20201@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37675 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758378Ab3BKRz7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 12:55:59 -0500
In-Reply-To: <510FB2CC.20201@parrot.com> (Jeremie Samuel's message of "Mon, 4
	Feb 2013 14:08:28 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Jeremie,

On Mon, Feb 04 2013, Jeremie Samuel wrote:
> This function doesn't have an mmc_host as parameter. It is an issue
> for me since the drive strength parameters can be board specific.
> A solution would be to add this parameter:
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 5674504..cb6d117 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -134,7 +134,7 @@ struct mmc_host_ops {
>         /* The tuning command opcode value is different for SD and
> eMMC cards */
>         int     (*execute_tuning)(struct mmc_host *host, u32 opcode);
>         void    (*enable_preset_value)(struct mmc_host *host, bool enable);
> -       int     (*select_drive_strength)(unsigned int max_dtr, int
> host_drv, int card_drv);
> +       int     (*select_drive_strength)(struct mmc_host *host,
> unsigned int max_dtr, int host_drv, int card_drv);
>         void    (*hw_reset)(struct mmc_host *host);
>  };
>
> Is this solution a good idea?

Yes, sounds good.  Want to send a formal patch?

> Also, the drive strength configuration might be different according to
> the mode (not only UHS). So, I would like to control the drive
> strength for the default speed and the high speed. Would it be
> relevant to add this a call to this function in mmc_sd_switch_hs or in
> mmc_sd_init_card?

Yes, that sounds sensible too.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
