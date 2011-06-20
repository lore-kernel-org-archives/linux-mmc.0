From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: set the card_width bit per card.
Date: Mon, 20 Jun 2011 14:57:45 -0400
Message-ID: <m2boxsz5xy.fsf@bob.laptop.org>
References: <1308558233-20545-1-git-send-email-tgih.jun@samsung.com>
	<BANLkTimUSAFF+P=ykHfG=GzbAjjaaxe_fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <BANLkTimUSAFF+P=ykHfG=GzbAjjaaxe_fA@mail.gmail.com> (Will
	Newton's message of "Mon, 20 Jun 2011 10:15:29 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 20 2011, Will Newton wrote:
> On Mon, Jun 20, 2011 at 9:23 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> This patch sets the card_width bit of CTYPE for the corresponding card.
>>
>> CTYPE[31] and CTYPE[16] correspond respectively to card[15] and card[0]
>> for 8-bit mode. And CTYPE[15] and CTYPE[0] correspond respectively to
>> card[15] and CTYPE[0] for 1-bit or 4-bit mode.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Pushed to mmc-next for 3.1, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
