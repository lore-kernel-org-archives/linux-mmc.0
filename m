From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 13 Jun 2016 15:48:15 +0800
Message-ID: <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <575E52AC.6000902-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Lemberg <alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2016/6/13 14:29, Adrian Hunter wrote:
> On 06/06/16 06:07, Shawn Lin wrote:
>> JEDEC eMMC v5.1 introduce an autonomously initiated method
>> for background operations.
>>
>> Host that wants to enable the device to perform background
>> operations during device idle time, should signal the device
>> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
>> this bit is set, the device may start or stop background operations
>> whenever it sees fit, without any notification to the host.
>>
>> When AUTO_EN bit is set, the host should keep the device power
>> active. The host may set or clear this bit at any time based on
>> its power constraints or other considerations.
>>
>> Currently the manual bkops is only be used under the async req
>> circumstances and it's a bit complicated to be controlled as the
>> perfect method is that we should do some idle monitor just as rpm
>> and send HPI each time if receiving rd/wr req. But it will impact
>> performance significantly, especially for random iops since the
>> weight of executing HPI against r/w small piece of LBAs is
>> nonnegligible.
>>
>> So we now prefer to select the auto one unconditionally if supported
>> which makes it as simple as possible. It should really good enough
>> for devices to manage its internal policy for bkops rather than the
>> host, which makes us believe that we could achieve the best
>> performance for all the devices implementing auto bkops and the only
>> thing we should do is to disable it when cutting off the power.
>
> Do you know if there is really a requirement to do that?

Even without bkops enable, no matter for manual or auto one, FTL should
always do bkops like GC internally when needed to guarantee the
performance and balance the wear leveling. What I thought to do is to
make it more explicitly.

Because then, what
> is the point of power off notification?

When power off notification is sent, bkops will be stopped
in _mmc_suspend. So I don't undertand your point here?

And why is AUTO_EN persistent across
> power failure?

Ahh, that's a problem need to be fixed, thanks for reminding.

>
>
>
>


-- 
Best Regards
Shawn Lin
