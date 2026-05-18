Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58732305681
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142854; cv=none; b=stfW+ydWHosbq1Yq77Fcm5pgEY7JOGKMLXeh7aI2/eupUzp1z8iPeFw+GbJs0TA4LX0mq/WYLKm/89/EsSHa3l4ASslMq/0RiV7ijlCFOUgftMP4QfoS8bQJezOr6Ftwh7tLCsrop/CuwRq/ksLYcUaSxmtlfhJAdRqoWwXs5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142854; c=relaxed/simple;
	bh=WzhGzR/qlbTPFjyOXx+TQCNfw7Gp40vu8efe4hkcEos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGSKbsEZePPn/yniRelbsAnyX/ii5YBi0k2N1y5b45FhwgKPocrZkW0Api96YFCg2htmZi1ZLHGWOpI1K9HwwvHCo7Yn5ubZ0hyzjnbtDRMBiWGtYC+gE6sRnfNaCNEVu6V3r0vAIY0xeaBtW6l/3J1yDOz6WG/Y7j/bi8fZlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPgnveAZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPgnveAZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b4650d5f5cso10490595ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779142853; x=1779747653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqafggWVzG45XkB/Trqo1jmbkzttKIzZZW2LIt34uL0=;
        b=EPgnveAZ1WBmbZyI6fJ2J9B7U0WAKvyOIxLCCMhr+OjHqt+7VtaoGGFfFI8TfufWhr
         VDv3Yv+EOl3d8GkvWYlT3pMq5GHGHxUdTJRjegcyX1xspWNjvl9CI1xwS0p/ziqCy0dd
         iLs5r+oWjUDY0seQwYUUj3CpwxTmlM+DtbzR06HP2FRKEHpkSdvru9/WIX0y9N1BeyEq
         JGB+41gos6eqkjL41R6KJWDzvpSIhCQYg3gLV9Xn3qZjB8JRNfkRhZTsNU64Y7DM1mjG
         NL1Hem0C9CPR5cTAtCzeoxpBpzXrzRmbU2oJq8d798gagRa4mdX1Eh17B4AuxmAYbCES
         2uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142853; x=1779747653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqafggWVzG45XkB/Trqo1jmbkzttKIzZZW2LIt34uL0=;
        b=QYJZOz6MHOFBa/EvaOp/SacybeI3q2nwmCts0+yxTdu4MOU12ALGro4QrVvFBYvIB/
         MIcnBbM1h1yzqjCNV4MYnYUuDqCqnGbP29cYNYI1DE8XZ23MDByQcQdJzTsnsNi9u/7l
         aqQVJmkLnMWAcSjlIjLDkJkLrq4iHFo6JlJ4+XqZDZADptt88Bn7SKtivaXcWqIC2Nm/
         fWgdETO96aEU+3LA/RMMcJhwPWHmvnmjPxsSYPjZgRtd4WMro/NFj2OVWV6RMlkuttih
         G39/IGTBEtYWidg6NYgur83Db//l8FKnkDJDORVKcMvK0sIdSWd6BwFgJf7HEPZG7q8E
         jy6Q==
X-Forwarded-Encrypted: i=1; AFNElJ91BY73iUabrQOCHsaHAD60Qe2eU+zILylxOQ17quwfdsoCrOsYsk2zqkIfYQ+nl0N4ocjxACloU/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMP9CQ5QkaA9309MGYrN044SMey0pgRHS/JHC7tkCMNyVOxpoy
	di5bYNY+Fv+Jgo03uA7NxcIrwiGPs3wUiiALpX7/xpD1/TM6tAGS90+r
