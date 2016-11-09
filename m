From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-iproc: support standard byte register
 accesses
Date: Wed, 9 Nov 2016 10:43:30 -0800
Message-ID: <f0e972d9-145c-e87d-f365-da74d6222679@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
 <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
 <c94dc018-5a2d-d50b-5746-43ae7fc258ce@intel.com>
 <132c772b-d4b9-c4b6-2eca-0393e7c995f9@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <132c772b-d4b9-c4b6-2eca-0393e7c995f9-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian/Ulf,

Please ignore my comments in last email I sent out.  The v2 patch 
documentation matches the code and is good.  I am confusing myself 
between internal versions and external upstream versions of this code.

On 16-11-09 10:38 AM, Scott Branden wrote:
> Hi Adrian/Ulf,
>
> On 16-11-08 01:55 AM, Adrian Hunter wrote:
>> On 01/11/16 18:37, Scott Branden wrote:
>>> Add bytewise register accesses support for newer versions of IPROC
>>> SDHCI controllers.
>>> Previous sdhci-iproc versions of SDIO controllers
>>> (such as Raspberry Pi and Cygnus) only allowed for 32-bit register
>>> accesses.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>> Signed-off-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>
>> This is unchanged from V1 which I acked, so:
> I updated the binding name in the documentation but forgot to change it
> in this patch.  Now that Rob has ack'd the binding documentation I will
> send out an updated patch with binding string in the code matching the
> ack'd documentation.
Ignore this - PATCH v2 is good.
>
>>
>> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
> With the minor change I will add your ack to the next version I send out.
>
> Thanks,
>  Scott


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
