From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string
 in bindings document
Date: Tue, 18 Oct 2016 13:08:52 -0700
Message-ID: <93502f42-ae86-742f-a8b1-3645005fa98e@broadcom.com>
References: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
 <1476297352-7812-2-git-send-email-scott.branden@broadcom.com>
 <20161018131614.lskxbdir3ghun5md@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161018131614.lskxbdir3ghun5md@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On 16-10-18 06:16 AM, Rob Herring wrote:
> On Wed, Oct 12, 2016 at 11:35:51AM -0700, Scott Branden wrote:
>> Adds brcm,sdhci-iproc compat string to DT bindings document for
>> the iProc SDHCI driver.
>>
>> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>> index be56d2b..aa58b94 100644
>> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>> @@ -7,6 +7,7 @@ Required properties:
>>  - compatible : Should be one of the following
>>  	       "brcm,bcm2835-sdhci"
>>  	       "brcm,sdhci-iproc-cygnus"
>> +	       "brcm,sdhci-iproc"
>
> Seems kind of generic. SoC specific compatible strings please.
>
The compatibility string is generic on purpose as it is not intended to 
be SoC specific but work on all new iproc SoCs that have the proper 
fixes in place for this block (unlike bcm2835 and cygnus class devices 
which can only do 32-bit accesses).  I could call it brcm,sdhci-iproc-v2 
if that is better or leave it as is.  Please let me know your preferences.

Regards,
Scott
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
