From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv4 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Wed, 21 Aug 2013 14:48:50 -0500
Message-ID: <1377114530.1554.13.camel@linux-builds1>
References: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
	 <1376498884-9199-2-git-send-email-dinguyen@altera.com>
	 <520EA97D.7050404@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:54076 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752497Ab3HUTst (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 15:48:49 -0400
In-Reply-To: <520EA97D.7050404@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, dinh.linux@gmail.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org

On Fri, 2013-08-16 at 16:36 -0600, Stephen Warren wrote:
> On 08/14/2013 10:48 AM, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> > +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
> > +		this where the register that controls the CIU clock phases
> > +		reside.
> 
> On the surface, this binding series seems OK, but I do have a question:
> how is the sysmgr phandle used?
> 
> I assume there's some register in this syscon device that resets or
> enables or otherwise controls this MSHC module. How does the code know
> which register it is? The phandle in the altr,sysmgr property would
> usually be followed by a/some cell(s) that encode this information, so
> that the MSHC driver doesn't have to know anything about the layout of
> the syscon registers, and so the sysconf driver doesn't have to know
> anything about the identity of the MSHC client device.

There is a #define SYSMGR_SDMMCGRP_CTRL_OFFSET that is in
dw_mmc-socfpga.c. This defines the offset from the base address that the
sysmgr phandle will give me.

> 
> That way, the MSHC driver will work fine if a HW designer has dropped
> the MSHC IP block into a completely different SoC with a different
> syscon register layout.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 



