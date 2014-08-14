From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add mmc0 and mmc1 aliases for rk3288
Date: Thu, 14 Aug 2014 11:57:02 +0800
Message-ID: <53EC338E.9060409@rock-chips.com>
References: <1407974880-30626-1-git-send-email-dianders@chromium.org>	<53EC177B.1080706@rock-chips.com> <CAD=FV=XNJ9RRnOaJ5e-D60S5vjZu6UbphdWqqfRq_YfZaXoq+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=XNJ9RRnOaJ5e-D60S5vjZu6UbphdWqqfRq_YfZaXoq+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

> Addy,
> 
> On Wed, Aug 13, 2014 at 6:57 PM, Addy <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> 
>> I think maybe it is suitable as follows:
>> mmc0 = &sdmmc
>> mmc1 = &sdio0
>> mmc2 = &sdio1
>> mmc3 = &emmc
> 
> Right, except the only ones that have landed in Heiko's tree are sdmmc
> and emmc, so we can't do sdio0 and sdio1 yet.  You could post support
> for sdio0 and adio1?

yes, I will post it today.
> 
> Also: it's really handy if emmc is 0.  See below: I don't think it's
> great to use the ID to find the sysconfig registers.
> 
> 
>> So we can get ctrl_id:
>> ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> 
> Somehow I hadn't realized that was there.  I guess we could use that
> too.  I'd vote to remove that and use the standard "mmc" numbering
> (and get some momentum to land those patches).  If you want I'll
> repost using the mshc stuff, though.
> 
> 
>> and can get offset of registers:
>> offset = 0x200 + ctrl_id * 8 + 4 * drive_or_sample
> 
> I thought the plan was to actually implement the phase stuff as a clock driver.
> 
> ...even if we didn't, I'd rather not rely on ID like this to find the
> right address.  It's really non-obvious.
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
