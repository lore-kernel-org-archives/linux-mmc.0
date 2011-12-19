From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 08/14] mmc: mmci: Fixup error handling for dma
Date: Mon, 19 Dec 2011 09:59:36 +0100
Message-ID: <4EEEFCF8.2060806@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-9-git-send-email-ulf.hansson@stericsson.com> <20111218231614.GB14542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:54410 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab1LSI75 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 03:59:57 -0500
In-Reply-To: <20111218231614.GB14542@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:54PM +0100, Ulf Hansson wrote:
>> When getting a cmd irq during an ongoing data transfer
>> with dma, the dma job were never terminated. This is now
>> corrected.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> 
> I've queued this up in my 'fixes' branch with a Cc to the stable team
> for previous kernels.  I believe this to be appropriate.  Please confirm.
> 

Great!

BR
Ulf Hansson

