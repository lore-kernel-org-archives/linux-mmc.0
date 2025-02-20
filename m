Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63C1F153C
	for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048977; cv=none; b=UUEw2AfuoSeHFXlkZ+0KYsMSy3bY6AWrkSEdsMhilS/FuKo+wzxrXD+8zJgPHySNNzUfEs69nX9qE/y2EjZKG7bHRT6YR2IqR9O7zvX/3nTfG6tHxwZljkVjCEmHZ7Pmolx6Uxq+bqtloddNFOjkqMYGDJc+lKyPV7fvvEyM9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048977; c=relaxed/simple;
	bh=AZ8pByUgDxIB+wqTibIJ3mjIR1Kc+wjA2PZxVI5tpFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZJBhwUbQHpW372UWYbX+jou7qRdwGSRSFTXRXHT3yve9opXjxWYi69RH/sfke3eCU4BmUjs+qxTc01YsE5XWSg5bgiWzXEf6mCzHe7Kaf5bRWG2dC629QCqA+DQSkOhcYUVp37hYY+tyFdgWr9mgpQnpHhUFD4gZV7DhDUGaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl4Dy-0001Kc-V5; Thu, 20 Feb 2025 11:56:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl4Dy-001vBZ-1a;
	Thu, 20 Feb 2025 11:56:10 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl4Dy-0084Uc-1E;
	Thu, 20 Feb 2025 11:56:10 +0100
Date: Thu, 20 Feb 2025 11:56:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v2 4/6] mmc: core: add undervoltage handler for MMC/eMMC
 devices
Message-ID: <Z7cKSuKWOedGVZ5G@pengutronix.de>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
 <20250220074429.2906141-5-o.rempel@pengutronix.de>
 <be715535-8931-489f-a2be-50aa6ec423a1@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be715535-8931-489f-a2be-50aa6ec423a1@arm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On Thu, Feb 20, 2025 at 10:47:01AM +0000, Christian Loehle wrote:
> On 2/20/25 07:44, Oleksij Rempel wrote:
> > Introduce _mmc_handle_undervoltage() to handle undervoltage events for
> > MMC/eMMC devices. This function interrupts ongoing operations using HPI
> > and performs a controlled suspend. After completing the sequence, the card
> > is marked as removed to prevent further interactions.
> > 
> > To support this, introduce __mmc_suspend() and __mmc_resume() as internal
> > helpers that omit mmc_claim_host()/mmc_release_host(), allowing them to be
> > called when the host is already claimed. Update mmc_shutdown() to skip the
> > normal shutdown sequence if the host is flagged as undervoltage to avoid
> > repeating of the shutdown procedure.
> 
> "of" can be removed here.
> 
> Given that this introduces large parts of the mmc handling IMO this commit
> deserves a lot more explanation of what steps exactly do for which cards
> and why.

ack

> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/mmc/core/mmc.c | 81 +++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 68 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 86b608843232..e626213e7a52 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -2104,8 +2104,8 @@ static int _mmc_flush_cache(struct mmc_host *host)
> >  	return err;
> >  }
> >  
> > -static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> > -			bool is_undervoltage)
> > +static int __mmc_suspend(struct mmc_host *host, bool is_suspend,
> > +			 bool is_undervoltage)
> 
> The is_undervoltage doesn't do anything? Did you forget something here?

This was done in the previous patch "mmc: core: refactor _mmc_suspend()
for undervoltage handling"

> > @@ -2189,6 +2205,9 @@ static int mmc_shutdown(struct mmc_host *host)
> >  {
> >  	int err = 0;
> >  
> > +	if (host->undervoltage)
> > +		return 0;
> > +
> 
> Probably deserves a comment.

ack

> >  	/*
> >  	 * In a specific case for poweroff notify, we need to resume the card
> >  	 * before we can shutdown it properly.
> > @@ -2280,6 +2299,41 @@ static int _mmc_hw_reset(struct mmc_host *host)
> >  	return mmc_init_card(host, card->ocr, card);
> >  }
> >  
> > +static int _mmc_handle_undervoltage(struct mmc_host *host)
> > +{
> > +	struct mmc_card *card = host->card;
> > +	int err = 0;
> > +
> > +	mmc_claim_host(host);
> > +
> > +	if (!host->card)
> > +		goto out;
> > +
> > +	if (mmc_can_poweroff_notify(host->card) &&
> > +		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
> > +		err = __mmc_resume(host);
> 
> I'm not sure I follow this.
> Why would we power-up a card that currently doesn't have power when we
> know we are about to powerfail it?

It is part of the mmc_shutdown, but it is not used on my HW. So, can be
skip it.

> > +
> > +	if (!err) {
> > +		err = mmc_interrupt_hpi(card);
> > +		if (err)
> > +			pr_err("%s: Interrupt HPI failed, error %d\n",
> > +				mmc_hostname(host), err);
> 
> There's no point in calling this for SD but I don't see why it currently
> wouldn't be called for SD.

I tried to keep budget low, until we agree that it is the way to go.
After this patch stack is accepted, i can try to request more time to
add and test the SD handler.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
