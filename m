From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Tue, 15 Mar 2011 17:38:27 +0900
Message-ID: <AANLkTinnc=w3Q1ytTDvy9nR=crKbdW3=A84xtu+jQn=-@mail.gmail.com>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
	<AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
	<20110310084158.GB6508@verge.net.au>
	<20110314012802.GD15317@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62320 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab1COIi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 04:38:29 -0400
In-Reply-To: <20110314012802.GD15317@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Simon,

On Mon, Mar 14, 2011 at 10:28 AM, Simon Horman <horms@verge.net.au> wro=
te:
> Hi Magnus,
>
> are the following also sh7372 specific?
>
> #define SDHI1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0(void __iomem *)0xe6860=
000
> #define SDHI_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHI1_BASE

Yes, you want to specify the base address of the SDHI hardware block
instance in the cpu specific code.

Thanks,

/ magnus
