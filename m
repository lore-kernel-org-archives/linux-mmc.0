Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18B19A3
	for <linux-mmc@vger.kernel.org>; Fri, 24 Nov 2023 08:32:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r6Z6Z-0008Ui-5f; Fri, 24 Nov 2023 17:32:35 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r6Z6Y-00BJ4n-JF; Fri, 24 Nov 2023 17:32:34 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r6Z6Y-003ev6-Gi; Fri, 24 Nov 2023 17:32:34 +0100
Date: Fri, 24 Nov 2023 17:32:34 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <20231124163234.GC819414@pengutronix.de>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023112435-dazzler-crisped-04a6@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
> On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> > On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> > 
> > > > This came out of some discussions about trying to handle emergency power
> > > > failure notifications.
> > 
> > > I'm sorry, but I don't know what that means.  Are you saying that the
> > > kernel is now going to try to provide a hard guarantee that some devices
> > > are going to be shut down in X number of seconds when asked?  If so, why
> > > not do this in userspace?
> > 
> > No, it was initially (or when I initially saw it anyway) handling of
> > notifications from regulators that they're in trouble and we have some
> > small amount of time to do anything we might want to do about it before
> > we expire.
> 
> So we are going to guarantee a "time" in which we are going to do
> something?  Again, if that's required, why not do it in userspace using
> a RT kernel?

For the HW in question I have only 100ms time before power loss. By
doing it over use space some we will have even less time to react.

In fact, this is not a new requirement. It exist on different flavors of
automotive Linux for about 10 years. Linux in cars should be able to
handle voltage drops for example on ignition and so on. The only new thing is
the attempt to mainline it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
