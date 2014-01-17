From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Fri, 17 Jan 2014 14:25:30 +0000
Message-ID: <867g9y8z39.fsf@void.printf.net>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
	<1389876527-13498-1-git-send-email-zhangfei.gao@linaro.org>
	<87y52fok4r.fsf@linaro.org>
	<003401cf1380$a194aa10$e4bdfe30$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38651 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaAQOZk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jan 2014 09:25:40 -0500
In-Reply-To: <003401cf1380$a194aa10$e4bdfe30$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 17 Jan 2014 21:35:40 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Kevin Hilman' <khilman@linaro.org>, 'Zhangfei Gao' <zhangfei.gao@linaro.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi,

On Fri, Jan 17 2014, Seungwon Jeon wrote:
> On Fri, January 17, 2014, Kevin Hilman wrote:
>> Zhangfei Gao <zhangfei.gao@linaro.org> writes:
>> 
>> > Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
>> > CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
>> > can not be checked by IS_ERR_VALUE.
>> > Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
>> > otherwise sd detect may occasionally fail.
>> >
>> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> > Reported-by: Kevin Hilman <khilman@linaro.org>
>> > Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
>> 
>> I didn't look at the patch in detail, but can at least confirm that
>> Arndale boots again in -next with this patch applied.
>> 
>> Tested-by: Kevin Hilman <khilman@linaro.org>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
