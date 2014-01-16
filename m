From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix dw_mci_get_cd
Date: Thu, 16 Jan 2014 20:34:47 +0800
Message-ID: <52D7D1E7.80502@linaro.org>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org> <201401161150.34258.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64105 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbaAPMex (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 07:34:53 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so2616735pab.20
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 04:34:52 -0800 (PST)
In-Reply-To: <201401161150.34258.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org



On 01/16/2014 06:50 PM, Arnd Bergmann wrote:
> On Thursday 16 January 2014, Zhangfei Gao wrote:
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -73,6 +73,8 @@ Optional properties:
>>
>>   * caps2-mmc-hs200-1_2v: Supports mmc HS200 SDR 1.2V mode
>>
>> +* caps2-mmc-cd-active-high: cd pin is high when card present
>> +
>>   * broken-cd: as documented in mmc core bindings.
>>
>>   * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>
> No, don't introduce a new flag when there is already one defined
> in the generic mmc binding.

Got it.

Update with "cd-inverted".

      if (of_get_property(np, "cd-inverted", NULL))
                 pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;


Thanks
