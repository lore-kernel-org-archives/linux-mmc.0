From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Mon, 22 Feb 2016 09:54:26 -0800
Message-ID: <20160222175426.GI13417@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-2-git-send-email-tony@atomide.com>
 <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
 <20160211150240.GR19432@atomide.com>
 <CAPDyKFo4Jyjwyvr3P5VHfDhQ87K9mnR01N-NtKz-yx2ycnfOLg@mail.gmail.com>
 <20160211172632.GT19432@atomide.com>
 <CAPDyKFpwGcCW_Vwz07cgh8LxGmxu9=GVch0MVJEpNJ19zoLZ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpwGcCW_Vwz07cgh8LxGmxu9=GVch0MVJEpNJ19zoLZ7g@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-serial@vger.kernel.org, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160212 05:00]:
> On 11 February 2016 at 18:26, Tony Lindgren <tony@atomide.com> wrote:
> > Subject: [PATCH] mmc: omap_hsmmc: Fix PM regression with deferred probe for
> >  pm_runtime_reinit
>
> Thanks, applied for fixes!

Ulf, any news on getting this into the mainline tree?

My PM tests have been now broken for six weeks or something
because of this!

Regards,

Tony
