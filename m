From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: Fixed sdio interrupt mask bit setting bug
Date: Thu, 17 May 2012 08:35:38 -0400
Message-ID: <87wr4b3rz9.fsf@laptop.org>
References: <002901cd31ac$fb410250$f1c306f0$%kim@samsung.com>
	<CAFbHwiSwu32cdzQib+TYj9uSt+PXmA1Ltk1mzECRoy1DfdjyNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAFbHwiSwu32cdzQib+TYj9uSt+PXmA1Ltk1mzECRoy1DfdjyNQ@mail.gmail.com>
	(Will Newton's message of "Mon, 14 May 2012 10:06:41 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Kyoungil Kim <ki0351.kim@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, May 14 2012, Will Newton wrote:
> On Mon, May 14, 2012 at 9:38 AM, Kyoungil Kim <ki0351.kim@samsung.com=
> wrote:
>> The sdio interrupt mask bits are arranged in [31:16].
>> (1 << SDMMC_INT_SDIO(slot->id))) does 16 bits left shift twice.
>> So this patch changes to do 16 bits left shift only one time.
>>
>> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> Yes, looks correct.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
