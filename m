From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 13/16] drm/edid: use new match_string() helper/macro
Date: Wed, 8 May 2019 14:28:39 +0300
Message-ID: <20190508112842.11654-15-alexandru.ardelean@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508112842.11654-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org, cgroups@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-Id: linux-mmc@vger.kernel.org

The `generic_edid_name` is a static array of strings.
Using match_string() (which computes the array size via ARRAY_SIZE())
is possible.

The change is mostly cosmetic.
No functionality change.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/gpu/drm/drm_edid_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
index 1450051972ea..66e1e325ff37 100644
--- a/drivers/gpu/drm/drm_edid_load.c
+++ b/drivers/gpu/drm/drm_edid_load.c
@@ -186,7 +186,7 @@ static void *edid_load(struct drm_connector *connector, const char *name,
 	int i, valid_extensions = 0;
 	bool print_bad_edid = !connector->bad_edid_counter || (drm_debug & DRM_UT_KMS);
 
-	builtin = __match_string(generic_edid_name, GENERIC_EDIDS, name);
+	builtin = match_string(generic_edid_name, name);
 	if (builtin >= 0) {
 		fwdata = generic_edid[builtin];
 		fwsize = sizeof(generic_edid[builtin]);
-- 
2.17.1
