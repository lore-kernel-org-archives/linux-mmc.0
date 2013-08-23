From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv5 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 23 Aug 2013 16:29:31 -0600
Message-ID: <5217E24B.3090302@wwwdotorg.org>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com> <1377272686-13253-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50488 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab3HWW3f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 18:29:35 -0400
In-Reply-To: <1377272686-13253-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/23/2013 09:44 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

> +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
> +		this where the register that controls the CIU clock phases
> +		reside.
> +
> +* altr,ciu-clk-offset: The order of the cells should be:
> +	- First Cell: Offset of the register in the system_mgr node that controls
> +		the smpsel bits.
> +	- Second Cell: Shift value of the drvsel bits.
> +	- Third Cell: Shift value of the smpsel bits.

This almost solves the issues I was thinking of. A few more thoughts though:

* What if the sysmgr node has multiple reg entries. Is the offset cell
in altr,ciu-clk-offset an offset from the first reg entry, or across all
reg entries? It might be better to specify this as a reg index plus
offset, or allow the sysmgr node to define the format (#sysmgr-cells
perhaps).

* What if the drvsel and smpsel bits are in different registers, even
different sysmgr blocks? Wouldn't it be better to have 2 separate
properties, each one defining the location of one bit-field?

* bikeshed: altr,ciu-clk-offset isn't a great name; the value is more
than just an offset.

Putting those together, I might expect the following properties:

sysmgr: sysmgr {
    /* binding for sysmgr node must specify what those 3 cells are */
    #sysmgr-cells = <3>;
}

dwmmc {
    altr,drvsel-reg-field = <
        &sysmgr /* sysmgr phandle */
        0 /* reg index */
        0 /* reg offset */
        0 /* field bit position */
        3 /* field bit size */>;
    altr,smpsel-reg-field = <
        &sysmgr /* sysmgr phandle */
        0 /* reg index */
        0 /* reg offset */
        3 /* field bit position */
        3 /* field bit size */>;
};

That would allow the whole sysmgr concept to be completely generic.

But, this is a bit like representing raw register I/O in DT, which has
been frowned upon in the past.

Finally, what if the values for drvsel, smpsel are different in
different sysmgr implementations? Do you need a property that defines
that values?

Another option might be to define a semantic API between the two, such
that you only need a sysmgr=<&sysmgr> property, yet the driver for the
sysmgr node exposes a function sysmgr_set_dwmmc_drvsel_smpsel(struct
device_node *sysmgr_node, uint drvsel, uint smpsel); Now, the sysmgr
driver would have to implement that on any SoC that supported a dwmmc.

