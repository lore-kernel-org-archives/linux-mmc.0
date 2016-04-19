From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/7] mmc: sdhci-pltfm: bail out if register resource is
 too small
Date: Tue, 19 Apr 2016 20:46:13 +0900
Message-ID: <CAK7LNAScX-JP13w4zZ3Fb=9HQQeqtzN0iyxocGBkLbeZyHxcPw@mail.gmail.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
	<1460600990-10993-2-git-send-email-yamada.masahiro@socionext.com>
	<57161754.5050303@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59388 "EHLO
	conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbcDSLqY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 07:46:24 -0400
In-Reply-To: <57161754.5050303@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Adrian,


2016-04-19 20:32 GMT+09:00 Adrian Hunter <adrian.hunter@intel.com>:
> On 14/04/16 05:29, Masahiro Yamada wrote:
>> This code checks the resource size and displays an error message if
>> it is too small, but still moves forward.  Let is fail in that case.
>
> is -> it
>
> How do you know there aren't drivers that actually have a smaller size?

No, I do not know.

This is an error message, so I think it should fail in that case.


Maybe, can we drop this check completely?




-- 
Best Regards
Masahiro Yamada
