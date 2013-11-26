From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Write only 4 bit in case of TIMEOUT_CONTROL
Date: Tue, 26 Nov 2013 16:22:37 -0500
Message-ID: <87zjoqg8o2.fsf@octavius.laptop.org>
References: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com>
	<20130716073826.GH28375@S2101-09.ap.freescale.net>
	<52734AC6.6020101@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34058 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540Ab3KZVWu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 16:22:50 -0500
In-Reply-To: <52734AC6.6020101@de.bosch.com> (Dirk Behme's message of "Fri, 1
	Nov 2013 07:31:34 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Dirk,

On Fri, Nov 01 2013, Dirk Behme wrote:
> On 16.07.2013 09:38, Shawn Guo wrote:
>> Hi Dirk,
>>
>> On Tue, Jul 16, 2013 at 08:36:11AM +0200, Dirk Behme wrote:
>>> In case of SDHCI_TIMEOUT_CONTROL write only 4 bits and not the
>>> whole byte to avoid touching other unrelated bits in the i.MX6
>>> SYS_CTRL register. E.g. IPP_RST_N shouldn't be touched accidently.
>>>
>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> What's the status of this? I can't find it e.g. in linux-next?
>
> Does anybody like to help to apply this?

Looks like you didn't answer Shawn's question yet, could you please?

>> I'm wondering if it fixes any issue in real life?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
