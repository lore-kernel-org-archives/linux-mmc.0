From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Simplify wmt_set_sd_power implementation
Date: Sun, 20 Oct 2013 21:21:38 -0400
Message-ID: <87d2mza065.fsf@octavius.laptop.org>
References: <1380791080.30876.2.camel@phoenix>
	<524F9496.8080209@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33402 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab3JUBVn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 21:21:43 -0400
In-Reply-To: <524F9496.8080209@prisktech.co.nz> (Tony Prisk's message of "Sat,
	05 Oct 2013 17:24:54 +1300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Axel Lin <axel.lin@ingics.com>, linux-mmc@vger.kernel.org

Hi Axel,

On Sat, Oct 05 2013, Tony Prisk wrote:
> On 03/10/13 22:04, Axel Lin wrote:
>> Simplify the code to set/clear BM_SD_OFF bit:
>>
>>            | power_inverted: 0  | power_inverted: 1
>> -------------------------------------------------
>> enable: 0 | SET BM_SD_OFF      | CLEAR BM_SD_OFF
>> -------------------------------------------------
>> enable: 1 | CLEAR BM_SD_OFF    | SET BM_SD_OFF
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Acked-by: Tony Prisk <linux@prisktech.co.nz>
>
> Thanks Axel - much better code.

Thanks, pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
