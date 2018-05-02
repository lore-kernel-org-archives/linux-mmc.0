From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] mmc: sunxi: add support for the MMC
 controller on H6
Date: Wed, 2 May 2018 14:54:58 +0200
Message-ID: <CAPDyKFr1CRS7W5gYntbo_KhkvoCB00xzfF4jyUOmtkG1z2g2xg@mail.gmail.com>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-2-icenowy@aosc.io>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDF57NG2XIHRBI7KU3LQKGQEQLVG5VI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180426140728.43155-2-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 26 April 2018 at 16:07, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
> The new Allwinner H6 SoC have 3 MMC controllers. The first and second
> ones are similar to the ones on A64, but the third one adds EMCE
> (Embedded Crypto Engine) support which does hardware transparent crypto
> on the eMMC.
>
> As we still do not have support for EMCE, and the support of it is
> disabled by defualt, we just duplicate the A64 mmc configurations and
> change the compatible string.
>
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  2 ++

DT doc changes in separate patches please!

>  drivers/mmc/host/sunxi-mmc.c                        | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>

Kind regards
Uffe
