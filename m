From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Sun, 11 Apr 2010 16:13:39 +0200
Message-ID: <n2n63386a3d1004110713w74a16713g13f32219b610d3a6@mail.gmail.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	 <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	 <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41388 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0DKONm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Apr 2010 10:13:42 -0400
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Russell,

are you OK with pushing these patches from this series:

patch 01 - <linux/amba/dma.h>
patch 08 - DMA for drivers/serial/amba-pl011.c

through Dan's async_tx / DMAengine tree?

I think those are the ones which need your Acked-by to proceed.

If you have some other idea of how these patches should be twisted
around please let me know!

Yours,
Linus Walleij
