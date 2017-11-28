From: Bastian Stender <bst@pengutronix.de>
Subject: Re: [PATCH v2 1/2] mmc: core: prepend 0x to OCR entry in sysfs
Date: Tue, 28 Nov 2017 09:14:52 +0100
Message-ID: <8a4f00d5-0d01-7860-7a20-a360d67f2617@pengutronix.de>
References: <20171127131721.865-1-bst@pengutronix.de>
 <CAOmT4fTBTiQZBSQqR5Y+dQG_bsOdNtnAFETMECgFROj8qa1hrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49655 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752037AbdK1IPB (ORCPT
        <rfc822;linux-mmc@vger.kernel.ORG>); Tue, 28 Nov 2017 03:15:01 -0500
In-Reply-To: <CAOmT4fTBTiQZBSQqR5Y+dQG_bsOdNtnAFETMECgFROj8qa1hrA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bojan prtvar <prtvar.b@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, Sascha Hauer <kernel@pengutronix.de>

On 11/28/2017 07:44 AM, bojan prtvar wrote:
> Hi Bastian,
> 
> On Mon, Nov 27, 2017 at 2:17 PM, Bastian Stender <bst@pengutronix.de> wrote:
>>
>> The sysfs entry "ocr" was missing the 0x prefix to identify it as hex
>> formatted.
>>
>>
>> -MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
>> +MMC_DEV_ATTR(pre_eol_info, "0x%02x\n", card->ext_csd.pre_eol_info);
> 
> 
> Commit messages are swapped for pre_eol_info and ocr patches.

Argh, yes, you are right, thanks. Will send v3.

Regards,
Bastian

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
