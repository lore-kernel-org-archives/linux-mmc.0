From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?B?UmU6IHVsZmgvbmV4dCBib290IGJpc2VjdGlvbjogdjUuMS1yYzEtMjItZ2IzNzI1ZDk3Yg==?=
        =?UTF-8?B?YTc1IG9uIHJrMzM5OS1ncnUta2V2aW7jgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51eC1tbWMtb3du?=
        =?UTF-8?B?ZXJAdmdlci5rZXJuZWwub3Jn5Luj5Y+R44CR?=
Date: Tue, 19 Mar 2019 09:48:28 +0100
Message-ID: <CAPDyKFoYgXuH_mJPwaqBsrpFjnrx8x6O5aVJ4LTfSVzFwO+8aw@mail.gmail.com>
References: <5c9020bc.1c69fb81.6977e.d27a@mx.google.com> <f75224ca-c0e5-94be-84b0-90c252784eb0@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f75224ca-c0e5-94be-84b0-90c252784eb0@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, guillaume.tucker@collabora.com, mgalka@collabora.com, Ziyuan Xu <xzy.xu@rock-chips.com>, Mark Brown <broonie@kernel.org>, matthew.hart@linaro.org, Kevin Hilman <khilman@baylibre.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 19 Mar 2019 at 01:38, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> On 2019/3/19 6:50, kernelci.org bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > ulfh/next boot bisection: v5.1-rc1-22-gb3725d97ba75 on rk3399-gru-kevin
> >
> > Summary:
> >    Start:      b3725d97ba75 Merge branch 'fixes' into next
> >    Details:    https://kernelci.org/boot/id/5c8fa85d59b5148afcfe6052
> >    Plain log:  https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.txt
> >    HTML log:   https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.html
> >    Result:     d6a6d722481f mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support
>
> Thanks for report!
>
> Ulf,
>
> It's a known issue already but didn't got managed to post v3 due to
> weekend. Should I post a increamental patch on top? or just resend a
> v3 series?

I have just dropped the offending patches (the series), please post a
new version.

[...]

Kind regards
Uffe
