From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/2] sh-mobile: enable both edges GPIO interrupts on sh7372
Date: Fri, 15 Jul 2011 20:14:23 +0900
Message-ID: <CANqRtoRin_mSERnYn8Q-dYJHc0O-kwa3YtmjCRDsUU=yEfDMEw@mail.gmail.com>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
	<Pine.LNX.4.64.1107151254300.22613@axis700.grange>
	<Pine.LNX.4.64.1107151256380.22613@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49652 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab1GOLOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2011 07:14:24 -0400
In-Reply-To: <Pine.LNX.4.64.1107151256380.22613@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

On Fri, Jul 15, 2011 at 7:58 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> IRQ-capable GPIOs on sh7372 can be configured to produce interrupts o=
n
> both edges.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <damm@opensource.se>
> ---
> =A0drivers/sh/intc/chip.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)

Acked-by: Magnus Damm <damm@opensource.se>
