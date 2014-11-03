From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH 3/4] mmc: core: make hw_reset generic
Date: Mon, 3 Nov 2014 11:19:15 +0100
Message-ID: <CA+20K0A6qKkEb=pGgFUn=Z07_YmqW1ot=LjPswDx6MzBpwP9ZQ@mail.gmail.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>
	<1414154790-20893-4-git-send-email-johanru@axis.com>
	<545748F7.8020707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:39841 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbaKCKTW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Nov 2014 05:19:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id B9B2418078
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:19:20 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id O8e+9v1zq26Y for <linux-mmc@vger.kernel.org>;
	Mon,  3 Nov 2014 11:19:18 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 1B7481808E
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:19:18 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id EC23BE23
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:19:17 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id DF51357B
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:19:17 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id DCA73341B4
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 11:19:17 +0100 (CET)
Received: by mail-qa0-f50.google.com with SMTP id bm13so6389520qab.9
        for <linux-mmc@vger.kernel.org>; Mon, 03 Nov 2014 02:19:15 -0800 (PST)
In-Reply-To: <545748F7.8020707@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Johan Rudholm <johanru@axis.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

2014-11-03 10:20 GMT+01:00 Adrian Hunter <adrian.hunter@intel.com>:
> On 24/10/14 15:46, Johan Rudholm wrote:
>> Move the (e)MMC specific hw_reset code from core.c into mmc.c and call
>> it from the new bus_ops member power_reset. This also lets us add code
>
> power_reset is not a good name because it does not necessarily have
> anything to do with power.  I am not sure why you don't stick with
> hw_reset.
>
>> for reseting SD cards as well.
>>
>> Rename the mmc_hw_reset* functions into mmc_reset*, since what they
>> now actually do depends on the device type (and it may be something else
>> than doing a hw_reset).
>
> I don't follow your reasoning about the rename.  Cycling the power is
> a kind of hardware reset isn't it.

Since we finalize the reset by calling bus_ops->power_restore, I was
looking for something symmetrical. Ulf mentioned perhaps extending
bus_ops->power_save, but I couldn't find a reasonable way of doing
this. Do you propose simply calling it bus_ops->hw_reset ?

//Johan
