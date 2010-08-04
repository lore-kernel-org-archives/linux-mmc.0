From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
Date: Wed, 4 Aug 2010 14:24:39 +0300
Message-ID: <AANLkTinu2S19r8fueM-jVkc35XL2G0Z16BddE92Ci9KB@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-4-git-send-email-ohad@wizery.com> <AANLkTimzA_JJ-byTDWznbL3YzeJ8LAP4M50onf2_3fBF@mail.gmail.com>
	<AANLkTi=Oy8X1xMOwWL_cKBB1LWULT6=p+adUgB+AuSJS@mail.gmail.com>
	<AANLkTi=BUX59heXAW2Uf4wZo2dSS19Je54dkQ5u2YGAW@mail.gmail.com>
	<AANLkTimZQKj7H_GeE=+O9cwxEMTR+LhfFbt=AyXGzN3d@mail.gmail.com>
	<AANLkTikfRja-h9mz7uyRXCZNZjKdU_yB8e58XQucUzrn@mail.gmail.com>
	<AANLkTi=vhWV1RNyemtfppfjvLYAbzd3aRjFOVgLLpG3Z@mail.gmail.com>
	<AANLkTin4m8gJR50zwMB2b0jRMHdNA6CQToKBTAhOL9wF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTin4m8gJR50zwMB2b0jRMHdNA6CQToKBTAhOL9wF-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Vitaly,

On Tue, Aug 3, 2010 at 5:17 PM, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Aug 2, 2010 at 11:35 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
>> I'm honestly trying to understand your concerns, but I'm afraid that
>> just saying "it's a hack" is not too informative. Can you please
>> explain what do you think is technically wrong with the proposed
>> solution ? is it not general enough for other use cases ? will it
>> break something ?

> So if I'd like to set the *same* structure for the *same* WL1271
> driver, provided that I'm working with the other platform, I'll need
> to do the following:
> - add the pointer to the board-specific header;
> - add the structure to the board-specific C file and propagate its
> pointer to the controller driver;
> - add setting the pointer in the core structure into the controller driver.
>
> This is far from being intuitive. This means we need to hack,
> generally speaking, all the MMC controller drivers to get it working
> on all platforms. This is error prone.

You make it sound really complex.

Let's see what it means to add it to a totally different platform.

As an example, let's take Google's ADP1 which is based on a different
host controller (msm-sdcc), and add the required support (untested of
course, just a quick sketch, patch is based on android's msm git):

diff --git a/arch/arm/mach-msm/board-trout-mmc.c b/arch/arm/mach-msm/board-trout
index 13755f5..df32b2f 100644
--- a/arch/arm/mach-msm/board-trout-mmc.c
+++ b/arch/arm/mach-msm/board-trout-mmc.c
@@ -10,6 +10,7 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/err.h>
 #include <linux/debugfs.h>
+#include <linux/wl12xx.h>

 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -297,11 +298,16 @@ int trout_wifi_reset(int on)
 EXPORT_SYMBOL(trout_wifi_reset);
 #endif

+struct wl12xx_platform_data trout_wlan_data = {
+       .irq = 62, /* put here your irq number */
+       .board_ref_clock = 1, /* put here your ref clock */
+};
+
 static struct mmc_platform_data trout_wifi_data = {
        .ocr_mask               = MMC_VDD_28_29,
        .status                 = trout_wifi_status,
        .register_status_notify = trout_wifi_status_register,
-       .embedded_sdio          = &trout_wifi_emb_data,
+       .embedded_sdio          = &trout_wlan_data,
 };

 int __init trout_init_mmc(unsigned int sys_rev)
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 1697d42..c40f0d1 100755
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1261,6 +1261,7 @@ msmsdcc_probe(struct platform_device *pdev)
        mmc->f_min = msmsdcc_fmin;
        mmc->f_max = msmsdcc_fmax;
        mmc->ocr_avail = plat->ocr_mask;
+        mmc_set_embedded_data(mmc, plat->embedded_sdio);

        if (msmsdcc_4bit)
                mmc->caps |= MMC_CAP_4_BIT_DATA;




Is it really that complex ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
