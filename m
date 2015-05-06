From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Wed, 06 May 2015 10:26:32 +0900
Message-ID: <55496DC8.8060208@samsung.com>
References: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org>
 <55496227.9000904@samsung.com>
 <CABQgh9E5B=q-5+go2FJXUbDpveGm2xEo+1LdKbG40sxrZ7vQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43708 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbbEFB0e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 21:26:34 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NNW00AB3MO8PS20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 May 2015 10:26:32 +0900 (KST)
In-reply-to: <CABQgh9E5B=q-5+go2FJXUbDpveGm2xEo+1LdKbG40sxrZ7vQnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On 05/06/2015 10:14 AM, Zhangfei Gao wrote:
> On 6 May 2015 at 08:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi, Zhangfei.
>>
>> If you want to check it, use the "broken-cd" and "non-removable" properties into dt-file.
>> Did you use them?
> 
> Yes.
> "broken-cd" can work, but mmc_rescan keeps running.
> "non-removable" does NOT work, which should be used for emmc.
> Since dw_mci_get_cd only checks DW_MCI_QUIRK_BROKEN_CARD_DETECTION, so
> only checks "broken-cd" but not check "non-removable"

Did you use the usage like the below..

dwmmc0 {
	non-removable;
	broken-cd;
};

Best Regards,
Jaehoon Chung

> 
> Thanks
> 

