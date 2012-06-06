From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/4] mmc: dw_mmc: some fiex for hosw driver
Date: Wed, 06 Jun 2012 09:39:21 -0400
Message-ID: <87ipf44l12.fsf@octavius.laptop.org>
References: <006701cd37cf$76e576c0$64b06440$%jun@samsung.com>
	<CAFbHwiRWKBSTDzjQ89Z0u1xziwBpngyFM8cZs4WLR2m=1taEow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52087 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab2FFNj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jun 2012 09:39:29 -0400
In-Reply-To: <CAFbHwiRWKBSTDzjQ89Z0u1xziwBpngyFM8cZs4WLR2m=1taEow@mail.gmail.com>
	(Will Newton's message of "Tue, 22 May 2012 10:28:47 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

Hi,

On Tue, May 22 2012, Will Newton wrote:
> On Tue, May 22, 2012 at 5:00 AM, Seungwon Jeon <tgih.jun@samsung.com>=
 wrote:
>> This patch-set includes fixes for the Synopsys DesignWare MMC driver
>>
>> Changes in v2:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- fix the error handling(mmc: dw_mmc: fix=
 the IDMAC sw reset)
>>
>> Seungwon Jeon (4):
>> =C2=A0 =C2=A0 =C2=A0mmc: dw_mmc: fix the transmission handling in ID=
MAC
>> =C2=A0 =C2=A0 =C2=A0mmc: dw_mmc: fix the IDMAC sw reset
>> =C2=A0 =C2=A0 =C2=A0mmc: dw_mmc: fix the wrong sequence
>> =C2=A0 =C2=A0 =C2=A0mmc: dw_mmc: correct the calculation for CLKDIV
>>
>> drivers/mmc/host/dw_mmc.c | =C2=A0 36 +++++++++++++++++++-----------=
------
>> 1 files changed, 19 insertions(+), 17 deletions(-)
>
> The v2 series looks good to me.
>
> Acked-by: Will Newton <will.newton@gmail.com>

Thanks, I've pushed this patchset to mmc-next for 3.5.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
