From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: support send_auto_stop
Date: Thu, 31 Mar 2011 10:29:26 +0900
Message-ID: <4D93D8F6.7000904@samsung.com>
References: <4D92C5D2.2000004@samsung.com>
 <AANLkTikzkX7vYu0h7T6-C5PvykOZAzYGnTmPydizkTU6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32189 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1CaBax (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 21:30:53 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LIW00G54EVEST80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Mar 2011 10:30:50 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LIW005MEEV4PO@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Mar 2011 10:30:40 +0900 (KST)
In-reply-to: <AANLkTikzkX7vYu0h7T6-C5PvykOZAzYGnTmPydizkTU6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Will Newton wrote:
> On Wed, Mar 30, 2011 at 6:55 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch is set the send_auto_stop bit in CMD register.
>> If use DW_MCI_QUIRK_SEND_AUTO_STOP, helps to send an exact
>> number of data bytes.
>>
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> This is something I have been meaning to look into, does it improve
> latency or throughput in your experiments?

Not improve latency...but in my experiments,
when i used this, i could find the stable throughput..

> 
> Is there a reason you have implemented it as a quirk? I would have
> thought if it was a win (in performance or code size) it would be
> applicable to all instances of this block?

I didn't test every case..so Somebody doesn't want to use send_auto_stop,
So i think good that used the quirks...
you can see Send_Auto_Stop generation table in DesigneWare MMC controller spec
I think that our case can use send_auto_stop...but i didn't ensure in other case

> 
> If we implemented it as an unconditional feature then we could
> probably remove some of the explicit stop handling code.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

