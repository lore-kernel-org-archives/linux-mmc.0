Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7741C63
	for <linux-mmc@vger.kernel.org>; Mon,  5 May 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449339; cv=none; b=SiK7k66N+uUW4RS+pv3Ns384iuw8/WT+VmM1fgJ3fv3bikKz+2Pn70+2VFIxEN3vs7DE9vcF0OBEYyd83Ao1jj1dIJGiTSVGkfO2SfJnNIxbRzvK6Elm4bbETmtQME9FE0muvqDg5UjtuvNy4s+dP9eA93foOKoJvvKt+gvJkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449339; c=relaxed/simple;
	bh=qOiDsPGyW52iz27gqPAj4k3cSNTm4gcs8TGRaSPcHeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1zCxG+i1wkPWpQm1pQQlcCcEZgIaizPD63J8oQemXw7q+PsrEPOK3kDQuUZPeGYaR2Oi0GOhT+ygcoR9PLFwoU0Gm+w7Fw/0PgpQJbHYRDq7ndfYXxna5jWkOd7m3IKR967fMr5210R1BS26c2DhGoeipClfZp4rIlZ4wlI8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBvFe-0000yT-BA; Mon, 05 May 2025 14:48:54 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBvFd-001ESa-0i;
	Mon, 05 May 2025 14:48:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBvFd-004cTk-0D;
	Mon, 05 May 2025 14:48:53 +0200
Date: Mon, 5 May 2025 14:48:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: Re: [PATCH v4 0/4] mmc: handle undervoltage events and prevent eMMC
 corruption
Message-ID: <aBiztawScUfcLELt@pengutronix.de>
References: <20250310102229.381887-1-o.rempel@pengutronix.de>
 <CAPDyKFrC56BBJk=YAPWCCNYNqFAoY74_yH0ZXfNQEiDhaA2xJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFrC56BBJk=YAPWCCNYNqFAoY74_yH0ZXfNQEiDhaA2xJg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Hi Ulf,

Sorry for very late replay,

On Thu, Mar 20, 2025 at 03:36:32PM +0100, Ulf Hansson wrote:
> Hi Oleksij,
> 
> On Mon, 10 Mar 2025 at 11:22, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > changes v4:
> > - drop HPI and SDHCI related patches
> >
> > This patch set introduces a framework for handling undervoltage events
> > in the MMC subsystem. The goal is to improve system reliability by
> > ensuring graceful handling of power fluctuations that could otherwise
> > lead to metadata corruption, potentially rendering the eMMC chip
> > unusable or causing significant data loss.
> 
> Thanks for posting this! I will spend some time reviewing this next
> week and let you know my comments then.
> 
> However, I just wanted to let you know that I just posted a series [1]
> (forgot to cc you, sorry), which also reworks the way _mmc_suspend()
> understands what scenario it should be running. I am guessing that
> re-work is simplifying for your $subject series too. Maybe you would
> like to have a look?

Ah, very nice. The integration of undervoltage support is easier now.

I rebased by match on top of mmc/next branch and do some testing
tomorrow. If you have no other comments I'll send updated patches after
testing.

By the way, are you on embedded recipes this year?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
