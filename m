From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: set the card_width bit per card.
Date: Mon, 20 Jun 2011 10:15:29 +0100
Message-ID: <BANLkTimUSAFF+P=ykHfG=GzbAjjaaxe_fA@mail.gmail.com>
References: <1308558233-20545-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1308558233-20545-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, cjb@laptop.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 9:23 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This patch sets the card_width bit of CTYPE for the corresponding card.
>
> CTYPE[31] and CTYPE[16] correspond respectively to card[15] and card[0]
> for 8-bit mode. And CTYPE[15] and CTYPE[0] correspond respectively to
> card[15] and CTYPE[0] for 1-bit or 4-bit mode.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Will Newton <will.newton@imgtec.com>
