Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F243ADE
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jul 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720903823; cv=none; b=WXcu/jbqGQDwDnR6l6xAapmVhlALrypthjcGTA6+738nKtTjndV8kW7RKjeJebJFWuPp+oNyjZnA+16QBQx3ASiZQmuqgX36ZAqLpeiRou2yeSyNruBt9TfScnZ29zzGrbUMUrwCXZnBJXUR+9wPRTxkS/L1qxSaSyXJVfJifu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720903823; c=relaxed/simple;
	bh=d9AsLNdAIW+Lv0ZU4DqMakZmSFncQFy4+GHu1aZ71iw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DrV20UQ/o+dzyTVwLPhdryTfRiqT8R2Icjw8Op9v3wm2HWdU/QgedCk945BRoUGZRF+gZLF1iW9PAYq47a+jXGGghfrfD4Iakyk/CNyzsba15/h6+/COKt4dzskibpZkJZBuYA8zb5yPF1Wxa5AfOieqR4X04lBX8QjsXeit9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 20BFD240229;
	Sat, 13 Jul 2024 22:50:10 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Jul 2024 22:50:09 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
In-Reply-To: <CAPDyKFrQc610OB+VaG=cKQys7+3pyB4m1DA4BZXeGT5WgRYQ=A@mail.gmail.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpvPaBwKdadCBC2LHTFGaEEjRN3ZrOC+PXp16aZKgPY=A@mail.gmail.com>
 <DM6PR04MB65756BE6093A5173C58CE9E4FCDB2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dc3524328a701be1ac3206af24b4a185@danman.eu>
 <CAPDyKFrQc610OB+VaG=cKQys7+3pyB4m1DA4BZXeGT5WgRYQ=A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <43ef0045c1eb638b89160c7a7e9b617f@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-10 15:26, Ulf Hansson wrote:
> On Wed, 10 Jul 2024 at 07:21, Daniel Kucera <linux-mmc@danman.eu> 
> wrote:
>> 
>> On 2024-07-09 22:06, Avri Altman wrote:
>> >> If I understand correctly, there is no point in sending the CMD13
>> >> above, unless
>> >> this is the first attempt to initialize the card.
>> >> Therefore, it's better to move the whole part above, inside the below
>> >> if-clause
>> >> too, otherwise we would end up sending a CMD13 in cases when it's not
>> >> needed.
>> > R1_CARD_IS_LOCKED is CMD13 response, but already in CMD7 response as
>> > well,
>> > So theoretically you want to skip mmc_sd_setup_card altogether.
>> 
>> Do you mean to modify:
>> mmc_select_card(struct mmc_card *card)
>> to somehow return or save the R1 response to card struct?
> 
> I quite like this, as it avoids us from sending an unnecessary command
> during initialization.

Okay, but what if the host is SPI?

         if (!mmc_host_is_spi(host)) {
                 err = mmc_select_card(card);
                 if (err)
                         goto free_card;
         }

         err = mmc_sd_setup_card(host, card, oldcard != NULL);

> 
> A suggestion is to let  _mmc_select_card() take an additional
> out-parameter to provide the card's status. Then we can let
> mmc_select_card() parse the status - and if it finds that the card is
> locked, it can set a new state in card->state (similar to how we use
> MMC_STATE_BLOCKADDR, for example).
> 
> In another future step, we may also want to keep track of whether a
> locked card becomes unlocked. Using the card->state should work fine
> for that too, I think.
> 
> [...]
> 
> Kind regards
> Uffe
