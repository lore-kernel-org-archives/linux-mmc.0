From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: Disable low power mode if SDIO interrupts
 are used
Date: Wed, 25 Jul 2012 19:02:16 +0900
Message-ID: <500FC428.8030305@samsung.com>
References: <CAD=FV=Wa1bCRvLNnFjhht6nvNorm3CRzX5zrn-YDA2Jec1K3Eg@mail.gmail.com>
 <1343149145-22927-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26272 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2GYKCd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jul 2012 06:02:33 -0400
In-reply-to: <1343149145-22927-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Olof Johansson <olofj@chromium.org>, shashidharh@vayavyalabs.com, ki0351.kim@samsung.com

> +
>  static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  {
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> @@ -871,6 +898,14 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  	/* Enable/disable Slot Specific SDIO interrupt */
>  	int_mask = mci_readl(host, INTMASK);
>  	if (enb) {
> +		/*
> +		 * Turn off low power mode if it was enabled.  This is a bit of
> +		 * a heavy operation and we disable / enable IRQs a lot, so
> +		 * we'll leave low power mode disabled and it will get
> +		 * re-enabled again in dw_mci_setup_bus().
> +		 */
> +		dw_mci_disable_low_power(mmc_priv(mmc));
Just use the slot. slot is already assigned to mmc_priv(mmc)

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>


