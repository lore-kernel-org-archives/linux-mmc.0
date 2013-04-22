From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add linux-samsung-soc list to
	all related entries
Date: Mon, 22 Apr 2013 15:23:29 +0900
Message-ID: <CAH9JG2U7Qdq_xQbuqHu6PXzURS2fWwBC=HJmyrXT5n3n_pAa0w@mail.gmail.com>
References: <1366572050-626-1-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1366572050-626-1-git-send-email-tomasz.figa@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: t.stanislaws@samsung.com, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, jy0922.shim@samsung.com, k.debski@samsung.com, sbkim73@samsung.com, linux-mmc@vger.kernel.org, jg1.han@samsung.com, sw0312.kim@samsung.com, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, inki.dae@samsung.com, jtp.park@samsung.com, dh09.lee@samsung.com, s.nawrocki@samsung.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I don't think it's not required, each tree has each own mailing list. don't
need to post all patches to samsung-soc list.

Thank you,
Kyungmin Park

On Mon, Apr 22, 2013 at 4:20 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Several entries in MAINTAINERS file related to Samsung SoCs do not point
> to linux-samsung-soc mailing list, which is supposed to collect all
> Samsung SoC-related threads, to ease following of Samsung SoC-related
> work. This leads to a problem with people skipping this mailing list in
> their posts, even though they are related to Samsung SoCs.
>
> This patch adds pointers to linux-samsung-soc mailing list to affected
> entries of MAINTAINERS file.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c0d68b..07cb8da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1139,6 +1139,7 @@ F:        arch/arm/mach-exynos*/
>  ARM/SAMSUNG MOBILE MACHINE SUPPORT
>  M:     Kyungmin Park <kyungmin.park@samsung.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for
> non-subscribers)
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm/mach-s5pv210/mach-aquila.c
>  F:     arch/arm/mach-s5pv210/mach-goni.c
> @@ -1150,6 +1151,7 @@ M:        Kyungmin Park <kyungmin.park@samsung.com>
>  M:     Kamil Debski <k.debski@samsung.com>
>  L:     linux-arm-kernel@lists.infradead.org
>  L:     linux-media@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/media/platform/s5p-g2d/
>
> @@ -1158,6 +1160,7 @@ M:        Kyungmin Park <kyungmin.park@samsung.com>
>  M:     Sylwester Nawrocki <s.nawrocki@samsung.com>
>  L:     linux-arm-kernel@lists.infradead.org
>  L:     linux-media@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm/plat-samsung/include/plat/*fimc*
>  F:     drivers/media/platform/s5p-fimc/
> @@ -1168,6 +1171,7 @@ M:        Kamil Debski <k.debski@samsung.com>
>  M:     Jeongtae Park <jtp.park@samsung.com>
>  L:     linux-arm-kernel@lists.infradead.org
>  L:     linux-media@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm/plat-samsung/s5p-dev-mfc.c
>  F:     drivers/media/platform/s5p-mfc/
> @@ -1177,6 +1181,7 @@ M:        Kyungmin Park <kyungmin.park@samsung.com>
>  M:     Tomasz Stanislawski <t.stanislaws@samsung.com>
>  L:     linux-arm-kernel@lists.infradead.org
>  L:     linux-media@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/media/platform/s5p-tv/
>
> @@ -2679,6 +2684,7 @@ M:        Joonyoung Shim <jy0922.shim@samsung.com>
>  M:     Seung-Woo Kim <sw0312.kim@samsung.com>
>  M:     Kyungmin Park <kyungmin.park@samsung.com>
>  L:     dri-devel@lists.freedesktop.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  T:     git git://
> git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git
>  S:     Supported
>  F:     drivers/gpu/drm/exynos
> @@ -3142,6 +3148,7 @@ F:        Documentation/extcon/
>  EXYNOS DP DRIVER
>  M:     Jingoo Han <jg1.han@samsung.com>
>  L:     linux-fbdev@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/video/exynos/exynos_dp*
>  F:     include/video/exynos_dp*
> @@ -3151,6 +3158,7 @@ M:        Inki Dae <inki.dae@samsung.com>
>  M:     Donghwa Lee <dh09.lee@samsung.com>
>  M:     Kyungmin Park <kyungmin.park@samsung.com>
>  L:     linux-fbdev@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/video/exynos/exynos_mipi*
>  F:     include/video/exynos_mipi*
> @@ -6892,12 +6900,14 @@ F:      drivers/platform/x86/samsung-laptop.c
>  SAMSUNG AUDIO (ASoC) DRIVERS
>  M:     Sangbeom Kim <sbkim73@samsung.com>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Supported
>  F:     sound/soc/samsung
>
>  SAMSUNG FRAMEBUFFER DRIVER
>  M:     Jingoo Han <jg1.han@samsung.com>
>  L:     linux-fbdev@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/video/s3c-fb.c
>
> @@ -7087,6 +7097,7 @@ F:        drivers/mmc/host/sdhci-pltfm.[ch]
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
>  M:     Ben Dooks <ben-linux@fluff.org>
>  L:     linux-mmc@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci-s3c.c
>
> --
> 1.8.2.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
