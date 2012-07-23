From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/6] mmc: dw_mmc: add support for device tree based
 instantiation
Date: Mon, 23 Jul 2012 10:57:35 +0900
Message-ID: <500CAF8F.5040407@samsung.com>
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
 <5008279B.4000001@samsung.com>
 <CAJuYYwQBgpJ1wiS3fSDS2cMi6kanuO47rc8SmniAqjRPuBGJHg@mail.gmail.com>
 <195201cd6600$7cb089f0$76119dd0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:64288 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab2GWB5s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Jul 2012 21:57:48 -0400
In-reply-to: <195201cd6600$7cb089f0$76119dd0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, patches@linaro.org

On 07/20/2012 07:47 AM, Kukjin Kim wrote:
> Thomas Abraham wrote:
>>
>> On 19 July 2012 20:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi Thomas,
>>>
>>> I think not good that added the samsung specific code into dw_mmc-
>> pltfm.c
>>> How about separating to dw-mmc-exynos.c?
>>
>> I am not sure of this. The only samsung specific code in
>> dw_mmc-pltfm.c file is the data for of_device_id instances. The clock
>> lookup added into this file in the 3rd patch does not cause any harm
>> on non-samsung SoC's which might not define those clocks (on clock
>> lookup failure, there are only warning printed, the driver's probe
>> does not fail.
>>
> I agree with Thomas' opinion, in addition, the dw_mmc-pltfm.c file can
> support that, so adding dw-mmc-exynos.c is not needed now.
> 
>> I would prefer not to add separate file for Exynos SoC's for now.
>> Splitting into different files will need to defined new callbacks
>> which I fell is not really required.
Then where is the callback function located?

Best Regards,
Jaehoon Chung
>>
> Yes.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


