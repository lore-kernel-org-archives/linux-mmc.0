From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
 first claimed
Date: Mon, 19 Dec 2011 13:17:24 +0100
Message-ID: <4EEF2B54.6050108@stericsson.com>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <201112141115.00945.rjw@sisk.pl> <4EE8849D.1010401@stericsson.com> <201112142236.26739.rjw@sisk.pl> <Pine.LNX.4.64.1112160954030.6572@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1112160954030.6572@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Wed, 14 Dec 2011, Rafael J. Wysocki wrote:
> 
>> On Wednesday, December 14, 2011, Ulf Hansson wrote:
> 
> [snip]
> 
>>> 2.
>>> When executing mmc/sd commands/requests the host must always be claimed 
>>> (and thus the host is always enabled).
> 
> Why? Why cannot we save some power between IO operations - if we can do 
> this quickly and safely without affecting functionality and throughput?
> 
>>> But more important some mmc/sd 
>>> commands must be executed as a sequence, without the host being disabled 
>>> in between the commands (since a disable might mean that the clock to 
>>> card gets disabled).
> 
> Ok, there might well be such command sequences, but my question is: who 
> knows about them? Is this mandated by the MMC(/SD/SDIO/...) standard or is 
> it host-specific? Also "might mean" is actually interesting here. I think 
> we eventually need a combination of timing-oriented PM constraints and 
> "stateful" ones. During such a command sequence you would require the card 
> clock to stay on.

MMC/SD/SDIO standard sets the requirement and must somehow "notify" the 
host about how to act in certain scenarios.

Just for information, I think one interesting host driver to look at is 
omap_hsmmc. For it's enable function is does pm_runtime_get_sync and for 
it's disable function it does pm_runtime_put_autosuspend, this to make 
sure the clock is enabled when it is needed.


> 
>>> To solve this, the mmc_claim_host is used, to make 
>>> sure the host is enabled during the complete command sequence.
>>>
>>> I happily continue this discussion, to see if someone more can break the 
>>> idea about having get_sync in mmc_host_enable. :-)
>> I'll leave this one to Guennadi, if you don't mind. :-)
> 
> As I said above, I think, we need both - to be able to require a certain 
> responsiveness / throughput and specific interface parameters like 
> supplying clock, power, etc.
> 
> Also notice, that setting a constraint doesn't affect in principle, when 
> the device is allowed to suspend. This is done as usual per 
> pm_runtime_get*() and _put*(). I think, a reasonable solution to use PM 
> QoS to impose timing constraints but at the same time to not disable the 
> hardware, when this is disallowed, is to tie pm_runtime_get() and _put() 
> calls to driver's .set_ios() method, like tmio_mmc and sh_mmcif drivers 
> currently do. Those drivers only call pm_runtime_put() when the interface 
> clock is gated. So, as long as the core is aware, that that IO sequence 
> has to run uninterrupted without stopping the clock between single 
> transfers, it just has to avoid gating the clock for that period and the 
> interface will not enter any power-saving mode.
> 
> So, I don't think we need to enforce pm_runtime_get_sync() in 
> mmc_claim_host().

You might be right; but still we need a way for the mmc framework to 
prevent the host driver from disabling clock etc to the card for some 
command sequences. As the omap driver solves it is to implement the 
enable/disable function and then call for get_sync and put in these 
functions, maybe that is the way how to solve this!?

Br
Ulf Hansson

