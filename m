From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH v2 6/6] mmc: core: add manual resume capability
Date: Fri, 27 Jun 2014 19:00:21 +0800
Message-ID: <CAOEd-H1c5rOs9ykdyvLNtLNhi6myxj7ExYQ6x1tNBP_LdJZoxg@mail.gmail.com>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1403763812-5495-7-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<8b071848-f7df-4965-bd49-ae05b21ebe2e@email.android.com>
	<CAOEd-H2Xtpmj9LAnfX6SwcUSu3W1qvD32YNNPpB4ZQn_HF9-wg@mail.gmail.com>
	<17c3cfc2-ae8c-4d19-8da5-fe40432f565c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35190 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbaF0LAV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jun 2014 07:00:21 -0400
In-Reply-To: <17c3cfc2-ae8c-4d19-8da5-fe40432f565c@email.android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "chris@printf.net" <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Anton Vorontsov <anton@enomsg.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "patches@linaro.org" <patches@linaro.org>, Andy Green <andy.green@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>

2014-06-27 17:40 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>
>
> On 27 juni 2014 04:23:42 CEST, Vincent Yang <vincent.yang.fujitsu@gmail.com> wrote:
>>2014-06-26 17:42 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>>
>>>
>>> On 26 juni 2014 08:23:32 CEST, Vincent Yang
>><vincent.yang.fujitsu@gmail.com> wrote:
>>>>This patch adds manual resume for some embedded platforms with rootfs
>>>>stored in SD card. It references CONFIG_MMC_BLOCK_DEFERRED_RESUME in
>>>>kernel 3.10. It lets host controller driver to manually handle resume
>>>>by itself.
>>>>
>>>>[symptom]
>>>>This issue is found on mb86s7x platforms with rootfs stored in SD
>>card.
>>>>It failed to resume form STR suspend mode because SD card cannot be
>>>>ready
>>>>in time. It take longer time (e.g., 600ms) to be ready for access.
>>>>The error log looks like below:
>>>>
>>>>root@localhost:~# echo mem > /sys/power/state
>>>>[   30.441974] SUSPEND
>>>>
>>>>SCB Firmware : Category 01 Version 02.03 Rev. 00_
>>>>    Config   : (no configuration)
>>>>root@localhost:~# [   30.702976] Buffer I/O error on device
>>mmcblk1p2,
>>>>logical block 31349
>>>>[   30.709678] Buffer I/O error on device mmcblk1p2, logical block
>>>>168073
>>>>[   30.716220] Buffer I/O error on device mmcblk1p2, logical block
>>>>168074
>>>>[   30.722759] Buffer I/O error on device mmcblk1p2, logical block
>>>>168075
>>>>[   30.729456] Buffer I/O error on device mmcblk1p2, logical block
>>>>31349
>>>>[   30.735916] Buffer I/O error on device mmcblk1p2, logical block
>>>>31350
>>>>[   30.742370] Buffer I/O error on device mmcblk1p2, logical block
>>>>31351
>>>>[   30.749025] Buffer I/O error on device mmcblk1p2, logical block
>>>>168075
>>>>[   30.755657] Buffer I/O error on device mmcblk1p2, logical block
>>>>31351
>>>>[   30.763130] Aborting journal on device mmcblk1p2-8.
>>>>[   30.768060] JBD2: Error -5 detected when updating journal
>>superblock
>>>>for mmcblk1p2-8.
>>>>[   30.776085] EXT4-fs error (device mmcblk1p2):
>>>>ext4_journal_check_start:56: Detected aborted journal
>>>>[   30.785259] EXT4-fs (mmcblk1p2): Remounting filesystem read-only
>>>>[   31.370716] EXT4-fs error (device mmcblk1p2):
>>ext4_find_entry:1309:
>>>>inode #2490369: comm udevd: reading directory lblock 0
>>>>[   31.382485] EXT4-fs error (device mmcblk1p2):
>>ext4_find_entry:1309:
>>>>inode #1048577: comm udevd: reading directory lblock 0
>>>>
>>>>[analysis]
>>>>In system resume path, mmc_sd_resume() is failed with error code -123
>>>>because at that time SD card is still not ready on mb86s7x platforms.
>>>
>>> So why does it fail? It shouldn't!
>>>
>>> I get the impression that you are solving this in the wrong way.
>>
>>Hi Uffe,
>>On mb86s7x EVB, power for SD card is completely removed when entering
>>STR suspend mode (i.e., echo mem > /sys/power/state). When system
>>starts to resume, it turns on the power for SD card again. However, It
>>take
>>longer time (e.g., 600ms) to get the power ready.
>>This is why mmc_sd_resume() failed with error code -123. At that time
>>point,
>>power for SD card is not ready yet.
>>
>>At first we fixed it by a simple method of using
>>SDHCI_QUIRK_DELAY_AFTER_POWER:
>>
>>diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>index 169e17d..ed28896 100644
>>--- a/drivers/mmc/host/sdhci.c
>>+++ b/drivers/mmc/host/sdhci.c
>>@@ -1283,7 +1283,7 @@ static void sdhci_set_power(struct sdhci_host
>>*host, unsigned char mode,
>>                 * they can apply clock after applying power
>>                 */
>>                if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
>>-                       mdelay(10);
>>+                       mdelay(600);
>>        }
>
> If you can't model the power to the card through a regulator, this is what you need to do.

