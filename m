From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc: Add check for IDMAC configuration"
Date: Mon, 17 Sep 2012 12:15:46 +0100
Message-ID: <CAFbHwiRWkCoxm553u8Ep3hF3XZpBihA-2_FW2Y0sVq1RC3riHg@mail.gmail.com>
References: <00d801cd8fc4$738f8540$5aae8fc0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53236 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755837Ab2IQLPs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 07:15:48 -0400
Received: by lagy9 with SMTP id y9so4064007lag.19
        for <linux-mmc@vger.kernel.org>; Mon, 17 Sep 2012 04:15:47 -0700 (PDT)
In-Reply-To: <00d801cd8fc4$738f8540$5aae8fc0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, girish.shivananjappa@linaro.org, James Hogan <James.Hogan@imgtec.com>

On Tue, Sep 11, 2012 at 3:23 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This reverts commit 94c6cee91(Add check for IDMAC configuration).
> Synopsys says that only if internal dmac is not present, optional
> external dma interface is present. When internal dmac is present,
> '0' value in DMA_INTERFACE of HCON is reasonable. DMA_INTERFACE
> indicates external dma interface. And idmac initialization is
> prohibited now. So, let's revert this commit.
>
> CC: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   15 ++-------------
>  1 files changed, 2 insertions(+), 13 deletions(-)

I think this revert is a good idea. The original patch tries to check
whether IDMAC is supported and falls back to PIO, but it is not clear
to me that HCON gives you the appropriate information to do this (at
least in my version of the manual, I have not tried to clarify this
with Synopsys). Also falling back to PIO mode seems like it would
provide pretty awful performance, I would not expect to see instances
of this block with no DMA support anywhere other than FPGA so
configuring with IDMAC without it's presence would be a serious
misconfiguration in any case.

Acked-by: Will Newton <will.newton@imgtec.com>
