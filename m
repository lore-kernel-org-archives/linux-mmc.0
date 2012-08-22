From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 08:54:37 -0600
Message-ID: <5034F2AD.7060801@wwwdotorg.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org> <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com> <87k3ws5uhs.fsf@octavius.laptop.org> <201208211208.49987.arnd@arndb.de> <87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com> <87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com> <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com> <20120822055151.GT24242@S2101-09.ap.freescale.net> <877gsr5iz1.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59116 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab2HVOyl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 10:54:41 -0400
In-Reply-To: <877gsr5iz1.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

On 08/22/2012 04:17 AM, Chris Ball wrote:
> Hi,
> 
> On Wed, Aug 22 2012, Shawn Guo wrote:
>> The following is what I have on my mind.
>>
>> broken-cd	cd-gpios	implication
>> -------------------------------------------
>> no		no		SDHCI CD
>> no		yes		GPIO CD
>> yes		no		NO CD / Broken CD
>> yes		yes		Invalid
>>
>> yes: property presents
>> no: property does not present
> 
> This matches Mitch's last suggestion exactly -- I think we're all agreed
> on these properties now.  The only remaining question is how to handle
> the pinctrl for CD in Thomas's case.

Sorry if this has already been mentioned, but I assume the standard
non-removable property overrides any of those, or is invalid in
combination with any of those?