X-Gm-Gg: Acq92OGBR5RoU2vZfX8S0FAKlBdkndrQSWid+cbnacEUingX/3fdLXFeyP87H1Thyky
	2B0wJ+JZKBo/5BmtFu1M+XMKs4Qf0SNC/iVQWHrS+ji2oia62V/cwbTiH8Rw9USg8iNDpf8iziq
	flbrsEEURTOY4gGzZPh+EKYLK1tCsDnIyRwEiFjL4uKdy9TKQQjX3aDSZIL7nSxRH3hQYFi/c+S
	VXKGdVIugoqj7ugfGcC7YGzhfgNJZG7/kIlzeBL1aCdKcPTdg6s2E58LzXRc/Lp7oBCkOON8S3a
	6uYSZuounSB0UlVslS0AnwzfgAhtf35NF51JXiJH57F3kAg4rf4VONDHU8ABWMqRNrJ1DPjnjeJ
	BtsaG9Kivq3A8AhfyuR5GXMgm41NPCnjXPOUU/v1v1A+HmugMoCHA/ifJt6pMjtQKxsuRmaSCW1
	VBXuEn6pU6Mzob14pWrpWAhLV7QOq48j5w38a0PZBIYMLE58Qz4Z7Wj2O65jVVVNyDYBDSA/CQ4
	ReYc/c5gIQ+
X-Received: by 2002:a17:903:f8d:b0:2b0:b016:773f with SMTP id d9443c01a7336-2bd7e8a0b31mr185023675ad.11.1779142852619;
        Mon, 18 May 2026 15:20:52 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-17-68-229.pitbpa.fios.verizon.net. [108.17.68.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm168648905ad.9.2026.05.18.15.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:20:52 -0700 (PDT)
Date: Mon, 18 May 2026 18:20:49 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Kamil Rakoczy <krakoczy@antmicro.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <aguQwccX_ujIoARX@errol.ini.cmu.edu>
References: <20260517015323.264179-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517015323.264179-1-inochiama@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett

with this patch on top of today's latest (4d3a2a466b8d), I get
(on 64-bit rocketchip with Litex):

[    6.475114] mmc0: invalid bus width
[    6.477870] mmc0: error -22 whilst initialising SD card

Thanks,
--Gabriel

On Sun, May 17, 2026 at 09:53:23AM +0800, Inochi Amaoto wrote:
> The litex_mmc driver assumes the card is already probed in the BIOS
> and skip the phy initialization. This will cause the command fail
> like the following when the old card is unplugged and then insert
> a new card:
> 
> [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> 
> Add required clock settings and initialization for the CMD 0, so it can
> probe the new card.
> 
> Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
> Changed from v3:
> - https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gmail.com/
> 1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> 2. Use set_ios() callback to apply the clock change.
> 
> Changed from v2:
> - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
> 1. Remove the added function forward reference and add a new patch
>    for moving litex_mmc_setclk() function
> 
> Change from v1:
> - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> 1. use fsleep to replace udelay
> 
> Inochi Amaoto (2):
>   mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
>   mmc: litex_mmc: Set mandatory idle clocks before CMD0
> 
>  drivers/mmc/host/litex_mmc.c | 37 ++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> ---
>  drivers/mmc/host/litex_mmc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index d2f19c2dc673..65d5c728f536 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -68,6 +68,9 @@
>  #define SD_SLEEP_US       5
>  #define SD_TIMEOUT_US 20000
> 
> +#define SD_INIT_DELAY_US  1000
> +#define SD_INIT_CLK_HZ    400000
> +
>  #define SDIRQ_CARD_DETECT    1
>  #define SDIRQ_SD_TO_MEM_DONE 2
>  #define SDIRQ_MEM_TO_SD_DONE 4
> @@ -449,6 +452,9 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct litex_mmc_host *host = mmc_priv(mmc);
> 
> +	if (ios->chip_select == MMC_CS_HIGH)
> +		ios->clock = SD_INIT_CLK_HZ;
> +
>  	/*
>  	 * NOTE: Ignore any ios->bus_width updates; they occur right after
>  	 * the mmc core sends its own acmd6 bus-width change notification,
> @@ -459,6 +465,11 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	/* Update sd_clk */
>  	if (ios->clock != host->sd_clk)
>  		litex_mmc_setclk(host, ios->clock);
> +
> +	if (ios->chip_select == MMC_CS_HIGH) {
> +		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> +		fsleep(SD_INIT_DELAY_US);
> +	}
>  }
> 
>  static const struct mmc_host_ops litex_mmc_ops = {
> --
> 2.54.0
> 
