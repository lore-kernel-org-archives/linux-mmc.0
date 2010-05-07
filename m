From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
Date: Fri, 7 May 2010 21:31:40 +0900
Message-ID: <j2r1b68c6791005070531u57b4b1basc56d45d0e06b1d04@mail.gmail.com>
References: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
	 <i2t63386a3d1005070213u2ad32613w694be1ecbeb46856@mail.gmail.com>
	 <20100507093256.GB19936@n2100.arm.linux.org.uk>
	 <x2j63386a3d1005070443yfadbaf3ct8686a8f7aae6412f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54029 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab0EGMbm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2010 08:31:42 -0400
In-Reply-To: <x2j63386a3d1005070443yfadbaf3ct8686a8f7aae6412f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>, Dan Williams <dan.j.williams@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, May 7, 2010 at 8:43 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/5/7 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> Or let me put it another way - if people are happy for Linux to support
>> new ARM CPU architectures, but with very little attention given to DMA
>> support on those architectures, then feel free to box the ARM platforms
>> into a corner on DMA support - but on the understanding that _you_ will
>> have to deal with the DMA API breakage on those architectures yourself.
>> Because with ARM platforms not having DMA support, there's absolutely
>> no way to run any checks what so ever on DMA when the CPU architecture
>> support is created.
>
> I'm doing the best I can to meet exactly this goal. The changes done in
> the DMA engine were done towards the end of making the DMA
> engine support *any* DMA controller for the PrimeCells,
with due respect, I think DMA Engine API is very restricting. And it is not
just the 'async' character of it but also some desirable features like
Circular-Linked-Buffer are missing. It may be good enough for Mem->Mem
but is found wanting for Mem<->Dev transfers.
I would like to see some new API defined that address reasonable
requirements of extant platform specific implementations.

> So now I guess I have to make it tick on the block known as PL080/PL081
> as well, and I'll have a try at it.
I always hoped the pl080 core would be segregated out of S3C implementation,
but for some new common DMA API.
