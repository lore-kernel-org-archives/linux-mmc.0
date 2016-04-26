From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH v4 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Tue, 26 Apr 2016 14:23:16 +0200
Message-ID: <571F5DB4.7090303@axis.com>
References: <cover.1461246772.git.larper@axis.com> <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461246772.git.larper@axis.com> <20160422202733.GA11270@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160422202733.GA11270@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On 04/22/2016 10:27 PM, Rob Herring wrote:
> On Thu, Apr 21, 2016 at 03:55:42PM +0200, Lars Persson wrote:
>> Add a pinctrl binding to specify different pin settings for high speed
>> modes and UHS modes.
>>
>> Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>> index 8babdaa..6d1b797 100644
>> --- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>> +++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>> @@ -12,6 +12,12 @@ Optional properties:
>>
>>   - vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
>>   - vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
>> +- pinctrl-names: Can contain a "default" entry and a "state_uhs"
>
> Don't use underscores. Just "uhs" should be sufficient, right?

I do not object to this, but for consistency it seems better with 
state_uhs that existing bindings use.

>
>> +                 entry. The state_uhs entry is used together with the default
>> +                 entry when the board requires distinct settings for UHS speeds.
>> +
>> +- pinctrl-N: One property for each name listed in pinctrl-names, see
>> +             ../pinctrl/pinctrl-bindings.txt.
>>
>>   Additionally any standard mmc bindings from mmc.txt can be used.
>>
>> --
>> 2.1.4
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
