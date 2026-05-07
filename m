Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA87326930
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778130226; cv=none; b=oyX/v2sGFnCVuw4fQ0cJwRIq91tQqrNxYVAsxuYbLpqcG2ljBCvNDFNwWT+IVMxVe3xIeA9/YI1NM4mLydnkMzb6CnuZ6yiDMWV+1HReL97B9FfOJ0sL3yvtwZBd6a+NxQBQ3meFge2SqGVIm/6X1i1hSVahSh5Z67zgxcYF6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778130226; c=relaxed/simple;
	bh=IiGrSdWZ6mIzmzjTlRwv7UDHKGU0V37uuRS//Bndlsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwFR3hOpBKytPUhhORTTR6awytdPvRohOU0Zofw2A2JNgi1PCJ4nDDsmEhjvki0t0TcVxzWw46KdVs0m5iCB2wNYgd5sSN2ho3SVcMOo0iM7ZMpzK9YyDxav38nctDRDxxOGYNgjWw5N/p7IDZh2/LfenLasyNkeGAblvF1PbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wKqtS-0003N9-Az; Thu, 07 May 2026 07:03:26 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wKqtQ-000rL8-0B;
	Thu, 07 May 2026 07:03:24 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wKqtQ-00000005d0x-1ZaL;
	Thu, 07 May 2026 07:03:24 +0200
Date: Thu, 7 May 2026 07:03:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after
 SLEEP
Message-ID: <afwdHLv4xLifaopS@pengutronix.de>
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
 <737a7feb-6573-4c77-8102-08653b3ae9f4@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <737a7feb-6573-4c77-8102-08653b3ae9f4@broadcom.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Hi Florian,

On Wed, May 06, 2026 at 09:49:46AM -0700, Florian Fainelli wrote:
> On 4/13/26 11:05, Florian Fainelli wrote:
> > The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
> > which prevents the system from properly resuming from S3 warm boot where
> > the eMMC is necessary to pull in the boot components.
> > 
> > Add a quirk which prevents that specific device model from entering
> > SLEEP mode. There are no differences in the power consumption observed.
> > 
> > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Any feedback on this?

Hm, can the sleep call be executed before mmcblk driver is loaded?
For example by under-voltage signal? In this case the quirk will not
be applied. May be better to put this quirk in mmc_ext_csd_fixups[]?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
