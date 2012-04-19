From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw-mmc: prevent the Null pointer dereference for dma_ops
Date: Wed, 18 Apr 2012 20:02:14 -0400
Message-ID: <87sjg0lhbt.fsf@laptop.org>
References: <4F8E6257.5010603@samsung.com>
	<CAFbHwiQ5Q8qaog2ZPSs-HkoAnnGTofBFb4tM=XVo_vAYPkts2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35762 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659Ab2DSACE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 20:02:04 -0400
In-Reply-To: <CAFbHwiQ5Q8qaog2ZPSs-HkoAnnGTofBFb4tM=XVo_vAYPkts2A@mail.gmail.com>
	(Will Newton's message of "Wed, 18 Apr 2012 11:02:11 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Wed, Apr 18 2012, Will Newton wrote:
> On Wed, Apr 18, 2012 at 7:42 AM, Jaehoon Chung <jh80.chung@samsung.co=
m> wrote:
>> Now, dma_ops is assumed that use the IDMAC.
>> But if dma_ops is assigned the pdata->dma_ops,
>> We didn't ensure that callback function is defined.
>>
>> If anything of callback didn't define, then should be run the PIO mo=
de.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> This looks ok.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
