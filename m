From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec
 3.0
Date: Mon, 16 Aug 2010 20:27:48 +0100
Message-ID: <20100816192748.GC6263@console-pimps.org>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
 <4C696233.6000408@csr.com>
 <20100816182710.GA6338@console-pimps.org>
 <4C698956.101@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:37783 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756110Ab0HPT1v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 15:27:51 -0400
Content-Disposition: inline
In-Reply-To: <4C698956.101@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Aug 16, 2010 at 07:54:14PM +0100, David Vrabel wrote:
> Matt Fleming wrote:
> > 
> > Sorry, I did mean to reply to this sooner but I've been travelling. Yeah
> > David, you're right. Zhangfei, have you confused the Programmable Clock
> > Mode in the 3.00 spec here with 10-bit Divided Clock Mode?
> > 
> > Both 8-bit Divided Clock Mode and 10-bit Divided Clock Mode require the
> > divisor to be a power of two.
> 
> The power-of-two requirement only applies to 2.00 controller.  From
> section 2.2.14 of the spec.
> 
>    "(2) 10-bit Divided Clock Mode
>    Host Controller Version 3.00 supports this mandatory mode instead of
>    the 8-bit Divided Clock Mode. The length of divider is extended to
>    10bits and all divider values shall be supported."
> 
> 3.00 dividers can be any multiple of two.

Yep, you're right. I misread the spec. My bad.
