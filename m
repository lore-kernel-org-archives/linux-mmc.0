From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [PATCH] mmc: dw_mmc: Increase the timeout in mci_send_cmd to 5
 sec
Date: Mon, 2 Oct 2017 13:29:50 +0000
Message-ID: <3c46c1a6-edd2-698e-3286-e30d04b99103@hotmail.de>
References: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAPDyKFojY21yTMu2E9M8tec6QPZfFuVwJMZO0vY8V2kG7=yRCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oln040092065107.outbound.protection.outlook.com ([40.92.65.107]:58603
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751062AbdJBN3x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Oct 2017 09:29:53 -0400
In-Reply-To: <CAPDyKFojY21yTMu2E9M8tec6QPZfFuVwJMZO0vY8V2kG7=yRCg@mail.gmail.com>
Content-Language: de-DE
Content-ID: <04547DAEF91F0B4685CCEC78B4663532@sct-15-1-1199-6-msonline-outlook-20107.templateTenant>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 10/02/17 09:13, Ulf Hansson wrote:
> On 30 September 2017 at 17:38, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> 
> Why?
> 

Obviously the 0.5 seconds time-out was not sufficent for me.
I experienced a time-out I believe it was with an erase command,
that took around one second to complete.  Not all brands of SD
card behave this way, but some do.

Incidentally I had a similar problem with a completely different
hardware, see: https://bugzilla.kernel.org/show_bug.cgi?id=107811
Should I send a patch for that as well?


Bernd.
