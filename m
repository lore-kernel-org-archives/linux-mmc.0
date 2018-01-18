From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
Date: Thu, 18 Jan 2018 09:13:21 +0100
Message-ID: <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On 17 January 2018 at 17:28, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> In the previous batch (https://lkml.org/lkml/2017/11/24/428)
> I sent 22 patches for TMIO MMC.
>
> 14 patches were applied, the rest is under discussion.
>
> This series consists of 16 patches.
>
> Patch 1-4:  repost from v2.
>             (Wolfram gave Reviewed by, so I moved them to the head)

Applied for next.

>
> Patch 5-11: new patches  (cleanups of WP flag)

I picked patch5 and patch6, as those seemed trivial. Unless there is a
rc9, let's aim for 4.17 for the rest.

[...]

Kind regards
Uffe
