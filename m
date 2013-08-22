From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv4 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Thu, 22 Aug 2013 14:13:02 -0600
Message-ID: <521670CE.4000202@wwwdotorg.org>
References: <1376498884-9199-1-git-send-email-dinguyen@altera.com>  <1376498884-9199-2-git-send-email-dinguyen@altera.com>  <520EA97D.7050404@wwwdotorg.org> <1377114530.1554.13.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47037 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab3HVUNF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2013 16:13:05 -0400
In-Reply-To: <1377114530.1554.13.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, dinh.linux@gmail.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org

On 08/21/2013 01:48 PM, Dinh Nguyen wrote:
> On Fri, 2013-08-16 at 16:36 -0600, Stephen Warren wrote:
>> On 08/14/2013 10:48 AM, dinguyen@altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Add bindings for SD/MMC for SOCFPGA.
>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
>>
>>> +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
>>> +		this where the register that controls the CIU clock phases
>>> +		reside.
>>
>> On the surface, this binding series seems OK, but I do have a question:
>> how is the sysmgr phandle used?
>>
>> I assume there's some register in this syscon device that resets or
>> enables or otherwise controls this MSHC module. How does the code know
>> which register it is? The phandle in the altr,sysmgr property would
>> usually be followed by a/some cell(s) that encode this information, so
>> that the MSHC driver doesn't have to know anything about the layout of
>> the syscon registers, and so the sysconf driver doesn't have to know
>> anything about the identity of the MSHC client device.
> 
> There is a #define SYSMGR_SDMMCGRP_CTRL_OFFSET that is in
> dw_mmc-socfpga.c. This defines the offset from the base address that the
> sysmgr phandle will give me.

Hmmm. That doesn't sound good. That means that the SDMMC driver knows
internal details about some other HW module. It'd be better if either:

a) The sysmgr driver was required to provide an API to the SDMMC driver
to set up the CIU register as requested.

or:

b) The CIU register details were represented in DT.

Either of these would allow the SDMMC driver to operate unchanged on an
SoC with a different sysmgr register layout.
