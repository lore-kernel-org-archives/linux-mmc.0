From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v4 09/15] mmc: sdhci-pxav3: add quirks2
Date: Fri, 28 Sep 2012 10:33:54 +0800
Message-ID: <CADz5_g+3kW9aQJdTh-cjeNNOZzEfjURQRaOYy_+ei5R37a+Uvw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-10-git-send-email-keyuan.liu@gmail.com>
	<CAMj5Bkgy6i2tg2yvEyLvEDOxB9n=ON5H4zqxiGOnzT-2pHz-FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64696 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab2I1Cdz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 22:33:55 -0400
Received: by wgbdr13 with SMTP id dr13so1924279wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 19:33:54 -0700 (PDT)
In-Reply-To: <CAMj5Bkgy6i2tg2yvEyLvEDOxB9n=ON5H4zqxiGOnzT-2pHz-FA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

2012/9/27 zhangfei gao <zhangfei.gao@gmail.com>:
>> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
>> index 59acd98..fdf38d6 100644
>> --- a/include/linux/platform_data/pxa_sdhci.h
>> +++ b/include/linux/platform_data/pxa_sdhci.h
>> @@ -38,6 +38,7 @@
>>   * @max_speed: the maximum speed supported
>>   * @host_caps: Standard MMC host capabilities bit field.
>>   * @quirks: quirks of platfrom
>> + * @quirks2: quirks2 of platfrom
>>   * @pm_caps: pm_caps of platfrom
>>   */
>>  struct sdhci_pxa_platdata {
>> @@ -51,6 +52,7 @@ struct sdhci_pxa_platdata {
>>         unsigned int    host_caps;
>>         unsigned int    host_caps2;
>>         unsigned int    quirks;
>> +       unsigned int    quirks2;
>>         unsigned int    pm_caps;
>>  };
>>
> Not find the patch using quirks2.
> Could you merge the patch together?
In my another patch "[PATCH v4 08/15] mmc: sdhci: enhance preset value
function", I introduced SDHCI_QUIRK2_PRESET_VALUE_BROKEN, which
located in quirks2. So I added this. We should not combine this
together.
