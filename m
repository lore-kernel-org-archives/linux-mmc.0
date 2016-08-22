From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
Date: Mon, 22 Aug 2016 10:02:59 +0100
Message-ID: <a758cbf9-abcb-a5b9-60ac-95ee59711112@arm.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
 <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
 <20160822075454.GB7104@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160822075454.GB7104@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 22/08/16 08:54, Maxime Ripard wrote:
> On Mon, Aug 01, 2016 at 02:11:09PM +0100, Andre Przywara wrote:
>> Hi Hans,
>>
>> On 30/07/16 15:25, Hans de Goede wrote:
>>> Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
>>> and newer.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>> Changes in v2:
>>> -New patch in v2 of this patch-set
>>> ---
>>>  arch/arm/boot/dts/sun6i-a31.dtsi     | 8 ++++----
>>>  arch/arm/boot/dts/sun7i-a20.dtsi     | 8 ++++----
>>>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
>>>  arch/arm/boot/dts/sun8i-h3.dtsi      | 6 +++---
>>>  4 files changed, 14 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>>> index 1867af2..0d24f10 100644
>>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>>> @@ -469,7 +469,7 @@
>>>  		};
>>>  
>>>  		mmc0: mmc@01c0f000 {
>>> -			compatible = "allwinner,sun5i-a13-mmc";
>>> +			compatible = "allwinner,sun7i-a20-mmc";
>>
>> But that breaks systems with newer DTs on older kernels, which do not
>> know about sun7i-a20-mmc.
> 
> That's not backward compatibility. That's the forward one, and that
> has never been something we supported.

I know, but it's unfortunate anyway and easy to fix with the above
mentioned fallback scheme.
So isn't that something that we can support anyway, despite it being not
strictly necessary? For instance I tend to load different kernels now
and then (different distro kernels, older versions for regression
checks, ...) and really like the fact that I can go with _one_ known
best DT.
I understand that that's not always possible, but on the other hand I
wouldn't give up so easily, especially if there is a nice way to achieve
compatibility without hurting anyone.

Cheers,
Andre.

> See https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt
> 
> Maxime
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
