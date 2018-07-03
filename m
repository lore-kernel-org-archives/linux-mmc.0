From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Mon, 2 Jul 2018 23:25:41 -0300
Message-ID: <CAOMZO5A7=ptbOiSUDywwQrFd+DAZ3vsE3dSPab7cwOF3_T3qeQ@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com> <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, "evgreen@chromium.org" <evgreen@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 2, 2018 at 11:13 PM, Anson Huang <anson.huang@nxp.com> wrote:

> I think either way is OK, since flexible array is used in kernel code quite commonly,
> so I prefer to make code change as small as possible, the original patch can also prevent
> similar bug in future. And like below commit Fabio pointed out, it also has same kind
> of fix: a158531f3c92 ("gpio: 74x164: Fix crash during .remove()"). Thanks.

I am also fine with this patch or the one from Linus.

Maybe Anson's patch could be applied to 4.18-rc as a bug fix and
Linus' patch could be applied to 4.19-rc1 as a cleanup/improvement?

Ulf,

What would you prefer?

Thanks
