From: Bastian Stender <bst@pengutronix.de>
Subject: Re: [PATCH] mmc: core: prepend 0x to hex numbers in sysfs
Date: Mon, 27 Nov 2017 14:18:19 +0100
Message-ID: <7fa98405-f9ea-ba0b-1cd1-7219d774c930@pengutronix.de>
References: <20171116113000.25044-1-bst@pengutronix.de>
 <CAPDyKForkLBLn059w1HJh8TCZTAim8RY3GF=ic5ot+_zEh6UzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55259 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751838AbdK0NSf (ORCPT
        <rfc822;linux-mmc@vger.kernel.ORG>); Mon, 27 Nov 2017 08:18:35 -0500
In-Reply-To: <CAPDyKForkLBLn059w1HJh8TCZTAim8RY3GF=ic5ot+_zEh6UzQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Sascha Hauer <kernel@pengutronix.de>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>

On 11/23/2017 02:28 PM, Ulf Hansson wrote:
> On 16 November 2017 at 12:30, Bastian Stender <bst@pengutronix.de> wrote:
>> The sysfs entries "pre_eol_info" and "ocr" were missing the 0x prefix
>> to identify them as hex formatted.
>>
>> Fixes: 5fb06af7a33b ("mmc: core: Extend sysfs with OCR register")
>> Fixes: 46bc5c408e4e ("mmc: core: Export device lifetime information through sysfs")
>> Signed-off-by: Bastian Stender <bst@pengutronix.de>
> 
> Bastian, would you mind splitting this into two patches. I need that
> to be able to add correct stable tags to each of them.

Sure, will send v2.

Regards,
Bastian

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
