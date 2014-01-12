From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: tmio: fixup compile error
Date: Sun, 12 Jan 2014 16:22:05 +0000
Message-ID: <861u0df9w2.fsf@void.printf.net>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com>
	<87fvqr8ogb.wl%kuninori.morimoto.gx@renesas.com>
	<201401071440.28355.arnd@arndb.de>
	<87fvozxnnn.wl%kuninori.morimoto.gx@gmail.com>
	<20140108044748.GI15891@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140108044748.GI15891@verge.net.au> (Simon Horman's message of
	"Wed, 8 Jan 2014 13:47:50 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jan 08 2014, Simon Horman wrote:
> On Tue, Jan 07, 2014 at 05:33:51PM -0800, Kuninori Morimoto wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> 
>> This patch fixup below compile error
>> 
>> ${LINUX}/drivers/mmc/host/tmio_mmc.c: In function 'tmio_mmc_probe':
>> ${LINUX}/drivers/mmc/host/tmio_mmc.c:93:35: \
>> 	error: 'res_ctl' undeclared (first use in this function)
>> ${LINUX}/drivers/mmc/host/tmio_mmc.c:93:35: \
>> 	note: each undeclared identifier is reported only \
>> 	once for each function it appears in
>> 
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