Hi Uffe,
Yes, I got it.

>
>>
>>        if (host->vmmc) {
>>
>>However, we found it blocks the system resume path. It can slow down
>>system resume and also booting.
>>Therefore, we would like to resume SD card manually and asynchronously
>>by host controller driver itself. Thus system resume path is not
>>blocked.
>
> That is accomplished by using MMC_CAP_RUNTIME_RESUME.

Yes, I got it.
Thanks a lot for your review and help.
I will update it in next version.


Best regards,
Vincent Yang

>
> Kind regards
> Uffe
>
>
>>Thanks a lot for your review!
>>
>>
>>Best regards,
>>Vincent Yang
>>
>>>
>>> Kind regards
>>> Uffe
>>>
>>>>
>>>>[solution]
>>>>In order to not blocking system resume path, this patch just sets a
>>>>flag
>>>>MMC_BUSRESUME_MANUAL_RESUME when this error happened, and then host
>>>>controller
>>>>driver can understand it by this flag. Then host controller driver
>>have
>>>>to
>>>>resume SD card manually and asynchronously.
>>>>
>>>>Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>>>>---
>>>> drivers/mmc/core/core.c          |  4 ++
>>>> drivers/mmc/core/sd.c            |  4 ++
>>>>drivers/mmc/host/sdhci_f_sdh30.c | 89
>>>>++++++++++++++++++++++++++++++++++++++++
>>>> include/linux/mmc/host.h         | 14 +++++++
>>>> 4 files changed, 111 insertions(+)
>>>>
>>>>diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>index 764af63..51fce49 100644
>>>>--- a/drivers/mmc/core/core.c
>>>>+++ b/drivers/mmc/core/core.c
>>>>@@ -2648,6 +2648,10 @@ int mmc_pm_notify(struct notifier_block
>>>>*notify_block,
>>>>       case PM_POST_RESTORE:
>>>>
>>>>               spin_lock_irqsave(&host->lock, flags);
>>>>+              if (mmc_bus_manual_resume(host)) {
>>>>+                      spin_unlock_irqrestore(&host->lock, flags);
>>>>+                      break;
>>>>+              }
>>>>               host->rescan_disable = 0;
>>>>               spin_unlock_irqrestore(&host->lock, flags);
>>>>               _mmc_detect_change(host, 0, false);
>>>>diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>index 0c44510..859390d 100644
>>>>--- a/drivers/mmc/core/sd.c
>>>>+++ b/drivers/mmc/core/sd.c
>>>>@@ -1133,6 +1133,10 @@ static int mmc_sd_resume(struct mmc_host
>>*host)
>>>>
>>>>       if (!(host->caps & MMC_CAP_RUNTIME_RESUME)) {
>>>>               err = _mmc_sd_resume(host);
>>>>+              if ((host->caps2 & MMC_CAP2_MANUAL_RESUME) && err)
>>>>+                      mmc_set_bus_resume_policy(host, 1);
>>>>+              else
>>>>+                      mmc_set_bus_resume_policy(host, 0);
>>>>               pm_runtime_set_active(&host->card->dev);
>>>>               pm_runtime_mark_last_busy(&host->card->dev);
>>>>       }
>>>>diff --git a/drivers/mmc/host/sdhci_f_sdh30.c
>>>>b/drivers/mmc/host/sdhci_f_sdh30.c
>>>>index 6fae509..67bcff2 100644
>>>>--- a/drivers/mmc/host/sdhci_f_sdh30.c
>>>>+++ b/drivers/mmc/host/sdhci_f_sdh30.c
>>>>@@ -30,6 +30,12 @@
>>>> #include "../core/core.h"
>>>>
>>>> #define DRIVER_NAME "f_sdh30"
>>>>+#define RESUME_WAIT_COUNT     100
>>>>+#define RESUME_WAIT_TIME      50
>>>>+#define RESUME_WAIT_JIFFIES   msecs_to_jiffies(RESUME_DETECT_TIME)
>>>>+#define RESUME_DETECT_COUNT   16
>>>>+#define RESUME_DETECT_TIME    50
>>>>+#define RESUME_DETECT_JIFFIES msecs_to_jiffies(RESUME_DETECT_TIME)
>>>>
>>>>
>>>> struct f_sdhost_priv {
>>>>@@ -38,8 +44,59 @@ struct f_sdhost_priv {
>>>>       int gpio_select_1v8;
>>>>       u32 vendor_hs200;
>>>>       struct device *dev;
>>>>+      unsigned int quirks;    /* Deviations from spec. */
>>>>+
>>>>+/* retry to detect mmc device when resume */
>>>>+#define F_SDH30_QUIRK_RESUME_DETECT_RETRY             (1<<0)
>>>>+
>>>>+      struct workqueue_struct *resume_detect_wq;
>>>>+      struct delayed_work resume_detect_work;
>>>>+      unsigned int            resume_detect_count;
>>>>+      unsigned int            resume_wait_count;
>>>> };
>>>>
>>>>+static void sdhci_f_sdh30_resume_detect_work_func(struct work_struct
>>>>*work)
>>>>+{
>>>>+      struct f_sdhost_priv *priv = container_of(work, struct
>>f_sdhost_priv,
>>>>+              resume_detect_work.work);
>>>>+      struct sdhci_host *host = dev_get_drvdata(priv->dev);
>>>>+      int err = 0;
>>>>+
>>>>+      if (mmc_bus_manual_resume(host->mmc)) {
>>>>+              pm_runtime_disable(&host->mmc->card->dev);
>>>>+              mmc_card_set_suspended(host->mmc->card);
>>>>+              err = host->mmc->bus_ops->resume(host->mmc);
>>>>+              if (priv->resume_detect_count-- && err)
>>>>+                      queue_delayed_work(priv->resume_detect_wq,
>>>>+                                         &priv->resume_detect_work,
>>>>+                              RESUME_DETECT_JIFFIES);
>>>>+              else
>>>>+                      pr_debug("%s: resume detection done (count:%d,
>>wait:%d, err:%d)\n",
>>>>+                               mmc_hostname(host->mmc),
>>>>+                               priv->resume_detect_count,
>>>>+                               priv->resume_wait_count, err);
>>>>+      } else {
>>>>+              if (priv->resume_wait_count--)
>>>>+                      queue_delayed_work(priv->resume_detect_wq,
>>>>+                                         &priv->resume_detect_work,
>>>>+                              RESUME_WAIT_JIFFIES);
>>>>+              else
>>>>+                      pr_debug("%s: resume done\n",
>>mmc_hostname(host->mmc));
>>>>+      }
>>>>+}
>>>>+
>>>>+static void sdhci_f_sdh30_resume_detect(struct mmc_host *mmc,
>>>>+                                      int detect, int wait)
>>>>+{
>>>>+      struct sdhci_host *host = mmc_priv(mmc);
>>>>+      struct f_sdhost_priv *priv = sdhci_priv(host);
>>>>+
>>>>+      priv->resume_detect_count = detect;
>>>>+      priv->resume_wait_count = wait;
>>>>+      queue_delayed_work(priv->resume_detect_wq,
>>>>+                         &priv->resume_detect_work, 0);
>>>>+}
>>>>+
>>>> void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>>>> {
>>>>       struct f_sdhost_priv *priv = sdhci_priv(host);
>>>>@@ -146,6 +203,12 @@ static int sdhci_f_sdh30_probe(struct
>>>>platform_device *pdev)
>>>>               }
>>>>       }
>>>>
>>>>+      if (of_find_property(pdev->dev.of_node, "resume-detect-retry",
>>NULL))
>>>>{
>>>>+              dev_info(dev, "Applying resume detect retry quirk\n");
>>>>+              priv->quirks |= F_SDH30_QUIRK_RESUME_DETECT_RETRY;
>>>>+              host->mmc->caps2 |= MMC_CAP2_MANUAL_RESUME;
>>>>+      }
>>>>+
>>>>       ret = mmc_of_parse_voltage(pdev->dev.of_node,
>>&host->ocr_mask);
>>>>       if (ret) {
>>>>               dev_err(dev, "%s: parse voltage error\n", __func__);
>>>>@@ -197,6 +260,18 @@ static int sdhci_f_sdh30_probe(struct
>>>>platform_device *pdev)
>>>>               }
>>>>       }
>>>>
>>>>+      /* Init workqueue */
>>>>+      if (priv->quirks & F_SDH30_QUIRK_RESUME_DETECT_RETRY) {
>>>>+              priv->resume_detect_wq =
>>create_workqueue("sdhci_f_sdh30");
>>>>+              if (priv->resume_detect_wq == NULL) {
>>>>+                      ret = -ENOMEM;
>>>>+                      dev_err(dev, "Failed to create resume
>>detection workqueue\n");
>>>>+                      goto err_init_wq;
>>>>+              }
>>>>+              INIT_DELAYED_WORK(&priv->resume_detect_work,
>>>>+
>>sdhci_f_sdh30_resume_detect_work_func);
>>>>+      }
>>>>+
>>>>       ret = sdhci_add_host(host);
>>>>       if (ret) {
>>>>               dev_err(dev, "%s: host add error\n", __func__);
>>>>@@ -229,6 +304,9 @@ static int sdhci_f_sdh30_probe(struct
>>>>platform_device *pdev)
>>>>       return 0;
>>>>
>>>> err_add_host:
>>>>+      if (priv->quirks & F_SDH30_QUIRK_RESUME_DETECT_RETRY)
>>>>+              destroy_workqueue(priv->resume_detect_wq);
>>>>+err_init_wq:
>>>>       if (gpio_is_valid(priv->gpio_select_1v8)) {
>>>>               gpio_direction_output(priv->gpio_select_1v8, 1);
>>>>               gpio_free(priv->gpio_select_1v8);
>>>>@@ -268,6 +346,9 @@ static int sdhci_f_sdh30_remove(struct
>>>>platform_device *pdev)
>>>>               gpio_free(priv->gpio_select_1v8);
>>>>       }
>>>>
>>>>+      if (priv->quirks & F_SDH30_QUIRK_RESUME_DETECT_RETRY)
>>>>+              destroy_workqueue(priv->resume_detect_wq);
>>>>+
>>>>       sdhci_free_host(host);
>>>>       platform_set_drvdata(pdev, NULL);
>>>>
>>>>@@ -285,7 +366,15 @@ static int sdhci_f_sdh30_suspend(struct device
>>>>*dev)
>>>> static int sdhci_f_sdh30_resume(struct device *dev)
>>>> {
>>>>       struct sdhci_host *host = dev_get_drvdata(dev);
>>>>+      struct f_sdhost_priv *priv = sdhci_priv(host);
>>>>
>>>>+      if (priv->quirks & F_SDH30_QUIRK_RESUME_DETECT_RETRY) {
>>>>+              pr_debug("%s: start resume detect\n",
>>>>+                       mmc_hostname(host->mmc));
>>>>+              sdhci_f_sdh30_resume_detect(host->mmc,
>>>>+                                          RESUME_DETECT_COUNT,
>>>>+                                          RESUME_WAIT_COUNT);
>>>>+      }
>>>>       return sdhci_resume_host(host);
>>>> }
>>>> #endif
>>>>diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>index 7960424..55221dd 100644
>>>>--- a/include/linux/mmc/host.h
>>>>+++ b/include/linux/mmc/host.h
>>>>@@ -283,6 +283,7 @@ struct mmc_host {
>>>> #define MMC_CAP2_HS400                (MMC_CAP2_HS400_1_8V | \
>>>>                                MMC_CAP2_HS400_1_2V)
>>>> #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>>>>+#define MMC_CAP2_MANUAL_RESUME     (1 << 18)  /* Resume manually
>>when
>>>>error */
>>>>
>>>>       mmc_pm_flag_t           pm_caps;        /* supported pm
>>features */
>>>>
>>>>@@ -338,6 +339,9 @@ struct mmc_host {
>>>>       const struct mmc_bus_ops *bus_ops;      /* current bus driver
>>*/
>>>>       unsigned int            bus_refs;       /* reference counter
>>*/
>>>>
>>>>+      unsigned int            bus_resume_flags;
>>>>+#define MMC_BUSRESUME_MANUAL_RESUME   (1 << 0)
>>>>+
>>>>       unsigned int            sdio_irqs;
>>>>       struct task_struct      *sdio_irq_thread;
>>>>       bool                    sdio_irq_pending;
>>>>@@ -384,6 +388,16 @@ static inline void *mmc_priv(struct mmc_host
>>>>*host)
>>>> #define mmc_dev(x)    ((x)->parent)
>>>> #define mmc_classdev(x)       (&(x)->class_dev)
>>>> #define mmc_hostname(x)       (dev_name(&(x)->class_dev))
>>>>+#define mmc_bus_manual_resume(host) ((host)->bus_resume_flags &
>>         \
>>>>+      MMC_BUSRESUME_MANUAL_RESUME)
>>>>+
>>>>+static inline void mmc_set_bus_resume_policy(struct mmc_host *host,
>>>>int manual)
>>>>+{
>>>>+      if (manual)
>>>>+              host->bus_resume_flags |= MMC_BUSRESUME_MANUAL_RESUME;
>>>>+      else
>>>>+              host->bus_resume_flags &=
>>~MMC_BUSRESUME_MANUAL_RESUME;
>>>>+}
>>>>
>>>> int mmc_power_save_host(struct mmc_host *host);
>>>> int mmc_power_restore_host(struct mmc_host *host);
>>>
>
