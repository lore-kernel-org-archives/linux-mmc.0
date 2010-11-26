From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/3] mmc: tmio: implement a bounce buffer for unaligned
 DMA
Date: Fri, 26 Nov 2010 13:04:44 +0100
Message-ID: <20101126120443.GI5520@sortiz-mobl>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
 <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab0KZMEr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Nov 2010 07:04:47 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Tue, Nov 23, 2010 at 05:24:15PM +0100, Guennadi Liakhovetski wrote:
> For example, with SDIO WLAN cards, some transfers happen with buffers at odd
> addresses, whereas the SH-Mobile DMA engine requires even addresses for SDHI.
> This patch extends the tmio driver with a bounce buffer, that is used for
> single entry scatter-gather lists both for sending and receiving. If we ever
> encounter unaligned transfers with multi-element sg lists, this patch will have
> to be extended. For now it just falls back to PIO in this and other unsupported
> cases.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
I'm not sure about who is going to carry those patches, probably not me
though.
So, for the MFD part:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
