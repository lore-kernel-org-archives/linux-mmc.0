From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/8] dmaengine: amba-pl08x: ensure physical channels are
 properly held
Date: Fri, 27 Apr 2012 22:38:08 +0200
Message-ID: <CACRpkdY8rJYQhUwtW1mtmnY8WB7T7mowefqOmiJdCZ1iS5E89A@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
	<E1SKRqh-0004b8-RH@rmk-PC.arm.linux.org.uk>
	<20120418101938.GM25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46603 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab2D0UiJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Apr 2012 16:38:09 -0400
Received: by yenl12 with SMTP id l12so711695yen.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 Apr 2012 13:38:08 -0700 (PDT)
In-Reply-To: <20120418101938.GM25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, Apr 18, 2012 at 12:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Oops, this patch wasn't supposed to be part of this set...

...however it gives me the impression that you have a patch set cooking
to also switch PL08x over to the virtual channel mechanism which is
really appetizing to see :-)

Yours,
Linus Walleij
