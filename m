From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay values from DT
Date: Thu, 7 Jun 2018 17:41:40 +0530
Message-ID: <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, mdf@kernel.org, stefan.krsmanovic@aggios.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: Manish Narani <manish.narani@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds support for reading Tap Delay values from Device Tree
and write them via eemi calls. The macros containing these tap delay
values are removed from the driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 131 +++++++++++++++++++++++++++++++++=
++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of=
-arasan.c
index e3332a5..fc0fd01 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -36,6 +36,8 @@

 #define PHY_CLK_TOO_SLOW_HZ            400000

+#define MMC_BANK2              0x2
+
 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
  * each 32-bit register act as a write mask for the lower 16-bits.  This a=
llows
@@ -90,6 +92,10 @@ struct sdhci_arasan_data {
        struct sdhci_host *host;
        struct clk      *clk_ahb;
        struct phy      *phy;
+       u32 mio_bank;
+       u32 device_id;
+       u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
+       u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
        bool            is_phy_on;

        bool            has_cqe;
@@ -160,11 +166,36 @@ static int sdhci_arasan_syscon_write(struct sdhci_hos=
t *host,
        return ret;
 }

+/**
+ * arasan_zynqmp_set_tap_delay - Program the tap delays.
+ * @deviceid:          Unique Id of device
+ * @itap_delay:                Input Tap Delay
+ * @oitap_delay:       Output Tap Delay
+ */
+static void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 ota=
p_delay)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops()=
;
+       u32 node_id =3D (deviceid =3D=3D 0) ? NODE_SD_0 : NODE_SD_1;
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (itap_delay)
+               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+                               PM_TAPDELAY_INPUT, itap_delay, NULL);
+
+       if (otap_delay)
+               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+                               PM_TAPDELAY_OUTPUT, otap_delay, NULL);
+}
+
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int c=
lock)
 {
        struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
        struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
        bool ctrl_phy =3D false;
+       u8 itap_delay;
+       u8 otap_delay;

        if (!IS_ERR(sdhci_arasan->phy)) {
                if (!sdhci_arasan->is_phy_on && clock <=3D PHY_CLK_TOO_SLOW=
_HZ) {
@@ -200,6 +231,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *=
host, unsigned int clock)
                }
        }

+       if (host->version >=3D SDHCI_SPEC_300) {
+               if ((host->timing !=3D MMC_TIMING_LEGACY) &&
+                       (host->timing !=3D MMC_TIMING_UHS_SDR12)) {
+                       itap_delay =3D sdhci_arasan->itapdly[host->timing];
+                       otap_delay =3D sdhci_arasan->otapdly[host->timing];
+                       arasan_zynqmp_set_tap_delay(sdhci_arasan->device_id=
,
+                                                   itap_delay, otap_delay)=
;
+               }
+       }
+
        if (ctrl_phy && sdhci_arasan->is_phy_on) {
                phy_power_off(sdhci_arasan->phy);
                sdhci_arasan->is_phy_on =3D false;
@@ -456,6 +497,7 @@ static const struct of_device_id sdhci_arasan_of_match[=
] =3D {
        { .compatible =3D "arasan,sdhci-8.9a" },
        { .compatible =3D "arasan,sdhci-5.1" },
        { .compatible =3D "arasan,sdhci-4.9a" },
+       { .compatible =3D "xlnx,zynqmp-8.9a" },

        { /* sentinel */ }
 };
@@ -641,6 +683,74 @@ static void sdhci_arasan_unregister_sdclk(struct devic=
e *dev)
        of_clk_del_provider(dev->of_node);
 }

