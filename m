From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Mon, 9 Jul 2018 15:21:10 +0200
Message-ID: <CACRpkdYs6RCw3Z9jqaPf3H_OExY+AtDFb21rNJXr6Gr2oVUTWQ@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
 <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5A7=ptbOiSUDywwQrFd+DAZ3vsE3dSPab7cwOF3_T3qeQ@mail.gmail.com> <CAPDyKFoVLT1zUPma7xRz_JFzFYpr=YCzENARmCkzwUnTZEX_8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoVLT1zUPma7xRz_JFzFYpr=YCzENARmCkzwUnTZEX_8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Anson Huang <anson.huang@nxp.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, evgreen@chromium.org, Shawn Lin <shawn.lin@rock-chips.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 3, 2018 at 7:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 July 2018 at 04:25, Fabio Estevam <festevam@gmail.com> wrote:
> > On Mon, Jul 2, 2018 at 11:13 PM, Anson Huang <anson.huang@nxp.com> wrote:
> >
> >> I think either way is OK, since flexible array is used in kernel code quite commonly,
> >> so I prefer to make code change as small as possible, the original patch can also prevent
> >> similar bug in future. And like below commit Fabio pointed out, it also has same kind
> >> of fix: a158531f3c92 ("gpio: 74x164: Fix crash during .remove()"). Thanks.
> >
> > I am also fine with this patch or the one from Linus.
> >
> > Maybe Anson's patch could be applied to 4.18-rc as a bug fix and
> > Linus' patch could be applied to 4.19-rc1 as a cleanup/improvement?
>
> Good idea!
>
> I have queued up Anson's v2 patch as a fix for 4.18.
>
> Linus, can please re-post a re-based version of your change on top!? I
> guess you can add Anson's and Fabio's reviewed by tags for it as well.

Sure thing! I'll fold in Andy's suggested fix as well.

Yours,
Linus Walleij
