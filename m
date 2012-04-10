From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix switch from DMA to PIO
Date: Tue, 10 Apr 2012 10:54:22 +0100
Message-ID: <CAFbHwiRAE0G9Yr5Af5cUGsAxw8VNFu0s_NWQ6T3NsLZwGX_Y0Q@mail.gmail.com>
References: <000601cd16b4$5a409a40$0ec1cec0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58756 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab2DJJyX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 05:54:23 -0400
Received: by pbcun15 with SMTP id un15so6020070pbc.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 Apr 2012 02:54:22 -0700 (PDT)
In-Reply-To: <000601cd16b4$5a409a40$0ec1cec0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Tue, Apr 10, 2012 at 1:53 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> When dw_mci_pre_dma_transfer returns failure in some reasons,
> dw_mci_submit_data will prepare to switch the PIO mode from DMA.
> After switching to PIO mode, DMA(IDMAC in particular) is still
> enabled. This makes the corruption in handling interrupt and
> the driver lock-up.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

This looks ok to me.

Acked-by: Will Newton <will.newton@imgtec.com>
