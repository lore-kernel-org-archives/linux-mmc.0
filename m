From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Mon, 2 Jul 2018 21:59:27 -0300
Message-ID: <CAOMZO5DxX7Mx35sjQtaBi=ew9w82Ve0VRyXnekMgL1N_ShwUTg@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Anson Huang <Anson.Huang@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, evgreen@chromium.org, Shawn Lin <shawn.lin@rock-chips.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On Mon, Jul 2, 2018 at 8:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> What about this:
>
> From facb3799f479bfd4dad99c25c9c5d4c77b14c9b0 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Mon, 2 Jul 2018 13:35:01 +0200
> Subject: [PATCH] mmc: slot-gpio: Allocate GPIO labels dynamically
>
> The use of string pointers in the MMC slot GPIO context is
> pretty dubious, allocating some 2*len extra bytes for each
> label of the ro and wp pins.
>
> Tidy this up using kasprintf() with dynamic allocation of
> labels for these strings.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Your proposed solution also worked fine, thanks.
