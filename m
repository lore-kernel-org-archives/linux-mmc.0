From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v3] ARM: davinci: map default_queue to edma channels
Date: Wed, 01 Feb 2012 07:40:24 +0100
Message-ID: <4F28DE58.3040902@denx.de>
References: <1326956721-25158-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:42210 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab2BAGk2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 01:40:28 -0500
In-reply-to: <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "juha.kuikka@gmail.com" <juha.kuikka@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

Hello Nori,

Nori, Sekhar wrote:
> Hi Heiko,
> 
> On Thu, Jan 19, 2012 at 12:35:21, Heiko Schocher wrote:
>> Default queue is expected to be a low-priority queue.
>> This way, long transfers on the default queue started
>> by the codec engine will not cause audio defects.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
>> Signed-off-by: juha.kuikka@gmail.com
>> Reported-by: juha.kuikka@gmail.com
> 
> Sign-off should include real name, so I changed these
> two lines to:
> 
>     Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
>     Reported-by: Juha Kuikka <juha.kuikka@gmail.com>

Thanks!

> before applying. Let me know if anyone has objections.

I saw no objections, so can this patch go in now?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
