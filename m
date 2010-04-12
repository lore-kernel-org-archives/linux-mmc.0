From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Mon, 12 Apr 2010 20:23:45 +0100
Message-ID: <20100412192345.GN3048@n2100.arm.linux.org.uk>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com> <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com> <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local> <n2n63386a3d1004110713w74a16713g13f32219b610d3a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47332 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab0DLTYM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2010 15:24:12 -0400
Content-Disposition: inline
In-Reply-To: <n2n63386a3d1004110713w74a16713g13f32219b610d3a6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Apr 11, 2010 at 04:13:39PM +0200, Linus Walleij wrote:
> Russell,
> 
> are you OK with pushing these patches from this series:
> 
> patch 01 - <linux/amba/dma.h>
> patch 08 - DMA for drivers/serial/amba-pl011.c
> 
> through Dan's async_tx / DMAengine tree?
> 
> I think those are the ones which need your Acked-by to proceed.
> 
> If you have some other idea of how these patches should be twisted
> around please let me know!

I do think it would be of value for someone to try to get this working
on the Realview boards to ensure that these patches are well proven...
unfortunately I don't have the bandwidth to do that at present.
