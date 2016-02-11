From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 07:02:41 -0800
Message-ID: <20160211150240.GR19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-2-git-send-email-tony@atomide.com>
 <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-serial@vger.kernel.org, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160211 02:19]:
> On 11 February 2016 at 00:02, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Ulf, I'd like to merge this along with other related fixes via the
> > ARM SoC tree if no objections, please review and ack if this look OK
> > to you.
> 
> I have some other omap_hsmmc patches queued for 4.6, so I prefer to
> send this via my mmc tree.
> 
> I guess that's okay as well!?

Naturally yes, please go ahead thanks!

Regards,

Tony
