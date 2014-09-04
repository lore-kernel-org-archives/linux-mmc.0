From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Make tuning block table endian agnostic
Date: Fri, 05 Sep 2014 06:58:12 +0900
Message-ID: <5408E074.7090008@samsung.com>
References: <1409752622-7564-1-git-send-email-sboyd@codeaurora.org>
 <5407F364.9030303@samsung.com>
 <CAPDyKFp0LwK=DABHaP-Ke=QZFP8bY5MO9RnYmUBqeEdDKp63BA@mail.gmail.com>
 <5408D81C.7070602@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44066 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbaIDV6P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Sep 2014 17:58:15 -0400
In-reply-to: <5408D81C.7070602@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Georgi Djakov <gdjakov@mm-sol.com>, Asutosh Das <asutoshd@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>

On 09/05/2014 06:22 AM, Stephen Boyd wrote:
> On 09/04/14 03:53, Ulf Hansson wrote:
>> On 4 September 2014 07:06, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>
>>> In dw-mmc.c, tuning_block values are same.
>>> So I think we can move these value into generic header. how about?
>> Actually, I believe these values comes from the eMMC specification?
>> Shouldn't they be moved to the mmc core instead?
> 
> That sounds like good consolidation, but can we do that in a follow-up
> patch? This fixes the driver for me and I was hoping to make something
> minimal to go back to stable trees.

Sure, if my opinion is ok, i will do it after apply your patches.

Best Regards,
Jaehoon Chung

> 

