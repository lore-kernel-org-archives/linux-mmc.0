From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Tue, 23 Aug 2011 10:10:35 +0100
Message-ID: <CAFbHwiSgLgrnKeDaipa1MfWhcvP8yN3hGk3ZufKNpbJTTtfr5w@mail.gmail.com>
References: <1314087642-3450-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59157 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab1HWJKg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2011 05:10:36 -0400
Received: by pzk37 with SMTP id 37so10058129pzk.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 02:10:35 -0700 (PDT)
In-Reply-To: <1314087642-3450-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

On Tue, Aug 23, 2011 at 9:20 AM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> The Patch adds the support for SDIO interrupts for all slots.
> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_ir=
q
> and the handling of the slot specific interrupts in the Interrupt Ser=
vice
> Routine.
>
> Signed-off-by: shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 37 +++++++++++++++++++++++++++++++=
++----
> =A0drivers/mmc/host/dw_mmc.h | =A0 =A02 +-
> =A02 files changed, 34 insertions(+), 5 deletions(-)

This looks fine.

Acked-by: Will Newton <will.newton@imgtec.com>
