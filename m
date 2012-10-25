From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Thu, 25 Oct 2012 08:33:12 -0400
Message-ID: <87ehkmenp3.fsf@octavius.laptop.org>
References: <1351144039-30588-1-git-send-email-r66093@freescale.com>
	<20121025080120.GA23807@lizard>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60505 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758999Ab2JYMdU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 25 Oct 2012 08:33:20 -0400
In-Reply-To: <20121025080120.GA23807@lizard> (Anton Vorontsov's message of
	"Thu, 25 Oct 2012 01:01:20 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: r66093@freescale.com, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>

Hi,

On Thu, Oct 25 2012, Anton Vorontsov wrote:
> On Thu, Oct 25, 2012 at 01:47:19PM +0800, r66093@freescale.com wrote:
>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>> 
>> CMD23 causes lots of errors in kernel on some freescale SoCs
>> (P1020, P1021, P1022, P1024, P1025 and P4080) when MMC card used,
>> which is because these controllers does not support CMD23,
>> even on the SoCs which declares CMD23 is supported.
>> Therefore, we'll not use CMD23.
>> 
>> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> CC: Chris Ball <cjb@laptop.org>
>> ---
>
> Looks perfect, thanks a lot!
>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
