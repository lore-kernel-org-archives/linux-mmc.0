From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Write only 4 bit in case of TIMEOUT_CONTROL
Date: Wed, 27 Nov 2013 07:47:39 +0100
Message-ID: <5295958B.6050509@de.bosch.com>
References: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com>	<20130716073826.GH28375@S2101-09.ap.freescale.net>	<52734AC6.6020101@de.bosch.com> <87zjoqg8o2.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:51722 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3K0Gru (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Nov 2013 01:47:50 -0500
In-Reply-To: <87zjoqg8o2.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 26.11.2013 22:22, Chris Ball wrote:
> Hi Dirk,
>
> On Fri, Nov 01 2013, Dirk Behme wrote:
>> On 16.07.2013 09:38, Shawn Guo wrote:
>>> Hi Dirk,
>>>
>>> On Tue, Jul 16, 2013 at 08:36:11AM +0200, Dirk Behme wrote:
>>>> In case of SDHCI_TIMEOUT_CONTROL write only 4 bits and not the
>>>> whole byte to avoid touching other unrelated bits in the i.MX6
>>>> SYS_CTRL register. E.g. IPP_RST_N shouldn't be touched accidently.
>>>>
>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>
>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> What's the status of this? I can't find it e.g. in linux-next?
>>
>> Does anybody like to help to apply this?
>
> Looks like you didn't answer Shawn's question yet, could you please?
>
>>> I'm wondering if it fixes any issue in real life?

I wasn't aware that this questions blocks applying that patch. I think 
I've answered Shawn's question in a private mail: Using RST_N doesn't 
work if the controller's IPP_RST_N bit is touched accidentally, i.e. if 
a reset is asserted if it shouldn't.

Many thanks and best regards

Dirk










