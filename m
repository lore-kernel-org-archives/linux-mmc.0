From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: mmc bus test data timeout setting
Date: Sat, 24 Aug 2013 23:26:05 -0400
Message-ID: <878uzqsb76.fsf@octavius.laptop.org>
References: <59606D77376AA44BB2E289FE5BA55046751F63AE@NTXXIAMBX01.xacn.micron.com>
	<CAPDyKFruF1kJoB=qrn6P+Px5neZijKFLEwQA382uSYR6=aiLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55818 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3HYD0L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:26:11 -0400
In-Reply-To: <CAPDyKFruF1kJoB=qrn6P+Px5neZijKFLEwQA382uSYR6=aiLHw@mail.gmail.com> (Ulf
	Hansson's message of "Fri, 23 Aug 2013 13:14:06 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Minjian Wu (minjianwu)" <minjianwu@micron.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Fri, Aug 23 2013, Ulf Hansson wrote:
> On 26 July 2013 07:06, Minjian Wu (minjianwu) <minjianwu@micron.com> wrote:
>> Add data timeout setting for mmc bus test command(CMD14 and CMD19).
>>
>> Signed-off-by: Minjian Wu <minjianwu@micron.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
