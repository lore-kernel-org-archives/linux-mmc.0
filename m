From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
 esdhc
Date: Fri, 12 Aug 2011 14:04:50 +0400
Message-ID: <20110812100450.GA23333@oksana.dev.rtsoft.ru>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
 <1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
 <20110722101512.GA1576@oksana.dev.rtsoft.ru>
 <2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54874 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab1HLKE4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Aug 2011 06:04:56 -0400
Received: by wyg24 with SMTP id 24so1997247wyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 12 Aug 2011 03:04:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Xu Lei-B33228 <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>

Hello,

On Fri, Aug 12, 2011 at 09:44:26AM +0000, Zang Roy-R61911 wrote:
[...]
> > We try to not pollute generic sdhci.c driver with chip-specific
> > quirks.
> > 
> > Maybe you can do the fixups via IO accessors? Or by introducing
> > some additional sdhci op?
> Anton,
> thanks for the comment, as we discussed, the original code use 8 bit byte operation,
> while in fact, on some powerpc platform, 32 bit operation is needed. 
> should it be possible fixed by adding some wrapper in IO accessors or introduce additional sdhci op?

I would do it in the IO accessors.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
