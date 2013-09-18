From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Adding aliases to mmc
Date: Tue, 17 Sep 2013 21:06:44 -0300
Message-ID: <CAOMZO5AT3bduZ0=EtWHuHVg6tSWrdr_ZjX5PLu815o0qgkeSig@mail.gmail.com>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Dirk,

On Tue, Sep 17, 2013 at 3:04 PM, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Dirk,
>
> I have adapted your patch at:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/111022.html
>
> and tested it on 3.12-rc1 on a mx6qsabresd board.
>
> Do you have plans to submit it? Maybe as a RFC?
>
> It solves the mmcblkX order issue on my tests and it would be nice we
> could have this problem addressed.

I simplied your patch a bit:

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1a3163f..94f842b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2026,7 +2026,7 @@ static struct mmc_blk_data
*mmc_blk_alloc_req(struct mmc_card *card,
     struct mmc_blk_data *md;
     int devidx, ret;

-    devidx = find_first_zero_bit(dev_use, max_devices);
+    devidx = find_next_zero_bit(dev_use, max_devices, card->host->devidx);
     if (devidx >= max_devices)
         return ERR_PTR(-ENOSPC);
     __set_bit(devidx, dev_use);
@@ -2044,7 +2044,8 @@ static struct mmc_blk_data
*mmc_blk_alloc_req(struct mmc_card *card,
      * index anymore so we keep track of a name index.
      */
     if (!subname) {
-        md->name_idx = find_first_zero_bit(name_use, max_devices);
+        md->name_idx = find_next_zero_bit(name_use, max_devices,
+                card->host->devidx);
         __set_bit(md->name_idx, name_use);
     } else
         md->name_idx = ((struct mmc_blk_data *)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
b/drivers/mmc/host/sdhci-esdhc-imx.c
index abc8cf0..e11a6af 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -524,8 +524,9 @@ static int sdhci_esdhc_imx_probe(struct
platform_device *pdev)
     struct sdhci_pltfm_host *pltfm_host;
     struct sdhci_host *host;
     struct esdhc_platform_data *boarddata;
-    int err;
+    int err, ret;
     struct pltfm_imx_data *imx_data;
+    struct device_node *np = pdev->dev.of_node;

     host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
     if (IS_ERR(host))
@@ -602,6 +603,13 @@ static int sdhci_esdhc_imx_probe(struct
platform_device *pdev)
                     host->mmc->parent->platform_data);
     }

+
+    if (np) {
+        ret = of_alias_get_id(np, "mmcblk");
+        if (ret >= 0)
+            host->mmc->devidx = ret;
+    }
+
     /* write_protect */
     if (boarddata->wp_type == ESDHC_WP_GPIO) {
         err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b0c33a..8209f72 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -362,6 +362,8 @@ struct mmc_host {

     unsigned int        slotno;    /* used for sdio acpi binding */

+    /* preferred mmc block device index (mmcblkX) */
+    unsigned int        devidx;
     unsigned long        private[0] ____cacheline_aligned;
 };

What do you think?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
