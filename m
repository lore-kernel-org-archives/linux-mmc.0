From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v3 0/3] dw_mmc-k3 support hi6220
Date: Mon, 18 May 2015 13:12:13 +0800
Message-ID: <555974AD.5010605@linaro.org>
References: <1431593119-31889-1-git-send-email-zhangfei.gao@linaro.org> <5555BF5B.9070604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34036 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbbERFMS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 01:12:18 -0400
Received: by pabru16 with SMTP id ru16so136062966pab.1
        for <linux-mmc@vger.kernel.org>; Sun, 17 May 2015 22:12:18 -0700 (PDT)
In-Reply-To: <5555BF5B.9070604@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org


Thanks Jaehoon for the help.

On 05/15/2015 05:41 PM, Jaehoon Chung wrote:
> Hi, Zhangfei.
>
> I will apply this patchset at my dw-mmc tree.
> Thanks!
>
> Best Regards,
> Jaehoon Chung


>
> On 05/14/2015 05:45 PM, Zhangfei Gao wrote:
>> v3:
>> Suggested by Jaehoon
>> Add comments about register AO_SCTRL_CTRL3 and remove one unused vector
>>
>> v2:
>> fix comments from Jaehoon
>> fix some issues in sdr12 & sdr25 mode
>>
>> Zhangfei Gao (3):
>>    Document: dw_mmc-k3: add document of hi6220 mmc
>>    mmc: dw_mmc: add switch_voltage
>>    mmc: dw_mmc: k3: support hi6220
>>
>>   .../devicetree/bindings/mmc/k3-dw-mshc.txt         |  28 ++++++
>>   drivers/mmc/host/dw_mmc-k3.c                       | 103 ++++++++++++++++++++-
>>   drivers/mmc/host/dw_mmc.c                          |   4 +
>>   drivers/mmc/host/dw_mmc.h                          |   2 +
>>   4 files changed, 135 insertions(+), 2 deletions(-)
>>
>
