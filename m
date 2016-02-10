From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Wed, 10 Feb 2016 12:07:19 -0800
Message-ID: <56BB9877.9000305@caviumnetworks.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Aleksey Makarov <aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 02/10/2016 11:01 AM, Ulf Hansson wrote:
> On 10 February 2016 at 18:36, Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
>> From: Aleksey Makarov <aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>> devices.  Device parameters are configured from device tree data.
>>
>> eMMC, MMC and SD devices are supported.
>>
>> Tested-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
>> Signed-off-by: Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> ---
>> v5:
>> Incoroprate comments from review
>> http://patchwork.linux-mips.org/patch/9558/
>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>    properties, since many devices have shipped with those properties
>>    embedded in firmware.
>> - Allow the <vmmc-supply> binding in addition to the legacy
>>    <gpios-power>.
>> - Remove the secondary driver for each slot.
>> - Use core gpio cd/wp handling
>
> Seems like you decided to ignore most comments realted to the DT
> bindings from the earlier version.
> Although, let's discuss this one more time.

I think you may have misread the patch.  The DT bindings have been
changed based on the feedback we received on v4.

>
> Therefore I recomend you to split this patch. DT documentation should
> be a separate patch preceeding the actual mmc driver patch.

You may have missed it the first time it was posted, but the legacy DT
bindings have been around for a while.

See:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-May/015482.html


> The DT patch needs to be acked by the DT maintainers.

The legacy DT has been deployed in firmware for several years now.  We
are adding more "modern" bindings, and the DT maintainers are
encouraged to review that portion, but the legacy is what it is and it
isn't changing.

>
> Until we somewhat agreed on the DT parts, I am going to defer the
> in-depth review of the driver code as I have limited bandwidth.
>

As I stated above, the legacy DT bindings are not changing and must be
supported.  Waiting for legacy DT bindings to change is equivalent to
infinite deferral.

> Does that make sense to you?
>

I understand why you would say this.  However, I think it doesn't
fully take into account the need to support devices that have already
been deployed.

That said, Matt really needs to get the DT maintainers reviewing the new 
DT bindings.


David Daney
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
