From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 04/11] mmc: sdhci-of-arasan: Properly set
 corecfg_baseclkfreq on rk3399
Date: Thu, 16 Jun 2016 09:06:14 +0800
Message-ID: <15960cce-354b-5eb6-79b0-19f55e840b0d@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-5-git-send-email-dianders@chromium.org>
 <f5dcc018-bd60-87a7-798b-efc261e443dd@rock-chips.com>
 <CAD=FV=UzGZmwGTthqqO5Skxj5f0wsS5VKr4gYP2i9SUyGqvbjg@mail.gmail.com>
 <47a2dcd9-9c3c-8fde-2be0-40e305c25e8d@rock-chips.com>
 <CAD=FV=UL5tU8RWtHF=-pE8SA0jUcBsqQDOU0BrruXOF7yGh5xg@mail.gmail.com>
 <da1c9ae9-71d9-6e9d-7b9f-08485ee9178e@rock-chips.com>
 <CAD=FV=WGwiQqRNMSSX9OR6nAOwuu7CbULuz7BcNp-S=duqpLLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:51947 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbcFPBGb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 21:06:31 -0400
In-Reply-To: <CAD=FV=WGwiQqRNMSSX9OR6nAOwuu7CbULuz7BcNp-S=duqpLLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2016/6/14 10:13, Doug Anderson wrote:
> Shawn,
>
> On Mon, Jun 13, 2016 at 5:59 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> Even in the case that an SoC designer didn't put a value into
>>> corecfg_baseclkfreq that matched register[15:8], it seems very likely
>>> that the rate returned from the clk_get_rate() would match.
>>>
>>> I guess what I'm saying is that, to me, it seems like my patch isn't
>>> broken in any real systems.  If we ever find a system that needs this
>>> behavior in the future, we can add it.  Until then, it seems like my
>>> patch would be fine.  Do you agree?
>>
>>
>> I agree. But from the code itself, we should still use
>> SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN to see if we could get
>> it from internal register in case of some platforms don't
>> provide the clk stuff.. Sounds sane? :)
>
> Could we wait until there exists a SoC that needs to provide
> baseclkfreq in its sdhci_arasan_soc_ctl_map table and that needs this
> value copied from register[15:8]?

yes, I think the base clk got from clk framework shouldn't
make any difference with that from register[15:8] if implemented. And
we now decide how to get base clk in a certain variant driver which
menas we know that this variant would never implement register[15:8], so
it looks fine for your patch with only a nit that we should make sure
we toggle up the COMMON_CLK. I saw your v2.1 to deal with it, so I think
it's okay now to add

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> AKA:
>
> A) If you have a SoC where clk_get_rate() is right and software needs
> to set baseclkfreq manualy, then you should include "baseclkfreq" in
> your sdhci_arasan_soc_ctl_map table.  This is like rk3399.  Note that
> if _both_ clk_get_rate() and register[15:8] are right, that's fine.
> We can still use clk_get_rate() since it will be exactly the same as
> register[15:8].
>
> B) If you have a SoC that doesn't even expose corecfg_baseclkfreq to
> software control, just don't include "baseclkfreq" in your
> sdhci_arasan_soc_ctl_map table.  Easy.  This is how my patch treats
> anyone using the current "generic" bindings, but you could easily just
> specify an offset of "-1" for baseclkfreq if you didn't want to use
> the generic bindings but couldn't control baseclkfreq.
>
> C) If you have a SoC that provides a valid value in register[15:8] and
> clk_get_rate() is wrong and software is required to copy the value
> from register[15:8] to baseclkfreq, technically we should fix
> clk_get_rate() anyway.  It's good when common clock framework provides
> correct values.  NOTE: It seems very unlikely to me that
> register[15:8] would be right AND that software would be required to
> copy this value to baseclkfreq, but I suppose there are some pretty
> crazy hardware designs out there.
>
> D) If you have a SoC that provides a valid value in register[15:8] and
> clk_get_rate() is wrong and can't be fixed (REALLY?) and software is
> required to copy the value from register[15:8] to baseclkfreq, we will
> need to add new code.  My assertion is that such a SoC doesn't exist
> and is unlikely to ever exist, so I am hesitant to add extra code to
> support this SoC.
>
>
> With my patch, A) and B) are certainly handled.  I think C) is
> unlikely to exist, but if it did exist then I'd say we should fix
> clk_get_rate().  I think D) is VERY unlikely to exist.  If I'm shown
> proof of D) existing, I'm happy to submit a patch for it.  Until we
> see proof of D)'s existence, I don't think we should clutter the code
> with support for it.
>
>
> -Doug
>
>
>


-- 
Best Regards
Shawn Lin

