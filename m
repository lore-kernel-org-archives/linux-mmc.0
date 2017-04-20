From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: MMC block addressing mode.
Date: Thu, 20 Apr 2017 16:28:09 -0500
Message-ID: <fdc1864b-9d5a-25ad-5d15-dc094f1c0886@cavium.com>
References: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
 <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
 <ef902f01-96fb-a314-e57c-bde8e1545b66@cavium.com>
 <c503aae1-4162-4398-1645-9e2acab5d002@caviumnetworks.com>
 <ebc19d7d-c6a2-0886-a17a-e1b4d82f957e@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0084.outbound.protection.outlook.com ([104.47.36.84]:64867
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033541AbdDTV2O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 17:28:14 -0400
In-Reply-To: <ebc19d7d-c6a2-0886-a17a-e1b4d82f957e@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 04/20/2017 04:24 PM, Steven J. Hill wrote:
> On 04/20/2017 12:12 PM, David Daney wrote:
>>
>> Steven and Jan:  Can we get around this requirement by:
>>
>> - Always set MIO_EMM_DMA[MULTI] = 1;  This way by SECTOR mode may be unimportant.
>>
>> - Always set MIO_EMM_DMA[SECTOR] = SUITABLE_CONSTANT.
>>
> No, this does not work. The 1.88GB card plugged into my 78xx
> board gives the output below. We cannot just blindly set the
> MULTI bit for all cards. These results are identical for all
> four combinations of SECTOR and MULTI values hardcoded.
> 
...for 3 of the 4 combinations. Obviously the correct one works.
