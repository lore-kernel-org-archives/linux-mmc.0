From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
Date: Fri, 8 Oct 2010 08:26:53 -0700
Message-ID: <3C0EA036-A47A-4149-BE5C-D31C6D116475@marvell.com>
References: <DFA7B5FE-718A-484B-BA1D-D1B44E3A5A32@marvell.com>
 <4CAEC1FD.6060607@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51263 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752483Ab0JHP06 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Oct 2010 11:26:58 -0400
In-Reply-To: <4CAEC1FD.6060607@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



Adrian,

Let me rephrase my question.  

I don't see why both CAPS are needed and why the voltage is specified in the CAPS.  If my understanding is correct the voltage range supported by the host controller is known in the MMC layer.  If the voltage range is supported  and the MMC chip capability says it supports DDR in that range that should be enough for the mmc layer to decide to use DDR.  The host controller should only set the one CAPS option that say the controller supports DDR.
 
On Oct 8, 2010, at 12:02 AM, Adrian Hunter wrote:

> On 01/10/10 06:01, ext Philip Rakity wrote:
>> 
>> I was wondering if we could remove one of the CAPS for DDR voltage (MMC_CAP_1_8V_DDR and MMC_CAP_1_2V_DDR). Both 1.2 and 1.8v are defined in the JEDEC Standard No. 84-A441.
>> 
>> The sd 3.0 host controller only defines the option for 1.8v.  I cannot see a way to set 1.2v.
>> 
>> If this makes sense I can prepare a patch.--
> 
> If the host controller does not support 1.2V DDR then it should definitely
> not set MMC_CAP_1_2V_DDR.  That is precisely what the caps are for.
> 
> 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 

