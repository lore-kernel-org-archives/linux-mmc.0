From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 06:17:22 -0400
Message-ID: <877gsr5iz1.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com>
	<CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
	<20120822055151.GT24242@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120822055151.GT24242@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Wed, 22 Aug 2012 13:51:53 +0800")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Aug 22 2012, Shawn Guo wrote:
> The following is what I have on my mind.
>
> broken-cd	cd-gpios	implication
> -------------------------------------------
> no		no		SDHCI CD
> no		yes		GPIO CD
> yes		no		NO CD / Broken CD
> yes		yes		Invalid
>
> yes: property presents
> no: property does not present

This matches Mitch's last suggestion exactly -- I think we're all agreed
on these properties now.  The only remaining question is how to handle
the pinctrl for CD in Thomas's case.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
