From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 10/17] ARM: dts: sun6i: Add mmc clocks
Date: Tue, 29 Apr 2014 10:29:02 +0200
Message-ID: <535F62CE.20606@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com> <1398507381-5614-11-git-send-email-hdegoede@redhat.com> <20140428193753.GJ3134@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBV6F7WNAKGQEOO42BAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140428193753.GJ3134@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 04/28/2014 09:37 PM, Maxime Ripard wrote:
> On Sat, Apr 26, 2014 at 12:16:14PM +0200, Hans de Goede wrote:
>> Add clk-nodes for the mmc clocks.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index d45efa7..12bcc17 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -198,6 +198,38 @@
>>  					"apb2_uart4", "apb2_uart5";
>>  		};
>>  
>> +		mmc0_clk: clk@01c20088 {
>> +			#clock-cells = <0>;
>> +			compatible = "allwinner,sun4i-a10-mod0-clk";
> 
> And this is not misleading but wrong. The MMC clocks have the phase
> control feature that mod0 clock don't have, so they should have a
> compatible of their own.

You said the same thing when I posted v8, and I replied to that, that
this is the exact same construction used as with sun4i, sun5i and sun7i.

I agree this needs to be fixed, but it needs to be fixed for *all* of
them, and IMHO it is best to be consistently "wrong" for now and then
fix them all in one go (and all in the same way) when we've landed a
generic way of dealing with phase-control.

So for now I'm going to keep this as is, iow the same as the clock
bindings for mmc which we already have for sun4i, sun5i and sun7i
which all have the same issue.

Regards,

Hans
