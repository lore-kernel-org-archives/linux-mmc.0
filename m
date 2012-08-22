From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 10:58:51 -0400
Message-ID: <87d32j2ct0.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com>
	<CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
	<20120822055151.GT24242@S2101-09.ap.freescale.net>
	<877gsr5iz1.fsf@octavius.laptop.org> <5034F2AD.7060801@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5034F2AD.7060801@wwwdotorg.org> (Stephen Warren's message of
	"Wed, 22 Aug 2012 08:54:37 -0600")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On Wed, Aug 22 2012, Stephen Warren wrote:
> On 08/22/2012 04:17 AM, Chris Ball wrote:
>> Hi,
>> 
>> On Wed, Aug 22 2012, Shawn Guo wrote:
>>> The following is what I have on my mind.
>>>
>>> broken-cd	cd-gpios	implication
>>> -------------------------------------------
>>> no		no		SDHCI CD
>>> no		yes		GPIO CD
>>> yes		no		NO CD / Broken CD
>>> yes		yes		Invalid
>>>
>>> yes: property presents
>>> no: property does not present
>> 
>> This matches Mitch's last suggestion exactly -- I think we're all agreed
>> on these properties now.  The only remaining question is how to handle
>> the pinctrl for CD in Thomas's case.
>
> Sorry if this has already been mentioned, but I assume the standard
> non-removable property overrides any of those, or is invalid in
> combination with any of those?

Yes, absolutely.  I'll make sure to explain that in the new version of
the document.  (I think the reason it hasn't been mentioned much in this
thread is that it's already part of the core bindings.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
