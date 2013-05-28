From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: change the macro name from DTO to DRTO
Date: Tue, 28 May 2013 21:04:07 +0900
Message-ID: <000d01ce5b9b$74bd13d0$5e373b70$%jun@samsung.com>
References: <51A2E57D.1000902@samsung.com> <51A47582.3010101@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30940 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933338Ab3E1MEJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2013 08:04:09 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNI00AF4C6RT150@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 May 2013 21:04:07 +0900 (KST)
In-reply-to: <51A47582.3010101@imgtec.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@gmail.com>

On 05/28/13 6:15 PM, James Hogan wrote:
> On 27/05/13 05:47, Jaehoon Chung wrote:
> > At Interrupt status register, Bit9 is Data Read Timeout.
> > But we used macro name as the DTO. It could be confused with the Data
> > Transfer Over(DTO)-Bit[3].
> > it's clearly that is changed the DRTO instead of DTO.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

