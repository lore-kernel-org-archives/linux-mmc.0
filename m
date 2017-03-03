From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/7] Some cleanup for dwmmc
Date: Fri, 3 Mar 2017 10:11:58 +0800
Message-ID: <d1228dee-ef65-4a2c-1d85-7203c87d74cb@rock-chips.com>
References: <CGME20170217025943epcas2p220d9ae88c0a8849e2c82da50339cec31@epcas2p2.samsung.com>
 <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
 <78c7e572-55e8-1e61-9c0d-34dacd36508d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:47331 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdCCCWG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Mar 2017 21:22:06 -0500
In-Reply-To: <78c7e572-55e8-1e61-9c0d-34dacd36508d@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 2017/3/3 10:01, Jaehoon Chung wrote:
> On 02/17/2017 11:56 AM, Shawn Lin wrote:
>> Hi Jaehoon,
>>
>> This is the first part of long term cleanup for dwmmc we need.
>> No functional changes here, but just to remove the unnecessary
>> function declare and improve the logic of dw_mci_reset for better
>> understood.
>>
>
> Applied on my repository. Thanks!

Thanks, Jeahoon!

>
> Best Regards,
> Jaehoon Chung
>
>>
>>
>> Shawn Lin (7):
>>   mmc: dw_mmc: improve the timeout polling code
>>   mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
>>   mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
>>   mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
>>   mmc: dw_mmc: remove declaration of dw_mci_card_busy
>>   mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
>>   mmc: dw_mmc: improve dw_mci_reset a bit
>>
>>  drivers/mmc/host/dw_mmc.c | 383 ++++++++++++++++++++++------------------------
>>  1 file changed, 182 insertions(+), 201 deletions(-)
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

