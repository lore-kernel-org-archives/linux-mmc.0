Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19B1F8755
	for <linux-mmc@vger.kernel.org>; Mon,  5 Jan 2026 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767574032; cv=none; b=SCMMAKkrbHuxZDxJICl8mDHXx6UROLJaHCD1vZ+CdZFjAemlqQLBiVXbrTiQHJy8ktST8/IooRfPJtMe2QMRvqbEYK9g2vbnd87/TlBzmhfmVol1x8ageD9CDZgROXmpNSDjD0fd/o5GdN+8183i81ApVDDyDCt4uTwvpSaIQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767574032; c=relaxed/simple;
	bh=6ojJQfku2he7/VKf+dDJ6IXcem0h0yCDiyVEshb3Sg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgjTym6mV8Sq+219aXAgXq0kyG8Z0NgM4poczdcYlzKHdCDkXnjPD2kIMFFt3sz8Yz1zoT4eqpvMClBu7I0prVLKNBzLvJGqL0AcsQdoCXVvZDomLuyBWXuKRDO15/BmRn1TMRPbx3rE+KbpE9m1M9W7J79B3H1yBdzEG1z9YuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gPAJoNT9; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gPAJoNT9"
Message-ID: <db872779-c1a5-4d93-9143-61a8f29b27a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767574024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWwCiv8RUrGTC+Yo40kbn5+xDWTpSZOMUMYbGxUCqmk=;
	b=gPAJoNT96VxtTI76jhEQEuAvBXyIjMXO3UbVIGkpKptwAkl7LGAbrRbUwhUqPdtbE/CK2R
	yB1xN+FTb0+GY3Dbb+PsKm4VlkZoIUjmVolsB35c/KT3pmM4mXQC9kwjO9j+upmLSpru14
	TPtZRgjMOt+c1B0tJS0HvdaIgLXhHVM=
Date: Sun, 4 Jan 2026 16:46:47 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: rtsx_pci: add quirk to disable MMC_CAP_AGGRESSIVE_PM
 for RTS525A
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Ricky Wu <ricky_wu@realtek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260103204226.71752-1-matthew.schwartz@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20260103204226.71752-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/3/26 12:42 PM, Matthew Schwartz wrote:
> Using MMC_CAP_AGGRESSIVE_PM on RTS525A card readers causes game
> performance issues when the card reader comes back from idle into active
> use. This can be observed in Hades II when loading new sections of the
> game or menu after the card reader puts itself into idle, and presents
> as a 1-2 second hang.
> 
> Add EXTRA_CAPS_NO_AGGRESSIVE_PM quirk to allow cardreader drivers to
> opt-out of aggressive PM, and set it for RTS525A.

Bit of an update: I dug up an old laptop that has a Realtek RTS5261 PCI card reader, and that has the exact same issue under identical circumstances.
It might make more sense to skip the quirking and just make no MMC_CAP_AGGRESSIVE_PM the default in rtsx_pci_sdmmc unless another solution can be found.

Matt

> 
> Closes: https://lore.kernel.org/linux-mmc/ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev/
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  drivers/misc/cardreader/rts5249.c | 3 +++
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++--
>  include/linux/rtsx_pci.h          | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> index 38aefd8db452..87d576a03e68 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -78,6 +78,9 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
>  	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
>  		pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
>  
> +	if (CHK_PCI_PID(pcr, PID_525A))
> +		pcr->extra_caps |= EXTRA_CAPS_NO_AGGRESSIVE_PM;
> +
>  	if (rtsx_check_mmc_support(reg))
>  		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>  	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index dc2587ff8519..5d3599ee06bf 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1456,8 +1456,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
>  	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>  		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>  		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> -	if (pcr->rtd3_en)
> -		mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
> +	if (pcr->rtd3_en && !(pcr->extra_caps & EXTRA_CAPS_NO_AGGRESSIVE_PM))
> +		mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>  	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
>  		MMC_CAP2_NO_SDIO;
>  	mmc->max_current_330 = 400;
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 3c5689356004..f6122349c00e 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -1230,6 +1230,7 @@ struct rtsx_pcr {
>  #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
>  #define EXTRA_CAPS_NO_MMC		(1 << 7)
>  #define EXTRA_CAPS_SD_EXPRESS		(1 << 8)
> +#define EXTRA_CAPS_NO_AGGRESSIVE_PM	(1 << 9)
>  	u32				extra_caps;
>  
>  #define IC_VER_A			0

