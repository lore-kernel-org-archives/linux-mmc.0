From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc: dw_mmc: fixed compile error when disable CONFIG_MMC_DW_IDMAC
Date: Mon, 20 Feb 2012 12:04:45 -0500
Message-ID: <m2hayl5tci.fsf@bob.laptop.org>
References: <4F3C67BA.7040309@samsung.com> <4F423820.10000@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46230 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab2BTRE4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Feb 2012 12:04:56 -0500
In-Reply-To: <4F423820.10000@imgtec.com> (James Hogan's message of "Mon, 20
	Feb 2012 12:10:08 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

On Mon, Feb 20 2012, James Hogan wrote:
> On 16/02/12 02:19, Jaehoon Chung wrote:
>> When disable CONFIG_MMC_DW_IDMAC, can see the compiler error.
>> Because in dw_mci_post_req(), called the dw_mci_get_dma_dir().
>> But that function is in #ifdef CONFIG_MMC_DW_IDMAC.
>> 
>> I think that function is generic function.
>> Not need the CONFIG_MMC_DW_IDMAC.
>> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks, pushed to mmc-next for 3.3.  (And I'll take the second patch to
fix the no IDMAC regression too.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
