From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API implementation
Date: Wed, 25 Apr 2012 00:51:09 +0300
Message-ID: <CANOLnOM29Mn2BTydX=C5FEu6evkS5W8eL87RwNmppJWuVLGjAQ@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55905 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901Ab2DXVvK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 17:51:10 -0400
In-Reply-To: <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Mon, Apr 23, 2012 at 7:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Since the driver becomes useless without DMA_ENGINE, we probably want
a 'depends on'?



--=20
Gra=C5=BEvydas
