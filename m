From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Fri, 30 Mar 2012 12:03:53 +0530
Message-ID: <4F7553D1.4030008@st.com>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org> <201203271619.13320.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:52386 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754525Ab2C3Gfr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 02:35:47 -0400
In-Reply-To: <201203271619.13320.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>, "cjb@laptop.org" <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "patches@linaro.org" <patches@linaro.org>

On 3/27/2012 9:49 PM, Arnd Bergmann wrote:
> These bindings came up in a discussion IRC today. I think it's rather bad that
> we can't agree on a common way to name the properties for mmc. We have
> bindings being proposed or already included from Anton, Stephen, Shawn,
> Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
> for card detect and write protect, as well properties to define the bus
> width and high-speed modes, but we seem to have almost as many different
> definitions of these as we have drivers.
> 
> Can we please come up with a common binding for these?

Is there any progress on this? Sorry i wasn't following all mails.
How should i progress for sdhci-spear?

-- 
viresh
