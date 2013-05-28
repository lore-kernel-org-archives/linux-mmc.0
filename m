From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: change the macro name from DTO to DRTO
Date: Tue, 28 May 2013 10:14:42 +0100
Message-ID: <51A47582.3010101@imgtec.com>
References: <51A2E57D.1000902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:50491 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933673Ab3E1JPd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 May 2013 05:15:33 -0400
In-Reply-To: <51A2E57D.1000902@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Will Newton <will.newton@gmail.com>

On 27/05/13 05:47, Jaehoon Chung wrote:
> At Interrupt status register, Bit9 is Data Read Timeout.
> But we used macro name as the DTO. It could be confused with the Data
> Transfer Over(DTO)-Bit[3].
> it's clearly that is changed the DRTO instead of DTO.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

