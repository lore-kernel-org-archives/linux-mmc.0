From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/8] Fix coding style in sdhci.c
Date: Mon, 12 Nov 2012 11:24:41 +0900
Message-ID: <50A05DE9.8070907@samsung.com>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16167 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab2KLCYo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Nov 2012 21:24:44 -0500
In-reply-to: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

Hi Tushar,

Could you make one patch? Why do you separate patches?

Best Regards,
Jaehoon Chung

On 11/09/2012 08:39 PM, Tushar Behera wrote:
> Documents/CodingStyle Chapter 3 recommends usage of braces for both
> if and else statements if any of the branches contains multiple
> statements.
> 
> Cleaning up drivers/mmc/host/sdhci.c for all these occurrences.
> 
> Tushar Behera (8):
>   mmc: sdhci: fix coding style in sdhci_calc_timeout
>   mmc: sdhci: fix coding style in sdhci_set_transfer_mode
>   mmc: sdhci: fix coding style in sdhci_finish_data
>   mmc: sdhci: fix coding style in sdhci_set_clock
>   mmc: sdhci: fix coding style in sdhci_do_set_ios
>   mmc: sdhci: fix coding style in sdhci_execute_tuning
>   mmc: sdhci: fix coding style in sdhci_data_irq
>   mmc: sdhci: fix coding style in sdhci_add_host
> 
>  drivers/mmc/host/sdhci.c |   58 +++++++++++++++++++++++++--------------------
>  1 files changed, 32 insertions(+), 26 deletions(-)
> 

