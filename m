From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] mmc: support background operation
Date: Wed, 17 Aug 2011 17:13:25 +0900
Message-ID: <4E4B7825.9030608@samsung.com>
References: <4E450B21.8040502@samsung.com>
 <001301cc5cb4$141daea0$3c590be0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64225 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1HQINf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 04:13:35 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LQ200F9KC3CU3K0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 17 Aug 2011 17:13:25 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LQ2001W6C6DX8@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 17 Aug 2011 17:13:25 +0900 (KST)
In-reply-to: <001301cc5cb4$141daea0$3c590be0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Chuanxiao Dong' <chuanxiao.dong@intel.com>, 'Hanumath Prasad' <hanumath.prasad@stericsson.com>

Hi Seungwon.

Seungwon Jeon wrote:
> Hi Jaehoon Chung,
> 
>> @@ -762,6 +773,23 @@ static int mmc_init_card(struct mmc_host *host, u32
>> ocr,
>>  	}
>>
>>  	/*
>> +	 * Enable HPI feature (if supported)
>> +	 */
>> +	if (card->ext_csd.hpi) {
>> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +			EXT_CSD_HPI_MGMT, 1, 0);
>> +		if (err && err != -EBADMSG)
>> +			goto free_card;
>> +
>> +		if (err) {
>> +			printk(KERN_WARNING "%s: Enabling HPI failed\n",
>> +				mmc_hostname(card->host));
>> +			err = 0;
>> +		} else
>> +			card->ext_csd.hpi_en = 1;
>> +	}
>> +
> There is no code for enabling BKOPS_EN?
> If host want to handle background operation manually, it needs. 

Sorry, this code is my mistake...maybe duplicated the HPI patch..
You means maybe need this code..
           /*
+           * Enable BKOPS feature (if supported)
+           */
+           if (card->ext_csd.bkops != NULL) {
+                         /*
+                         * If card supported BKOPS, default set BKOPS_EN bit.
+                         * But ensure to enable bkops, need to check enable bit
+                         */
+                         if (!card->ext_csd.bkops_en) {
+                                      err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+                                                   EXT_CSD_BKOPS_EN, 1, 0);
+                                      if (err && err != -EBADMSG)
+                                                   goto free_card;
+
+                                      if (err) {
+                                                   printk(KERN_ERR "%s: Enabling BKOPS failed\n",
+                                                                mmc_hostname(card->host));
+                                                   err = 0;
+                                      } else
+                                                   card->ext_csd.bkops_en = 1;
+                         }
+           }
+

I will resend the RFC patch..

Thank you for comment.

Best Regards,
Jaehoon Chung
