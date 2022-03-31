Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B7C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Mar 2022 08:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiCaIIt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 31 Mar 2022 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiCaIIq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2022 04:08:46 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3911C1B;
        Thu, 31 Mar 2022 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648714020; x=1680250020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hmbdlfSAVy3MtxW9X7UN4auw220H+YI+Yt/QeUjJsRo=;
  b=LvbCsotkIZxIYE5jG8YqbvX9RW9rVyQ0sk/YZ9cL6vwsF5AwQVHsyNyP
   5B8bEdtWAzM/Erx6RmXoAIBaDQLw2H9zq9KMYG2/FFB4GQmhJt1kFBm1Y
   tFlMb5ZK608njJZzADfMmg4OIvThpr1r9YDOGHu+u6fZVkcs1keDyk8jZ
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 Mar 2022 01:06:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:06:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 31 Mar 2022 01:06:59 -0700
Received: from [10.216.48.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 01:06:44 -0700
Message-ID: <4eaa8fed-56be-4f36-82be-a016e7e6ca2c@quicinc.com>
Date:   Thu, 31 Mar 2022 13:36:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add gcc resets
 strings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sayalil@quicinc.com>
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1647532165-6302-2-git-send-email-quic_c_sbhanu@quicinc.com>
 <cd976ef0-767b-8cf0-8635-28aeaa6542a3@kernel.org>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <cd976ef0-767b-8cf0-8635-28aeaa6542a3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 3/18/2022 6:20 PM, Krzysztof Kozlowski wrote:
> On 17/03/2022 16:49, Shaik Sajida Bhanu wrote:
>> Add gcc hardware reset supported strings for qcom-sdhci controller.
>>
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 6216ed7..f180111 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -62,6 +62,10 @@ Required properties:
>>   - qcom,dll-config: Chipset and Platform specific value. Use this field to
>>   	specify the DLL_CONFIG register value as per Hardware Programming Guide.
>>   
>> +- resets: Phandle and reset specifier for the device's reset.
>> +- reset-names: List of reset signal name strings sorted in the same order as
>> +	       the resets property.
> Please list the actual names used in reset-names.
Sure Thanks for the review.
>
> Best regards,
> Krzysztof
