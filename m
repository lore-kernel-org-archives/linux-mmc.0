From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 13:15:58 +0200
Message-ID: <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	 <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	 <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	 <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	 <20100318092352.GD8267@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:34534 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab0CRLP7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 07:15:59 -0400
Received: by yxe29 with SMTP id 29so442880yxe.4
        for <linux-mmc@vger.kernel.org>; Thu, 18 Mar 2010 04:15:58 -0700 (PDT)
In-Reply-To: <20100318092352.GD8267@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Hemanth V <hemanthv@ti.com>, linux-mmc@vger.kernel.org, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

>> The only conclusion I came to so far is that ARMv5 where highmem wor=
ks
>> just fine in all cases has VIVT cache whereas ARMv6 has VIPT cache.
>> And the problem with VIPT caches occurs when direct DMA is involved,
>> otherwise there is no problem if PIO or NFS is used. =C2=A0Sprinklin=
g some
>> flush_cache_all() in a few places makes things work, but this is not=
 a
>> satisfactory solution.
>
> This sounds like the problem we had with the DMA API. =C2=A0Since tha=
t's now
> fixed, there shouldn't be a problem with the latest (-rc) kernels, or
> a kernel with my old streaming DMA patches applied.
The failure happens also on 2.6.34.rc1,  as Nico said, it looks like
that buffers that are subject to DMA remain dirty, as I understand it,
for vipt nonaliasing cpu's, the kernel doesn't clean user space cache
lines. if I force kmap_atomic/kunmap_atomic to highmem pages that are
not mapped by the kernel (kmap_high_get returns null), then the issue
disappears.
saeed
