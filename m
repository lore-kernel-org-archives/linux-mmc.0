From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Mon, 09 Apr 2012 10:48:07 -0400
Message-ID: <87pqbhx8pk.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<201203271619.13320.arnd@arndb.de> <4F7553D1.4030008@st.com>
	<201203301136.05038.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201203301136.05038.arnd@arndb.de> (Arnd Bergmann's message of
	"Fri, 30 Mar 2012 11:36:04 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, Thomas Abraham <thomas.abraham@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Fri, Mar 30 2012, Arnd Bergmann wrote:
> On Friday 30 March 2012, Viresh Kumar wrote:
>> On 3/27/2012 9:49 PM, Arnd Bergmann wrote:
>> > These bindings came up in a discussion IRC today. I think it's rather bad that
>> > we can't agree on a common way to name the properties for mmc. We have
>> > bindings being proposed or already included from Anton, Stephen, Shawn,
>> > Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
>> > for card detect and write protect, as well properties to define the bus
>> > width and high-speed modes, but we seem to have almost as many different
>> > definitions of these as we have drivers.
>> > 
>> > Can we please come up with a common binding for these?
>> 
>> Is there any progress on this? Sorry i wasn't following all mails.
>> How should i progress for sdhci-spear?
>
> No progress so far. I would suggest we apply the patch below to unify
> the bindings we have. I tried to minimize the impact by picking the most
> common version for each property, but if we know about devices that would
> get broken by this, we may have to be more careful.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks very much for doing this -- I'll be happy to take the patch in
mmc-next once you get time to post a v2 covering Stephen Warren's review
comments (and adding "max-frequency" to the document, I guess).

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
