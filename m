From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 02/14] mmc: mmci: Fixup handling of MCI_STARTBITERR
Date: Mon, 19 Dec 2011 09:59:11 +0100
Message-ID: <4EEEFCDF.5030304@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-3-git-send-email-ulf.hansson@stericsson.com> <20111218231534.GA14542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:42713 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab1LSI7k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 03:59:40 -0500
In-Reply-To: <20111218231534.GA14542@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:48PM +0100, Ulf Hansson wrote:
>> The interrupt was previously enabled and then correctly cleared.
>> Now we also handle it correctly.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I've queued this in my 'fixes' branch with a Cc to the stable team for
> previous kernel versions.  I believe that to be appropriate.  Please
> confirm.
> 

Great!

BR
Ulf Hansson
