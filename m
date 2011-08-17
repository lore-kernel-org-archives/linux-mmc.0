From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] mmc: support background operation
Date: Wed, 17 Aug 2011 17:30:39 +0900
Message-ID: <4E4B7C2F.9090304@samsung.com>
References: <4E450B21.8040502@samsung.com>
 <001301cc5cb4$141daea0$3c590be0$%jun@samsung.com>
 <4E4B7825.9030608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55495 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1HQIat (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 04:30:49 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LQ200EQNCYUM9H0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 17 Aug 2011 17:30:38 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LQ200302CZ32J@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 17 Aug 2011 17:30:39 +0900 (KST)
In-reply-to: <4E4B7825.9030608@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Chuanxiao Dong' <chuanxiao.dong@intel.com>, 'Hanumath Prasad' <hanumath.prasad@stericsson.com>

Hi

In eMMC spec, if set BKOPS_SUPPORT bit in ext_csd,
BKOPS_EN, BKOPS_STATUS, BKOPS_START and URGENT_BKOPS are supported for default.

So need not to send switch-command for BKOPS_EN when set BKOPS_SUPPORT bit.

Thanks,
Jaehoon Chung

>> There is no code for enabling BKOPS_EN?
>> If host want to handle background operation manually, it needs. 
> 
> Sorry, this code is my mistake...maybe duplicated the HPI patch..
> You means maybe need this code..
>            /*
> +           * Enable BKOPS feature (if supported)
> +           */
> +           if (card->ext_csd.bkops != NULL) {
> +                         /*
> +                         * If card supported BKOPS, default set BKOPS_EN bit.
> +                         * But ensure to enable bkops, need to check enable bit
> +                         */
> +                         if (!card->ext_csd.bkops_en) {
> +                                      err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                                                   EXT_CSD_BKOPS_EN, 1, 0);
> +                                      if (err && err != -EBADMSG)
> +                                                   goto free_card;
> +
> +                                      if (err) {
> +                                                   printk(KERN_ERR "%s: Enabling BKOPS failed\n",
> +                                                                mmc_hostname(card->host));
> +                                                   err = 0;
> +                                      } else
> +                                                   card->ext_csd.bkops_en = 1;
> +                         }
> +           }
> +
> 
> I will resend the RFC patch..
> 
> Thank you for comment.
> 
> Best Regards,
> Jaehoon Chung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

