Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A024F1E2
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jul 2024 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589405; cv=none; b=XKGPdld6fA/2IO1tLmCLRLzyuJaibolgsD7U+vd0nrL0HEHDU1KPc5DW8l3TEWCr6ZbgGTJc1PlJrbu1vOv3AVsI6yWuni7QC2u0J7fXLwM5T5KvoIrGvAhvaT9GaGTTTeVW1PuZmHCh56TtIwoU+WpXc2sBnXgCbncq4ESdZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589405; c=relaxed/simple;
	bh=rGAInnsyQt3v6iQZ18+P41Un0hWOARucuUUtsadM6/s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tppXRMr8Byu6NNSckCg4G2Yb7O+vpUHpzYE9ZMN9f6RhLCO/R0TMqNfvU0dqJXC8kQlA9rX550bjJuSk9ZiAaZm4XcXRal4RiezvssiH8LQ2nokw6VnydqfobB0/ZEMCKfLWD05i9KJIZFdHBg2WXt/AH13N3Mbj2M91nYi+vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 7216B24173C;
	Wed, 10 Jul 2024 07:21:40 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 07:21:40 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
In-Reply-To: <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
 <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <dc3524328a701be1ac3206af24b4a185@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-09 22:06, Avri Altman wrote:
>> If I understand correctly, there is no point in sending the CMD13 
>> above, unless
>> this is the first attempt to initialize the card.
>> Therefore, it's better to move the whole part above, inside the below 
>> if-clause
>> too, otherwise we would end up sending a CMD13 in cases when it's not
>> needed.
> R1_CARD_IS_LOCKED is CMD13 response, but already in CMD7 response as 
> well,
> So theoretically you want to skip mmc_sd_setup_card altogether.

Do you mean to modify:
mmc_select_card(struct mmc_card *card)
to somehow return or save the R1 response to card struct?

Because currently, it is not available.

Thank you,
Daniel.

> ACMD6, CMD6, and CMD19 should wait for CMD42 to unlock the card.
> 
> Thanks,
> Avri
> 
>> 
>> > +
>> > +       if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>> >                 /*
>> >                  * Fetch SCR from card.
>> >                  */
>> > --
>> > 2.34.1
>> >
>> 
>> Kind regards
>> Uffe
