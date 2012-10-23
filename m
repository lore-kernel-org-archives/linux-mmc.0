From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc: dw_mmc: remove the compiling warning
Date: Tue, 23 Oct 2012 17:08:01 -0400
Message-ID: <87y5iwhp72.fsf@octavius.laptop.org>
References: <00ff01cd9d61$dd516520$97f42f60$%jun@samsung.com>
	<CAFbHwiQ0qhA_-oqG_q-fQuem2gODL-51Wed-ERfHjj70yCpaFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48445 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933701Ab2JWVIH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:08:07 -0400
In-Reply-To: <CAFbHwiQ0qhA_-oqG_q-fQuem2gODL-51Wed-ERfHjj70yCpaFw@mail.gmail.com>
	(Will Newton's message of "Fri, 28 Sep 2012 11:42:57 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Hi,

On Fri, Sep 28 2012, Will Newton wrote:
> On Fri, Sep 28, 2012 at 11:13 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> This patch removes the following warning.
>> drivers/mmc/host/dw_mmc.c:1976: warning: passing argument 1 of
>> '_dev_info' from incompatible pointer type
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
