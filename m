From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] regulator: treat regulators with constant volatage as
 fixed
Date: Tue, 20 Nov 2012 14:20:20 +0100
Message-ID: <50AB8394.1010207@samsung.com>
References: <20121113094255.GW18224@opensource.wolfsonmicro.com>
 <1352800177-16139-1-git-send-email-m.szyprowski@samsung.com>
 <20121114020124.GH4415@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20121114020124.GH4415@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

On 11/14/2012 3:01 AM, Mark Brown wrote:
> On Tue, Nov 13, 2012 at 10:49:37AM +0100, Marek Szyprowski wrote:
>
> > +	if (rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_VOLTAGE) {
> > +		if (rdev->desc->n_voltages)
> > +			return rdev->desc->n_voltages;
> > +		else
> > +			return -EINVAL;
> > +	} else {
> > +		return 1;
> > +	}
>
> Hrm, now I can read the logic I'm not convinced this is a good idea.
> This will report that we have an available voltage for devices which
> don't know their voltage (things like battery supplies often do this as
> the voltage is unregulated) and it will mean that we are doing something
> different for the case where there's only one voltage (reporting the
> restricted count instead of the physically supported count).
>
> I think we want a regulator_can_change_voltage() or possibly a count
> function (though I can't see any use cases except this) which answers
> the question directly instead of layering on top of this function.

Right, regulator_can_change_voltage() sounds much better than my hacky
approach. The first client would be probably sdhci/mmc driver, as
'can_change_voltage' check sounds much more appropriate than counting
available voltage values.

I will prepare patches soon.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
