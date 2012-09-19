From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT property for broken voltage quirk
Date: Wed, 19 Sep 2012 06:24:46 -0400
Message-ID: <m3a9wmgvip.fsf@pullcord.laptop.org>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
	<1346748609-11115-2-git-send-email-t.figa@samsung.com>
	<m38vc6k1qu.fsf@pullcord.laptop.org> <1587150.uFGRdL0s8e@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1587150.uFGRdL0s8e@amdc1227> (Tomasz Figa's message of "Wed, 19
	Sep 2012 12:13:14 +0200")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Tomasz,

On Wed, Sep 19 2012, Tomasz Figa wrote:
> Hi Chris,
>
> On Wednesday 19 of September 2012 01:42:01 Chris Ball wrote:
>> On Tue, Sep 04 2012, Tomasz Figa wrote:
>> > Some boards use fixed voltage regulator for vmmc supply (e.g. for eMMC
>> > memories). MMC_CAP2_BROKEN_VOLTAGE must be enabled for them to operate
>> > correctly.
>>>
>> Is there a reason we can't make this a property on the regulator instead?
>
> Is there a reason we can't make this a property of the mmc subsystem? ;)
>
> Now, seriously, could you elaborate on this a bit more? Do you mean that a 
> regulator should provide a dummy set voltage operation that would accept 
> any voltage?

Sorry for the terseness.

It seems like we're encoding exactly the same information twice in two
different subsystems -- I don't see the point, so I'd like to think
about how we could do better.

For example, if we're only concerned about fixed regulators, could we
just detect a fixed regulator in the driver and avoid the failing call
to regulator_set_voltage() directly, without needing to go via this
capability?  Seems like the capability doesn't tell us anything we
couldn't already have known.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
