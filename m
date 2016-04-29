From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 1/4] Documentation: mmc: Document mmc aliases
Date: Fri, 29 Apr 2016 10:32:16 -0700
Message-ID: <1461951139-6109-2-git-send-email-dianders@chromium.org>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461951139-6109-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Now, index of mmc/mmcblk devices is allocated in accordance with probing
time.  If want to use the mmcblk1 for some device, it can use alias.

aliases {
	mmc0 = &mmc0;	/* mmc0/mmcblk0 for eMMC */
	mmc1 = &mmc2;	/* mmc1/mmcblk1 for SD */
	mmc2 = &mmc1;	/* mmc2/mmcblk2 for SDIO*/
};

If there are no corresponding values, it might be allocated with
existing scheme.

Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
[dianders: just bindings now; mention mmc not just mmcblk]
Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Changes in v2: None

 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ed23b9bedfdc..4b5c23e61adb 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -71,6 +71,10 @@ Optional SDIO properties:
 - wakeup-source: Enables wake up of host system on SDIO IRQ assertion
 		 (Legacy property supported: "enable-sdio-wakeup")
 
+Aliases (Optional):
+- If you want to use the fixed index for devices like mmcX / mmcblkX, should
+be represented in the aliases node using following format "mmc(X)".
+(X is an unique number for the alias.)
 
 MMC power sequences:
 --------------------
@@ -145,3 +149,10 @@ mmc3: mmc@01c12000 {
 		interrupt-names = "host-wake";
 	};
 };
+
+Example with aliases nodes:
+
+aliases {
+	mmc0 = &mmc0;	/* Fixed to mmc0/mmcblk0 for &mmc0 */
+	mmc1 = &mmc2;	/* Fixed to mmc1/mmcblk1 for &mmc2 */
+};
-- 
2.8.0.rc3.226.g39d4020
