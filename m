From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v2 0/4] mmc: dw_mmc: some fiex for hosw driver
Date: Tue, 22 May 2012 10:28:47 +0100
Message-ID: <CAFbHwiRWKBSTDzjQ89Z0u1xziwBpngyFM8cZs4WLR2m=1taEow@mail.gmail.com>
References: <006701cd37cf$76e576c0$64b06440$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55591 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757034Ab2EVJ2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 05:28:48 -0400
Received: by dady13 with SMTP id y13so8003405dad.19
        for <linux-mmc@vger.kernel.org>; Tue, 22 May 2012 02:28:48 -0700 (PDT)
In-Reply-To: <006701cd37cf$76e576c0$64b06440$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Tue, May 22, 2012 at 5:00 AM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> This patch-set includes fixes for the Synopsys DesignWare MMC driver
>
> Changes in v2:
> =A0 =A0 =A0 =A0- fix the error handling(mmc: dw_mmc: fix the IDMAC sw=
 reset)
>
> Seungwon Jeon (4):
> =A0 =A0 =A0mmc: dw_mmc: fix the transmission handling in IDMAC
> =A0 =A0 =A0mmc: dw_mmc: fix the IDMAC sw reset
> =A0 =A0 =A0mmc: dw_mmc: fix the wrong sequence
> =A0 =A0 =A0mmc: dw_mmc: correct the calculation for CLKDIV
>
> drivers/mmc/host/dw_mmc.c | =A0 36 +++++++++++++++++++---------------=
--
> 1 files changed, 19 insertions(+), 17 deletions(-)

The v2 series looks good to me.

Acked-by: Will Newton <will.newton@gmail.com>
