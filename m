From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 13:51:53 +0800
Message-ID: <20120822055151.GT24242@S2101-09.ap.freescale.net>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
 <87k3ws5uhs.fsf@octavius.laptop.org>
 <201208211208.49987.arnd@arndb.de>
 <87393g5mic.fsf@octavius.laptop.org>
 <5033A34E.7040201@gmail.com>
 <87pq6k46jg.fsf@octavius.laptop.org>
 <5033B0F0.7050506@gmail.com>
 <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 21, 2012 at 11:03:59PM +0530, Thomas Abraham wrote:
> Ok, I agree with Rob. I was mixing pin muxing here. So if we have
> 'cd-gpios' and 'broken-cd' as generic bindings, would the following be
> valid?
> 
> [A] cd-gpios not present ,  broken-cd not present : This means that
> there is no card detect pin available. Controller drivers are free to
> infer this as "card detection is broken" and use implementation
> specific behavior.
> 
> [B] cd-gpio not present , broken-cd present :  This means that there
> is nothing connected to the card-detect pad of the mmc host
> controller. Controller drivers are free to use implementation specific
> behavior to deal with card detection.
> 
> [C] cd-gpio present, broken-cd not present : This means that 'cd-gpio'
> line connects card-detect pad of the controller to the card-detect pin
> of the mmc slot.
> 
> [D] cd-gpio present, broken-cd present : This means that there is
> nothing connected to the card-detect pad of the mmc host controller.
> Controller drivers are free to use the 'cd-gpio' line in any
> implementation specific way.
> 
The following is what I have on my mind.

broken-cd	cd-gpios	implication
-------------------------------------------
no		no		SDHCI CD
no		yes		GPIO CD
yes		no		NO CD / Broken CD
yes		yes		Invalid

yes: property presents
no: property does not present

-- 
Regards,
Shawn
