From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: Fix disableing DMA in Non-IDMAC
Date: Mon, 20 Feb 2012 12:07:50 -0500
Message-ID: <m2d3995t7d.fsf@bob.laptop.org>
References: <001e01ccef73$97aee200$c70ca600$%jun@samsung.com>
	<CAAG0J9-wRLj29=LztT4Ppi7q6Q=4dm29vHODk9KdVAGWKMJgUw@mail.gmail.com>
	<4F42384E.8020006@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34052 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306Ab2BTRH5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Feb 2012 12:07:57 -0500
In-Reply-To: <4F42384E.8020006@imgtec.com> (James Hogan's message of "Mon, 20
	Feb 2012 12:10:54 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, James Hogan <james@albanarts.com>, Will Newton <will.newton@imgtec.com>

Hi,

On Mon, Feb 20 2012, James Hogan wrote:
> Hi,
>
> On 20/02/12 12:03, Seungwon Jeon wrote:
>> dw_mci_pre_dma_transfer() is valid only if internal DMA. In case of
>> using other DMA it returns -ENOSYS. It prevents the DMA operations.
>> This patch makes dw_mci_pre_dma_transfer() effective in all DMA case.
>> 
>> Reported-by: James Hogan <james@albanarts.com>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> I've tested, and this seems to work for me (no IDMAC) as long as your
> other patch is applied first of course ("fixed compile error when
> disable CONFIG_MMC_DW_IDMAC").
>
> Probably worth fixing the typo in the subject too (s/disableing/disabling/).
>
> Otherwise, Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks, pushed to mmc-next for 3.3 with the subject line fix, and with
explicit mention of the regression and the patch that caused it.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
