From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] MMC: meson: initial support for GXBB platforms
Date: Wed, 7 Sep 2016 18:18:25 -0700
Message-ID: <20160908011825.GA19921@codeaurora.org>
References: <20160803231843.23012-1-khilman@baylibre.com>
 <20160803231843.23012-2-khilman@baylibre.com>
 <20160823012124.GQ6502@codeaurora.org>
 <7hy433qpoo.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7hy433qpoo.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xing Wu <xing.xu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/07, Kevin Hilman wrote:
> Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> writes:
> > On 08/03, Kevin Hilman wrote:
> >> +	host->mux.hw.init = &init;
> >> +
> >> +	host->mux_clk = devm_clk_register(host->dev, &host->mux.hw);
> >
> > Hmm I was hoping to get rid of devm_clk_register() and replace it
> > with devm_clk_hw_register() instead. All part of my grand plan to
> > split providers from consumers, but this driver is different in
> > the sense that it registers clks to provide to itself. Maybe we
> > should make __clk_create_clk() into a real clk provider API so
> > that we can use devm_clk_hw_register() here and then generate a
> > clk for this device from the hw structure.
> 
> So is there something else I should do here, or can we rework this later
> after you rework the framework a bit?
> 

That can wait for later. If nobody takes care of it I'll do it
when I get around to it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
