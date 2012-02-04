From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw-mmc: modify the condition for platdata of blk-setting
Date: Sat, 04 Feb 2012 17:01:52 -0500
Message-ID: <m239aqb6lr.fsf@bob.laptop.org>
References: <4F138F47.7040709@samsung.com>
	<CAFbHwiR5yD+_GMK4ZEZ0uV3Gq7Wh-n8fM7M_RrPOX0o_cN4+6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59635 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab2BDWB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Feb 2012 17:01:58 -0500
In-Reply-To: <CAFbHwiR5yD+_GMK4ZEZ0uV3Gq7Wh-n8fM7M_RrPOX0o_cN4+6g@mail.gmail.com>
	(Will Newton's message of "Mon, 16 Jan 2012 10:20:59 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Mon, Jan 16 2012, Will Newton wrote:
> On Mon, Jan 16, 2012 at 2:45 AM, Jaehoon Chung <jh80.chung@samsung.co=
m> wrote:
>> When use the IDMAC, we can also want to use the pdata->blk-setting.
>> So if pdata->blk-setting is unset, use the default value.
>> if not, use the pdata->blk-setting.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 16 ++++++++--------
>> =C2=A01 files changed, 8 insertions(+), 8 deletions(-)
>
> Looks good.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
