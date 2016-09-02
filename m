From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] Documentation: mmc: sdhci-of-arasan: Add clk_syscon
 as an optional one
Date: Fri, 2 Sep 2016 12:14:18 -0500
Message-ID: <CAL_JsqKwDfwf1T8=u9JerkDxBUir=Qt=B=N-DZZ1Ljn=YYi7oQ@mail.gmail.com>
References: <1472457779-7194-1-git-send-email-shawn.lin@rock-chips.com>
 <1472457779-7194-2-git-send-email-shawn.lin@rock-chips.com>
 <20160902141508.GA20303@rob-hp-laptop> <CAD=FV=ViB8Fc579URi755ns+cKwuHC2orCqUSwh-fTpCi4TzqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=ViB8Fc579URi755ns+cKwuHC2orCqUSwh-fTpCi4TzqA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 2, 2016 at 11:12 AM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Rob,
>
> On Fri, Sep 2, 2016 at 7:15 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Mon, Aug 29, 2016 at 04:02:56PM +0800, Shawn Lin wrote:
>>> We introduced soc-ctl-syscon to do several things, for instance, update
>>> baseclk or update clkmul, etc. In odrder to access this physical block,
>>> we need to explicitly enable its clock. Currently we don't control this
>>> clock as we always add a CLK_IGNORE_UNUSED flag for it to indicate that
>>> we will not gate it even if not referenced. This is not a correct way since
>>> it is a clock parenting from clk_ahb which is used by sdhci-of-arasan now.
>>> Without enabling clk_ahb, the flag don't guarantee we could access
>>> soc-ctl-syscon. Moreover, we can't find a reason not to gate clk_syscon
>>> once we remove/power-down emmc controller. So let's add clk_syscon and
>>> enable/disable it explicitly when needed.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> index 3404afa..b04eb02 100644
>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> @@ -33,6 +33,9 @@ Optional Properties:
>>>    - clock-output-names: If specified, this will be the name of the card clock
>>>      which will be exposed by this device.  Required if #clock-cells is
>>>      specified.
>>> +  - clock-names: From clock bindings: Although we treat clock-names as required
>>> +    property, there is still one, "clk_syscon", should be optional as it depends
>>> +    on whether we need to control soc-ctl-syscon or not.
>>
>> No. This doesn't look right to me. The syscon is a separate block
>> and the clock for it belongs in the syscon node itself. Probably there
>> needs to be some sort of ref counting in the syscon so it can do
>> runtime-pm.
>
> I'm not an expert, but one thing to note is that this is actually a
> separate clock just for this small part of the GRF (general register
> files).  Yeah, it's bizarre.

I wasn't doubting that. Only that the connection is not to the sdhci block.

> Said another way, the GRF is a sorta hodgepodge location for all sorts
> of stuff.  ...included in there are the "corecfg" registers that are
> used by the SDHCI IP block.  Within the GRF register space these
> registers are 0x0f000 - 0x0f050 (last register is at 0x0f04c).  I
> believe that only registers in that special range need this clock.
>
> Maybe the right answer is that we should actually have had a sub-node
> of the GRF for these registers and then SDHCI should have referenced
> that as its syscon?

Sub-node or not is an orthogonal question. The main part is now we
have a syscon link and we need to power manage the syscon. Or is there
really a need to manage this clock at runtime? Perhaps it can just be
turned on and left on, but that should be in the syscon driver. The
SDHCI driver could retrieve the clocks from syscon node and manage it
directly. I'd be fine with that from a binding perspective, but seems
a bit hacky from a kernel perspective.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
