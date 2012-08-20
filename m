From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] omap-hsmmc: Implementation of i761 errata
Date: Mon, 20 Aug 2012 12:08:12 +0530
Message-ID: <CANfBPZ9iAuMmwGC_QuhM9k4MyAt4mgAYVSG3K3uMq=mOH_dewg@mail.gmail.com>
References: <1345219546-6646-1-git-send-email-semen.protsenko@ti.com>
 <CANfBPZ9NqZGN1LPNu+5DVWdkut2AL3O_8TWtWhBTufpdRZYZ_Q@mail.gmail.com> <CANwLT1SADwqn2Hgj2etiYyRu=TboT8DOfBsqjg02rrk6CYcFTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:55298 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785Ab2HTGie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Aug 2012 02:38:34 -0400
Received: by dadi14 with SMTP id i14so2396230dad.14
        for <linux-mmc@vger.kernel.org>; Sun, 19 Aug 2012 23:38:33 -0700 (PDT)
In-Reply-To: <CANwLT1SADwqn2Hgj2etiYyRu=TboT8DOfBsqjg02rrk6CYcFTw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Puttagunta, Viswanath" <vishp@ti.com>
Cc: Semen Protsenko <semen.protsenko@ti.com>, linux-omap@vger.kernel.org, Volodymyr Ryazantsev <x0153367@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

On Fri, Aug 17, 2012 at 11:43 PM, Puttagunta, Viswanath <vishp@ti.com> wrote:
> On Fri, Aug 17, 2012 at 12:28 PM, S, Venkatraman <svenkatr@ti.com> wrote:
>> On Fri, Aug 17, 2012 at 9:35 PM, Semen Protsenko <semen.protsenko@ti.com> wrote:
>>> Errata description:
>>> Due to a bad behavior of an internal signal, the Card Error interrupt bit
>>> MMCHS_STAT[28] CERR may not be set sometimes when an error occurred in the
>>> card response.
>>>
>>> Workaround:
>>> After responses of type R1/R1b for all cards and responses of type R5/R5b/R6
>>> for SD and SDIO cards, software must read two registers: MMCHS_RSP10 and
>>> MMCHS_CSRE. When a MMCHS_CSRE[i] bit is set to 1, if the corresponding bit at
>>> the same position in the response MMCHS_RSP10[i] is set to 1, the host
>>> controller indicates a card error and software should proceed in the same way
>>> as if a CERR interrupt would have been detected in the MMCHS_STAT register.
>>>
>>> Note:
>>> This errata is applicable for omap44xx.
>>>
>>> Signed-off-by: Semen Protsenko <semen.protsenko@ti.com>
>>
>> The implementation looks fine, but can we simply not set the errata
>> flag and make this as default
>> behaviour ? I suppose the documented behaviour with CSRE and RSP10 is
>> independent of the
>> errata..
>>
>> Also, please send it to the linux-mmc list as well.
>
> Vish>> We don't know if this errata effects OMAP5 as well. So, I think
> we should only do this if we are OMAP4.
>
That's precisely why the code shouldn't check for cpu_() flags. There are other
OMAP variants as well and we can't check all of them
What I mean is to make the check for RSP10 and CSRE all the time as part
of the IRQ check.
  Then it equally applies to silcon with or without errata.
