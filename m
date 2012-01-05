From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: fixed wrong bit operation for SDMMC_GET_FCNT()
Date: Thu, 05 Jan 2012 10:33:57 -0500
Message-ID: <m2hb0acgey.fsf@bob.laptop.org>
References: <4F0577A9.5080302@samsung.com>
	<CAFbHwiTUjLUX2oRie2L5xDMg9BA+sLdYcg3H1w+vVJcQMVUwrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47752 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932654Ab2AEPeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 10:34:11 -0500
In-Reply-To: <CAFbHwiTUjLUX2oRie2L5xDMg9BA+sLdYcg3H1w+vVJcQMVUwrg@mail.gmail.com>
	(Will Newton's message of "Thu, 5 Jan 2012 10:20:52 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, Jan 05 2012, Will Newton wrote:
> On Thu, Jan 5, 2012 at 10:12 AM, Jaehoon Chung <jh80.chung@samsung.co=
m> wrote:
>> In status register, fifo_count is bit[29:17].
>> (0x1FFF is correctly)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.h | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> Good catch, thanks!
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Pushed to mmc-next for 3.3, thanks.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
