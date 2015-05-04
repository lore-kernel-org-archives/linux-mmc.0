From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC documentation
 to support 4.9a version of Arasan SDHC controller.
Date: Mon, 4 May 2015 08:29:27 +0200
Message-ID: <7a375e19-7cae-48b7-9b34-25dd5ad8b739@BY2FFO11FD026.protection.gbl>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
	<1430456052-8888-4-git-send-email-stripathi@apm.com>
	<f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
 <CAOHikRBbOYHOmnzA6Ycu6hwdNL6SgmXKVK0NLtJQfJL9KULuxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOHikRBbOYHOmnzA6Ycu6hwdNL6SgmXKVK0NLtJQfJL9KULuxg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 05/04/2015 08:03 AM, Suman Tripathi wrote:
> Hi,
> 
> On Mon, May 4, 2015 at 11:30 AM, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
>> On 05/01/2015 06:54 AM, Suman Tripathi wrote:
>>> This patch updates Arasan SDHC documentation to support
>>> 4.9a version of Arasan SDHC controller.
>>>
>>> Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> index 98ee2ab..f01d41a 100644
>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>>
>>>  Required Properties:
>>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>>> +                'arasan,sdhci-4.9a'
>>>    - reg: From mmc bindings: Register location and length.
>>>    - clocks: From clock bindings: Handles to clock inputs.
>>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>>> @@ -18,7 +19,7 @@ Required Properties:
>>>
>>>  Example:
>>>       sdhci@e0100000 {
>>> -             compatible = "arasan,sdhci-8.9a";
>>> +             compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
>>
>> Is there any reason to change this example?
> 
> Thought that if dts is updated so why not update the binding too.

It is just about updating example. It is fine to update binding.

Thanks,
Michal
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
