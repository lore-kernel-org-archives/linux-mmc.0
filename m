From: merez@codeaurora.org
Subject: Re: [PATCH v6 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Tue, 29 May 2012 04:37:54 -0700 (PDT)
Message-ID: <d98d78ec2312cbc5edb1b2c337ab788d.squirrel@www.codeaurora.org>
References: <009d01cd3411$0febc350$2fc349f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:10841 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab2E2Lhy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 May 2012 07:37:54 -0400
In-Reply-To: <009d01cd3411$0febc350$2fc349f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, merez@codeaurora.org, linux-kernel@vger.kernel.org

> @@ -1244,6 +1249,25 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>  		}
>  	}
>
> +	if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
> +			(card->ext_csd.max_packed_writes > 0) &&
> +			(card->ext_csd.max_packed_reads > 0)) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				EXT_CSD_EXP_EVENTS_CTRL,
> +				EXT_CSD_PACKED_EVENT_EN,
> +				card->ext_csd.generic_cmd6_time);
> +		if (err && err != -EBADMSG)
> +			goto free_card;
> +		if (err) {
> +			pr_warning("%s: Enabling packed event failed\n",
> +					mmc_hostname(card->host));
> +			card->ext_csd.packed_event_en = 0;
> +			err = 0;
> +		} else {
> +			card->ext_csd.packed_event_en = 1;
> +		}
> +	}
> +
The above shoud not be performed in case of resume. Therefore it needs to
be done only if (!oldcard)

Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

