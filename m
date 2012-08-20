From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] omap-hsmmc: Implementation of i761 errata
Date: Mon, 20 Aug 2012 14:30:01 +0530
Message-ID: <CAM=Q2cs+oX6pYe=ME9At49QXfzJjsMjy0g0YidFD5F7JNBVYzQ@mail.gmail.com>
References: <1345219546-6646-1-git-send-email-semen.protsenko@ti.com>
	<CANfBPZ9NqZGN1LPNu+5DVWdkut2AL3O_8TWtWhBTufpdRZYZ_Q@mail.gmail.com>
	<CANwLT1SADwqn2Hgj2etiYyRu=TboT8DOfBsqjg02rrk6CYcFTw@mail.gmail.com>
	<CANfBPZ9iAuMmwGC_QuhM9k4MyAt4mgAYVSG3K3uMq=mOH_dewg@mail.gmail.com>
	<CAMQu2gzc4o_fYGk8Jgtd5tf89xh1N2e4DhN8MKE_Zm=eg_e1=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40146 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2HTJAF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Aug 2012 05:00:05 -0400
In-Reply-To: <CAMQu2gzc4o_fYGk8Jgtd5tf89xh1N2e4DhN8MKE_Zm=eg_e1=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Puttagunta, Viswanath" <vishp@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, linux-omap@vger.kernel.org, Volodymyr Ryazantsev <x0153367@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>

On Mon, Aug 20, 2012 at 12:25 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Mon, Aug 20, 2012 at 12:08 PM, S, Venkatraman <svenkatr@ti.com> wrote:
>>
>> On Fri, Aug 17, 2012 at 11:43 PM, Puttagunta, Viswanath <vishp@ti.com>
>> wrote:
[...]
>> >>> Signed-off-by: Semen Protsenko <semen.protsenko@ti.com>
>> >>
>> >> The implementation looks fine, but can we simply not set the errata
>> >> flag and make this as default
>> >> behaviour ? I suppose the documented behaviour with CSRE and RSP10 is
>> >> independent of the
>> >> errata..
>> >>
>> >> Also, please send it to the linux-mmc list as well.
>> >
>> > Vish>> We don't know if this errata effects OMAP5 as well. So, I think
>> > we should only do this if we are OMAP4.
>> >
>> That's precisely why the code shouldn't check for cpu_() flags. There are
>> other
>> OMAP variants as well and we can't check all of them
>> What I mean is to make the check for RSP10 and CSRE all the time as part
>> of the IRQ check.
>>   Then it equally applies to silcon with or without errata.
>
> Apart from above comment, please don't add the cpu_is_xxx() check inside
> device driver. You can pass that information from platform code
> while registering the MMC controllers using a flag and then just
> use that flag to enable/disable errata in the driver.

The other option is to check something like MMCHS_HL_REV to get the ip revision
and decide.


>
> Regards
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
