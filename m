From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/7] mmc: dw_mmc: add samsung exynos5250 specific extentions
Date: Wed, 2 May 2012 11:10:45 -0700
Message-ID: <CAOesGMiJrfCgLHmBix1WUrpF-0D9tG5r6xi-3zsiM7KQjkO=ug@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-5-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335935266-25289-5-git-send-email-thomas.abraham@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, May 1, 2012 at 10:07 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The instantiation of the Synopsis Designware controller on Exynos5250
> include extension for SDR and DDR specific tx/rx phase shift timing
> and CIU internal divider. In addition to that, the option to skip the
> command hold stage is also introduced. Add support for these Exynos52=
50
> specfic extenstions.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> =A0.../devicetree/bindings/mmc/synposis-dw-mshc.txt =A0 | =A0 33 ++++=
+++++++++++++++-
> =A0drivers/mmc/host/dw_mmc-pltfm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A08 +++++
> =A0drivers/mmc/host/dw_mmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 32 ++++++++++++++++++-
> =A0drivers/mmc/host/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 13 ++++++++
> =A0include/linux/mmc/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A06 +++
> =A05 files changed, 89 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.t=
xt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> index c1ed70e..465fc31 100644
> --- a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> @@ -7,6 +7,8 @@ Required Properties:
>
> =A0* compatible: should be one of the following
> =A0 =A0 =A0 =A0- synopsis,dw-mshc: for controllers compliant with syn=
opsis dw-mshc.
> + =A0 =A0 =A0 - synopsis,dw-mshc-exynos5250: for controllers with Sam=
sung
> + =A0 =A0 =A0 =A0 Exynos5250 specific extentions.

It makes more sense to use your own manufacturer prefix here:

samsung,exynos5250-dw-mshc


-Olof
