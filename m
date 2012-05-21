From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 3/4] mmc: dw_mmc: fix the wrong sequence
Date: Mon, 21 May 2012 11:16:59 +0100
Message-ID: <CAFbHwiRbD9dr5cF3F5xu0vWVrVOmoopnB8JG3oJF=djMc9d89w@mail.gmail.com>
References: <003401cd3640$e4767df0$ad6379d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53768 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab2EUKQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 06:16:59 -0400
Received: by dady13 with SMTP id y13so6618258dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 May 2012 03:16:59 -0700 (PDT)
In-Reply-To: <003401cd3640$e4767df0$ad6379d0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Sun, May 20, 2012 at 5:27 AM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> Setting host->data to NULL is incorrect sequence in
> dw_mci_command_complete. This early setting makes
> the skip of dma_unmap_sg in dw_mci_dma_cleanup.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
