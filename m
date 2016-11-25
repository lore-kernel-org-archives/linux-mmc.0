From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] mmc: core: add DT binding for CMD23
Date: Fri, 25 Nov 2016 15:52:14 +0900
Message-ID: <20161125065215.10833-1-jh80.chung@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Provide the option to configure one type of multiple block read/wrte
transatction (CMD23 - it's optional.)

Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ff..9bdc369 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -321,6 +321,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_NO_SD;
 	if (of_property_read_bool(np, "no-mmc"))
 		host->caps2 |= MMC_CAP2_NO_MMC;
+	if (of_property_read_bool(np, "cap-mmc-cmd23"))
+		host->caps |= MMC_CAP_CMD23;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
