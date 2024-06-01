Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA641A94C
	for <linux-mmc@vger.kernel.org>; Sat,  1 Jun 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717278194; cv=none; b=ptgDWKnRlad8J0xB/yGYax+sZ6teK6/KYnGTxPu+SVDmGn0aonF5zRzupD5IKjXhN0GqeOPJhvnEAaxLpACxiDGjYdseEwCzIjZoojz86AEUFscJ1f9+DxuMCiOUjJ2jA885d6LhDeRih4U8uCtX730T7exQePAwyHazWXr/VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717278194; c=relaxed/simple;
	bh=g/Ss24ADt7xv8S3Fv9lN4YXx+nk2Cxme/4isrY30Nhc=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fQVlLC7SbsNUglxUXLiFPQ066dyyL+ou4WHaDfOTdQQBZJ3VchpuH2b6Wii+YccX98u/7HAmy6Xkkm2PlwMPiWQzd5s9L9+K8+2IwFAdjZIiLePKRHfmgYxuxVYIMGyJ2958uI4fRcUxqJHAYxRMgIHXU8UhU/CcYRTE1SOmaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 355852401FE;
	Sat,  1 Jun 2024 23:43:01 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Jun 2024 23:43:01 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3] mmc: core: allow detection of locked cards
In-Reply-To: <20240523132016.599343-1-linux-mmc@danman.eu>
References: <20240523132016.599343-1-linux-mmc@danman.eu>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-23 15:20, linux-mmc@danman.eu wrote:
> From: Daniel Kucera <linux-mmc@danman.eu>
> 
> Locked card will not reply to SEND_SCR or SD_STATUS commands
> so it was failing to initialize previously. When skipped,
> the card will get initialized and CMD42 can be sent using
> ioctl to unlock the card or remove password protection.
> Until unlocked, all read/write calls will timeout.
> 
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  drivers/mmc/core/sd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdd..ae821df7d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host,
> struct mmc_card *card,
>  	bool reinit)
>  {
>  	int err;
> +	u32 card_status;
> 
> -	if (!reinit) {
> +	err = mmc_send_status(card, &card_status);
> +	if (err){
> +		pr_err("%s: unable to get card status\n", mmc_hostname(host));
> +		return err;
> +	}
> +
> +	if (card_status & R1_CARD_IS_LOCKED){
> +		pr_warn("%s: card is locked\n", mmc_hostname(host));
> +	}
> +
> +	if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>  		/*
>  		 * Fetch SCR from card.
>  		 */

Any feedback please?

D.
