From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/4] mmc: dw_mmc: fix the transmission handling in IDMAC
Date: Mon, 21 May 2012 11:11:37 +0100
Message-ID: <CAFbHwiR+rHfmHpBfT0R7QVmkrJbCUVZ-wYT1=xVQeRbSL7F0jA@mail.gmail.com>
References: <003201cd3640$d940ec90$8bc2c5b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63997 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab2EUKLh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 06:11:37 -0400
Received: by pbbrp8 with SMTP id rp8so6740057pbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 May 2012 03:11:37 -0700 (PDT)
In-Reply-To: <003201cd3640$d940ec90$8bc2c5b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Sun, May 20, 2012 at 5:27 AM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> DTO interrupt can be later than transmit interrupt(IDMAC)
> in case of write. Current handling of IDMAC interrupt sets
> EVENT_DATA_COMPLETE as well as EVENT_XFER_COMPLETE regardless
> DTO rising. This makes the current request be finished in tasklet
> and permits the next request even though current data transfer
> is still in progress. As a result, sequence is broken and lock-up
> happens. Setting EVENT_DATA_COMPLETE is not proper after IDMAC
> interrupt. It should be taken after DTO interrupt is generated.
>
> Reported-by: Dmitry Shmidt <dimitrysh@android.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)

This looks ok, although I don't have any IDMAC hardware to test with.

Acked-by: Will Newton <will.newton@imgtec.com>
