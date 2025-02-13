Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6F20C01E
	for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437081; cv=none; b=pLiymKTPASZdnqoyr3I8I+aV4Y5Vr8pNemmXDEf9te8WCEqZAfUAT7/gnnMXTPWxCHFb4WbvGwx47f6LAfFjm1mqlrqmqsps8ZuR78Lq66uVSpbriX1VS9SggQ5ZqIh61jjJA26SrAQgrGWwW+AkLZ/uhfhRmyMd9GIfpqjH0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437081; c=relaxed/simple;
	bh=s8sXWMDu/QUnoFTZ22/hDVtpPDaq0QP9ZU6cEyAHFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atWxTZ1JHwCWd+d38da69/oZ1KDY561BKQswR8YCxlYWk6o/zpDtPW+SfN1K6Vz1/bUeMwWiK52zvYkYcI2pMtmV1u+8GOYfv3Bfbum7pPKCfVFOFGzDA6b7DYu0f4V27gCDA9KvDGla8jM15R9+400WIk3Qzm4dd3NVNO39sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tiV2h-0005U2-Jz; Thu, 13 Feb 2025 09:57:55 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tiV2h-000ipD-0K;
	Thu, 13 Feb 2025 09:57:55 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tiV2h-00CoLM-00;
	Thu, 13 Feb 2025 09:57:55 +0100
Date: Thu, 13 Feb 2025 09:57:54 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] mmc: core: Handle undervoltage events and
 register regulator notifiers
Message-ID: <Z620Ei5FwhhPfBu9@pengutronix.de>
References: <20250212132403.3978175-1-o.rempel@pengutronix.de>
 <96959ef4-2287-4601-85fb-2ce457c605d2@arm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96959ef4-2287-4601-85fb-2ce457c605d2@arm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On Wed, Feb 12, 2025 at 11:47:08PM +0000, Christian Loehle wrote:
> On 2/12/25 13:24, Oleksij Rempel wrote:
> > Extend the MMC core to handle undervoltage events by implementing
> > infrastructure to notify the MMC bus about voltage drops.
> > 
> > Background & Decision at LPC24:
> > 
> > This solution was proposed and refined during LPC24 in the talk
> > "Graceful Under Pressure: Prioritizing Shutdown to Protect Your Data in
> > Embedded Systems" which aimed to address how Linux should handle power
> > fluctuations in embedded devices to prevent data corruption or storage
> > damage.
> > 
> > At the time, multiple possible solutions were considered:
> > 
> > 1. Triggering a system-wide suspend or shutdown: when undervoltage is
> >    detected, with device-specific prioritization to ensure critical
> >    components shut down first.
> >    - This approach was disliked by Greg Kroah-Hartman, as it introduced
> >      complexity and was not suitable for all use cases.
> > 
> > 2. Notifying relevant devices through the regulator framework: to allow
> >    graceful per-device handling.
> >    - This approach was agreed upon as the most acceptable: by participants
> >      in the discussion, including Greg Kroah-Hartman, Mark Brown,
> >      and Rafael J. Wysocki.
> >    - This patch implements that decision by integrating undervoltage
> >      handling into the MMC subsystem.
> > 
> > This patch was tested on iMX8MP based system with SDHCI controller.
> 
> Any details here? How long does it take from undervoltage to
> poweroff notification.

On this system, with current implementation, it takes 4.5 millisecond
from voltage drop detection to mmc_poweroff_notify.

> Roughly how long of a heads up would that yield in realistic
> undervoltage scenarios?

It depends on the board implementation and attached power supply.
In my case, the testing system provides about 100ms capacity on board.
The power supply provides additional 1-2 seconds.

If the power is cut between power supply and board, we will have max
100ms.

> > +static int _mmc_handle_undervoltage(struct mmc_host *host)
> > +{
> > +	return mmc_shutdown(host);
> > +}
> > +
> 
> The poweroff notification part I understand, because it polls for busy
> (i.e. hopefully until the card thinks it's done committing to flash).
> Poweroff isn't always available though, the other paths of
> _mmc_suspend() are:
> 
> 	else if (mmc_can_sleep(host->card))
> 		err = mmc_sleep(host);
> 	else if (!mmc_host_is_spi(host))
> 		err = mmc_deselect_cards(host);
> 
> 	if (!err) {
> 		mmc_power_off(host);
> 
> So we may also just deselect, which AFAIR succeeds as a FSM (i.e.
> doesn't mean anything was committed to flash) and then we just
> poweroff.
> Is that what we want in an undervoltage scenario?

Yes. In an undervoltage scenario, our primary priority is to protect the
hardware from damage. Data integrity is secondary in this case. The most
critical action is to immediately stop writing to the card.  

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
