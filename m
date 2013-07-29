From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 2/2 V2] mmc: esdhc: get voltage from dts file
Date: Mon, 29 Jul 2013 08:40:38 +0800
Message-ID: <51F5BA06.4080109@freescale.com>
References: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com> <20130726191858.GB14216@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:9303
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab3G2AkX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Jul 2013 20:40:23 -0400
In-Reply-To: <20130726191858.GB14216@lizard>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com

On 07/27/2013 03:18 AM, Anton Vorontsov wrote:
> On Thu, Jul 25, 2013 at 08:38:11AM +0800, Haijun Zhang wrote:
>> Add voltage-range support in esdhc of T4, So we can choose
>> to read voltages from dts file as one optional.
>> If we can get a valid voltage-range from device node, we use
>> this voltage as the final voltage support. Else we still read
>> from capacity or from other provider.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Development process nitpick...
>
> The code originated from me, but I did not sign off this patch...
>
> Per Documentation/SubmittingPatches:
>
>    The Signed-off-by: tag indicates that the signer was involved in the
>    development of the patch, or that he/she was in the patch's delivery path.
>
> The order of the sign-off lines also has a meaning. Putting my sign off
> below yours means that I was not only involved in the development of the
> patch but also somehow approved the patch (but I did not :).
>
> [..]
>> +void sdhci_get_voltage(struct platform_device *pdev)
> You still duplicate the code... Per my previous email, this should
> probably go into mmc/core (with the function renamed to something more
> generic, of course.)
>
> Thanks,
>
> Anton
>
Thanks Anton.

I'll correct this and resend the patch.

-- 
Thanks & Regards

Haijun


