From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] mmc: sunxi: Support eMMC DDR modes
Date: Tue, 2 Feb 2016 14:11:25 +0100
Message-ID: <CAPDyKFrH80eb3dC=AuxXHBHhk-P7puGtModHEmfywRXskVmWQQ@mail.gmail.com>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRB7WVYK2QKGQE4NIWTHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1454088108-2332-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 29 January 2016 at 18:21, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> Hi everyone,
>
> This was "mmc: sunxi: Support vqmmc regulator and eMMC DDR modes". vqmmc
> support and DT patches were merged even though it was an RFC series, to
> my suprise.
>
> These are the remaining patches that add eMMC HS-DDR support to sunxi.
>
> Patch 1 adds timing delays for MMC_DDR52 mode.
>
> Patch 2 adds support for 8 bit eMMC DDR52 mode. Under this mode, the
> controller must run at twice the card clock, and different timing delays
> are needed.
>
> Patch 3 enables eMMC HS-DDR for sunxi-mmc.
>
>
> Changes since RFC:
>
>   - Dropped patches that are merged
>
>   - Dropped "mmc: sunxi: Block signal voltage switching (CMD11)".
>     According to Ulf, the mmc core won't send this command unless the UHS
>     capabilities are set. We don't.
>
>   - Increased f_max to 52 MHz. Clock rate range for 50 MHz timing delay
>     also increased to match. See patch 1.
>
>
> Regards
> ChenYu
>
>
> Chen-Yu Tsai (3):
>   mmc: sunxi: Support MMC_DDR52 timing modes
>   mmc: sunxi: Support 8 bit eMMC DDR transfer modes
>   mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support
>
>  drivers/mmc/host/sunxi-mmc.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> --
> 2.7.0
>

Thanks, applied for next!

Kind regards
Uffe
