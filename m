From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] mmc: dw_mmc: Add the ability to set the ciu clock
 frequency
Date: Thu,  6 Jun 2013 21:46:46 -0700
Message-ID: <1370580406-10254-2-git-send-email-dianders@chromium.org>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370580406-10254-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

As of now we rely on code outside of the driver to set the ciu clock
frequency.  There's no reason to do that.  Add support for setting up
the clock in the driver during probe.

Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/mmc/synopsis-dw-mshc.txt        | 13 +++++++++++++
 drivers/mmc/host/dw_mmc.c                               | 17 +++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
index b09d2d0..edb7659 100644
--- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
@@ -39,6 +39,19 @@ Required Properties:
 
 Optional properties:
 
+* clocks: from common clock binding: handle to biu and ciu clocks for the
+  bus interface unit clock and the card interface unit clock.
+
+* clock-names: from common clock binding: Shall be "biu" and "ciu".
+  If the biu clock is missing we'll simply skip enabling it.  If the
+  ciu clock is missing we'll just assume that the clock is running at
+  clock-frequency.  It is an error to omit both the ciu clock and the
+  clock-frequency.
+
+* clock-frequency: should be the frequency (in Hz) of the ciu clock.  If this
+  is specified and the ciu clock is specified then we'll try to set the ciu
+  clock to this at probe time.
+
 * num-slots: specifies the number of slots supported by the controller.
   The number of physical slots actually used could be equal or less than the
   value specified by num-slots. If this property is not specified, the value
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d3a0f8a..7ffb502 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2133,6 +2133,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	struct device_node *np = dev->of_node;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int idx, ret;
+	u32 clock_frequency;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
@@ -2159,6 +2160,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
 
+	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
+		pdata->bus_hz = clock_frequency;
+
 	if (drv_data && drv_data->parse_dt) {
 		ret = drv_data->parse_dt(host);
 		if (ret)
@@ -2223,18 +2227,23 @@ int dw_mci_probe(struct dw_mci *host)
 	host->ciu_clk = devm_clk_get(host->dev, "ciu");
 	if (IS_ERR(host->ciu_clk)) {
 		dev_dbg(host->dev, "ciu clock not available\n");
+		host->bus_hz = host->pdata->bus_hz;
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);
 		if (ret) {
 			dev_err(host->dev, "failed to enable ciu clock\n");
 			goto err_clk_biu;
 		}
-	}
 
-	if (IS_ERR(host->ciu_clk))
-		host->bus_hz = host->pdata->bus_hz;
-	else
+		if (host->pdata->bus_hz) {
+			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
+			if (ret)
+				dev_warn(host->dev,
+					 "Unable to set bus rate to %ul\n",
+					 host->pdata->bus_hz);
+		}
 		host->bus_hz = clk_get_rate(host->ciu_clk);
+	}
 
 	if (drv_data && drv_data->setup_clock) {
 		ret = drv_data->setup_clock(host);
-- 
1.8.3
