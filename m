From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 09:54:30 -0400
Message-ID: <87txvv3ucp.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org>
	<20120822122655.GW24242@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120822122655.GW24242@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Wed, 22 Aug 2012 20:26:56 +0800")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On Wed, Aug 22 2012, Shawn Guo wrote:
>     mmc: sdhci: Always pass clock request value zero to set_clock host op
>
>     To allow the set_clock host op to disable the SDCLK source when not
>     needed, always call the host op when the requested clock speed is
>     zero.  Do this even if host->clock already equals zero, because
>     the SDHCI driver may set that value (without calling the host op)
>     to force an update at the next (non-zero-speed) call.
>
>     Signed-off-by: Todd Poynor <toddpoynor@google.com>
>     Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
> Reverting the commit will get "controller" mode back to work.

Weird; I wonder how that's related to card detection.

I'm afraid it's ultimately a driver bug -- esdhc should be able to
handle having set_clock called with a value of 0.  It seems to have
a case in esdhc_set_clock() for 0, so I'm surprised it's not working.

What's the symptom of the failure?  Can you debug some more?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
