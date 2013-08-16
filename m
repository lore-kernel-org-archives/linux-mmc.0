From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv4 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 16 Aug 2013 16:36:45 -0600
Message-ID: <520EA97D.7050404@wwwdotorg.org>
References: <1376498884-9199-1-git-send-email-dinguyen@altera.com> <1376498884-9199-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36604 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab3HPWgt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Aug 2013 18:36:49 -0400
In-Reply-To: <1376498884-9199-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/14/2013 10:48 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

> +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
> +		this where the register that controls the CIU clock phases
> +		reside.

On the surface, this binding series seems OK, but I do have a question:
how is the sysmgr phandle used?

I assume there's some register in this syscon device that resets or
enables or otherwise controls this MSHC module. How does the code know
which register it is? The phandle in the altr,sysmgr property would
usually be followed by a/some cell(s) that encode this information, so
that the MSHC driver doesn't have to know anything about the layout of
the syscon registers, and so the sysconf driver doesn't have to know
anything about the identity of the MSHC client device.

That way, the MSHC driver will work fine if a HW designer has dropped
the MSHC IP block into a completely different SoC with a different
syscon register layout.
