From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
Date: Tue, 13 Aug 2013 14:10:58 -0600
Message-ID: <520A92D2.2090208@wwwdotorg.org>
References: <1376322589-17606-1-git-send-email-dinguyen@altera.com>  <520A8E71.4090508@wwwdotorg.org> <1376423915.3167.2.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54710 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758929Ab3HMULD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Aug 2013 16:11:03 -0400
In-Reply-To: <1376423915.3167.2.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: dinh.linux@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/13/2013 01:58 PM, Dinh Nguyen wrote:
> On Tue, 2013-08-13 at 13:52 -0600, Stephen Warren wrote:
>> On 08/12/2013 09:49 AM, dinguyen@altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Add bindings for SD/MMC for SOCFPGA.
>>> Add "syscon" to the "altr,sys-mgr" binding.

>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>
>>>  		sysmgr@ffd08000 {
>>> -				compatible = "altr,sys-mgr";
>>> +				compatible = "altr,sys-mgr", "syscon";
>>
>> That seems like an unrelated change?
> 
> This patch is to enable SD/MMC for SOCFPGA. The "syscon" is needed in
> dw_mmc-socfpga.c as the clock phases for the SD IP is controlled by
> registers in "altr,sys-mgr".

But nothing in the dwmmc nodes refers to the syscon node, so how can the
syscon driver possibly provide services to the MMC driver; the MMC
driver won't be able to find it. I hope there's no back-door assumption
that some syscon exists, and that there's only one of them...
