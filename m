From: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
Date: Tue, 31 Aug 2010 08:14:16 +0200
Message-ID: <AANLkTimwqvE3ssqaqfe40V+51dRTxndqroBQUK9js_NR@mail.gmail.com>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
	<20100830132914.GA32266@oksana.dev.rtsoft.ru>
	<AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
	<AANLkTinhctfE_BTF3xtACMoqrtRiSNApQ3+qCaOJ=w7m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60455 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab0HaGOR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 02:14:17 -0400
Received: by qyk33 with SMTP id 33so6156452qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 23:14:17 -0700 (PDT)
In-Reply-To: <AANLkTinhctfE_BTF3xtACMoqrtRiSNApQ3+qCaOJ=w7m@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@lists.ozlabs.org

On Mon, Aug 30, 2010 at 7:46 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Mon, Aug 30, 2010 at 10:04 AM, Esben Haabendal
>> Hopefully, arm users will soon enjoy this driver/wrapper soon also.
>
> My hope is that even on ARM when the device tree is used I'll be able
> eliminate IRQs mapped to 0 (but I need to do a lot more research on
> how best to do that though). =A0Are you actually using this on ARM?

No.

> I'm okay with you keeping the NO_IRQ test for the short term though.

Ok.  I personally don't see a big problem with dropping it either, as
I don't actually
use it on ARM. But until at least ARM has NO_IRQ=3D=3D0, I just thought=
 it would be
the right thing to try to be compatible.

/Esben