+/**
+ * arasan_zynqmp_dt_parse_tap_delays - Read Tap Delay values from DT
+ *
+ * Called at initialization to parse the values of Tap Delays.
+ *
+ * @dev:               Pointer to our struct device.
+ */
+static void arasan_zynqmp_dt_parse_tap_delays(struct device *dev)
+{
+       struct platform_device *pdev =3D to_platform_device(dev);
+       struct sdhci_host *host =3D platform_get_drvdata(pdev);
+       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+       struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
+       struct device_node *np =3D dev->of_node;
+
+       of_property_read_u32(np, "xlnx,itap_delay_sd_hsd",
+                            &sdhci_arasan->itapdly[MMC_TIMING_SD_HS]);
+       of_property_read_u32(np, "xlnx,otap_delay_sd_hsd",
+                            &sdhci_arasan->otapdly[MMC_TIMING_SD_HS]);
+       of_property_read_u32(np, "xlnx,itap_delay_sdr25",
+                            &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR25]);
+       of_property_read_u32(np, "xlnx,otap_delay_sdr25",
+                            &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR25]);
+       of_property_read_u32(np, "xlnx,itap_delay_sdr50",
+                            &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR50]);
+       of_property_read_u32(np, "xlnx,otap_delay_sdr50",
+                            &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR50]);
+       of_property_read_u32(np, "xlnx,itap_delay_sd_ddr50",
+                            &sdhci_arasan->itapdly[MMC_TIMING_UHS_DDR50]);
+       of_property_read_u32(np, "xlnx,otap_delay_sd_ddr50",
+                            &sdhci_arasan->otapdly[MMC_TIMING_UHS_DDR50]);
+       of_property_read_u32(np, "xlnx,itap_delay_mmc_hsd",
+                            &sdhci_arasan->itapdly[MMC_TIMING_MMC_HS]);
+       of_property_read_u32(np, "xlnx,otap_delay_mmc_hsd",
+                            &sdhci_arasan->otapdly[MMC_TIMING_MMC_HS]);
+       of_property_read_u32(np, "xlnx,itap_delay_mmc_ddr50",
+                            &sdhci_arasan->itapdly[MMC_TIMING_MMC_DDR52]);
+       of_property_read_u32(np, "xlnx,otap_delay_mmc_ddr50",
+                            &sdhci_arasan->otapdly[MMC_TIMING_MMC_DDR52]);
+       if (sdhci_arasan->mio_bank =3D=3D MMC_BANK2) {
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_sdr104_b2",
+                               &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_sdr104_b2",
+                               &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_mmc_hs200_b2",
+                               &sdhci_arasan->itapdly[MMC_TIMING_MMC_HS200=
]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_mmc_hs200_b2",
+                               &sdhci_arasan->otapdly[MMC_TIMING_MMC_HS200=
]);
+       } else {
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_sdr104_b0",
+                               &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_sdr104_b0",
+                               &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_mmc_hs200_b0",
+                               &sdhci_arasan->itapdly[MMC_TIMING_MMC_HS200=
]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_mmc_hs200_b0",
+                               &sdhci_arasan->otapdly[MMC_TIMING_MMC_HS200=
]);
+       }
+}
+
 static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 {
        struct sdhci_host *host =3D sdhci_arasan->host;
@@ -776,6 +886,27 @@ static int sdhci_arasan_probe(struct platform_device *=
pdev)
                goto unreg_clk;
        }

+       if (of_device_is_compatible(pdev->dev.of_node,
+                                   "xlnx,zynqmp-8.9a")) {
+               ret =3D of_property_read_u32(pdev->dev.of_node,
+                                          "xlnx,mio_bank",
+                                          &sdhci_arasan->mio_bank);
+               if (ret < 0) {
+                       dev_err(&pdev->dev,
+                               "\"xlnx,mio_bank \" property is missing.\n"=
);
+                       goto clk_disable_all;
+               }
+               ret =3D of_property_read_u32(pdev->dev.of_node,
+                                          "xlnx,device_id",
+                                          &sdhci_arasan->device_id);
+               if (ret < 0) {
+                       dev_err(&pdev->dev,
+                               "\"xlnx,device_id \" property is missing.\n=
");
+                       goto clk_disable_all;
+               }
+               arasan_zynqmp_dt_parse_tap_delays(&pdev->dev);
+       }
+
        sdhci_arasan->phy =3D ERR_PTR(-ENODEV);
        if (of_device_is_compatible(pdev->dev.of_node,
                                    "arasan,sdhci-5.1")) {
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
