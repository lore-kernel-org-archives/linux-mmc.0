From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Wed, 31 Oct 2012 13:29:27 +0900
Message-ID: <5090A927.2050708@samsung.com>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <CAGxe1ZEs=3Y9+mdvt1kp2oQ4DXAdUqC0crH2oZAi-j3DKCbAPA@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C2042CA@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34091 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2JaE3d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 00:29:33 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCQ00A8TPSKSD00@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 31 Oct 2012 13:29:31 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MCQ00H9SPT7FQ90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 31 Oct 2012 13:29:31 +0900 (KST)
In-reply-to: <110EED8CC96DFC488B7E717A2027A27C2042CA@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Hi,

>> *host)
>>>         if (!host->card || mmc_card_removed(host->card))
>>>                 return 1;
>>>
>>> -       ret = host->bus_ops->alive(host);
>>> +       if (host->ops->get_cd) {
>>> +               ret = host->ops->get_cd(host);
>>> +               if (ret >= 0)
>>> +                       ret = !ret;
>>> +       }
>>> +       if (ret < 0)
>>> +               ret = host->bus_ops->alive(host);
>> why should we check for negative here? can move this code into else
>> path of   if (host->ops->get_cd).
>>>         if (ret) {
> 
> I did this comment:
> If the card is present, 1 will return, if the card is absent, 0 will return.
> If the controller will not support this feature, -ENOSYS will return.
If checked whether card is absent or not with get_cd(), need to check the host->bus_ops->alive?
> 
> Can't move to other address, because these codes check the card present state.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

