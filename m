From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/5] arm: davinci: Allow EVENTQ_0 as a default queue
Date: Fri, 08 Jul 2011 14:25:23 +0400
Message-ID: <4E16DB13.90806@mvista.com>
References: <1310074390-4277-1-git-send-email-ido@wizery.com> <1310074390-4277-3-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:61175 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1GHK0f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 06:26:35 -0400
Received: by fxd18 with SMTP id 18so1924526fxd.11
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2011 03:26:33 -0700 (PDT)
In-Reply-To: <1310074390-4277-3-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org

Hello.

On 08-07-2011 1:33, Ido Yariv wrote:

> Davinci platforms may define a default queue for each channel
> controller. If one is not defined, the default queue is set to EVENTQ_1.
> However, there's no way to distinguish between an unset default queue to
> one that is set to EVENTQ_0, as EVENTQ_0 = 0.

> In order to keep existing behaviour on platforms which don't specify a
> default_queue member, the default_queue member was modified to be a
> pointer to enum dma_event_q. A NULL value means that this member was not
> specified.

    Mmm, perhaps it's better to drop the default EVENTQ_1 concept and 
explicitly initilaize that field for every SoC. It's also possible to offset 
the event queue number by 1. I don't like the pointer solution.

> Signed-off-by: Ido Yariv<ido@wizery.com>

WBR, Sergei
