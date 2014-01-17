From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Fri, 17 Jan 2014 21:35:40 +0900
Message-ID: <003401cf1380$a194aa10$e4bdfe30$%jun@samsung.com>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
 <1389876527-13498-1-git-send-email-zhangfei.gao@linaro.org>
 <87y52fok4r.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43384 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaAQMfm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 07:35:42 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZJ00DNSPNGC220@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Jan 2014 21:35:40 +0900 (KST)
In-reply-to: <87y52fok4r.fsf@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kevin Hilman' <khilman@linaro.org>, 'Zhangfei Gao' <zhangfei.gao@linaro.org>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <chris@printf.net>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, January 17, 2014, Kevin Hilman wrote:
> Zhangfei Gao <zhangfei.gao@linaro.org> writes:
> 
> > Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
> > CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
> > can not be checked by IS_ERR_VALUE.
> > Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
> > otherwise sd detect may occasionally fail.
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> I didn't look at the patch in detail, but can at least confirm that
> Arndale boots again in -next with this patch applied.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

