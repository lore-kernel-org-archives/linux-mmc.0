From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] mmc: mmc_oops: support mmc_oops feature
Date: Fri, 27 Feb 2015 18:42:29 +0900
Message-ID: <54F03C05.7040009@samsung.com>
References: <1425015219-19849-1-git-send-email-jh80.chung@samsung.com>
 <41342138.MjUK31a4Mt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9335 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbB0Jmb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 04:42:31 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NKF008GLCATNB10@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 27 Feb 2015 18:42:29 +0900 (KST)
In-reply-to: <41342138.MjUK31a4Mt@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Dear, Arnd.

On 02/27/2015 05:31 PM, Arnd Bergmann wrote:
> On Friday 27 February 2015 14:33:39 Jaehoon Chung wrote:
>> --- a/drivers/mmc/card/Kconfig
>> +++ b/drivers/mmc/card/Kconfig
>> @@ -68,3 +68,11 @@ config MMC_TEST
>>  
>>           This driver is only of interest to those developing or
>>           testing a host driver. Most people should say N here.
>> +
>> +config MMC_OOPS
>> +       tristate "Log panic/oops to a MMC buffer"
>> +       depends on OF
>> +       help
>> +         This enables panic and oops messages to be logged to a circular
>> +         buffer in a MMC sectors where it can be read back at some
>> +         later point.
>>
> 
> This sounds a lot like the implementation should be using
> the fs/pstore infrastructure like we do for ramoops, chromeos
> and the EFI runtime services logger.

I refer to it, so you can sound so. It's my wrong.
I will rewrite the comment for MMC_OOPS config.
Thanks for point out.

Best Regards,
Jaehoon Chung

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

