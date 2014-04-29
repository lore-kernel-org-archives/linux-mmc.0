From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 05/17] ARM: dts: sun4i: Add pin-muxing
 info for the mmc0 controller
Date: Tue, 29 Apr 2014 10:20:39 +0200
Message-ID: <535F60D7.1080500@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com> <1398507381-5614-6-git-send-email-hdegoede@redhat.com> <20140428193210.GF3134@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBZGB7WNAKGQEKUS4XGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140428193210.GF3134@lukather>
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

On 04/28/2014 09:32 PM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Sat, Apr 26, 2014 at 12:16:09PM +0200, Hans de Goede wrote:
>> mmc0 is the only controller actually being used on boards, so limit the
>> pin-muxing options to that.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/sun4i-a10.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index dce074b..29fd4f5 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -565,6 +565,20 @@
>>  				allwinner,drive = <0>;
>>  				allwinner,pull = <0>;
>>  			};
>> +
>> +			mmc0_pins_a: mmc0@0 {
>> +				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
>> +				allwinner,function = "mmc0";
>> +				allwinner,drive = <2>;
>> +				allwinner,pull = <0>;
>> +			};
>> +
>> +			mmc0_cd_pin_a: mmc0_cd_pin@0 {
>> +				allwinner,pins = "PH1";
>> +				allwinner,function = "gpio_in";
>> +				allwinner,drive = <0>;
>> +				allwinner,pull = <1>;
>> +			};
> 
> Actually, I like very much the reference_pin mention you had in your
> bindings documentation. Could you use it for this and the other
> patches?

Ok will fix this up for the next version.

Regards,

Hans
