From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH] mmc: block: use block layer pm helpers for pm of card
 device
Date: Wed, 01 Apr 2015 18:56:52 +0300
Message-ID: <551C1544.8000906@codeaurora.org>
References: <5518080D.6070803@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59174 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbDAP4z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2015 11:56:55 -0400
In-Reply-To: <5518080D.6070803@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello all,

Any comments?

I'm working on power management for eMMC CQ command queuing solution 
(these are patches released by Asutosh Das).

Using the block layer pm helpers is important to be able to issue a data 
requests in non-blocking way directly from the block layer contexts, so 
it is important to get feedback about the patch.

Thanks,
Kostya

-- 
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
