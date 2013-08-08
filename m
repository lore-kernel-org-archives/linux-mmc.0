From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
Date: Thu, 08 Aug 2013 14:37:14 -0600
Message-ID: <5204017A.1040607@wwwdotorg.org>
References: <1375735392-6836-1-git-send-email-dinguyen@altera.com>  <5203FC1A.3090903@wwwdotorg.org> <1375993920.22740.9.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36775 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966335Ab3HHUhS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2013 16:37:18 -0400
In-Reply-To: <1375993920.22740.9.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: dinh.linux@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/08/2013 02:32 PM, Dinh Nguyen wrote:
> On Thu, 2013-08-08 at 14:14 -0600, Stephen Warren wrote:
>> On 08/05/2013 02:43 PM, dinguyen@altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Add bindings for SD/MMC for SOCFPGA.
>>> Add "syscon" to the "altr,sys-mgr" binding.
>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
>>> new file mode 100644
>>> index 0000000..dc14922
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
>>> @@ -0,0 +1,48 @@
>>> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
>>> +  Storage Host Controller
>>> +
>>> +Required Properties:
>>> +
>>> +* compatible: should be
>>> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
>>> +	  specific extensions.
>>> +
>>> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
>>> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
>>> +  value is fixed at 3, which means parent_clock/4.
>>
>> This feels like something that should be represented using the common
>> clock API; a driver should query the rate of its input clock, and then
>> calculate the MMC block's internal divider based on that (perhaps also
>> call clk_set_rate() on the input clock?).
> 
> This means a change to the dw_mmc driver, which I can look into for the
> next round? I have promised Pawel to consolidate the bindings for both
> exynos and socfpga in the next round already. I will also look into
> using the common clock API for the MMC as well. 
> 
> This patch is the only thing that is preventing from SD/MMC working for
> SOCFPGA in the mainline, can I get your Ack if I look into doing this
> for 3.13 for both the exynos and socfpga driver, and address your latter
> comments?

The problem is that if the binding supports or requires that property
now, it has to at least support it forever. Given that we're getting
serious about DT ABI now, we should be only introducing DT bindings that
we believe are complete and corrrect, rather than bindings which we
actively expect to be temporary and to change incompatibly later.
