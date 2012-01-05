From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: Clear the DDR mode for non-DDR
Date: Wed, 04 Jan 2012 22:32:06 -0500
Message-ID: <m21ureeseh.fsf@bob.laptop.org>
References: <000b01ccc91c$26cf0330$746d0990$%jun@samsung.com>
	<CAFbHwiSH_eSYofo07Rk4H21nQ+0KSQ8zgmimEZz0anEga8rYgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAFbHwiSH_eSYofo07Rk4H21nQ+0KSQ8zgmimEZz0anEga8rYgA@mail.gmail.com>
	(Will Newton's message of "Tue, 3 Jan 2012 10:29:57 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 03 2012, Will Newton wrote:
> On Mon, Jan 2, 2012 at 7:00 AM, Seungwon Jeon <tgih.jun@samsung.com> =
wrote:
>> UHS_REG should be cleared for non-DDR mode. But currently there is
>> no way to clear DDR mode, if it is already set once. This patch adds
>> clearing DDR mode for non-DDD mode.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 11 +++++++----
>> =C2=A01 files changed, 7 insertions(+), 4 deletions(-)
>
> Looks ok to me, although I don't have any DDR capable hardware to tes=
t.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.3.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
