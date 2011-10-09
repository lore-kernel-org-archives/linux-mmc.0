From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Sun, 9 Oct 2011 08:59:29 +0200
Message-ID: <CACRpkdY=DFW+J_pQetK38mPqic2iBuDWCx5QZTo-NkL1L37Fuw@mail.gmail.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
	<4E8F028C.10102@stericsson.com>
	<20111008091036.GF25689@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62750 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab1JIG7a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Oct 2011 02:59:30 -0400
Received: by iakk32 with SMTP id k32so6069862iak.19
        for <linux-mmc@vger.kernel.org>; Sat, 08 Oct 2011 23:59:30 -0700 (PDT)
In-Reply-To: <20111008091036.GF25689@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>

On Sat, Oct 8, 2011 at 11:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Oct 07, 2011 at 03:45:48PM +0200, Ulf Hansson wrote:
>
> Well, the patch system says that each one depends on the previous one,
> and the first one in the series contains the PIO read thing.
>
> Do 7108/1 onwards depend on 7106/1 and 7107/1 ?

Probably my fault, since I was helping Ulf out with the patch tracker
introduction.

The patches should be pretty much semantically orthogonal as
far as I can tell, the only reason dependency was stated that way
was that I couldn't tell from head-parsing whether there were
syntactical dependencies. (And wanted to avoid the annoyance
of non-applying patches...)

So if they apply, they are independent AFAICT.

Yours,
Linus Walleij
