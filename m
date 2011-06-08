From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for
 max_segment_number
Date: Wed, 8 Jun 2011 14:23:27 +0900
Message-ID: <20110608142121T.fujita.tomonori@lab.ntt.co.jp>
References: <20110606094751.GC10508@n2100.arm.linux.org.uk>
	<20110606191041U.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:48675 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab1FHFYU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Jun 2011 01:24:20 -0400
In-Reply-To: <BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dan.j.williams@intel.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux@arm.linux.org.uk, cjb@laptop.org, patches@linaro.org, vinod.koul@intel.com, gregkh@suse.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Mon, 6 Jun 2011 11:48:56 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> dmaengine expands the class of dma providers to include standalone dma
> agents on a host bus (or elsewhere) in addition to the traditional bus
> mastering host-bus-adapters that the existing api understands.  So in
> the case of slave dma the dma capabilities of the block-device are
> irrelevant because another agent will do the transfer on behalf of the
> block-device driver.  So the value should be whatever the dma device
> driver says it is.

The dma parameter restriction could be due to software (HBA drivers,
or subsystem). The value should be whatever the dma device driver says
it is in such case?
