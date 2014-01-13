From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: core: sd: implement proper support for sd3.0 au sizes
Date: Mon, 13 Jan 2014 18:04:32 +0000
Message-ID: <861u0bdahb.fsf@void.printf.net>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
	<20140113124117.GD2586@katana>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45264 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbaAMSEh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 13:04:37 -0500
In-Reply-To: <20140113124117.GD2586@katana> (Wolfram Sang's message of "Mon,
	13 Jan 2014 13:41:18 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, H Hartley Sweeten <hartleys@visionengravers.com>

Hi Wolfram,

On Mon, Jan 13 2014, Wolfram Sang wrote:
> On Tue, Nov 26, 2013 at 02:16:25AM +0100, Wolfram Sang wrote:
>> This reverts and updates commit 77776fd0a4cc541b9a528eacc1d31ca47eb1ae7a
>> ("mmc: sd: fix the maximum au_size for SD3.0"). The au_size for SD3.0
>> cannot be achieved by a simple bit shift, so this needs to be
>> implemented differently. Also, don't print the warning in case of 0
>> since 'not defined' is different from 'invalid'.
>
> Ping! Chris are you there? This got reviewed and acked, and I'd even
> think this could be suitable for stable.

Sorry about that!  I agree, pushed to mmc-next for 3.14 with stable@ tag.

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
