From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 0/4] mmc: core: Signal voltage switch procedure for UHS mode
Date: Tue, 8 Jan 2013 22:08:43 +0100
Message-ID: <CAPDyKFrszsL21H2LDUWWyWPs=arNF+dZ739B+e4Ar2ozqjnyeA@mail.gmail.com>
References: <1357653962-10887-1-git-send-email-johan.rudholm@stericsson.com>
	<alpine.LFD.2.02.1301081435410.6300@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:60284 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab3AHVIo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 16:08:44 -0500
Received: by mail-la0-f50.google.com with SMTP id fs13so964850lab.23
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 13:08:43 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1301081435410.6300@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 8 January 2013 20:36, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 8 Jan 2013, Johan Rudholm wrote:
>
>> This patch series attempts to make the 1.8V signal voltage switch
>> required for UHS mode work according to the SD specification.
>>
>> These patches have been tested with a couple of UHS SD cards, one of
>> which sometimes requires up to five power cycles before it accepts the
>> signal voltage switch.
>
> Any idea why this is the case?
>

No, not really. But to comply with the sd spec this updated voltage
sequence is needed.

I think we need to understand the internal electrical voltage switch
behaviour of that particular sd card to answer this. I doubt we can
get hold of that information in the spec of the card, unfortunately.

>
> Nicolas

Kind regards
Ulf Hansson
