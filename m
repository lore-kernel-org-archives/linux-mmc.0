From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 13:15:38 +0100
Message-ID: <54C7816A.8050800@ahsoftware.de>
References: <1422359304-30321-1-git-send-email-holler@ahsoftware.de> <CAFLxGvyuE8odPdNSD1PTccyBXFm=JO=ooikUOJfz41aFpsUAJg@mail.gmail.com> <54C77E69.7050600@ahsoftware.de> <20150127120855.GA9254@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:54522 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbA0MPo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 07:15:44 -0500
In-Reply-To: <20150127120855.GA9254@pd.tnic>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

Am 27.01.2015 um 13:08 schrieb Borislav Petkov:
> On Tue, Jan 27, 2015 at 01:02:49PM +0100, Alexander Holler wrote:
>> Look at the source at the message which is printed just before and decide
>> which one you find more informational / useful.
>
> I find such a message absolutely useless. Also, if it flies off and
> printk buffer gets overwritten, it serves you sh*t. IOW, listen to what
> Richard tells you.

Ok. I shut/give up.

Maybe you could be so nice to inform me where the similiar detail is 
exposed in sysfs for SSDs.

Also it's unlikely I will send any further patch. There are still 21 
from me where I've exposed sysfs attributes for NAND devices which are 
still not applied and most NAND devices still don't have a sysfs entry.

So why should I waste my time again?

Alexander Holler

