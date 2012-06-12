From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v7 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Tue, 12 Jun 2012 12:12:49 +0900
Message-ID: <001a01cd4849$3f287180$bd795480$%jun@samsung.com>
References: <000601cd47ab$8ad77c50$a08674f0$%jun@samsung.com>
 <68ac9afd251593ab3df348a469a10adb.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49485 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2FLDMv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 23:12:51 -0400
In-reply-to: <68ac9afd251593ab3df348a469a10adb.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>

Maya Erez <merez@codeaurora.org> wrote:
> > +	if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
> > +			((card->ext_csd.max_packed_writes > 0) ||
> > +			(card->ext_csd.max_packed_reads > 0))) {
> > +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +				EXT_CSD_EXP_EVENTS_CTRL,
> > +				EXT_CSD_PACKED_EVENT_EN,
> > +				card->ext_csd.generic_cmd6_time);
> > +		if (err && err != -EBADMSG)
> > +			goto free_card;
> 
> Subhash suggestion to change to the following is missing:
>      if (  (host->caps2 & MMC_CAP2_PACKED_WR &&
> card->ext_csd.max_packed_writes > 0) ||
>             (host->caps2 & MMC_CAP2_PACKED_RD &&
> card->ext_csd.max_packed_reads > 0)
Thanks to detect.
It'll be applied.

Best regards,
Seungwon Jeon

> 
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

