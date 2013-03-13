From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt
Date: Wed, 13 Mar 2013 23:22:40 +0900
Message-ID: <002501ce1ff6$38e3c470$aaab4d50$%jun@samsung.com>
References: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26483 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab3CMOWn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 10:22:43 -0400
In-reply-to: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Markos Chandras' <markos.chandras@imgtec.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>

On Tuesday, March 12, 2013, Markos Chandras wrote:
> There is no reason to loop when handling an interrupt. The "if" clauses
> will handle all of them sequentially. This also eliminates the extra loop
> we used to take with no pending interrupts and we ended up breaking out
> of the while loop.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

You can add my ack to other patches.
However, could you change the subject prefix to 'mmc: dw_mmc' and resend?

Thanks,
Seungwon Jeon

