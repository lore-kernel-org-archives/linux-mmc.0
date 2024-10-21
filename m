Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBD1EEE0
	for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493586; cv=none; b=pUt7Yqn4EVhux5K3cyro1axnUp8BwFBl5WeaIn3sSTKabY5aEhYixhiSVbIsmbt2gToCm4/cLBAP62QOsWuAkT47XrbeOxMQwEKaNyCnqn26lUjEp0iiGzvLjar+cmVM71zI3ZiQLixWTbU9htcPm+oCzTltlPVIWuUzr60mMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493586; c=relaxed/simple;
	bh=gJW+xKiNt2Bu9JJVERXHzUdIj2hOtgdERCGzLOekrfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnj3plgPdMb5GCJqIDCUeGE0vitYV+YhCjxYNT907zH/DnW3MwLF2x4p06NAHhvKElLdgGZihBEiefjtwrZkxKrjXfx5nOmr68c5GPNlmI7Qd0kWDm60ATQqd+KZofhh7l/YDGD2s1Mds/WHDvEiB2Lc87dc/Qbrt9Kf4K7gYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t2mHj-00048P-3d; Mon, 21 Oct 2024 08:52:59 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t2mHi-000eIu-28;
	Mon, 21 Oct 2024 08:52:58 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t2mHi-005e9d-1o;
	Mon, 21 Oct 2024 08:52:58 +0200
Date: Mon, 21 Oct 2024 08:52:58 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Message-ID: <20241021065258.w56zhl7y3loanjwi@pengutronix.de>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
 <20241005182632.GA496820-robh@kernel.org>
 <92a27d06-cd37-42ff-ac48-687981d24d41@leica-geosystems.com>
 <20241007155939.GA849826-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007155939.GA849826-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On 24-10-07, Rob Herring wrote:
> On Mon, Oct 07, 2024 at 03:32:42PM +0000, POPESCU Catalin wrote:
> > On 05/10/2024 20:26, Rob Herring wrote:
> > > [Some people who received this message don't often get email from robh@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
> > >
> > >
> > > On Fri, Oct 04, 2024 at 02:07:39PM +0200, Catalin Popescu wrote:
> > >> Add compatible value "mmc-pwrseq-simple-reset" to support reset control
> > >> instead of gpios. Reset controls being refcounted, they allow to use
> > >> shared resets or gpios across drivers. Support of reset control is
> > >> limited to one single reset control.
> > > Can't you do this without a binding change? Just use reset controls when
> > > there is only 1 GPIO.
> > 
> > That's a good question. The idea was to keep in place the gpio support 
> > w/o impacting any platform using pwrseq-simple.
> 
> Why would it matter? If not shared, then the behavior should be the 
> same. If shared, we want to maintain the broken behavior?

My two cents on this. This will break systems which haven't the
RESET_GPIO driver enabled yet. Therefore we may get regressions mails.
I'm fine with it if that is okay.

Regards,
  Marco

> > Also, later on when support for a list of reset gpios will be added to 
> > the reset framework, this would not work anymore...
> 
> Why not?
> 
> How an OS handles reset-gpios is up to the OS. It can evolve. The 
> binding can't evolve because it is an ABI.
> 
> Also, a list is kind of broken to begin with for a "generic" binding. 
> What's the order the lines should be asserted/deasserted? What about 
> timing requirements? You don't know because every device is different. 
> This binding would not be accepted now, so extending it is questionable.
> 
> Rob
> 
