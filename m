From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Add second capability field
Date: Thu, 22 Dec 2011 10:30:36 +0000
Message-ID: <CAFbHwiT8cyrDLqfAu+=8Ab2y31gDSfpqMQjO9RmAyNx=VT7=DQ@mail.gmail.com>
References: <006801ccc088$40cf1460$c26d3d20$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <006801ccc088$40cf1460$c26d3d20$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, James Hogan <james@albanarts.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 22, 2011 at 9:01 AM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> This patch adds caps2 filed for second capability in dw_mmc.
> It corresponds with MMC_CAPS2_XXX. And this patch removes the
> unnecessary condition statement for assigning caps.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 =A06 ++----
> =A0include/linux/mmc/dw_mmc.h | =A0 =A01 +
> =A02 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
