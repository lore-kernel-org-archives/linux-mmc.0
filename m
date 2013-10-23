From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 06/27] mmc: dw_mmc: Move away from using deprecated APIs
Date: Wed, 23 Oct 2013 20:17:37 +0900
Message-ID: <001401cecfe1$7aa04c80$6fe0e580$%jun@samsung.com>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
 <1380207292-16968-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:65525 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab3JWLRj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 07:17:39 -0400
In-reply-to: <1380207292-16968-7-git-send-email-ulf.hansson@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>

On Thu, September 26, 2013, Ulf Hansson wrote:
> Suspend and resume of cards are being handled from the protocol layer
> and consequently the mmc_suspend|resume_host APIs are deprecated.
> 
> This means we can simplify the suspend|resume callbacks by removing the
> use of the deprecated APIs.
> 
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon


