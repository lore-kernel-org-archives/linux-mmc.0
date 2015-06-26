From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/3] mmc: sdhci: Card detection fixes
Date: Fri, 26 Jun 2015 19:31:06 +0900
Message-ID: <558D29EA.2040203@samsung.com>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56344 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbFZKbI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 06:31:08 -0400
In-reply-to: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi, Ivan.

On 06/26/2015 07:00 PM, Ivan T. Ivanov wrote:
> Following changes aimed to fix some aspects of card detection, when
> BROKEN_CARD_DETECTION quirk is set.

As i know, when there is no card detection scheme, BROKEN_CARD_DETECTION quirks is set.
If it can use CD_GPIO, doesn't it need to set BROKEN_CARD_DETECTION?
Just wondering..

Best Regards,
Jaehoon Chung

> 
> Ivan T. Ivanov (3):
>   mmc: sdhci: let GPIO based card detection have higher precedence
>   mmc: sdhci: don't use card state polling when CD GPIO is defined
>   mmc: sdhci: properly check card present state when quirk
>     NO_CARD_NO_RESET is set
> 
>  drivers/mmc/host/sdhci.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

