From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: DT: Allow to specify that no write protect
 signal is present
Date: Tue, 05 May 2015 11:04:48 +0200
Message-ID: <554887B0.4020407@metafoo.de>
References: <1430214020-16816-1-git-send-email-lars@metafoo.de>	<1430214020-16816-2-git-send-email-lars@metafoo.de> <CAPDyKFpC9uc0n8HLiC1gWgdJOM-0DGVaNazkF3Q847r-sfXNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpC9uc0n8HLiC1gWgdJOM-0DGVaNazkF3Q847r-sfXNtg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 05/05/2015 10:36 AM, Ulf Hansson wrote:
[...]
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index 438899e..b068549 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -21,6 +21,7 @@ Optional properties:
>>     below for the case, when a GPIO is used for the CD line
>>   - wp-inverted: when present, polarity on the WP line is inverted. See the note
>>     below for the case, when a GPIO is used for the WP line
>> +- disable-wp: When set no physical WP line is present
>
> This requires some additional explanation, I believe. I assume this
> property is only relevant for those controllers that have internal
> logic to handle WP!?

Yes, currently drivers for controllers that have a built-in WP detection 
logic typically assume that if no WP GPIO is specified the built-in WP logic 
should be used. But for some of them the value returned by the internal 
detection logic will be bogus if there is no WP signal connected. So we need 
a way to specify that that there is no WP signal and the internal detection 
logic shouldn't be used either.

>
> For those that uses GPIO, this can't ever be a correct configuration. Right?

It wouldn't make much sense to use it with a GPIO based detection logic, 
since you simply don't specify the wp-gpio property if it is not present. 
One the other hand it wouldn't cause any harm to specify it in addition to 
not specifying the wp-gpios property.

How about:

- disable-wp: When set no physical WP line is present. This property should 
only be specified when the controller has a dedicated write-protect 
detection logic. If a GPIO is used for write-protect detection logic is used 
it is sufficient to not specify wp-gpios property in the absence of a WP line.

[...]

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
