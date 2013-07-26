From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 26 Jul 2013 15:13:01 -0600
Message-ID: <51F2E65D.8090705@wwwdotorg.org>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>  <51F2B0C4.8000301@wwwdotorg.org> <1374867220.20685.44.camel@linux-builds1>  <51F2D5EA.7050108@wwwdotorg.org> <1374871494.20685.46.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54639 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010Ab3GZVNF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 17:13:05 -0400
In-Reply-To: <1374871494.20685.46.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Chris Ball <cjb@laptop.org>, dinh.linux@gmail.com, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/26/2013 02:44 PM, Dinh Nguyen wrote:
> On Fri, 2013-07-26 at 14:02 -0600, Stephen Warren wrote:
>> On 07/26/2013 01:33 PM, Dinh Nguyen wrote:
>>> On Fri, 2013-07-26 at 11:24 -0600, Stephen Warren wrote:
>>>> On 07/25/2013 04:04 PM, dinguyen@altera.com wrote:
>>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>>>
>>>>> Add bindings for SD/MMC for SOCFPGA.
>>>>> Add "syscon" to the "altr,sys-mgr" binding.
>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
>>
>>>>> +Example:
>>>>> +
>>>>> +  The MSHC controller node can be split into two portions, SoC specific and
>>>>> +  board specific portions, as listed below.
>>>>
>>>> That doesn't sound like a good idea. There should be one DT node for
>>>> each logical block. The internal construction of the Linux drivers
>>>> (presumably you have entirely separate code to handle the two nodes in
>>>> Linux so far?) should not influence the DT construction at all.
>>>
>>> In the end, there is only 1 DT node for each logical block:
>>
>> Oh right, I see you were intending to show the distinction between the
>> SoC .dtsi and board .dts file. I hadn't realized that. I don't think
>> it's common to do that in the examples, so I would recommend just
>> merging the whole example together myself.
> 
> I'll merge it.
> 
>>
>>> dwmmc0@ff704000 {
>>> 	compatible = "altr,socfpga-dw-mshc";
>>
>> That should include the baseline synopsis compatible value too.
> 
> We don't need the baseline synopsis compatible because of
> dw_mci_pltfm_register() call.

It's not a matter of whether it's strictly necessary for the SW to work
right now. The compatible property should include entries for everything
that the HW is actually compatible with.

Of course, if a plain driver for the raw synopsis controller/binding
wouldn't actually work on this HW at all, without explicit knowledge of
the extra details of the more HW-specific binding, then that's a good
argument for leaving it out of compatible.
